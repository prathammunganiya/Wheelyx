package com.wheelyx;

import com.wheelyx.util.PasswordUtil;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class PasswordUtilTest {

    @Test
    @DisplayName("Should hash passwords using BCrypt and verify successfully")
    void testPasswordHashingAndVerification() {
        String rawPassword = "Customer@123";
        String hashed = PasswordUtil.hashPassword(rawPassword);

        assertNotNull(hashed);
        assertTrue(hashed.startsWith("$2a$") || hashed.startsWith("$2b$"));
        assertTrue(PasswordUtil.checkPassword(rawPassword, hashed));
        assertFalse(PasswordUtil.checkPassword("WrongPassword", hashed));
    }

    @Test
    @DisplayName("Should handle null or empty password gracefully")
    void testInvalidPasswordInputs() {
        assertFalse(PasswordUtil.checkPassword(null, "somehash"));
        assertFalse(PasswordUtil.checkPassword("password", null));
        assertFalse(PasswordUtil.checkPassword("", "somehash"));
    }
}
