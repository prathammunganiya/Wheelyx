package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public Booking findById(Long id) {
        String sql = "SELECT b.*, u.name as customer_name, u.email as customer_email, u.phone as customer_phone, " +
                     "v.model_name as vehicle_model, v.image_url as vehicle_image, v.registration_no, " +
                     "ci.city_name, cp1.place_name as pickup_place_name, cp2.place_name as return_place_name, " +
                     "r.id as rental_id, r.status as rental_status " +
                     "FROM bookings b " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "JOIN cities ci ON b.city_id = ci.id " +
                     "JOIN city_places cp1 ON b.pickup_place_id = cp1.id " +
                     "JOIN city_places cp2 ON b.return_place_id = cp2.id " +
                     "LEFT JOIN rentals r ON r.booking_id = b.id " +
                     "WHERE b.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Booking findByCode(String code) {
        String sql = "SELECT b.*, u.name as customer_name, u.email as customer_email, u.phone as customer_phone, " +
                     "v.model_name as vehicle_model, v.image_url as vehicle_image, v.registration_no, " +
                     "ci.city_name, cp1.place_name as pickup_place_name, cp2.place_name as return_place_name, " +
                     "r.id as rental_id, r.status as rental_status " +
                     "FROM bookings b " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "JOIN cities ci ON b.city_id = ci.id " +
                     "JOIN city_places cp1 ON b.pickup_place_id = cp1.id " +
                     "JOIN city_places cp2 ON b.return_place_id = cp2.id " +
                     "LEFT JOIN rentals r ON r.booking_id = b.id " +
                     "WHERE b.booking_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Booking> findByCustomerId(Long customerId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, u.name as customer_name, u.email as customer_email, u.phone as customer_phone, " +
                     "v.model_name as vehicle_model, v.image_url as vehicle_image, v.registration_no, " +
                     "ci.city_name, cp1.place_name as pickup_place_name, cp2.place_name as return_place_name, " +
                     "r.id as rental_id, r.status as rental_status " +
                     "FROM bookings b " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "JOIN cities ci ON b.city_id = ci.id " +
                     "JOIN city_places cp1 ON b.pickup_place_id = cp1.id " +
                     "JOIN city_places cp2 ON b.return_place_id = cp2.id " +
                     "LEFT JOIN rentals r ON r.booking_id = b.id " +
                     "WHERE b.customer_id = ? ORDER BY b.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Booking> findByOwnerId(Long ownerId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, u.name as customer_name, u.email as customer_email, u.phone as customer_phone, " +
                     "v.model_name as vehicle_model, v.image_url as vehicle_image, v.registration_no, " +
                     "ci.city_name, cp1.place_name as pickup_place_name, cp2.place_name as return_place_name, " +
                     "r.id as rental_id, r.status as rental_status " +
                     "FROM bookings b " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "JOIN cities ci ON b.city_id = ci.id " +
                     "JOIN city_places cp1 ON b.pickup_place_id = cp1.id " +
                     "JOIN city_places cp2 ON b.return_place_id = cp2.id " +
                     "LEFT JOIN rentals r ON r.booking_id = b.id " +
                     "WHERE v.owner_id = ? ORDER BY b.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, ownerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Booking> findAll(String status, int offset, int limit) {
        List<Booking> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT b.*, u.name as customer_name, u.email as customer_email, u.phone as customer_phone, " +
            "v.model_name as vehicle_model, v.image_url as vehicle_image, v.registration_no, " +
            "ci.city_name, cp1.place_name as pickup_place_name, cp2.place_name as return_place_name, " +
            "r.id as rental_id, r.status as rental_status " +
            "FROM bookings b " +
            "JOIN users u ON b.customer_id = u.id " +
            "JOIN vehicles v ON b.vehicle_id = v.id " +
            "JOIN cities ci ON b.city_id = ci.id " +
            "JOIN city_places cp1 ON b.pickup_place_id = cp1.id " +
            "JOIN city_places cp2 ON b.return_place_id = cp2.id " +
            "LEFT JOIN rentals r ON r.booking_id = b.id " +
            "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append(" AND b.status = ?");
            params.add(status.trim().toUpperCase());
        }
        sql.append(" ORDER BY b.id DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean create(Booking b) {
        String sql = "INSERT INTO bookings (booking_code, customer_id, vehicle_id, city_id, pickup_place_id, " +
                     "return_place_id, start_date, end_date, duration_days, base_amount, deposit_amount, " +
                     "tax_amount, discount_amount, total_amount, status, notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, b.getBookingCode());
            stmt.setLong(2, b.getCustomerId());
            stmt.setLong(3, b.getVehicleId());
            stmt.setInt(4, b.getCityId());
            stmt.setLong(5, b.getPickupPlaceId());
            stmt.setLong(6, b.getReturnPlaceId());
            stmt.setDate(7, b.getStartDate());
            stmt.setDate(8, b.getEndDate());
            stmt.setInt(9, b.getDurationDays());
            stmt.setBigDecimal(10, b.getBaseAmount());
            stmt.setBigDecimal(11, b.getDepositAmount());
            stmt.setBigDecimal(12, b.getTaxAmount());
            stmt.setBigDecimal(13, b.getDiscountAmount());
            stmt.setBigDecimal(14, b.getTotalAmount());
            stmt.setString(15, b.getStatus() != null ? b.getStatus() : "CONFIRMED");
            stmt.setString(16, b.getNotes());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        b.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Booking b) {
        String sql = "UPDATE bookings SET pickup_place_id = ?, return_place_id = ?, start_date = ?, " +
                     "end_date = ?, duration_days = ?, base_amount = ?, tax_amount = ?, discount_amount = ?, " +
                     "total_amount = ?, notes = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, b.getPickupPlaceId());
            stmt.setLong(2, b.getReturnPlaceId());
            stmt.setDate(3, b.getStartDate());
            stmt.setDate(4, b.getEndDate());
            stmt.setInt(5, b.getDurationDays());
            stmt.setBigDecimal(6, b.getBaseAmount());
            stmt.setBigDecimal(7, b.getTaxAmount());
            stmt.setBigDecimal(8, b.getDiscountAmount());
            stmt.setBigDecimal(9, b.getTotalAmount());
            stmt.setString(10, b.getNotes());
            stmt.setLong(11, b.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(Long id, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setLong(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getLong("id"));
        b.setBookingCode(rs.getString("booking_code"));
        b.setCustomerId(rs.getLong("customer_id"));
        b.setVehicleId(rs.getLong("vehicle_id"));
        b.setCityId(rs.getInt("city_id"));
        b.setPickupPlaceId(rs.getLong("pickup_place_id"));
        b.setReturnPlaceId(rs.getLong("return_place_id"));
        b.setStartDate(rs.getDate("start_date"));
        b.setEndDate(rs.getDate("end_date"));
        b.setDurationDays(rs.getInt("duration_days"));
        b.setBaseAmount(rs.getBigDecimal("base_amount"));
        b.setDepositAmount(rs.getBigDecimal("deposit_amount"));
        b.setTaxAmount(rs.getBigDecimal("tax_amount"));
        b.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        b.setTotalAmount(rs.getBigDecimal("total_amount"));
        b.setStatus(rs.getString("status"));
        b.setNotes(rs.getString("notes"));
        b.setCreatedAt(rs.getTimestamp("created_at"));
        b.setUpdatedAt(rs.getTimestamp("updated_at"));

        b.setCustomerName(rs.getString("customer_name"));
        b.setCustomerEmail(rs.getString("customer_email"));
        b.setCustomerPhone(rs.getString("customer_phone"));
        b.setVehicleModel(rs.getString("vehicle_model"));
        b.setVehicleImage(rs.getString("vehicle_image"));
        b.setRegistrationNo(rs.getString("registration_no"));
        b.setCityName(rs.getString("city_name"));
        b.setPickupPlaceName(rs.getString("pickup_place_name"));
        b.setReturnPlaceName(rs.getString("return_place_name"));

        long rId = rs.getLong("rental_id");
        if (!rs.wasNull()) {
            b.setRentalId(rId);
            b.setRentalStatus(rs.getString("rental_status"));
        }
        return b;
    }
}
