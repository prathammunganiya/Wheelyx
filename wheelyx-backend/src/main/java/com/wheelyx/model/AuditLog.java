package com.wheelyx.model;

import java.sql.Timestamp;

public class AuditLog {
    private Long id;
    private Long userId;
    private String role;
    private String action;
    private String entityType;
    private Long entityId;
    private String description;
    private String ipAddress;
    private Timestamp createdAt;

    // Joined fields
    private String userName;
    private String userEmail;

    public AuditLog() {}

    public AuditLog(Long userId, String role, String action, String entityType, Long entityId, String description, String ipAddress) {
        this.userId = userId;
        this.role = role;
        this.action = action;
        this.entityType = entityType;
        this.entityId = entityId;
        this.description = description;
        this.ipAddress = ipAddress;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public String getEntityType() { return entityType; }
    public void setEntityType(String entityType) { this.entityType = entityType; }

    public Long getEntityId() { return entityId; }
    public void setEntityId(Long entityId) { this.entityId = entityId; }

    public String getDescription() { return description; }
    public String getDetails() { return description; }
    public void setDescription(String description) { this.description = description; }
    public void setDetails(String details) { this.description = details; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
}
