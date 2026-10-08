package com.wheelyx.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Vehicle {
    private Long id;
    private Long ownerId;
    private Integer categoryId;
    private Integer cityId;
    private Long placeId;
    private String brand;
    private String modelName;
    private String registrationNo;
    private String fuelType; // Petrol, Diesel, Electric, CNG
    private String transmission; // Manual, Automatic
    private Integer seatingCapacity;
    private BigDecimal pricePerDay;
    private BigDecimal securityDeposit;
    private String status; // AVAILABLE, BOOKED, ACTIVE_RENTAL, RETURNED, MAINTENANCE, UNAVAILABLE, PENDING_APPROVAL, REJECTED
    private String imageUrl;
    private String description;
    private String features;
    private String rentalTerms;
    private boolean isFeatured;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Joined fields
    private String ownerName;
    private String categoryName;
    private String cityName;
    private String placeName;
    private Double averageRating;
    private Integer reviewCount;

    public Vehicle() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getOwnerId() { return ownerId; }
    public void setOwnerId(Long ownerId) { this.ownerId = ownerId; }

    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }

    public Integer getCityId() { return cityId; }
    public void setCityId(Integer cityId) { this.cityId = cityId; }

    public Long getPlaceId() { return placeId; }
    public void setPlaceId(Long placeId) { this.placeId = placeId; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getModelName() { return modelName; }
    public void setModelName(String modelName) { this.modelName = modelName; }

    public String getRegistrationNo() { return registrationNo; }
    public void setRegistrationNo(String registrationNo) { this.registrationNo = registrationNo; }

    public String getFuelType() { return fuelType; }
    public void setFuelType(String fuelType) { this.fuelType = fuelType; }

    public String getTransmission() { return transmission; }
    public void setTransmission(String transmission) { this.transmission = transmission; }

    public Integer getSeatingCapacity() { return seatingCapacity; }
    public void setSeatingCapacity(Integer seatingCapacity) { this.seatingCapacity = seatingCapacity; }

    public BigDecimal getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(BigDecimal pricePerDay) { this.pricePerDay = pricePerDay; }

    public BigDecimal getSecurityDeposit() { return securityDeposit; }
    public void setSecurityDeposit(BigDecimal securityDeposit) { this.securityDeposit = securityDeposit; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getFeatures() { return features; }
    public void setFeatures(String features) { this.features = features; }

    public String getRentalTerms() { return rentalTerms; }
    public void setRentalTerms(String rentalTerms) { this.rentalTerms = rentalTerms; }

    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getCityName() { return cityName; }
    public void setCityName(String cityName) { this.cityName = cityName; }

    public String getPlaceName() { return placeName; }
    public void setPlaceName(String placeName) { this.placeName = placeName; }

    public Double getAverageRating() { return averageRating != null ? averageRating : 0.0; }
    public void setAverageRating(Double averageRating) { this.averageRating = averageRating; }

    public Integer getReviewCount() { return reviewCount != null ? reviewCount : 0; }
    public void setReviewCount(Integer reviewCount) { this.reviewCount = reviewCount; }

    public boolean isAvailable() { return "AVAILABLE".equalsIgnoreCase(status); }
}
