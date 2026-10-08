package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.AuditLog;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuditLogDAO {

    public static void log(Long userId, String role, String action, String entityType, Long entityId, String description, String ipAddress) {
        String sql = "INSERT INTO audit_logs (user_id, role, action, entity_type, entity_id, description, ip_address) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            if (userId != null) {
                stmt.setLong(1, userId);
            } else {
                stmt.setNull(1, Types.BIGINT);
            }
            stmt.setString(2, role != null ? role : "SYSTEM");
            stmt.setString(3, action);
            stmt.setString(4, entityType);
            if (entityId != null) {
                stmt.setLong(5, entityId);
            } else {
                stmt.setNull(5, Types.BIGINT);
            }
            stmt.setString(6, description);
            stmt.setString(7, ipAddress);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<AuditLog> findAll(int offset, int limit) {
        List<AuditLog> list = new ArrayList<>();
        String sql = "SELECT a.*, u.name as user_name, u.email as user_email " +
                     "FROM audit_logs a " +
                     "LEFT JOIN users u ON a.user_id = u.id " +
                     "ORDER BY a.id DESC LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    AuditLog al = new AuditLog();
                    al.setId(rs.getLong("id"));
                    long uId = rs.getLong("user_id");
                    if (!rs.wasNull()) al.setUserId(uId);
                    al.setRole(rs.getString("role"));
                    al.setAction(rs.getString("action"));
                    al.setEntityType(rs.getString("entity_type"));
                    long eId = rs.getLong("entity_id");
                    if (!rs.wasNull()) al.setEntityId(eId);
                    al.setDescription(rs.getString("description"));
                    al.setIpAddress(rs.getString("ip_address"));
                    al.setCreatedAt(rs.getTimestamp("created_at"));
                    al.setUserName(rs.getString("user_name"));
                    al.setUserEmail(rs.getString("user_email"));
                    list.add(al);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM audit_logs";
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
}
