package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.VehicleOwner;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleOwnerDAO {

    public VehicleOwner findByUserId(Long userId) {
        String sql = "SELECT vo.*, u.name as owner_name, u.email, u.phone, " +
                     "(SELECT COUNT(*) FROM vehicles v WHERE v.owner_id = u.id) as vehicle_count " +
                     "FROM vehicle_owners vo " +
                     "JOIN users u ON vo.user_id = u.id " +
                     "WHERE vo.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapOwner(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public VehicleOwner findById(Long id) {
        String sql = "SELECT vo.*, u.name as owner_name, u.email, u.phone, " +
                     "(SELECT COUNT(*) FROM vehicles v WHERE v.owner_id = u.id) as vehicle_count " +
                     "FROM vehicle_owners vo " +
                     "JOIN users u ON vo.user_id = u.id " +
                     "WHERE vo.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapOwner(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean create(VehicleOwner owner) {
        String sql = "INSERT INTO vehicle_owners (user_id, business_name, pan_number, bank_account, ifsc_code, is_verified) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, owner.getUserId());
            stmt.setString(2, owner.getBusinessName());
            stmt.setString(3, owner.getPanNumber());
            stmt.setString(4, owner.getBankAccount());
            stmt.setString(5, owner.getIfscCode());
            stmt.setBoolean(6, owner.isVerified());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        owner.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(VehicleOwner owner) {
        String sql = "UPDATE vehicle_owners SET business_name = ?, pan_number = ?, bank_account = ?, ifsc_code = ? " +
                     "WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, owner.getBusinessName());
            stmt.setString(2, owner.getPanNumber());
            stmt.setString(3, owner.getBankAccount());
            stmt.setString(4, owner.getIfscCode());
            stmt.setLong(5, owner.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<VehicleOwner> findAll(int offset, int limit) {
        List<VehicleOwner> list = new ArrayList<>();
        String sql = "SELECT vo.*, u.name as owner_name, u.email, u.phone, " +
                     "(SELECT COUNT(*) FROM vehicles v WHERE v.owner_id = u.id) as vehicle_count " +
                     "FROM vehicle_owners vo " +
                     "JOIN users u ON vo.user_id = u.id " +
                     "ORDER BY vo.id DESC LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapOwner(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM vehicle_owners";
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

    private VehicleOwner mapOwner(ResultSet rs) throws SQLException {
        VehicleOwner vo = new VehicleOwner();
        vo.setId(rs.getLong("id"));
        vo.setUserId(rs.getLong("user_id"));
        vo.setBusinessName(rs.getString("business_name"));
        vo.setPanNumber(rs.getString("pan_number"));
        vo.setBankAccount(rs.getString("bank_account"));
        vo.setIfscCode(rs.getString("ifsc_code"));
        vo.setVerified(rs.getBoolean("is_verified"));
        vo.setCreatedAt(rs.getTimestamp("created_at"));
        vo.setOwnerName(rs.getString("owner_name"));
        vo.setEmail(rs.getString("email"));
        vo.setPhone(rs.getString("phone"));
        vo.setVehicleCount(rs.getInt("vehicle_count"));
        return vo;
    }
}
