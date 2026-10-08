package com.wheelyx.service;

import com.wheelyx.config.AppConfig;
import com.wheelyx.dao.VehicleDAO;
import com.wheelyx.dao.VehicleLocationDAO;
import com.wheelyx.model.Vehicle;
import com.wheelyx.model.VehicleLocation;

import java.math.BigDecimal;
import java.util.List;

public class TrackingService {

    private final VehicleLocationDAO locationDAO = new VehicleLocationDAO();
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    public boolean isGoogleMapsConfigured() {
        String key = AppConfig.getGoogleMapsApiKey();
        return key != null && !key.trim().isEmpty();
    }

    public String getGoogleMapsApiKey() {
        return AppConfig.getGoogleMapsApiKey();
    }

    public VehicleLocation getLatestVehicleLocation(Long vehicleId) {
        VehicleLocation loc = locationDAO.getLatestLocation(vehicleId);
        if (loc != null) return loc;

        // Fallback default coordinates (e.g., Delhi / India Gate)
        loc = new VehicleLocation();
        loc.setVehicleId(vehicleId);
        loc.setLatitude(new BigDecimal("28.6129"));
        loc.setLongitude(new BigDecimal("77.2295"));
        loc.setSource("DEMO_DEFAULT");
        loc.setDemo(true);

        Vehicle v = vehicleDAO.findById(vehicleId);
        if (v != null) {
            loc.setVehicleModel(v.getModelName());
            loc.setRegistrationNo(v.getRegistrationNo());
            loc.setRentalStatus(v.getStatus());
        }
        return loc;
    }

    public List<VehicleLocation> getLocationHistory(Long vehicleId, int limit) {
        return locationDAO.getLocationHistory(vehicleId, limit);
    }

    public boolean updateLocation(Long vehicleId, Long rentalId, BigDecimal lat, BigDecimal lng, String source, boolean isDemo) {
        VehicleLocation loc = new VehicleLocation(vehicleId, rentalId, lat, lng, source, isDemo);
        return locationDAO.recordLocation(loc);
    }
}
