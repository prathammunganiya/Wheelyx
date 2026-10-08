package com.wheelyx;

import com.wheelyx.util.ValidationUtil;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class ValidationUtilTest {

    @Test
    @DisplayName("Should validate correct and incorrect email addresses")
    void testEmailValidation() {
        assertTrue(ValidationUtil.isValidEmail("customer@wheelyx.com"));
        assertTrue(ValidationUtil.isValidEmail("user.name+tag@domain.co.in"));
        assertFalse(ValidationUtil.isValidEmail("invalid-email"));
        assertFalse(ValidationUtil.isValidEmail("@missingusername.com"));
        assertFalse(ValidationUtil.isValidEmail(null));
    }

    @Test
    @DisplayName("Should validate 10-digit Indian phone numbers with optional country prefix")
    void testPhoneValidation() {
        assertTrue(ValidationUtil.isValidPhone("9876543210"));
        assertTrue(ValidationUtil.isValidPhone("+919876543210"));
        assertTrue(ValidationUtil.isValidPhone("98765-43210"));
        assertFalse(ValidationUtil.isValidPhone("123"));
        assertFalse(ValidationUtil.isValidPhone("abc1234567"));
        assertFalse(ValidationUtil.isValidPhone(null));
    }

    @Test
    @DisplayName("Should validate vehicle registration numbers")
    void testRegistrationNoValidation() {
        assertTrue(ValidationUtil.isValidRegistrationNo("DL01AB1234"));
        assertTrue(ValidationUtil.isValidRegistrationNo("MH-12-CD-5678"));
        assertTrue(ValidationUtil.isValidRegistrationNo("KA03E9999"));
        assertFalse(ValidationUtil.isValidRegistrationNo("1234"));
        assertFalse(ValidationUtil.isValidRegistrationNo(null));
    }

    @Test
    @DisplayName("Should validate future date ranges for self-drive bookings")
    void testDateRangeValidation() {
        LocalDate today = LocalDate.now();
        LocalDate tomorrow = today.plusDays(1);
        LocalDate nextWeek = today.plusDays(7);
        LocalDate yesterday = today.minusDays(1);

        assertTrue(ValidationUtil.isValidDateRange(today, tomorrow));
        assertTrue(ValidationUtil.isValidDateRange(tomorrow, nextWeek));
        assertFalse(ValidationUtil.isValidDateRange(yesterday, tomorrow), "Past dates should not be allowed");
        assertFalse(ValidationUtil.isValidDateRange(nextWeek, tomorrow), "End date cannot be before start date");
        assertFalse(ValidationUtil.isValidDateRange(null, tomorrow));
    }

    @Test
    @DisplayName("Should validate star ratings strictly between 1 and 5")
    void testRatingValidation() {
        assertTrue(ValidationUtil.isValidRating(1));
        assertTrue(ValidationUtil.isValidRating(5));
        assertTrue(ValidationUtil.isValidRating(3));
        assertFalse(ValidationUtil.isValidRating(0));
        assertFalse(ValidationUtil.isValidRating(6));
        assertFalse(ValidationUtil.isValidRating(-1));
    }
}
