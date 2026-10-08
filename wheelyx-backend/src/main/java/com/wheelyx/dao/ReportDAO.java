package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

public class ReportDAO {

    public Map<String, Object> getAdminKpis() {
        Map<String, Object> kpis = new HashMap<>();
        String sql = "SELECT " +
                "(SELECT COUNT(*) FROM users WHERE role = 'CUSTOMER') as total_customers, " +
                "(SELECT COUNT(*) FROM users WHERE role = 'OWNER') as total_owners, " +
                "(SELECT COUNT(*) FROM vehicles) as total_vehicles, " +
                "(SELECT COUNT(*) FROM vehicles WHERE status = 'AVAILABLE') as available_vehicles, " +
                "(SELECT COUNT(*) FROM vehicles WHERE status = 'BOOKED') as booked_vehicles, " +
                "(SELECT COUNT(*) FROM vehicles WHERE status = 'ACTIVE_RENTAL') as active_rentals, " +
                "(SELECT COUNT(*) FROM vehicles WHERE status = 'MAINTENANCE') as maintenance_vehicles, " +
                "(SELECT COUNT(*) FROM bookings) as total_bookings, " +
                "(SELECT COALESCE(SUM(final_amount), 0.00) FROM bills WHERE status = 'PAID') as total_revenue, " +
                "(SELECT COUNT(*) FROM reviews) as total_reviews";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                kpis.put("totalCustomers", rs.getInt("total_customers"));
                kpis.put("totalOwners", rs.getInt("total_owners"));
                kpis.put("totalVehicles", rs.getInt("total_vehicles"));
                kpis.put("availableVehicles", rs.getInt("available_vehicles"));
                kpis.put("bookedVehicles", rs.getInt("booked_vehicles"));
                kpis.put("activeRentals", rs.getInt("active_rentals"));
                kpis.put("maintenanceVehicles", rs.getInt("maintenance_vehicles"));
                kpis.put("totalBookings", rs.getInt("total_bookings"));
                kpis.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                kpis.put("totalReviews", rs.getInt("total_reviews"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return kpis;
    }

    public Map<String, Object> getOwnerKpis(Long ownerId) {
        Map<String, Object> kpis = new HashMap<>();
        String sql = "SELECT " +
                "(SELECT COUNT(*) FROM vehicles WHERE owner_id = ?) as total_vehicles, " +
                "(SELECT COUNT(*) FROM vehicles WHERE owner_id = ? AND status = 'AVAILABLE') as available_vehicles, " +
                "(SELECT COUNT(*) FROM vehicles WHERE owner_id = ? AND status = 'ACTIVE_RENTAL') as rented_vehicles, " +
                "(SELECT COUNT(*) FROM bookings b JOIN vehicles v ON b.vehicle_id = v.id WHERE v.owner_id = ? AND b.status = 'PENDING') as pending_requests, " +
                "(SELECT COUNT(*) FROM rentals r JOIN vehicles v ON r.vehicle_id = v.id WHERE v.owner_id = ? AND r.status = 'ACTIVE_RENTAL') as active_rentals, " +
                "(SELECT COUNT(*) FROM rentals r JOIN vehicles v ON r.vehicle_id = v.id WHERE v.owner_id = ? AND r.status = 'RETURNED') as completed_rentals, " +
                "(SELECT COALESCE(SUM(bl.final_amount), 0.00) FROM bills bl JOIN bookings b ON bl.booking_id = b.id JOIN vehicles v ON b.vehicle_id = v.id WHERE v.owner_id = ? AND bl.status = 'PAID') as total_earnings";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 1; i <= 7; i++) {
                stmt.setLong(i, ownerId);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    kpis.put("totalVehicles", rs.getInt("total_vehicles"));
                    kpis.put("availableVehicles", rs.getInt("available_vehicles"));
                    kpis.put("rentedVehicles", rs.getInt("rented_vehicles"));
                    kpis.put("pendingRequests", rs.getInt("pending_requests"));
                    kpis.put("activeRentals", rs.getInt("active_rentals"));
                    kpis.put("completedRentals", rs.getInt("completed_rentals"));
                    kpis.put("totalEarnings", rs.getBigDecimal("total_earnings"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return kpis;
    }

    public Map<String, Integer> getBookingsByCategory() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT vc.category_name, COUNT(b.id) as booking_count " +
                     "FROM vehicle_categories vc " +
                     "LEFT JOIN vehicles v ON v.category_id = vc.id " +
                     "LEFT JOIN bookings b ON b.vehicle_id = v.id " +
                     "GROUP BY vc.id, vc.category_name ORDER BY vc.id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("category_name"), rs.getInt("booking_count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    public Map<String, Integer> getVehiclesByCity() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT ci.city_name, COUNT(v.id) as vehicle_count " +
                     "FROM cities ci " +
                     "JOIN vehicles v ON v.city_id = ci.id " +
                     "GROUP BY ci.id, ci.city_name " +
                     "ORDER BY vehicle_count DESC LIMIT 8";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("city_name"), rs.getInt("vehicle_count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
}
