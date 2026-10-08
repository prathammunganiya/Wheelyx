package com.wheelyx.controller;

import com.wheelyx.model.VehicleLocation;
import com.wheelyx.service.TrackingService;
import com.wheelyx.util.JsonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "VehicleLocationApiServlet", urlPatterns = {"/api/tracking/telemetry"})
public class VehicleLocationApiServlet extends HttpServlet {

    private final TrackingService trackingService = new TrackingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String vehicleIdParam = req.getParameter("vehicleId");
        if (vehicleIdParam == null || vehicleIdParam.trim().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            long vehicleId = Long.parseLong(vehicleIdParam.trim());
            VehicleLocation loc = trackingService.getLatestVehicleLocation(vehicleId);
            JsonUtil.sendJsonResponse(resp, loc);
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
