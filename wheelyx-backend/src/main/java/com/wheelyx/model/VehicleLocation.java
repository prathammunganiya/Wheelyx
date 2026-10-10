package com.wheelyx.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class VehicleLocation {
    private Long id;
    private Long vehicleId;
    private Long rentalId;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Timestamp recordedAt;
    private String source;
    private boolean isDemo;

    // Joined fields
    private String vehicleModel;
    private String registrationNo;
    private String rentalStatus;

    public VehicleLocation() {}

    public VehicleLocation(Long vehicleId, Long rentalId, BigDecimal latitude, BigDecimal longitude, String source, boolean isDemo) {
        this.vehicleId = vehicleId;
        this.rentalId = rentalId;
        this.latitude = latitude;
        this.longitude = longitude;
        this.source = source;
        this.isDemo = isDemo;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getVehicleId() { return vehicleId; }
    public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }

    public Long getRentalId() { return rentalId; }
    public void setRentalId(Long rentalId) { this.rentalId = rentalId; }

    public BigDecimal getLatitude() { return latitude; }
    public void setLatitude(BigDecimal latitude) { this.latitude = latitude; }

    public BigDecimal getLongitude() { return longitude; }
    public void setLongitude(BigDecimal longitude) { this.longitude = longitude; }

    public Timestamp getRecordedAt() { return recordedAt; }
    public void setRecordedAt(Timestamp recordedAt) { this.recordedAt = recordedAt; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public boolean isDemo() { return isDemo; }
    public void setDemo(boolean demo) { isDemo = demo; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getRegistrationNo() { return registrationNo; }
    public void setRegistrationNo(String registrationNo) { this.registrationNo = registrationNo; }

    public String getRentalStatus() { return rentalStatus; }
    public void setRentalStatus(String rentalStatus) { this.rentalStatus = rentalStatus; }
}
