package com.wheelyx.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection
 * Production-ready connection pool manager using HikariCP with graceful fallback.
 * Strictly uses Parameterized PreparedStatements across all DAO calls.
 */
public class DBConnection {

    private static HikariDataSource dataSource;
    private static boolean poolInitialized = false;

    static {
        initPool();
    }

    private static synchronized void initPool() {
        if (poolInitialized) return;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcUrl = String.format(
                "jdbc:mysql://%s:%d/%s?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata&characterEncoding=UTF-8",
                AppConfig.getDbHost(),
                AppConfig.getDbPort(),
                AppConfig.getDbName()
            );

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(jdbcUrl);
            config.setUsername(AppConfig.getDbUsername());
            config.setPassword(AppConfig.getDbPassword());
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

            config.setMinimumIdle(AppConfig.getPoolMinIdle());
            config.setMaximumPoolSize(AppConfig.getPoolMaxSize());
            config.setConnectionTimeout(30000);
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
            System.out.println("[DBConnection] HikariCP pool initialized successfully.");
        } catch (Exception e) {
            System.err.println("[DBConnection] HikariCP initialization warning: " + e.getMessage() + ". Will use direct connections if pool fails.");
        }
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
        String jdbcUrl = String.format(
            "jdbc:mysql://%s:%d/%s?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata&characterEncoding=UTF-8",
            AppConfig.getDbHost(),
            AppConfig.getDbPort(),
            AppConfig.getDbName()
        );
        return DriverManager.getConnection(jdbcUrl, AppConfig.getDbUsername(), AppConfig.getDbPassword());
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
