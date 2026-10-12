package com.wheelyx.controller;

import com.wheelyx.config.DBConnection;
import com.wheelyx.util.JsonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * HealthCheckServlet
 * Provides health probe for Railway and container orchestration.
 * Verifies service liveness and database connectivity.
 */
@WebServlet(name = "HealthCheckServlet", urlPatterns = {"/health", "/api/health"})
public class HealthCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean dbHealthy = DBConnection.isHealthy(3);

        Map<String, Object> health = new LinkedHashMap<>();
        health.put("status", dbHealthy ? "UP" : "DEGRADED");
        health.put("service", "wheelyx-backend");
        health.put("database", dbHealthy ? "CONNECTED" : "DISCONNECTED");
        health.put("timestamp", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

        if (!dbHealthy) {
            resp.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
        } else {
            resp.setStatus(HttpServletResponse.SC_OK);
        }

        JsonUtil.sendJsonResponse(resp, health);
    }
}
