package com.wheelyx;

import com.wheelyx.config.DBConnection;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.*;

public class DatabaseIntegrationTest {

    @Test
    @DisplayName("Should establish valid connection to MySQL wheelyx_vehicle_rental database")
    void testMySQLConnection() {
        try (Connection conn = DBConnection.getConnection()) {
            assertNotNull(conn, "Database connection should not be null");
            assertFalse(conn.isClosed(), "Database connection should be open");
        } catch (Exception e) {
            fail("Failed to connect to MySQL database: " + e.getMessage());
        }
    }

    @Test
    @DisplayName("Should verify exact counts: 20 real cities, 200 places, 6 categories, and 36 real vehicles")
    void testSeedDataCounts() {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // 1. Verify 20 Indian cities
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM cities")) {
                assertTrue(rs.next());
                assertEquals(20, rs.getInt(1), "Database must contain exactly 20 real Indian cities");
            }

            // 2. Verify 200 real places (10 per city)
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM city_places")) {
                assertTrue(rs.next());
                assertEquals(200, rs.getInt(1), "Database must contain exactly 200 famous landmarks (10 per city)");
            }

            // 3. Verify 6 vehicle categories
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM vehicle_categories")) {
                assertTrue(rs.next());
                assertEquals(6, rs.getInt(1), "Database must contain exactly 6 vehicle categories");
            }

            // 4. Verify 36 real vehicles
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM vehicles")) {
                assertTrue(rs.next());
                assertEquals(36, rs.getInt(1), "Database must contain exactly 36 real vehicle models");
            }

            // 5. Verify zero fake reviews
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM reviews")) {
                assertTrue(rs.next());
                assertEquals(0, rs.getInt(1), "Reviews table must start with 0 fake reviews");
            }

        } catch (Exception e) {
            fail("Database assertion query failed: " + e.getMessage());
        }
    }
}
