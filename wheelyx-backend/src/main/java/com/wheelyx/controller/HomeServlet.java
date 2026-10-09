package com.wheelyx.controller;

import com.wheelyx.model.City;
import com.wheelyx.model.Review;
import com.wheelyx.model.Vehicle;
import com.wheelyx.model.VehicleCategory;
import com.wheelyx.service.FleetService;
import com.wheelyx.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<VehicleCategory> categories = fleetService.getAllCategories();
        List<Vehicle> featuredVehicles = fleetService.getFeaturedVehicles();
        List<City> cities = fleetService.getAllCities();
        List<Review> customerReviews = reviewService.getHomepageReviews(6);

        req.setAttribute("categories", categories);
        req.setAttribute("featuredVehicles", featuredVehicles);
        req.setAttribute("cities", cities);
        req.setAttribute("customerReviews", customerReviews); // Dynamic from DB! Empty list if zero reviews!

        req.getRequestDispatcher("/pages/home/index.jsp").forward(req, resp);
    }
}
