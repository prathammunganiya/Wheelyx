package com.wheelyx.service;

import com.wheelyx.dao.*;
import com.wheelyx.model.*;
import com.wheelyx.util.ValidationUtil;

import java.util.List;

public class FleetService {

    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final CityDAO cityDAO = new CityDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    public List<Vehicle> searchVehicles(
            Integer cityId,
            Long placeId,
            Integer categoryId,
            String fuelType,
            String transmission,
            Integer minSeats,
            Double minPrice,
            Double maxPrice,
            String status,
            int page,
            int pageSize
    ) {
        int offset = Math.max(0, (page - 1) * pageSize);
        return vehicleDAO.findFiltered(
                cityId, placeId, categoryId, fuelType, transmission, minSeats,
                minPrice, maxPrice, status, null, offset, pageSize
        );
    }

    public int countSearchVehicles(
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
        return vehicleDAO.countFiltered(
                cityId, placeId, categoryId, fuelType, transmission, minSeats, minPrice, maxPrice, status
        );
    }

    public List<Vehicle> getFeaturedVehicles() {
        return vehicleDAO.findFeatured();
    }

    public Vehicle getVehicleDetails(Long id) {
        if (id == null || id <= 0) return null;
        return vehicleDAO.findById(id);
    }

    public List<Vehicle> getOwnerVehicles(Long ownerId) {
        return vehicleDAO.findByOwnerId(ownerId);
    }

    public List<VehicleCategory> getAllCategories() {
        return categoryDAO.findAll();
    }

    public List<City> getAllCities() {
        return cityDAO.findAll();
    }

    public List<CityPlace> getPlacesForCity(int cityId) {
        return cityDAO.findPlacesByCityId(cityId);
    }

    public boolean listVehicle(Vehicle vehicle, String ipAddress) {
        if (!ValidationUtil.isNotEmpty(vehicle.getModelName()) ||
            !ValidationUtil.isNotEmpty(vehicle.getBrand()) ||
            !ValidationUtil.isNotEmpty(vehicle.getRegistrationNo()) ||
            vehicle.getPricePerDay() == null ||
            vehicle.getCityId() == null ||
            vehicle.getPlaceId() == null ||
            vehicle.getCategoryId() == null) {
            return false;
        }

        // Default image fallback if none provided
        if (!ValidationUtil.isNotEmpty(vehicle.getImageUrl())) {
            vehicle.setImageUrl("assets/images/vehicles/cars/swift.jpg");
        }

        vehicle.setStatus("AVAILABLE");
        boolean created = vehicleDAO.create(vehicle);
        if (created) {
            AuditLogDAO.log(vehicle.getOwnerId(), "OWNER", "CREATE_VEHICLE", "VEHICLE", vehicle.getId(),
                    "Listed new vehicle " + vehicle.getModelName() + " (" + vehicle.getRegistrationNo() + ")", ipAddress);
            notificationDAO.create(new Notification(vehicle.getOwnerId(), "Vehicle Listed Successfully",
                    "Your vehicle " + vehicle.getModelName() + " is now available for booking in " + vehicle.getCityName(), "FLEET"));
        }
        return created;
    }

    public boolean updateVehicle(Vehicle vehicle, Long currentUserId, String role, String ipAddress) {
        Vehicle existing = vehicleDAO.findById(vehicle.getId());
        if (existing == null) return false;

        // Security check: only the owner or an admin can edit
        if (!"ADMIN".equalsIgnoreCase(role) && !existing.getOwnerId().equals(currentUserId)) {
            return false;
        }

        boolean updated = vehicleDAO.update(vehicle);
        if (updated) {
            AuditLogDAO.log(currentUserId, role, "EDIT_VEHICLE", "VEHICLE", vehicle.getId(),
                    "Updated vehicle specifications for " + vehicle.getModelName(), ipAddress);
        }
        return updated;
    }

    public boolean updateVehicleStatus(Long vehicleId, String status, Long currentUserId, String role, String ipAddress) {
        Vehicle existing = vehicleDAO.findById(vehicleId);
        if (existing == null) return false;

        if (!"ADMIN".equalsIgnoreCase(role) && !existing.getOwnerId().equals(currentUserId)) {
            return false;
        }

        boolean updated = vehicleDAO.updateStatus(vehicleId, status);
        if (updated) {
            AuditLogDAO.log(currentUserId, role, "STATUS_CHANGE", "VEHICLE", vehicleId,
                    "Vehicle status set to " + status, ipAddress);
        }
        return updated;
    }

    public boolean cancelOrRemoveListing(Long vehicleId, Long currentUserId, String role, String ipAddress) {
        Vehicle existing = vehicleDAO.findById(vehicleId);
        if (existing == null) return false;

        if (!"ADMIN".equalsIgnoreCase(role) && !existing.getOwnerId().equals(currentUserId)) {
            return false;
        }

        // Soft deactivation to preserve historical booking records
        boolean deactivated = vehicleDAO.deleteOrDeactivate(vehicleId);
        if (deactivated) {
            AuditLogDAO.log(currentUserId, role, "CANCEL_LISTING", "VEHICLE", vehicleId,
                    "Listing cancelled/marked unavailable for " + existing.getModelName(), ipAddress);
        }
        return deactivated;
    }
}
