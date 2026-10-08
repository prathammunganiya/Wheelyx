package com.wheelyx.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil
 * Secure password hashing and verification using BCrypt with 12 salt rounds.
 * Never stores or logs plain text passwords.
 */
public class PasswordUtil {

    private static final int LOG_ROUNDS = 12;

    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(LOG_ROUNDS));
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }
}
