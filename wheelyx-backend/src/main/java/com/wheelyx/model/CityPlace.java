package com.wheelyx.model;

public class CityPlace {
    private Long id;
    private Integer cityId;
    private String cityName;
    private String placeName;
    private String landmarkDetails;
    private boolean isActive;

    public CityPlace() {}

    public CityPlace(Long id, Integer cityId, String placeName, String landmarkDetails, boolean isActive) {
        this.id = id;
        this.cityId = cityId;
        this.placeName = placeName;
        this.landmarkDetails = landmarkDetails;
        this.isActive = isActive;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Integer getCityId() { return cityId; }
    public void setCityId(Integer cityId) { this.cityId = cityId; }

    public String getCityName() { return cityName; }
    public void setCityName(String cityName) { this.cityName = cityName; }

    public String getPlaceName() { return placeName; }
    public void setPlaceName(String placeName) { this.placeName = placeName; }

    public String getLandmarkDetails() { return landmarkDetails; }
    public void setLandmarkDetails(String landmarkDetails) { this.landmarkDetails = landmarkDetails; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
