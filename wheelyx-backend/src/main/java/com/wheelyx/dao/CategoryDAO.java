package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.VehicleCategory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<VehicleCategory> findAll() {
        List<VehicleCategory> list = new ArrayList<>();
        String sql = "SELECT c.*, (SELECT COUNT(*) FROM vehicles v WHERE v.category_id = c.id) as vehicle_count " +
                     "FROM vehicle_categories c ORDER BY c.id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                VehicleCategory cat = new VehicleCategory();
                cat.setId(rs.getInt("id"));
                cat.setCategoryCode(rs.getString("category_code"));
                cat.setCategoryName(rs.getString("category_name"));
                cat.setDescription(rs.getString("description"));
                cat.setIconClass(rs.getString("icon_class"));
                cat.setVehicleCount(rs.getInt("vehicle_count"));
                list.add(cat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public VehicleCategory findById(int id) {
        String sql = "SELECT c.*, (SELECT COUNT(*) FROM vehicles v WHERE v.category_id = c.id) as vehicle_count " +
                     "FROM vehicle_categories c WHERE c.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    VehicleCategory cat = new VehicleCategory();
                    cat.setId(rs.getInt("id"));
                    cat.setCategoryCode(rs.getString("category_code"));
                    cat.setCategoryName(rs.getString("category_name"));
                    cat.setDescription(rs.getString("description"));
                    cat.setIconClass(rs.getString("icon_class"));
                    cat.setVehicleCount(rs.getInt("vehicle_count"));
                    return cat;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean create(VehicleCategory cat) {
        String sql = "INSERT INTO vehicle_categories (category_code, category_name, description, icon_class) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, cat.getCategoryCode());
            stmt.setString(2, cat.getCategoryName());
            stmt.setString(3, cat.getDescription());
            stmt.setString(4, cat.getIconClass());
            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        cat.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(VehicleCategory cat) {
        String sql = "UPDATE vehicle_categories SET category_code = ?, category_name = ?, description = ?, icon_class = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cat.getCategoryCode());
            stmt.setString(2, cat.getCategoryName());
            stmt.setString(3, cat.getDescription());
            stmt.setString(4, cat.getIconClass());
            stmt.setInt(5, cat.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
