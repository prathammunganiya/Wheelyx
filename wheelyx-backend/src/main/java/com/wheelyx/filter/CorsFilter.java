package com.wheelyx.filter;

import com.wheelyx.config.AppConfig;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;

/**
 * CorsFilter
 * Enables Cross-Origin Resource Sharing (CORS) for external frontends.
 * Configurable via CORS_ALLOWED_ORIGINS environment variable.
 */
@WebFilter(filterName = "CorsFilter", urlPatterns = {"/*"})
public class CorsFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String origin = request.getHeader("Origin");
        String allowedOrigins = AppConfig.getCorsAllowedOrigins();

        if (origin != null && !origin.trim().isEmpty()) {
            if ("*".equals(allowedOrigins) || isOriginAllowed(origin, allowedOrigins)) {
                response.setHeader("Access-Control-Allow-Origin", origin);
                response.setHeader("Access-Control-Allow-Credentials", "true");
            }
        } else if ("*".equals(allowedOrigins)) {
            response.setHeader("Access-Control-Allow-Origin", "*");
        }

        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD");
        response.setHeader("Access-Control-Allow-Headers", "Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers, Authorization, Cookie");
        response.setHeader("Access-Control-Max-Age", "3600");

        // Handle CORS preflight request
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        chain.doFilter(req, res);
    }

    private boolean isOriginAllowed(String origin, String allowedOrigins) {
        if (allowedOrigins == null || allowedOrigins.trim().isEmpty()) {
            return false;
        }
        return Arrays.stream(allowedOrigins.split(","))
                .map(String::trim)
                .anyMatch(allowed -> allowed.equalsIgnoreCase(origin) || "*".equals(allowed));
    }
}
