package com.wheelyx.model;

public class City {
    private Integer id;
    private String cityName;
    private String stateName;
    private boolean isActive;
    private int placeCount;
    private int vehicleCount;

    public City() {}

    public City(Integer id, String cityName, String stateName, boolean isActive) {
        this.id = id;
        this.cityName = cityName;
        this.stateName = stateName;
        this.isActive = isActive;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getCityName() { return cityName; }
    public void setCityName(String cityName) { this.cityName = cityName; }

    public String getStateName() { return stateName; }
    public void setStateName(String stateName) { this.stateName = stateName; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public int getPlaceCount() { return placeCount; }
    public void setPlaceCount(int placeCount) { this.placeCount = placeCount; }

    public int getVehicleCount() { return vehicleCount; }
    public void setVehicleCount(int vehicleCount) { this.vehicleCount = vehicleCount; }
}
