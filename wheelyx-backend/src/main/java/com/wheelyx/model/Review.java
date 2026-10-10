package com.wheelyx.model;

import java.sql.Timestamp;

public class Review {
    private Long id;
    private Long rentalId;
    private Long customerId;
    private Long vehicleId;
    private Integer rating;
    private String comment;
    private Timestamp createdAt;

    // Joined fields
    private String customerName;
    private String vehicleModel;
    private String vehicleImage;
    private String rentalCode;

    public Review() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getRentalId() { return rentalId; }
    public void setRentalId(Long rentalId) { this.rentalId = rentalId; }

    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long customerId) { this.customerId = customerId; }

    public Long getVehicleId() { return vehicleId; }
    public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getVehicleImage() { return vehicleImage; }
    public void setVehicleImage(String vehicleImage) { this.vehicleImage = vehicleImage; }

    public String getRentalCode() { return rentalCode; }
    public void setRentalCode(String rentalCode) { this.rentalCode = rentalCode; }
}
