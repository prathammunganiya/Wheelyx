package com.wheelyx.model;

public class VehicleCategory {
    private Integer id;
    private String categoryCode;
    private String categoryName;
    private String description;
    private String iconClass;
    private int vehicleCount;

    public VehicleCategory() {}

    public VehicleCategory(Integer id, String categoryCode, String categoryName, String description, String iconClass) {
        this.id = id;
        this.categoryCode = categoryCode;
        this.categoryName = categoryName;
        this.description = description;
        this.iconClass = iconClass;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getCategoryCode() { return categoryCode; }
    public void setCategoryCode(String categoryCode) { this.categoryCode = categoryCode; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getIconClass() { return iconClass; }
    public void setIconClass(String iconClass) { this.iconClass = iconClass; }

    public int getVehicleCount() { return vehicleCount; }
    public void setVehicleCount(int vehicleCount) { this.vehicleCount = vehicleCount; }
}
