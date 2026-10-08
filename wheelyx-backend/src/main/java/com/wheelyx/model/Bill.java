package com.wheelyx.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Bill {
    private Long id;
    private String billNo;
    private Long bookingId;
    private Long rentalId;
    private BigDecimal baseAmount;
    private BigDecimal securityDeposit;
    private BigDecimal taxAmount;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;
    private String status; // PENDING, PAID, REFUNDED, PARTIAL
    private Timestamp createdAt;

    // Joined fields
    private String bookingCode;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String vehicleModel;
    private String registrationNo;
    private String paymentMethod;
    private String transactionId;

    public Bill() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getBillNo() { return billNo; }
    public void setBillNo(String billNo) { this.billNo = billNo; }

    public Long getBookingId() { return bookingId; }
    public void setBookingId(Long bookingId) { this.bookingId = bookingId; }

    public Long getRentalId() { return rentalId; }
    public void setRentalId(Long rentalId) { this.rentalId = rentalId; }

    public BigDecimal getBaseAmount() { return baseAmount; }
    public void setBaseAmount(BigDecimal baseAmount) { this.baseAmount = baseAmount; }

    public BigDecimal getSecurityDeposit() { return securityDeposit; }
    public void setSecurityDeposit(BigDecimal securityDeposit) { this.securityDeposit = securityDeposit; }

    public BigDecimal getTaxAmount() { return taxAmount; }
    public void setTaxAmount(BigDecimal taxAmount) { this.taxAmount = taxAmount; }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public BigDecimal getFinalAmount() { return finalAmount; }
    public void setFinalAmount(BigDecimal finalAmount) { this.finalAmount = finalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getRegistrationNo() { return registrationNo; }
    public void setRegistrationNo(String registrationNo) { this.registrationNo = registrationNo; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }
}
