package com.wheelyx.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;

public class Booking {
    private Long id;
    private String bookingCode;
    private Long customerId;
    private Long vehicleId;
    private Integer cityId;
    private Long pickupPlaceId;
    private Long returnPlaceId;
    private Date startDate;
    private Date endDate;
    private Integer durationDays;
    private BigDecimal baseAmount;
    private BigDecimal depositAmount;
    private BigDecimal taxAmount;
    private BigDecimal discountAmount;
    private BigDecimal totalAmount;
    private String status; // PENDING, CONFIRMED, CANCELLED, COMPLETED, REJECTED
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Joined fields for display
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String vehicleModel;
    private String vehicleImage;
    private String registrationNo;
    private String cityName;
    private String pickupPlaceName;
    private String returnPlaceName;
    private Long rentalId;
    private String rentalStatus;

    public Booking() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long customerId) { this.customerId = customerId; }

    public Long getVehicleId() { return vehicleId; }
    public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }

    public Integer getCityId() { return cityId; }
    public void setCityId(Integer cityId) { this.cityId = cityId; }

    public Long getPickupPlaceId() { return pickupPlaceId; }
    public void setPickupPlaceId(Long pickupPlaceId) { this.pickupPlaceId = pickupPlaceId; }

    public Long getReturnPlaceId() { return returnPlaceId; }
    public void setReturnPlaceId(Long returnPlaceId) { this.returnPlaceId = returnPlaceId; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public Integer getDurationDays() { return durationDays; }
    public void setDurationDays(Integer durationDays) { this.durationDays = durationDays; }

    public BigDecimal getBaseAmount() { return baseAmount; }
    public void setBaseAmount(BigDecimal baseAmount) { this.baseAmount = baseAmount; }

    public BigDecimal getDepositAmount() { return depositAmount; }
    public void setDepositAmount(BigDecimal depositAmount) { this.depositAmount = depositAmount; }

    public BigDecimal getTaxAmount() { return taxAmount; }
    public void setTaxAmount(BigDecimal taxAmount) { this.taxAmount = taxAmount; }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getVehicleImage() { return vehicleImage; }
    public void setVehicleImage(String vehicleImage) { this.vehicleImage = vehicleImage; }

    public String getRegistrationNo() { return registrationNo; }
    public void setRegistrationNo(String registrationNo) { this.registrationNo = registrationNo; }

    public String getCityName() { return cityName; }
    public void setCityName(String cityName) { this.cityName = cityName; }

    public String getPickupPlaceName() { return pickupPlaceName; }
    public void setPickupPlaceName(String pickupPlaceName) { this.pickupPlaceName = pickupPlaceName; }

    public String getReturnPlaceName() { return returnPlaceName; }
    public void setReturnPlaceName(String returnPlaceName) { this.returnPlaceName = returnPlaceName; }

    public Long getRentalId() { return rentalId; }
    public void setRentalId(Long rentalId) { this.rentalId = rentalId; }

    public String getRentalStatus() { return rentalStatus; }
    public void setRentalStatus(String rentalStatus) { this.rentalStatus = rentalStatus; }

    /**
     * Determines whether the booking can still be edited or cancelled.
     * Allowed only if status is PENDING or CONFIRMED and start_date is in the future.
     */
    public boolean isModifiable() {
        if (!("CONFIRMED".equalsIgnoreCase(status) || "PENDING".equalsIgnoreCase(status))) {
            return false;
        }
        if (startDate == null) return false;
        LocalDate start = startDate.toLocalDate();
        return !start.isBefore(LocalDate.now());
    }
}
