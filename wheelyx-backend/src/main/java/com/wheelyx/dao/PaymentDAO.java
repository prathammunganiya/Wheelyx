package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public Payment findById(Long id) {
        String sql = "SELECT p.*, bl.bill_no, b.booking_code, u.name as customer_name " +
                     "FROM payments p " +
                     "JOIN bills bl ON p.bill_id = bl.id " +
                     "JOIN bookings b ON p.booking_id = b.id " +
                     "JOIN users u ON p.customer_id = u.id " +
                     "WHERE p.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapPayment(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Payment> findByCustomerId(Long customerId) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT p.*, bl.bill_no, b.booking_code, u.name as customer_name " +
                     "FROM payments p " +
                     "JOIN bills bl ON p.bill_id = bl.id " +
                     "JOIN bookings b ON p.booking_id = b.id " +
                     "JOIN users u ON p.customer_id = u.id " +
                     "WHERE p.customer_id = ? ORDER BY p.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapPayment(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Payment> findAll(int offset, int limit) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT p.*, bl.bill_no, b.booking_code, u.name as customer_name " +
                     "FROM payments p " +
                     "JOIN bills bl ON p.bill_id = bl.id " +
                     "JOIN bookings b ON p.booking_id = b.id " +
                     "JOIN users u ON p.customer_id = u.id " +
                     "ORDER BY p.id DESC LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapPayment(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean create(Payment p) {
        String sql = "INSERT INTO payments (transaction_id, bill_id, booking_id, customer_id, " +
                     "payment_method, amount, status, gateway_ref) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, p.getTransactionId());
            stmt.setLong(2, p.getBillId());
            stmt.setLong(3, p.getBookingId());
            stmt.setLong(4, p.getCustomerId());
            stmt.setString(5, p.getPaymentMethod());
            stmt.setBigDecimal(6, p.getAmount());
            stmt.setString(7, p.getStatus() != null ? p.getStatus() : "SUCCESS");
            stmt.setString(8, p.getGatewayRef());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        p.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Payment mapPayment(ResultSet rs) throws SQLException {
        Payment p = new Payment();
        p.setId(rs.getLong("id"));
        p.setTransactionId(rs.getString("transaction_id"));
        p.setBillId(rs.getLong("bill_id"));
        p.setBookingId(rs.getLong("booking_id"));
        p.setCustomerId(rs.getLong("customer_id"));
        p.setPaymentMethod(rs.getString("payment_method"));
        p.setAmount(rs.getBigDecimal("amount"));
        p.setStatus(rs.getString("status"));
        p.setGatewayRef(rs.getString("gateway_ref"));
        p.setPaymentDate(rs.getTimestamp("payment_date"));

        p.setBillNo(rs.getString("bill_no"));
        p.setBookingCode(rs.getString("booking_code"));
        p.setCustomerName(rs.getString("customer_name"));
        return p;
    }
}
