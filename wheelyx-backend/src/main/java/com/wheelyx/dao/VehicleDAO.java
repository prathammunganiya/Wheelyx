package com.wheelyx.dao;

import com.wheelyx.config.DBConnection;
import com.wheelyx.model.Vehicle;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    public Vehicle findById(Long id) {
        String sql = "SELECT v.*, u.name as owner_name, c.category_name, ci.city_name, cp.place_name, " +
                     "COALESCE((SELECT AVG(r.rating) FROM reviews r WHERE r.vehicle_id = v.id), 0.0) as avg_rating, " +
                     "COALESCE((SELECT COUNT(r.id) FROM reviews r WHERE r.vehicle_id = v.id), 0) as review_count " +
                     "FROM vehicles v " +
                     "JOIN users u ON v.owner_id = u.id " +
                     "JOIN vehicle_categories c ON v.category_id = c.id " +
                     "JOIN cities ci ON v.city_id = ci.id " +
                     "JOIN city_places cp ON v.place_id = cp.id " +
                     "WHERE v.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapVehicle(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Vehicle> findFeatured() {
        return findFiltered(null, null, null, null, null, null, null, null, "AVAILABLE", true, 0, 8);
    }

    public List<Vehicle> findFiltered(
            Integer cityId,
            Long placeId,
            Integer categoryId,
            String fuelType,
            String transmission,
            Integer minSeats,
            Double minPrice,
            Double maxPrice,
            String status,
            Boolean featuredOnly,
            int offset,
            int limit
    ) {
        List<Vehicle> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT v.*, u.name as owner_name, c.category_name, ci.city_name, cp.place_name, " +
            "COALESCE((SELECT AVG(r.rating) FROM reviews r WHERE r.vehicle_id = v.id), 0.0) as avg_rating, " +
            "COALESCE((SELECT COUNT(r.id) FROM reviews r WHERE r.vehicle_id = v.id), 0) as review_count " +
            "FROM vehicles v " +
            "JOIN users u ON v.owner_id = u.id " +
            "JOIN vehicle_categories c ON v.category_id = c.id " +
            "JOIN cities ci ON v.city_id = ci.id " +
            "JOIN city_places cp ON v.place_id = cp.id " +
            "WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

        if (cityId != null && cityId > 0) {
            sql.append(" AND v.city_id = ?");
            params.add(cityId);
        }
        if (placeId != null && placeId > 0) {
            sql.append(" AND v.place_id = ?");
            params.add(placeId);
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND v.category_id = ?");
            params.add(categoryId);
        }
        if (fuelType != null && !fuelType.trim().isEmpty() && !"ALL".equalsIgnoreCase(fuelType)) {
            sql.append(" AND v.fuel_type = ?");
            params.add(fuelType.trim());
        }
        if (transmission != null && !transmission.trim().isEmpty() && !"ALL".equalsIgnoreCase(transmission)) {
            sql.append(" AND v.transmission = ?");
            params.add(transmission.trim());
        }
        if (minSeats != null && minSeats > 0) {
            sql.append(" AND v.seating_capacity >= ?");
            params.add(minSeats);
        }
        if (minPrice != null && minPrice > 0) {
            sql.append(" AND v.price_per_day >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null && maxPrice > 0) {
            sql.append(" AND v.price_per_day <= ?");
            params.add(maxPrice);
        }
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append(" AND v.status = ?");
            params.add(status.trim().toUpperCase());
        }
        if (featuredOnly != null && featuredOnly) {
            sql.append(" AND v.is_featured = TRUE");
        }

        sql.append(" ORDER BY v.is_featured DESC, v.id ASC LIMIT ? OFFSET ?");
        params.add(limit > 0 ? limit : 50);
        params.add(offset >= 0 ? offset : 0);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapVehicle(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countFiltered(
            Integer cityId,
            Long placeId,
            Integer categoryId,
            String fuelType,
            String transmission,
            Integer minSeats,
            Double minPrice,
            Double maxPrice,
            String status
    ) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM vehicles v WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (cityId != null && cityId > 0) {
            sql.append(" AND v.city_id = ?");
            params.add(cityId);
        }
        if (placeId != null && placeId > 0) {
            sql.append(" AND v.place_id = ?");
            params.add(placeId);
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND v.category_id = ?");
            params.add(categoryId);
        }
        if (fuelType != null && !fuelType.trim().isEmpty() && !"ALL".equalsIgnoreCase(fuelType)) {
            sql.append(" AND v.fuel_type = ?");
            params.add(fuelType.trim());
        }
        if (transmission != null && !transmission.trim().isEmpty() && !"ALL".equalsIgnoreCase(transmission)) {
            sql.append(" AND v.transmission = ?");
            params.add(transmission.trim());
        }
        if (minSeats != null && minSeats > 0) {
            sql.append(" AND v.seating_capacity >= ?");
            params.add(minSeats);
        }
        if (minPrice != null && minPrice > 0) {
            sql.append(" AND v.price_per_day >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null && maxPrice > 0) {
            sql.append(" AND v.price_per_day <= ?");
            params.add(maxPrice);
        }
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append(" AND v.status = ?");
            params.add(status.trim().toUpperCase());
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Vehicle> findByOwnerId(Long ownerId) {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT v.*, u.name as owner_name, c.category_name, ci.city_name, cp.place_name, " +
                     "COALESCE((SELECT AVG(r.rating) FROM reviews r WHERE r.vehicle_id = v.id), 0.0) as avg_rating, " +
                     "COALESCE((SELECT COUNT(r.id) FROM reviews r WHERE r.vehicle_id = v.id), 0) as review_count " +
                     "FROM vehicles v " +
                     "JOIN users u ON v.owner_id = u.id " +
                     "JOIN vehicle_categories c ON v.category_id = c.id " +
                     "JOIN cities ci ON v.city_id = ci.id " +
                     "JOIN city_places cp ON v.place_id = cp.id " +
                     "WHERE v.owner_id = ? ORDER BY v.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, ownerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapVehicle(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Vehicle> findByCategory(int categoryId, int limit) {
        return findFiltered(null, null, categoryId, null, null, null, null, null, "AVAILABLE", null, 0, limit);
    }

    public boolean create(Vehicle vehicle) {
        String sql = "INSERT INTO vehicles (owner_id, category_id, city_id, place_id, brand, model_name, " +
                     "registration_no, fuel_type, transmission, seating_capacity, price_per_day, " +
                     "security_deposit, status, image_url, description, features, rental_terms, is_featured) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, vehicle.getOwnerId());
            stmt.setInt(2, vehicle.getCategoryId());
            stmt.setInt(3, vehicle.getCityId());
            stmt.setLong(4, vehicle.getPlaceId());
            stmt.setString(5, vehicle.getBrand());
            stmt.setString(6, vehicle.getModelName());
            stmt.setString(7, vehicle.getRegistrationNo().toUpperCase().trim());
            stmt.setString(8, vehicle.getFuelType());
            stmt.setString(9, vehicle.getTransmission());
            stmt.setInt(10, vehicle.getSeatingCapacity());
            stmt.setBigDecimal(11, vehicle.getPricePerDay());
            stmt.setBigDecimal(12, vehicle.getSecurityDeposit());
            stmt.setString(13, vehicle.getStatus() != null ? vehicle.getStatus() : "AVAILABLE");
            stmt.setString(14, vehicle.getImageUrl());
            stmt.setString(15, vehicle.getDescription());
            stmt.setString(16, vehicle.getFeatures());
            stmt.setString(17, vehicle.getRentalTerms());
            stmt.setBoolean(18, vehicle.isFeatured());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        vehicle.setId(keys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Vehicle vehicle) {
        String sql = "UPDATE vehicles SET category_id = ?, city_id = ?, place_id = ?, brand = ?, model_name = ?, " +
                     "registration_no = ?, fuel_type = ?, transmission = ?, seating_capacity = ?, price_per_day = ?, " +
                     "security_deposit = ?, status = ?, image_url = ?, description = ?, features = ?, rental_terms = ?, is_featured = ? " +
                     "WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, vehicle.getCategoryId());
            stmt.setInt(2, vehicle.getCityId());
            stmt.setLong(3, vehicle.getPlaceId());
            stmt.setString(4, vehicle.getBrand());
            stmt.setString(5, vehicle.getModelName());
            stmt.setString(6, vehicle.getRegistrationNo().toUpperCase().trim());
            stmt.setString(7, vehicle.getFuelType());
            stmt.setString(8, vehicle.getTransmission());
            stmt.setInt(9, vehicle.getSeatingCapacity());
            stmt.setBigDecimal(10, vehicle.getPricePerDay());
            stmt.setBigDecimal(11, vehicle.getSecurityDeposit());
            stmt.setString(12, vehicle.getStatus());
            stmt.setString(13, vehicle.getImageUrl());
            stmt.setString(14, vehicle.getDescription());
            stmt.setString(15, vehicle.getFeatures());
            stmt.setString(16, vehicle.getRentalTerms());
            stmt.setBoolean(17, vehicle.isFeatured());
            stmt.setLong(18, vehicle.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(Long vehicleId, String status) {
        String sql = "UPDATE vehicles SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setLong(2, vehicleId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteOrDeactivate(Long vehicleId) {
        // Soft-delete to preserve booking and invoice historical integrity
        return updateStatus(vehicleId, "UNAVAILABLE");
    }

    /**
     * Checks if a vehicle is free of overlapping bookings or maintenance in [startDate, endDate].
     */
    public boolean checkAvailability(Long vehicleId, LocalDate startDate, LocalDate endDate, Long excludeBookingId) {
        // 1. Vehicle status check
        Vehicle v = findById(vehicleId);
        if (v == null || "MAINTENANCE".equalsIgnoreCase(v.getStatus()) || "UNAVAILABLE".equalsIgnoreCase(v.getStatus())) {
            return false;
        }

        // 2. Overlapping bookings check
        String bookingSql = "SELECT COUNT(*) FROM bookings WHERE vehicle_id = ? " +
                            "AND status IN ('CONFIRMED', 'PENDING') " +
                            "AND NOT (end_date < ? OR start_date > ?)";
        if (excludeBookingId != null) {
            bookingSql += " AND id != " + excludeBookingId;
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(bookingSql)) {
            stmt.setLong(1, vehicleId);
            stmt.setDate(2, Date.valueOf(startDate));
            stmt.setDate(3, Date.valueOf(endDate));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // 3. Maintenance check
        String maintSql = "SELECT COUNT(*) FROM maintenance WHERE vehicle_id = ? " +
                          "AND status IN ('SCHEDULED', 'IN_PROGRESS') " +
                          "AND NOT (end_date < ? OR start_date > ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(maintSql)) {
            stmt.setLong(1, vehicleId);
            stmt.setDate(2, Date.valueOf(startDate));
            stmt.setDate(3, Date.valueOf(endDate));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    private Vehicle mapVehicle(ResultSet rs) throws SQLException {
        Vehicle v = new Vehicle();
        v.setId(rs.getLong("id"));
        v.setOwnerId(rs.getLong("owner_id"));
        v.setCategoryId(rs.getInt("category_id"));
        v.setCityId(rs.getInt("city_id"));
        v.setPlaceId(rs.getLong("place_id"));
        v.setBrand(rs.getString("brand"));
        v.setModelName(rs.getString("model_name"));
        v.setRegistrationNo(rs.getString("registration_no"));
        v.setFuelType(rs.getString("fuel_type"));
        v.setTransmission(rs.getString("transmission"));
        v.setSeatingCapacity(rs.getInt("seating_capacity"));
        v.setPricePerDay(rs.getBigDecimal("price_per_day"));
        v.setSecurityDeposit(rs.getBigDecimal("security_deposit"));
        v.setStatus(rs.getString("status"));
        v.setImageUrl(rs.getString("image_url"));
        v.setDescription(rs.getString("description"));
        v.setFeatures(rs.getString("features"));
        v.setRentalTerms(rs.getString("rental_terms"));
        v.setFeatured(rs.getBoolean("is_featured"));
        v.setCreatedAt(rs.getTimestamp("created_at"));
        v.setUpdatedAt(rs.getTimestamp("updated_at"));

        v.setOwnerName(rs.getString("owner_name"));
        v.setCategoryName(rs.getString("category_name"));
        v.setCityName(rs.getString("city_name"));
        v.setPlaceName(rs.getString("place_name"));
        v.setAverageRating(rs.getDouble("avg_rating"));
        v.setReviewCount(rs.getInt("review_count"));
        return v;
    }
}
