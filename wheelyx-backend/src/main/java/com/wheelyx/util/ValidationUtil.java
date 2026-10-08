package com.wheelyx.util;

import java.time.LocalDate;
import java.util.regex.Pattern;

/**
 * ValidationUtil
 * Comprehensive input validation for both client and server side security.
 */
public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\+?[0-9]{10,13}$");
    private static final Pattern REG_NO_PATTERN = Pattern.compile("^[A-Z]{2}[0-9]{1,2}[A-Z]{0,3}[0-9]{1,4}$", Pattern.CASE_INSENSITIVE);

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        String clean = phone.replaceAll("[\\s-]", "");
        return PHONE_PATTERN.matcher(clean).matches();
    }

    public static boolean isNotEmpty(String text) {
        return text != null && !text.trim().isEmpty();
    }

    public static boolean isValidRegistrationNo(String reg) {
        if (reg == null) return false;
        String clean = reg.replaceAll("[\\s-]", "");
        return REG_NO_PATTERN.matcher(clean).matches();
    }

    public static boolean isValidDateRange(LocalDate start, LocalDate end) {
        if (start == null || end == null) return false;
        LocalDate today = LocalDate.now();
        if (start.isBefore(today)) return false;
        return !end.isBefore(start);
    }

    public static boolean isValidRating(int rating) {
        return rating >= 1 && rating <= 5;
    }

    public static boolean isPositive(double value) {
        return value > 0;
    }
}
