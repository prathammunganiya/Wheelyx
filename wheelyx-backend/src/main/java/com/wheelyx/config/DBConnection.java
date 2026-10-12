package com.wheelyx.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection
 * Production-ready connection pool manager using HikariCP with graceful fallback.
 * Strictly uses Parameterized PreparedStatements across all DAO calls.
 * Configured with SSL and environment-variable awareness for Aiven MySQL and Railway.
 */
public class DBConnection {

    private static HikariDataSource dataSource;
    private static boolean poolInitialized = false;

    static {
        initPool();
    }

    /**
     * Builds the JDBC URL based on environment variables or db.properties.
     * Incorporates required SSL parameters for Aiven MySQL.
     */
    public static String buildJdbcUrl() {
        String explicitUrl = AppConfig.getDbUrl();
        if (explicitUrl != null && !explicitUrl.trim().isEmpty()) {
            return normalizeJdbcUrl(explicitUrl.trim());
        }

        String host = AppConfig.getDbHost();
        int port = AppConfig.getDbPort();
        String dbName = AppConfig.getDbName();
        boolean useSsl = AppConfig.isDbSslEnabled();
        String sslMode = AppConfig.getDbSslMode();

        StringBuilder sb = new StringBuilder();
        sb.append("jdbc:mysql://").append(host).append(":").append(port).append("/").append(dbName);
        sb.append("?allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata&characterEncoding=UTF-8");

        if (useSsl) {
            sb.append("&useSSL=true");
            if (sslMode != null && !sslMode.trim().isEmpty() && !sslMode.equalsIgnoreCase("DISABLED")) {
                sb.append("&sslMode=").append(sslMode.trim());
            } else {
                sb.append("&sslMode=REQUIRED");
            }
        } else {
            sb.append("&useSSL=false");
        }

        return sb.toString();
    }

    /**
     * Normalizes an incoming database URL.
     * Converts standard URI format (e.g. mysql://user:pass@host:port/dbname?ssl-mode=REQUIRED)
     * into JDBC format (jdbc:mysql://host:port/dbname?sslMode=REQUIRED...).
     */
    private static String normalizeJdbcUrl(String rawUrl) {
        if (rawUrl.startsWith("jdbc:mysql://")) {
            return rawUrl;
        }

        if (rawUrl.startsWith("mysql://")) {
            try {
                URI uri = new URI(rawUrl.replace("mysql://", "http://"));
                String host = uri.getHost();
                int port = uri.getPort() > 0 ? uri.getPort() : 3306;
                String path = uri.getPath();
                if (path != null && path.startsWith("/")) {
                    path = path.substring(1);
                }
                String query = uri.getQuery();

                StringBuilder sb = new StringBuilder();
                sb.append("jdbc:mysql://").append(host).append(":").append(port).append("/").append(path != null ? path : "");
                sb.append("?allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata&characterEncoding=UTF-8");

                if (query != null && !query.isEmpty()) {
                    String normalizedQuery = query.replace("ssl-mode=", "sslMode=");
                    sb.append("&").append(normalizedQuery);
                    if (!normalizedQuery.contains("useSSL")) {
                        sb.append("&useSSL=true");
                    }
                } else if (AppConfig.isDbSslEnabled()) {
                    sb.append("&useSSL=true&sslMode=").append(AppConfig.getDbSslMode());
                }

                return sb.toString();
            } catch (Exception e) {
                System.err.println("[DBConnection] Could not parse URI, prepending jdbc: " + e.getMessage());
                return "jdbc:" + rawUrl;
            }
        }

        return rawUrl;
    }

    private static synchronized void initPool() {
        if (poolInitialized) return;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcUrl = buildJdbcUrl();

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(jdbcUrl);
            config.setUsername(AppConfig.getDbUsername());
            config.setPassword(AppConfig.getDbPassword());
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

            config.setMinimumIdle(AppConfig.getPoolMinIdle());
            config.setMaximumPoolSize(AppConfig.getPoolMaxSize());
            config.setConnectionTimeout(AppConfig.getConnectionTimeout());
            config.setIdleTimeout(600000);
            config.setMaxLifetime(1800000);
            config.setPoolName("WheelyxHikariPool");

            // Recommended MySQL performance optimizations
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
            config.addDataSourceProperty("useServerPrepStmts", "true");

            dataSource = new HikariDataSource(config);
            poolInitialized = true;
            System.out.println("[DBConnection] HikariCP pool initialized successfully with URL: " + maskUrl(jdbcUrl));
        } catch (Exception e) {
            System.err.println("[DBConnection] HikariCP initialization warning: " + e.getMessage() + ". Will use direct connections if pool fails.");
        }
    }

    private static String maskUrl(String url) {
        if (url == null) return "";
        return url.replaceAll("(?i)(password=)[^&]+", "$1*****");
    }

    /**
     * Obtains an active database connection.
     * @return Connection
     * @throws SQLException on database connection error
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource != null && !dataSource.isClosed()) {
            return dataSource.getConnection();
        }

        // Direct fallback if pool is closed or uninitialized
        String jdbcUrl = buildJdbcUrl();
        return DriverManager.getConnection(jdbcUrl, AppConfig.getDbUsername(), AppConfig.getDbPassword());
    }

    /**
     * Tests if the database connection is currently alive.
     * @param timeoutSeconds timeout in seconds
     * @return true if database connection is valid
     */
    public static boolean isHealthy(int timeoutSeconds) {
        try (Connection conn = getConnection()) {
            return conn != null && conn.isValid(timeoutSeconds);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Closes the connection pool on application shutdown.
     */
    public static synchronized void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            poolInitialized = false;
            System.out.println("[DBConnection] HikariCP pool shut down.");
        }
    }
}
