package com.wheelyx.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.security.SecureRandom;
import java.util.Base64;

/**
 * SecurityUtil
 * Handles XSS sanitization, CSRF token generation and session protection.
 */
public class SecurityUtil {

    private static final SecureRandom secureRandom = new SecureRandom();
    private static final String CSRF_SESSION_KEY = "WHEELYX_CSRF_TOKEN";

    public static String generateCsrfToken(HttpSession session) {
        byte[] bytes = new byte[32];
        secureRandom.nextBytes(bytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
        session.setAttribute(CSRF_SESSION_KEY, token);
        return token;
    }

    public static String getCsrfToken(HttpSession session) {
        if (session == null) return null;
        Object token = session.getAttribute(CSRF_SESSION_KEY);
        if (token == null) {
            return generateCsrfToken(session);
        }
        return (String) token;
    }

    public static boolean validateCsrfToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        String sessionToken = (String) session.getAttribute(CSRF_SESSION_KEY);
        if (sessionToken == null) return false;

        String paramToken = request.getParameter("csrf_token");
        if (paramToken == null) {
            paramToken = request.getHeader("X-CSRF-Token");
        }

        return sessionToken.equals(paramToken);
    }

    public static String sanitizeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
}
