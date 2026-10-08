package com.wheelyx.service;

import com.wheelyx.dao.*;
import com.wheelyx.model.*;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.UUID;

public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final BillDAO billDAO = new BillDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    public Booking createBooking(
            Long customerId,
            Long vehicleId,
            Integer cityId,
            Long pickupPlaceId,
            Long returnPlaceId,
            LocalDate startDate,
            LocalDate endDate,
            String notes,
            String ipAddress
    ) {
        if (customerId == null || vehicleId == null || startDate == null || endDate == null) {
            return null;
        }

        LocalDate today = LocalDate.now();
        if (startDate.isBefore(today) || endDate.isBefore(startDate)) {
            return null;
        }

        // Concurrency-safe overlap check
        if (!vehicleDAO.checkAvailability(vehicleId, startDate, endDate, null)) {
            return null; // Vehicle is not available for requested interval
        }

        Vehicle vehicle = vehicleDAO.findById(vehicleId);
        if (vehicle == null) return null;

        int durationDays = (int) ChronoUnit.DAYS.between(startDate, endDate);
        if (durationDays < 1) durationDays = 1; // Minimum 1 day rental

        BigDecimal basePrice = vehicle.getPricePerDay().multiply(BigDecimal.valueOf(durationDays));
        BigDecimal deposit = vehicle.getSecurityDeposit();

        // 18% GST on base rental
        BigDecimal gst = basePrice.multiply(BigDecimal.valueOf(0.18)).setScale(2, RoundingMode.HALF_UP);

        // 10% discount on base rental for bookings of 7 or more days
        BigDecimal discount = BigDecimal.ZERO;
        if (durationDays >= 7) {
            discount = basePrice.multiply(BigDecimal.valueOf(0.10)).setScale(2, RoundingMode.HALF_UP);
        }

        BigDecimal total = basePrice.add(deposit).add(gst).subtract(discount).setScale(2, RoundingMode.HALF_UP);

        String bookingCode = "WX-BK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Booking booking = new Booking();
        booking.setBookingCode(bookingCode);
        booking.setCustomerId(customerId);
        booking.setVehicleId(vehicleId);
        booking.setCityId(cityId);
        booking.setPickupPlaceId(pickupPlaceId);
        booking.setReturnPlaceId(returnPlaceId);
        booking.setStartDate(Date.valueOf(startDate));
        booking.setEndDate(Date.valueOf(endDate));
        booking.setDurationDays(durationDays);
        booking.setBaseAmount(basePrice);
        booking.setDepositAmount(deposit);
        booking.setTaxAmount(gst);
        booking.setDiscountAmount(discount);
        booking.setTotalAmount(total);
        booking.setStatus("CONFIRMED");
        booking.setNotes(notes);

        boolean created = bookingDAO.create(booking);
        if (!created) return null;

        // Automatically generate associated invoice
        String billNo = "WX-INV-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        Bill bill = new Bill();
        bill.setBillNo(billNo);
        bill.setBookingId(booking.getId());
        bill.setBaseAmount(basePrice);
        bill.setSecurityDeposit(deposit);
        bill.setTaxAmount(gst);
        bill.setDiscountAmount(discount);
        bill.setFinalAmount(total);
        bill.setStatus("PAID"); // Pre-authorized or simulated paid
        billDAO.create(bill);

        // Transition vehicle status to BOOKED
        vehicleDAO.updateStatus(vehicleId, "BOOKED");

        // Send notifications
        notificationDAO.create(new Notification(customerId, "Booking Confirmed: " + bookingCode,
                "Your reservation for " + vehicle.getModelName() + " (" + durationDays + " days) is confirmed.", "BOOKING"));
        notificationDAO.create(new Notification(vehicle.getOwnerId(), "New Booking Received",
                "Your vehicle " + vehicle.getModelName() + " has been booked from " + startDate + " to " + endDate + ".", "BOOKING"));

        AuditLogDAO.log(customerId, "CUSTOMER", "CREATE_BOOKING", "BOOKING", booking.getId(),
                "Booking created for vehicle " + vehicle.getModelName() + " (" + bookingCode + ")", ipAddress);

        return booking;
    }

    public boolean editBooking(
            Long bookingId,
            Long customerId,
            Long pickupPlaceId,
            Long returnPlaceId,
            LocalDate startDate,
            LocalDate endDate,
            String notes,
            String ipAddress
    ) {
        Booking existing = bookingDAO.findById(bookingId);
        if (existing == null || !existing.getCustomerId().equals(customerId) || !existing.isModifiable()) {
            return false;
        }

        LocalDate today = LocalDate.now();
        if (startDate.isBefore(today) || endDate.isBefore(startDate)) {
            return false;
        }

        // Check availability excluding current booking
        if (!vehicleDAO.checkAvailability(existing.getVehicleId(), startDate, endDate, bookingId)) {
            return false;
        }

        Vehicle vehicle = vehicleDAO.findById(existing.getVehicleId());
        int durationDays = (int) ChronoUnit.DAYS.between(startDate, endDate);
        if (durationDays < 1) durationDays = 1;

        BigDecimal basePrice = vehicle.getPricePerDay().multiply(BigDecimal.valueOf(durationDays));
        BigDecimal deposit = vehicle.getSecurityDeposit();
        BigDecimal gst = basePrice.multiply(BigDecimal.valueOf(0.18)).setScale(2, RoundingMode.HALF_UP);
        BigDecimal discount = durationDays >= 7 ? basePrice.multiply(BigDecimal.valueOf(0.10)).setScale(2, RoundingMode.HALF_UP) : BigDecimal.ZERO;
        BigDecimal total = basePrice.add(deposit).add(gst).subtract(discount).setScale(2, RoundingMode.HALF_UP);

        existing.setPickupPlaceId(pickupPlaceId);
        existing.setReturnPlaceId(returnPlaceId);
        existing.setStartDate(Date.valueOf(startDate));
        existing.setEndDate(Date.valueOf(endDate));
        existing.setDurationDays(durationDays);
        existing.setBaseAmount(basePrice);
        existing.setDepositAmount(deposit);
        existing.setTaxAmount(gst);
        existing.setDiscountAmount(discount);
        existing.setTotalAmount(total);
        existing.setNotes(notes);

        boolean updated = bookingDAO.update(existing);
        if (updated) {
            notificationDAO.create(new Notification(customerId, "Booking Modified: " + existing.getBookingCode(),
                    "Your booking dates/locations have been updated.", "BOOKING"));
            AuditLogDAO.log(customerId, "CUSTOMER", "EDIT_BOOKING", "BOOKING", bookingId,
                    "Booking modified to " + startDate + " - " + endDate, ipAddress);
        }
        return updated;
    }

    public boolean cancelBooking(Long bookingId, Long currentUserId, String role, String reason, String ipAddress) {
        Booking existing = bookingDAO.findById(bookingId);
        if (existing == null) return false;

        // Security check
        if (!"ADMIN".equalsIgnoreCase(role) && !existing.getCustomerId().equals(currentUserId)) {
            return false;
        }

        if (!existing.isModifiable()) {
            return false;
        }

        boolean cancelled = bookingDAO.updateStatus(bookingId, "CANCELLED");
        if (cancelled) {
            // Restore vehicle status to AVAILABLE
            vehicleDAO.updateStatus(existing.getVehicleId(), "AVAILABLE");

            notificationDAO.create(new Notification(existing.getCustomerId(), "Booking Cancelled",
                    "Your booking " + existing.getBookingCode() + " has been successfully cancelled.", "BOOKING"));

            Vehicle vehicle = vehicleDAO.findById(existing.getVehicleId());
            if (vehicle != null) {
                notificationDAO.create(new Notification(vehicle.getOwnerId(), "Booking Cancelled",
                        "Booking " + existing.getBookingCode() + " for " + vehicle.getModelName() + " has been cancelled.", "BOOKING"));
            }

            AuditLogDAO.log(currentUserId, role, "CANCEL_BOOKING", "BOOKING", bookingId,
                    "Booking cancelled. Reason: " + reason, ipAddress);
        }
        return cancelled;
    }
}
