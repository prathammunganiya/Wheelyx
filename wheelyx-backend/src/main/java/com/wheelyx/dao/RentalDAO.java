package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.Rental;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RentalDAO {

    public Rental findById(Long id) {
        String sql = "SELECT r.*, b.booking_code, v.model_name as vehicle_model, v.image_url as vehicle_image, " +
                     "v.registration_no, u.name as customer_name, " +
                     "EXISTS(SELECT 1 FROM reviews rw WHERE rw.rental_id = r.id) as has_review " +
                     "FROM rentals r " +
                     "JOIN bookings b ON r.booking_id = b.id " +
                     "JOIN vehicles v ON r.vehicle_id = v.id " +
                     "JOIN users u ON r.customer_id = u.id " +
                     "WHERE r.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRental(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Rental findByBookingId(Long bookingId) {
        String sql = "SELECT r.*, b.booking_code, v.model_name as vehicle_model, v.image_url as vehicle_image, " +
                     "v.registration_no, u.name as customer_name, " +
                     "EXISTS(SELECT 1 FROM reviews rw WHERE rw.rental_id = r.id) as has_review " +
                     "FROM rentals r " +
                     "JOIN bookings b ON r.booking_id = b.id " +
                     "JOIN vehicles v ON r.vehicle_id = v.id " +
                     "JOIN users u ON r.customer_id = u.id " +
                     "WHERE r.booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRental(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Rental> findByCustomerId(Long customerId) {
        List<Rental> list = new ArrayList<>();
        String sql = "SELECT r.*, b.booking_code, v.model_name as vehicle_model, v.image_url as vehicle_image, " +
                     "v.registration_no, u.name as customer_name, " +
                     "EXISTS(SELECT 1 FROM reviews rw WHERE rw.rental_id = r.id) as has_review " +
                     "FROM rentals r " +
                     "JOIN bookings b ON r.booking_id = b.id " +
                     "JOIN vehicles v ON r.vehicle_id = v.id " +
                     "JOIN users u ON r.customer_id = u.id " +
                     "WHERE r.customer_id = ? ORDER BY r.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRental(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Rental> findByOwnerId(Long ownerId) {
        List<Rental> list = new ArrayList<>();
        String sql = "SELECT r.*, b.booking_code, v.model_name as vehicle_model, v.image_url as vehicle_image, " +
                     "v.registration_no, u.name as customer_name, " +
                     "EXISTS(SELECT 1 FROM reviews rw WHERE rw.rental_id = r.id) as has_review " +
                     "FROM rentals r " +
                     "JOIN bookings b ON r.booking_id = b.id " +
                     "JOIN vehicles v ON r.vehicle_id = v.id " +
                     "JOIN users u ON r.customer_id = u.id " +
                     "WHERE v.owner_id = ? ORDER BY r.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, ownerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRental(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Rental> findAll(String status, int offset, int limit) {
        List<Rental> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT r.*, b.booking_code, v.model_name as vehicle_model, v.image_url as vehicle_image, " +
            "v.registration_no, u.name as customer_name, " +
            "EXISTS(SELECT 1 FROM reviews rw WHERE rw.rental_id = r.id) as has_review " +
            "FROM rentals r " +
            "JOIN bookings b ON r.booking_id = b.id " +
            "JOIN vehicles v ON r.vehicle_id = v.id " +
            "JOIN users u ON r.customer_id = u.id " +
            "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append(" AND r.status = ?");
            params.add(status.trim().toUpperCase());
        }
        sql.append(" ORDER BY r.id DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRental(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean create(Rental r) {
        String sql = "INSERT INTO rentals (rental_code, booking_id, vehicle_id, customer_id, handover_time, " +
                     "start_odometer, fuel_level_start, status, handover_notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, r.getRentalCode());
            stmt.setLong(2, r.getBookingId());
            stmt.setLong(3, r.getVehicleId());
            stmt.setLong(4, r.getCustomerId());
            stmt.setTimestamp(5, r.getHandoverTime() != null ? r.getHandoverTime() : new Timestamp(System.currentTimeMillis()));
            stmt.setInt(6, r.getStartOdometer() != null ? r.getStartOdometer() : 0);
            stmt.setString(7, r.getFuelLevelStart() != null ? r.getFuelLevelStart() : "Full");
            stmt.setString(8, r.getStatus() != null ? r.getStatus() : "ACTIVE_RENTAL");
            stmt.setString(9, r.getHandoverNotes());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        r.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean returnVehicle(Long rentalId, int endOdometer, String fuelLevelEnd, String returnNotes) {
        String sql = "UPDATE rentals SET return_time = CURRENT_TIMESTAMP, end_odometer = ?, " +
                     "fuel_level_end = ?, status = 'RETURNED', return_notes = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, endOdometer);
            stmt.setString(2, fuelLevelEnd != null ? fuelLevelEnd : "Full");
            stmt.setString(3, returnNotes);
            stmt.setLong(4, rentalId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Rental mapRental(ResultSet rs) throws SQLException {
        Rental r = new Rental();
        r.setId(rs.getLong("id"));
        r.setRentalCode(rs.getString("rental_code"));
        r.setBookingId(rs.getLong("booking_id"));
        r.setVehicleId(rs.getLong("vehicle_id"));
        r.setCustomerId(rs.getLong("customer_id"));
        r.setHandoverTime(rs.getTimestamp("handover_time"));
        r.setReturnTime(rs.getTimestamp("return_time"));
        r.setStartOdometer(rs.getInt("start_odometer"));
        r.setEndOdometer(rs.getInt("end_odometer"));
        r.setFuelLevelStart(rs.getString("fuel_level_start"));
        r.setFuelLevelEnd(rs.getString("fuel_level_end"));
        r.setStatus(rs.getString("status"));
        r.setHandoverNotes(rs.getString("handover_notes"));
        r.setReturnNotes(rs.getString("return_notes"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        r.setUpdatedAt(rs.getTimestamp("updated_at"));

        r.setBookingCode(rs.getString("booking_code"));
        r.setVehicleModel(rs.getString("vehicle_model"));
        r.setVehicleImage(rs.getString("vehicle_image"));
        r.setRegistrationNo(rs.getString("registration_no"));
        r.setCustomerName(rs.getString("customer_name"));
        r.setHasReview(rs.getBoolean("has_review"));
        return r;
    }
}
