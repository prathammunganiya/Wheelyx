package com.wheelyx.controller;

import com.wheelyx.model.CityPlace;
import com.wheelyx.model.Review;
import com.wheelyx.model.Vehicle;
import com.wheelyx.service.FleetService;
import com.wheelyx.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "VehicleDetailServlet", urlPatterns = {"/vehicles/detail", "/vehicle"})
public class VehicleDetailServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/vehicles");
            return;
        }

        try {
            long vehicleId = Long.parseLong(idParam.trim());
            Vehicle vehicle = fleetService.getVehicleDetails(vehicleId);
            if (vehicle == null) {
                resp.sendRedirect(req.getContextPath() + "/vehicles?error=not_found");
                return;
            }

            List<Review> reviews = reviewService.getVehicleReviews(vehicleId);
            List<CityPlace> cityPlaces = fleetService.getPlacesForCity(vehicle.getCityId());

            req.setAttribute("vehicle", vehicle);
            req.setAttribute("reviews", reviews);
            req.setAttribute("cityPlaces", cityPlaces);

            req.getRequestDispatcher("/pages/vehicles/detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/vehicles");
        }
    }
}
