package com.wheelyx.model;

import java.sql.Timestamp;

public class Rental {
    private Long id;
    private String rentalCode;
    private Long bookingId;
    private Long vehicleId;
    private Long customerId;
    private Timestamp handoverTime;
    private Timestamp returnTime;
    private Integer startOdometer;
    private Integer endOdometer;
    private String fuelLevelStart;
    private String fuelLevelEnd;
    private String status; // ACTIVE_RENTAL, RETURNED, OVERDUE, CANCELLED
    private String handoverNotes;
    private String returnNotes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Joined fields
    private String bookingCode;
    private String vehicleModel;
    private String vehicleImage;
    private String registrationNo;
    private String customerName;
    private boolean hasReview;

    public Rental() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getRentalCode() { return rentalCode; }
    public void setRentalCode(String rentalCode) { this.rentalCode = rentalCode; }

    public Long getBookingId() { return bookingId; }
    public void setBookingId(Long bookingId) { this.bookingId = bookingId; }

    public Long getVehicleId() { return vehicleId; }
    public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }

    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long customerId) { this.customerId = customerId; }

    public Timestamp getHandoverTime() { return handoverTime; }
    public void setHandoverTime(Timestamp handoverTime) { this.handoverTime = handoverTime; }

    public Timestamp getReturnTime() { return returnTime; }
    public void setReturnTime(Timestamp returnTime) { this.returnTime = returnTime; }

    public Integer getStartOdometer() { return startOdometer; }
    public void setStartOdometer(Integer startOdometer) { this.startOdometer = startOdometer; }

    public Integer getEndOdometer() { return endOdometer; }
    public void setEndOdometer(Integer endOdometer) { this.endOdometer = endOdometer; }

    public String getFuelLevelStart() { return fuelLevelStart; }
    public void setFuelLevelStart(String fuelLevelStart) { this.fuelLevelStart = fuelLevelStart; }

    public String getFuelLevelEnd() { return fuelLevelEnd; }
    public void setFuelLevelEnd(String fuelLevelEnd) { this.fuelLevelEnd = fuelLevelEnd; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getHandoverNotes() { return handoverNotes; }
    public void setHandoverNotes(String handoverNotes) { this.handoverNotes = handoverNotes; }

    public String getReturnNotes() { return returnNotes; }
    public void setReturnNotes(String returnNotes) { this.returnNotes = returnNotes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getVehicleImage() { return vehicleImage; }
    public void setVehicleImage(String vehicleImage) { this.vehicleImage = vehicleImage; }

    public String getRegistrationNo() { return registrationNo; }
    public void setRegistrationNo(String registrationNo) { this.registrationNo = registrationNo; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public boolean isHasReview() { return hasReview; }
    public void setHasReview(boolean hasReview) { this.hasReview = hasReview; }

    public boolean isActive() { return "ACTIVE_RENTAL".equalsIgnoreCase(status); }
    public boolean isReturned() { return "RETURNED".equalsIgnoreCase(status); }
}
