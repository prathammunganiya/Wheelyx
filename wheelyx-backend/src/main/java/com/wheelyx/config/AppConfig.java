package com.wheelyx.config;

import java.io.InputStream;
import java.util.Properties;

/**
 * AppConfig
 * Centralized configuration loader for Wheelyx platform.
 * Reads environment variables first, falling back to db.properties.
 */
public class AppConfig {

    private static final Properties properties = new Properties();

    static {
        try (InputStream is = AppConfig.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is != null) {
                properties.load(is);
            }
        } catch (Exception e) {
            System.err.println("[AppConfig] Notice: Could not load db.properties: " + e.getMessage());
        }
    }

    public static String get(String key, String defaultValue) {
        // Priority 1: System Environment Variable (e.g., DB_HOST -> db.host)
        String envKey = key.replace('.', '_').toUpperCase();
        String envVal = System.getenv(envKey);
        if (envVal != null && !envVal.trim().isEmpty()) {
            return envVal.trim();
        }

        // Priority 2: System Property
        String sysProp = System.getProperty(key);
        if (sysProp != null && !sysProp.trim().isEmpty()) {
            return sysProp.trim();
        }

        // Priority 3: properties file
        return properties.getProperty(key, defaultValue);
    }

    public static String getDbHost() {
        return get("db.host", "localhost");
    }

    public static int getDbPort() {
        return Integer.parseInt(get("db.port", "3306"));
    }

    public static String getDbName() {
        return get("db.name", "wheelyx_vehicle_rental");
    }

    public static String getDbUsername() {
        return get("db.username", "root");
    }

    public static String getDbPassword() {
        return get("db.password", "Root@123");
    }

    public static int getPoolMinIdle() {
        return Integer.parseInt(get("db.pool.minIdle", "5"));
    }

    public static int getPoolMaxSize() {
        return Integer.parseInt(get("db.pool.maxPoolSize", "20"));
    }

    public static String getGoogleMapsApiKey() {
        return get("google.maps.api.key", "");
    }

    public static String getUploadDir() {
        return get("upload.dir", "./uploads/vehicles");
    }
}
