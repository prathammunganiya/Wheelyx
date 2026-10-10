package com.wheelyx.model;

import java.sql.Timestamp;

public class VehicleOwner {
    private Long id;
    private Long userId;
    private String businessName;
    private String panNumber;
    private String bankAccount;
    private String ifscCode;
    private boolean isVerified;
    private Timestamp createdAt;

    // Joined fields from User table
    private String ownerName;
    private String email;
    private String phone;
    private int vehicleCount;

    public VehicleOwner() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public String getBusinessName() { return businessName; }
    public void setBusinessName(String businessName) { this.businessName = businessName; }

    public String getPanNumber() { return panNumber; }
    public void setPanNumber(String panNumber) { this.panNumber = panNumber; }

    public String getBankAccount() { return bankAccount; }
    public void setBankAccount(String bankAccount) { this.bankAccount = bankAccount; }

    public String getIfscCode() { return ifscCode; }
    public void setIfscCode(String ifscCode) { this.ifscCode = ifscCode; }

    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean verified) { isVerified = verified; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getVehicleCount() { return vehicleCount; }
    public void setVehicleCount(int vehicleCount) { this.vehicleCount = vehicleCount; }
}
