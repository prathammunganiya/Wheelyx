package com.wheelyx.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Maintenance {
    private Long id;
    private Long vehicleId;
    private String maintenanceType;
    private String description;
    private Date startDate;
    private Date endDate;
    private BigDecimal cost;
    private String status; // SCHEDULED, IN_PROGRESS, COMPLETED
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Joined fields
    private String vehicleModel;
    private String registrationNo;
    private String vehicleImage;

    public Maintenance() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getVehicleId() { return vehicleId; }
    public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }

    public String getMaintenanceType() { return maintenanceType; }
    public void setMaintenanceType(String maintenanceType) { this.maintenanceType = maintenanceType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public BigDecimal getCost() { return cost; }
    public void setCost(BigDecimal cost) { this.cost = cost; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getRegistrationNo() { return registrationNo; }
    public void setRegistrationNo(String registrationNo) { this.registrationNo = registrationNo; }

    public String getVehicleImage() { return vehicleImage; }
    public void setVehicleImage(String vehicleImage) { this.vehicleImage = vehicleImage; }
}
