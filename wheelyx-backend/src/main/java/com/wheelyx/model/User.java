package com.wheelyx.model;

import java.sql.Timestamp;

public class User {
    private Long id;
    private String name;
    private String email;
    private String phone;
    private String passwordHash;
    private String role; // CUSTOMER, OWNER, ADMIN
    private String status; // ACTIVE, INACTIVE, SUSPENDED
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public User() {}

    public User(Long id, String name, String email, String phone, String passwordHash, String role, String status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.passwordHash = passwordHash;
        this.role = role;
        this.status = status;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public boolean isAdmin() { return "ADMIN".equalsIgnoreCase(role); }
    public boolean isOwner() { return "OWNER".equalsIgnoreCase(role); }
    public boolean isCustomer() { return "CUSTOMER".equalsIgnoreCase(role); }
    public boolean isActive() { return "ACTIVE".equalsIgnoreCase(status); }
}
