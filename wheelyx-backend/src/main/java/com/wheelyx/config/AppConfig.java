package com.wheelyx.config;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStream;
import java.util.Properties;

/**
 * AppConfig
 * Centralized configuration loader for Wheelyx platform.
 * Supports:
 *   1. System Environment Variables (priority in production / Railway)
 *   2. System Properties (-Djvm arguments)
 *   3. .env file (for local development)
 *   4. db.properties fallback (classpath resource)
 *
 * Fully configured for Aiven MySQL with required SSL support and Railway runtime variables.
 */
public class AppConfig {

    private static final Properties properties = new Properties();
    private static final Properties dotEnvProperties = new Properties();

    static {
        // 1. Load db.properties from classpath as base defaults
        try (InputStream is = AppConfig.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is != null) {
                properties.load(is);
            }
        } catch (Exception e) {
            System.err.println("[AppConfig] Notice: Could not load db.properties: " + e.getMessage());
        }

        // 2. Load .env file if available
        loadDotEnv();
    }

    private static void loadDotEnv() {
        File[] candidateFiles = new File[]{
            new File(".env"),
            new File("wheelyx-backend/.env"),
            new File("../.env")
        };

        for (File candidate : candidateFiles) {
            if (candidate.exists() && candidate.isFile() && candidate.canRead()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(candidate))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        line = line.trim();
                        if (line.isEmpty() || line.startsWith("#")) {
                            continue;
                        }
                        int eqIdx = line.indexOf('=');
                        if (eqIdx > 0) {
                            String key = line.substring(0, eqIdx).trim();
                            String val = line.substring(eqIdx + 1).trim();
                            // Strip surrounding single or double quotes
                            if ((val.startsWith("\"") && val.endsWith("\"")) ||
                                (val.startsWith("'") && val.endsWith("'"))) {
                                val = val.substring(1, val.length() - 1);
                            }
                            if (!key.isEmpty()) {
                                dotEnvProperties.setProperty(key, val);
                            }
                        }
                    }
                    System.out.println("[AppConfig] Loaded local configuration from " + candidate.getPath());
                    break;
                } catch (Exception e) {
                    System.err.println("[AppConfig] Notice: Could not parse .env file: " + e.getMessage());
                }
            }
        }
    }

    /**
     * Resolves configuration key following strict precedence:
     * 1. OS Environment Variable (e.g. DB_HOST, MYSQLHOST)
     * 2. JVM System Property (e.g. -Ddb.host)
     * 3. .env File Property
     * 4. db.properties Classpath Resource
     * 5. Default Value
     */
    public static String get(String key, String defaultValue) {
        String envKey = key.replace('.', '_').toUpperCase();

        // Priority 1: System Environment Variable
        String envVal = System.getenv(envKey);
        if (envVal != null && !envVal.trim().isEmpty()) {
            return envVal.trim();
        }

        // Priority 2: System Property
        String sysProp = System.getProperty(key);
        if (sysProp != null && !sysProp.trim().isEmpty()) {
            return sysProp.trim();
        }

        // Priority 3: .env property
        String dotEnvVal = dotEnvProperties.getProperty(envKey);
        if (dotEnvVal == null || dotEnvVal.trim().isEmpty()) {
            dotEnvVal = dotEnvProperties.getProperty(key);
        }
        if (dotEnvVal != null && !dotEnvVal.trim().isEmpty()) {
            return dotEnvVal.trim();
        }

        // Priority 4: db.properties fallback
        return properties.getProperty(key, defaultValue);
    }

    /**
     * Helper to check multiple environment variable aliases in order.
     */
    private static String getFirstOf(String[] keys, String defaultValue) {
        for (String k : keys) {
            String val = get(k, null);
            if (val != null && !val.trim().isEmpty()) {
                return val.trim();
            }
        }
        return defaultValue;
    }

    public static String getDbUrl() {
        return getFirstOf(new String[]{
            "db.url", "DB_URL", "DATABASE_URL", "MYSQL_URL", "JDBC_DATABASE_URL"
        }, null);
    }

    public static String getDbHost() {
        return getFirstOf(new String[]{
            "db.host", "DB_HOST", "MYSQLHOST"
        }, "localhost");
    }

    public static int getDbPort() {
        String portStr = getFirstOf(new String[]{
            "db.port", "DB_PORT", "MYSQLPORT"
        }, "3306");
        try {
            return Integer.parseInt(portStr);
        } catch (NumberFormatException e) {
            return 3306;
        }
    }

    public static String getDbName() {
        return getFirstOf(new String[]{
            "db.name", "DB_NAME", "MYSQLDATABASE"
        }, "wheelyx_vehicle_rental");
    }

    public static String getDbUsername() {
        return getFirstOf(new String[]{
            "db.username", "DB_USERNAME", "DB_USER", "MYSQLUSER"
        }, "root");
    }

    public static String getDbPassword() {
        return getFirstOf(new String[]{
            "db.password", "DB_PASSWORD", "MYSQLPASSWORD"
        }, "Root@123");
    }

    /**
     * Determines whether SSL is enabled.
     * Auto-enables SSL if connecting to an Aiven MySQL cluster (*.aivencloud.com).
     */
    public static boolean isDbSslEnabled() {
        String host = getDbHost();
        if (host != null && host.toLowerCase().contains("aivencloud.com")) {
            return true;
        }
        String sslVal = getFirstOf(new String[]{
            "db.ssl", "DB_SSL", "DB_USE_SSL", "db.use.ssl"
        }, null);

        if (sslVal != null) {
            return "true".equalsIgnoreCase(sslVal) || "required".equalsIgnoreCase(sslVal) || "1".equals(sslVal);
        }

        String rawMode = getFirstOf(new String[]{
            "db.ssl.mode", "DB_SSL_MODE", "SSL_MODE"
        }, null);
        if (rawMode != null) {
            return !rawMode.equalsIgnoreCase("DISABLED") && !rawMode.equalsIgnoreCase("false");
        }
        return false;
    }

    /**
     * Returns MySQL SSL mode (e.g. REQUIRED, VERIFY_CA, VERIFY_IDENTITY, DISABLED).
     * Defaults to "REQUIRED" for Aiven and cloud databases.
     */
    public static String getDbSslMode() {
        String defaultMode = isDbSslEnabled() ? "REQUIRED" : "DISABLED";
        return getFirstOf(new String[]{
            "db.ssl.mode", "DB_SSL_MODE", "SSL_MODE"
        }, defaultMode);
    }

    public static int getPoolMinIdle() {
        String minIdle = getFirstOf(new String[]{
            "db.pool.minIdle", "DB_POOL_MIN_IDLE"
        }, "5");
        return Integer.parseInt(minIdle);
    }

    public static int getPoolMaxSize() {
        String maxSize = getFirstOf(new String[]{
            "db.pool.maxPoolSize", "DB_POOL_MAX_SIZE"
        }, "20");
        return Integer.parseInt(maxSize);
    }

    public static int getConnectionTimeout() {
        String timeout = getFirstOf(new String[]{
            "db.pool.connectionTimeout", "DB_POOL_TIMEOUT"
        }, "30000");
        return Integer.parseInt(timeout);
    }

    public static String getCorsAllowedOrigins() {
        return getFirstOf(new String[]{
            "cors.allowed.origins", "CORS_ALLOWED_ORIGINS"
        }, "*");
    }

    public static int getServerPort() {
        String port = getFirstOf(new String[]{
            "PORT", "SERVER_PORT", "port"
        }, "8080");
        try {
            return Integer.parseInt(port);
        } catch (NumberFormatException e) {
            return 8080;
        }
    }

    public static String getGoogleMapsApiKey() {
        return getFirstOf(new String[]{
            "google.maps.api.key", "GOOGLE_MAPS_API_KEY"
        }, "");
    }

    public static String getUploadDir() {
        return getFirstOf(new String[]{
            "upload.dir", "UPLOAD_DIR"
        }, "./uploads/vehicles");
    }
}
