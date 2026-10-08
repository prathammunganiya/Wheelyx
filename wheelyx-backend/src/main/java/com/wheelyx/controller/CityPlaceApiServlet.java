package com.wheelyx.controller;

import com.wheelyx.model.CityPlace;
import com.wheelyx.service.FleetService;
import com.wheelyx.util.JsonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CityPlaceApiServlet", urlPatterns = {"/api/city-places", "/api/places"})
public class CityPlaceApiServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cityIdParam = req.getParameter("cityId");
        if (cityIdParam == null || cityIdParam.trim().isEmpty()) {
            JsonUtil.sendJsonResponse(resp, List.of());
            return;
        }

        try {
            int cityId = Integer.parseInt(cityIdParam.trim());
            List<CityPlace> places = fleetService.getPlacesForCity(cityId);
            JsonUtil.sendJsonResponse(resp, places);
        } catch (NumberFormatException e) {
            JsonUtil.sendJsonResponse(resp, List.of());
        }
    }
}
