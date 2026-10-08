package com.wheelyx.service;

import com.wheelyx.dao.*;
import com.wheelyx.model.*;

import java.sql.Timestamp;
import java.util.UUID;

public class RentalService {

    private final RentalDAO rentalDAO = new RentalDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    public Rental dispatchHandover(Long bookingId, int startOdometer, String fuelLevel, String notes,
                                   Long currentUserId, String role, String ipAddress) {
        Booking booking = bookingDAO.findById(bookingId);
        if (booking == null || !"CONFIRMED".equalsIgnoreCase(booking.getStatus())) {
            return null;
        }

        Vehicle vehicle = vehicleDAO.findById(booking.getVehicleId());
        if (vehicle == null) return null;

        // Verify owner or admin permission
        if (!"ADMIN".equalsIgnoreCase(role) && !vehicle.getOwnerId().equals(currentUserId)) {
            return null;
        }

        String rentalCode = "WX-RN-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        Rental rental = new Rental();
        rental.setRentalCode(rentalCode);
        rental.setBookingId(bookingId);
        rental.setVehicleId(vehicle.getId());
        rental.setCustomerId(booking.getCustomerId());
        rental.setHandoverTime(new Timestamp(System.currentTimeMillis()));
        rental.setStartOdometer(startOdometer);
        rental.setFuelLevelStart(fuelLevel != null ? fuelLevel : "Full");
        rental.setStatus("ACTIVE_RENTAL");
        rental.setHandoverNotes(notes);

        boolean created = rentalDAO.create(rental);
        if (!created) return null;

        // Update vehicle status to ACTIVE_RENTAL
        vehicleDAO.updateStatus(vehicle.getId(), "ACTIVE_RENTAL");

        // Notify customer: tracking is now unlocked!
        notificationDAO.create(new Notification(booking.getCustomerId(), "Vehicle Handover Complete",
                "Your rental for " + vehicle.getModelName() + " has begun. Live GPS tracking is now available.", "RENTAL"));

        AuditLogDAO.log(currentUserId, role, "HANDOVER", "RENTAL", rental.getId(),
                "Vehicle handed over for rental " + rentalCode + ", start odo: " + startOdometer, ipAddress);

        return rental;
    }

    public boolean processReturn(Long rentalId, int endOdometer, String fuelLevel, String notes,
                                 Long currentUserId, String role, String ipAddress) {
        Rental rental = rentalDAO.findById(rentalId);
        if (rental == null || !"ACTIVE_RENTAL".equalsIgnoreCase(rental.getStatus())) {
            return false;
        }

        Vehicle vehicle = vehicleDAO.findById(rental.getVehicleId());
        if (vehicle == null) return false;

        if (!"ADMIN".equalsIgnoreCase(role) && !vehicle.getOwnerId().equals(currentUserId)) {
            return false;
        }

        boolean returned = rentalDAO.returnVehicle(rentalId, endOdometer, fuelLevel, notes);
        if (returned) {
            // Restore vehicle to AVAILABLE
            vehicleDAO.updateStatus(vehicle.getId(), "AVAILABLE");

            // Complete booking
            bookingDAO.updateStatus(rental.getBookingId(), "COMPLETED");

            // Notify customer that rental is closed and invite verified review
            notificationDAO.create(new Notification(rental.getCustomerId(), "Rental Completed Successfully",
                    "Thank you for riding with Wheelyx! You can now rate and review your experience with " + vehicle.getModelName() + ".", "RENTAL"));

            AuditLogDAO.log(currentUserId, role, "RETURN_CHECKIN", "RENTAL", rentalId,
                    "Vehicle returned successfully. End odo: " + endOdometer, ipAddress);
        }
        return returned;
    }
}
