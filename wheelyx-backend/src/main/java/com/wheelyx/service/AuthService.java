package com.wheelyx.service;

import com.wheelyx.dao.AuditLogDAO;
import com.wheelyx.dao.NotificationDAO;
import com.wheelyx.dao.UserDAO;
import com.wheelyx.dao.VehicleOwnerDAO;
import com.wheelyx.model.Notification;
import com.wheelyx.model.User;
import com.wheelyx.model.VehicleOwner;
import com.wheelyx.util.PasswordUtil;
import com.wheelyx.util.ValidationUtil;

public class AuthService {

    private final UserDAO userDAO = new UserDAO();
    private final VehicleOwnerDAO ownerDAO = new VehicleOwnerDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    public User login(String email, String plainPassword, String expectedRole, String ipAddress) {
        if (!ValidationUtil.isValidEmail(email) || !ValidationUtil.isNotEmpty(plainPassword)) {
            return null;
        }

        User user = userDAO.findByEmail(email);
        if (user == null || !user.isActive()) {
            return null;
        }

        if (!PasswordUtil.checkPassword(plainPassword, user.getPasswordHash())) {
            return null;
        }

        // Strict role validation
        if (expectedRole != null && !expectedRole.equalsIgnoreCase(user.getRole())) {
            return null;
        }

        AuditLogDAO.log(user.getId(), user.getRole(), "LOGIN", "USER", user.getId(),
                "User logged in successfully via role " + user.getRole(), ipAddress);

        return user;
    }

    public boolean registerCustomer(String name, String email, String phone, String plainPassword, String ipAddress) {
        if (!ValidationUtil.isNotEmpty(name) ||
            !ValidationUtil.isValidEmail(email) ||
            !ValidationUtil.isValidPhone(phone) ||
            !ValidationUtil.isNotEmpty(plainPassword)) {
            return false;
        }

        if (userDAO.findByEmail(email) != null) {
            return false; // Email already in use
        }

        User u = new User();
        u.setName(name.trim());
        u.setEmail(email.trim().toLowerCase());
        u.setPhone(phone.trim());
        u.setPasswordHash(PasswordUtil.hashPassword(plainPassword));
        u.setRole("CUSTOMER");
        u.setStatus("ACTIVE");

        boolean created = userDAO.create(u);
        if (created) {
            notificationDAO.create(new Notification(u.getId(), "Welcome to Wheelyx!",
                    "Your customer account is active. Explore our fleet across 20 cities. Move Your Way.", "WELCOME"));
            AuditLogDAO.log(u.getId(), "CUSTOMER", "REGISTER", "USER", u.getId(),
                    "Customer registration completed for " + u.getEmail(), ipAddress);
        }
        return created;
    }

    public boolean registerOwner(String name, String email, String phone, String plainPassword,
                                 String businessName, String pan, String bank, String ifsc, String ipAddress) {
        if (!ValidationUtil.isNotEmpty(name) ||
            !ValidationUtil.isValidEmail(email) ||
            !ValidationUtil.isValidPhone(phone) ||
            !ValidationUtil.isNotEmpty(plainPassword)) {
            return false;
        }

        if (userDAO.findByEmail(email) != null) {
            return false;
        }

        User u = new User();
        u.setName(name.trim());
        u.setEmail(email.trim().toLowerCase());
        u.setPhone(phone.trim());
        u.setPasswordHash(PasswordUtil.hashPassword(plainPassword));
        u.setRole("OWNER");
        u.setStatus("ACTIVE");

        boolean userCreated = userDAO.create(u);
        if (!userCreated) return false;

        VehicleOwner vo = new VehicleOwner();
        vo.setUserId(u.getId());
        vo.setBusinessName(businessName != null ? businessName.trim() : name + " Mobility");
        vo.setPanNumber(pan != null ? pan.trim() : "NOT_SPECIFIED");
        vo.setBankAccount(bank != null ? bank.trim() : "NOT_SPECIFIED");
        vo.setIfscCode(ifsc != null ? ifsc.trim() : "NOT_SPECIFIED");
        vo.setVerified(true);

        boolean ownerCreated = ownerDAO.create(vo);
        if (ownerCreated) {
            notificationDAO.create(new Notification(u.getId(), "Owner Account Activated",
                    "Welcome to Wheelyx Fleet Management. You can now list and manage your vehicles.", "WELCOME"));
            AuditLogDAO.log(u.getId(), "OWNER", "REGISTER_OWNER", "VEHICLE_OWNER", vo.getId(),
                    "Owner account created for " + u.getEmail(), ipAddress);
        }
        return ownerCreated;
    }

    public boolean changePassword(Long userId, String currentPassword, String newPassword, String ipAddress) {
        if (!ValidationUtil.isNotEmpty(currentPassword) || !ValidationUtil.isNotEmpty(newPassword)) {
            return false;
        }

        User u = userDAO.findById(userId);
        if (u == null) return false;

        if (!PasswordUtil.checkPassword(currentPassword, u.getPasswordHash())) {
            return false;
        }

        String newHash = PasswordUtil.hashPassword(newPassword);
        boolean updated = userDAO.updatePassword(userId, newHash);
        if (updated) {
            AuditLogDAO.log(userId, u.getRole(), "CHANGE_PASSWORD", "USER", userId,
                    "Password updated successfully", ipAddress);
        }
        return updated;
    }

    public boolean updateProfile(Long userId, String name, String phone, String ipAddress) {
        if (!ValidationUtil.isNotEmpty(name) || !ValidationUtil.isValidPhone(phone)) {
            return false;
        }

        User u = userDAO.findById(userId);
        if (u == null) return false;

        u.setName(name.trim());
        u.setPhone(phone.trim());
        boolean updated = userDAO.updateProfile(u);
        if (updated) {
            AuditLogDAO.log(userId, u.getRole(), "UPDATE_PROFILE", "USER", userId,
                    "Profile contact info updated", ipAddress);
        }
        return updated;
    }
}
