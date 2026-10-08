package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.City;
import com.wheelyx.model.CityPlace;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CityDAO {

    public List<City> findAll() {
        List<City> list = new ArrayList<>();
        String sql = "SELECT c.*, " +
                     "(SELECT COUNT(*) FROM city_places cp WHERE cp.city_id = c.id AND cp.is_active = TRUE) as place_count, " +
                     "(SELECT COUNT(*) FROM vehicles v WHERE v.city_id = c.id) as vehicle_count " +
                     "FROM cities c WHERE c.is_active = TRUE ORDER BY c.city_name ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                City city = new City();
                city.setId(rs.getInt("id"));
                city.setCityName(rs.getString("city_name"));
                city.setStateName(rs.getString("state_name"));
                city.setActive(rs.getBoolean("is_active"));
                city.setPlaceCount(rs.getInt("place_count"));
                city.setVehicleCount(rs.getInt("vehicle_count"));
                list.add(city);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public City findById(int id) {
        String sql = "SELECT c.*, " +
                     "(SELECT COUNT(*) FROM city_places cp WHERE cp.city_id = c.id AND cp.is_active = TRUE) as place_count, " +
                     "(SELECT COUNT(*) FROM vehicles v WHERE v.city_id = c.id) as vehicle_count " +
                     "FROM cities c WHERE c.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    City city = new City();
                    city.setId(rs.getInt("id"));
                    city.setCityName(rs.getString("city_name"));
                    city.setStateName(rs.getString("state_name"));
                    city.setActive(rs.getBoolean("is_active"));
                    city.setPlaceCount(rs.getInt("place_count"));
                    city.setVehicleCount(rs.getInt("vehicle_count"));
                    return city;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<CityPlace> findPlacesByCityId(int cityId) {
        List<CityPlace> list = new ArrayList<>();
        String sql = "SELECT cp.*, c.city_name FROM city_places cp " +
                     "JOIN cities c ON cp.city_id = c.id " +
                     "WHERE cp.city_id = ? AND cp.is_active = TRUE " +
                     "ORDER BY cp.place_name ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cityId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CityPlace p = new CityPlace();
                    p.setId(rs.getLong("id"));
                    p.setCityId(rs.getInt("city_id"));
                    p.setCityName(rs.getString("city_name"));
                    p.setPlaceName(rs.getString("place_name"));
                    p.setLandmarkDetails(rs.getString("landmark_details"));
                    p.setActive(rs.getBoolean("is_active"));
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public CityPlace findPlaceById(long placeId) {
        String sql = "SELECT cp.*, c.city_name FROM city_places cp " +
                     "JOIN cities c ON cp.city_id = c.id WHERE cp.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, placeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    CityPlace p = new CityPlace();
                    p.setId(rs.getLong("id"));
                    p.setCityId(rs.getInt("city_id"));
                    p.setCityName(rs.getString("city_name"));
                    p.setPlaceName(rs.getString("place_name"));
                    p.setLandmarkDetails(rs.getString("landmark_details"));
                    p.setActive(rs.getBoolean("is_active"));
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createCity(City city) {
        String sql = "INSERT INTO cities (city_name, state_name, is_active) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, city.getCityName());
            stmt.setString(2, city.getStateName());
            stmt.setBoolean(3, city.isActive());
            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        city.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean createPlace(CityPlace place) {
        String sql = "INSERT INTO city_places (city_id, place_name, landmark_details, is_active) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, place.getCityId());
            stmt.setString(2, place.getPlaceName());
            stmt.setString(3, place.getLandmarkDetails());
            stmt.setBoolean(4, place.isActive());
            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        place.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
