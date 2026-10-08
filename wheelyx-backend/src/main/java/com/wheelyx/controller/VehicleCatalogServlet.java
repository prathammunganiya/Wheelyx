package com.wheelyx.controller;

import com.wheelyx.model.City;
import com.wheelyx.model.CityPlace;
import com.wheelyx.model.Vehicle;
import com.wheelyx.model.VehicleCategory;
import com.wheelyx.service.FleetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "VehicleCatalogServlet", urlPatterns = {"/vehicles"})
public class VehicleCatalogServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer cityId = parseInteger(req.getParameter("cityId"));
        Long placeId = parseLong(req.getParameter("placeId"));
        Integer categoryId = parseInteger(req.getParameter("categoryId"));
        String fuelType = req.getParameter("fuelType");
        String transmission = req.getParameter("transmission");
        Integer minSeats = parseInteger(req.getParameter("minSeats"));
        Double minPrice = parseDouble(req.getParameter("minPrice"));
        Double maxPrice = parseDouble(req.getParameter("maxPrice"));
        String status = req.getParameter("status");

        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try { page = Math.max(1, Integer.parseInt(pageParam)); } catch (NumberFormatException ignored) {}
        }
        int pageSize = 12;

        List<Vehicle> vehicles = fleetService.searchVehicles(
                cityId, placeId, categoryId, fuelType, transmission, minSeats, minPrice, maxPrice, status, page, pageSize
        );
        int totalMatches = fleetService.countSearchVehicles(
                cityId, placeId, categoryId, fuelType, transmission, minSeats, minPrice, maxPrice, status
        );

        int totalPages = (int) Math.ceil((double) totalMatches / pageSize);

        List<VehicleCategory> categories = fleetService.getAllCategories();
        List<City> cities = fleetService.getAllCities();
        List<CityPlace> places = (cityId != null && cityId > 0) ? fleetService.getPlacesForCity(cityId) : null;

        req.setAttribute("vehicles", vehicles);
        req.setAttribute("totalMatches", totalMatches);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("categories", categories);
        req.setAttribute("cities", cities);
        req.setAttribute("places", places);

        // Echo filters for form state retention
        req.setAttribute("selectedCityId", cityId);
        req.setAttribute("selectedPlaceId", placeId);
        req.setAttribute("selectedCategoryId", categoryId);
        req.setAttribute("selectedFuelType", fuelType);
        req.setAttribute("selectedTransmission", transmission);
        req.setAttribute("selectedMinSeats", minSeats);
        req.setAttribute("selectedMinPrice", minPrice);
        req.setAttribute("selectedMaxPrice", maxPrice);
        req.setAttribute("selectedStatus", status);

        req.getRequestDispatcher("/pages/vehicles/catalog.jsp").forward(req, resp);
    }

    private Integer parseInteger(String val) {
        if (val == null || val.trim().isEmpty() || "ALL".equalsIgnoreCase(val)) return null;
        try { return Integer.parseInt(val.trim()); } catch (NumberFormatException e) { return null; }
    }

    private Long parseLong(String val) {
        if (val == null || val.trim().isEmpty() || "ALL".equalsIgnoreCase(val)) return null;
        try { return Long.parseLong(val.trim()); } catch (NumberFormatException e) { return null; }
    }

    private Double parseDouble(String val) {
        if (val == null || val.trim().isEmpty()) return null;
        try { return Double.parseDouble(val.trim()); } catch (NumberFormatException e) { return null; }
    }
}
