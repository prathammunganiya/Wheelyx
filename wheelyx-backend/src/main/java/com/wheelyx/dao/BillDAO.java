package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.Bill;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public Bill findById(Long id) {
        String sql = "SELECT bl.*, b.booking_code, u.name as customer_name, u.email as customer_email, " +
                     "u.phone as customer_phone, v.model_name as vehicle_model, v.registration_no, " +
                     "p.payment_method, p.transaction_id " +
                     "FROM bills bl " +
                     "JOIN bookings b ON bl.booking_id = b.id " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "LEFT JOIN payments p ON p.bill_id = bl.id " +
                     "WHERE bl.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapBill(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Bill findByBookingId(Long bookingId) {
        String sql = "SELECT bl.*, b.booking_code, u.name as customer_name, u.email as customer_email, " +
                     "u.phone as customer_phone, v.model_name as vehicle_model, v.registration_no, " +
                     "p.payment_method, p.transaction_id " +
                     "FROM bills bl " +
                     "JOIN bookings b ON bl.booking_id = b.id " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "LEFT JOIN payments p ON p.bill_id = bl.id " +
                     "WHERE bl.booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapBill(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Bill findByBillNo(String billNo) {
        String sql = "SELECT bl.*, b.booking_code, u.name as customer_name, u.email as customer_email, " +
                     "u.phone as customer_phone, v.model_name as vehicle_model, v.registration_no, " +
                     "p.payment_method, p.transaction_id " +
                     "FROM bills bl " +
                     "JOIN bookings b ON bl.booking_id = b.id " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "LEFT JOIN payments p ON p.bill_id = bl.id " +
                     "WHERE bl.bill_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, billNo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapBill(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean create(Bill bill) {
        String sql = "INSERT INTO bills (bill_no, booking_id, rental_id, base_amount, security_deposit, " +
                     "tax_amount, discount_amount, final_amount, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, bill.getBillNo());
            stmt.setLong(2, bill.getBookingId());
            if (bill.getRentalId() != null) {
                stmt.setLong(3, bill.getRentalId());
            } else {
                stmt.setNull(3, Types.BIGINT);
            }
            stmt.setBigDecimal(4, bill.getBaseAmount());
            stmt.setBigDecimal(5, bill.getSecurityDeposit());
            stmt.setBigDecimal(6, bill.getTaxAmount());
            stmt.setBigDecimal(7, bill.getDiscountAmount());
            stmt.setBigDecimal(8, bill.getFinalAmount());
            stmt.setString(9, bill.getStatus() != null ? bill.getStatus() : "PAID");

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        bill.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Bill> findAll(int offset, int limit) {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT bl.*, b.booking_code, u.name as customer_name, u.email as customer_email, " +
                     "u.phone as customer_phone, v.model_name as vehicle_model, v.registration_no, " +
                     "p.payment_method, p.transaction_id " +
                     "FROM bills bl " +
                     "JOIN bookings b ON bl.booking_id = b.id " +
                     "JOIN users u ON b.customer_id = u.id " +
                     "JOIN vehicles v ON b.vehicle_id = v.id " +
                     "LEFT JOIN payments p ON p.bill_id = bl.id " +
                     "ORDER BY bl.id DESC LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBill(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Bill mapBill(ResultSet rs) throws SQLException {
        Bill bl = new Bill();
        bl.setId(rs.getLong("id"));
        bl.setBillNo(rs.getString("bill_no"));
        bl.setBookingId(rs.getLong("booking_id"));
        long rId = rs.getLong("rental_id");
        if (!rs.wasNull()) {
            bl.setRentalId(rId);
        }
        bl.setBaseAmount(rs.getBigDecimal("base_amount"));
        bl.setSecurityDeposit(rs.getBigDecimal("security_deposit"));
        bl.setTaxAmount(rs.getBigDecimal("tax_amount"));
        bl.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        bl.setFinalAmount(rs.getBigDecimal("final_amount"));
        bl.setStatus(rs.getString("status"));
        bl.setCreatedAt(rs.getTimestamp("created_at"));

        bl.setBookingCode(rs.getString("booking_code"));
        bl.setCustomerName(rs.getString("customer_name"));
        bl.setCustomerEmail(rs.getString("customer_email"));
        bl.setCustomerPhone(rs.getString("customer_phone"));
        bl.setVehicleModel(rs.getString("vehicle_model"));
        bl.setRegistrationNo(rs.getString("registration_no"));
        bl.setPaymentMethod(rs.getString("payment_method"));
        bl.setTransactionId(rs.getString("transaction_id"));
        return bl;
    }
}
