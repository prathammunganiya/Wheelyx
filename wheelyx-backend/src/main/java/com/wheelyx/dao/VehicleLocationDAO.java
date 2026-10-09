package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.VehicleLocation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleLocationDAO {

    public VehicleLocation getLatestLocation(Long vehicleId) {
        String sql = "SELECT vl.*, v.model_name as vehicle_model, v.registration_no, r.status as rental_status " +
                     "FROM vehicle_locations vl " +
                     "JOIN vehicles v ON vl.vehicle_id = v.id " +
                     "LEFT JOIN rentals r ON vl.rental_id = r.id " +
                     "WHERE vl.vehicle_id = ? ORDER BY vl.recorded_at DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, vehicleId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapLocation(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<VehicleLocation> getLocationHistory(Long vehicleId, int limit) {
        List<VehicleLocation> list = new ArrayList<>();
        String sql = "SELECT vl.*, v.model_name as vehicle_model, v.registration_no, r.status as rental_status " +
                     "FROM vehicle_locations vl " +
                     "JOIN vehicles v ON vl.vehicle_id = v.id " +
                     "LEFT JOIN rentals r ON vl.rental_id = r.id " +
                     "WHERE vl.vehicle_id = ? ORDER BY vl.recorded_at DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, vehicleId);
            stmt.setInt(2, limit > 0 ? limit : 20);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapLocation(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean recordLocation(VehicleLocation loc) {
        String sql = "INSERT INTO vehicle_locations (vehicle_id, rental_id, latitude, longitude, source, is_demo) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, loc.getVehicleId());
            if (loc.getRentalId() != null) {
                stmt.setLong(2, loc.getRentalId());
            } else {
                stmt.setNull(2, Types.BIGINT);
            }
            stmt.setBigDecimal(3, loc.getLatitude());
            stmt.setBigDecimal(4, loc.getLongitude());
            stmt.setString(5, loc.getSource() != null ? loc.getSource() : "SIMULATED");
            stmt.setBoolean(6, loc.isDemo());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        loc.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private VehicleLocation mapLocation(ResultSet rs) throws SQLException {
        VehicleLocation vl = new VehicleLocation();
        vl.setId(rs.getLong("id"));
        vl.setVehicleId(rs.getLong("vehicle_id"));
        long rId = rs.getLong("rental_id");
        if (!rs.wasNull()) {
            vl.setRentalId(rId);
        }
        vl.setLatitude(rs.getBigDecimal("latitude"));
        vl.setLongitude(rs.getBigDecimal("longitude"));
        vl.setRecordedAt(rs.getTimestamp("recorded_at"));
        vl.setSource(rs.getString("source"));
        vl.setDemo(rs.getBoolean("is_demo"));

        vl.setVehicleModel(rs.getString("vehicle_model"));
        vl.setRegistrationNo(rs.getString("registration_no"));
        vl.setRentalStatus(rs.getString("rental_status"));
        return vl;
    }
}
