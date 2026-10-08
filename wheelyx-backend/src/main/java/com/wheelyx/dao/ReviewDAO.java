package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public List<Review> findAll(int limit) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT rw.*, u.name as customer_name, v.model_name as vehicle_model, " +
                     "v.image_url as vehicle_image, r.rental_code " +
                     "FROM reviews rw " +
                     "JOIN users u ON rw.customer_id = u.id " +
                     "JOIN vehicles v ON rw.vehicle_id = v.id " +
                     "JOIN rentals r ON rw.rental_id = r.id " +
                     "ORDER BY rw.id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit > 0 ? limit : 20);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapReview(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Review> findByVehicleId(Long vehicleId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT rw.*, u.name as customer_name, v.model_name as vehicle_model, " +
                     "v.image_url as vehicle_image, r.rental_code " +
                     "FROM reviews rw " +
                     "JOIN users u ON rw.customer_id = u.id " +
                     "JOIN vehicles v ON rw.vehicle_id = v.id " +
                     "JOIN rentals r ON rw.rental_id = r.id " +
                     "WHERE rw.vehicle_id = ? ORDER BY rw.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, vehicleId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapReview(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Review findByRentalId(Long rentalId) {
        String sql = "SELECT rw.*, u.name as customer_name, v.model_name as vehicle_model, " +
                     "v.image_url as vehicle_image, r.rental_code " +
                     "FROM reviews rw " +
                     "JOIN users u ON rw.customer_id = u.id " +
                     "JOIN vehicles v ON rw.vehicle_id = v.id " +
                     "JOIN rentals r ON rw.rental_id = r.id " +
                     "WHERE rw.rental_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, rentalId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapReview(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean create(Review rw) {
        String sql = "INSERT INTO reviews (rental_id, customer_id, vehicle_id, rating, comment) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, rw.getRentalId());
            stmt.setLong(2, rw.getCustomerId());
            stmt.setLong(3, rw.getVehicleId());
            stmt.setInt(4, rw.getRating());
            stmt.setString(5, rw.getComment());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        rw.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM reviews";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Review mapReview(ResultSet rs) throws SQLException {
        Review rw = new Review();
        rw.setId(rs.getLong("id"));
        rw.setRentalId(rs.getLong("rental_id"));
        rw.setCustomerId(rs.getLong("customer_id"));
        rw.setVehicleId(rs.getLong("vehicle_id"));
        rw.setRating(rs.getInt("rating"));
        rw.setComment(rs.getString("comment"));
        rw.setCreatedAt(rs.getTimestamp("created_at"));

        rw.setCustomerName(rs.getString("customer_name"));
        rw.setVehicleModel(rs.getString("vehicle_model"));
        rw.setVehicleImage(rs.getString("vehicle_image"));
        rw.setRentalCode(rs.getString("rental_code"));
        return rw;
    }
}
