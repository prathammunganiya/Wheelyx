package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.Maintenance;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaintenanceDAO {

    public Maintenance findById(Long id) {
        String sql = "SELECT m.*, v.model_name as vehicle_model, v.registration_no, v.image_url as vehicle_image " +
                     "FROM maintenance m " +
                     "JOIN vehicles v ON m.vehicle_id = v.id " +
                     "WHERE m.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapMaintenance(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Maintenance> findByVehicleId(Long vehicleId) {
        List<Maintenance> list = new ArrayList<>();
        String sql = "SELECT m.*, v.model_name as vehicle_model, v.registration_no, v.image_url as vehicle_image " +
                     "FROM maintenance m " +
                     "JOIN vehicles v ON m.vehicle_id = v.id " +
                     "WHERE m.vehicle_id = ? ORDER BY m.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, vehicleId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapMaintenance(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Maintenance> findAll(String status, int offset, int limit) {
        List<Maintenance> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT m.*, v.model_name as vehicle_model, v.registration_no, v.image_url as vehicle_image " +
            "FROM maintenance m " +
            "JOIN vehicles v ON m.vehicle_id = v.id " +
            "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append(" AND m.status = ?");
            params.add(status.trim().toUpperCase());
        }
        sql.append(" ORDER BY m.id DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapMaintenance(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean create(Maintenance m) {
        String sql = "INSERT INTO maintenance (vehicle_id, maintenance_type, description, start_date, end_date, cost, status, notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, m.getVehicleId());
            stmt.setString(2, m.getMaintenanceType());
            stmt.setString(3, m.getDescription());
            stmt.setDate(4, m.getStartDate());
            stmt.setDate(5, m.getEndDate());
            stmt.setBigDecimal(6, m.getCost());
            stmt.setString(7, m.getStatus() != null ? m.getStatus() : "SCHEDULED");
            stmt.setString(8, m.getNotes());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        m.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Maintenance m) {
        String sql = "UPDATE maintenance SET maintenance_type = ?, description = ?, start_date = ?, " +
                     "end_date = ?, cost = ?, status = ?, notes = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, m.getMaintenanceType());
            stmt.setString(2, m.getDescription());
            stmt.setDate(3, m.getStartDate());
            stmt.setDate(4, m.getEndDate());
            stmt.setBigDecimal(5, m.getCost());
            stmt.setString(6, m.getStatus());
            stmt.setString(7, m.getNotes());
            stmt.setLong(8, m.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(Long id, String status) {
        String sql = "UPDATE maintenance SET status = ? WHERE id = ?";
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

    private Maintenance mapMaintenance(ResultSet rs) throws SQLException {
        Maintenance m = new Maintenance();
        m.setId(rs.getLong("id"));
        m.setVehicleId(rs.getLong("vehicle_id"));
        m.setMaintenanceType(rs.getString("maintenance_type"));
        m.setDescription(rs.getString("description"));
        m.setStartDate(rs.getDate("start_date"));
        m.setEndDate(rs.getDate("end_date"));
        m.setCost(rs.getBigDecimal("cost"));
        m.setStatus(rs.getString("status"));
        m.setNotes(rs.getString("notes"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        m.setUpdatedAt(rs.getTimestamp("updated_at"));

        m.setVehicleModel(rs.getString("vehicle_model"));
        m.setRegistrationNo(rs.getString("registration_no"));
        m.setVehicleImage(rs.getString("vehicle_image"));
        return m;
    }
}
