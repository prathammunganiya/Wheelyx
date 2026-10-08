package com.wheelyx.controller;

import com.wheelyx.model.City;
import com.wheelyx.model.User;
import com.wheelyx.model.Vehicle;
import com.wheelyx.model.VehicleCategory;
import com.wheelyx.service.FleetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "OwnerVehicleAddServlet", urlPatterns = {"/owner/vehicles/add"})
public class OwnerVehicleAddServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=owner");
            return;
        }

        List<VehicleCategory> categories = fleetService.getAllCategories();
        List<City> cities = fleetService.getAllCities();

        req.setAttribute("categories", categories);
        req.setAttribute("cities", cities);

        req.getRequestDispatcher("/pages/owner/vehicle-add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        // Cancel button support
        String cancelAction = req.getParameter("cancel");
        if (cancelAction != null) {
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles");
            return;
        }

        try {
            Vehicle v = new Vehicle();
            v.setOwnerId(user.getId());
            v.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            v.setCityId(Integer.parseInt(req.getParameter("cityId")));
            v.setPlaceId(Long.parseLong(req.getParameter("placeId")));
            v.setBrand(req.getParameter("brand"));
            v.setModelName(req.getParameter("modelName"));
            v.setRegistrationNo(req.getParameter("registrationNo"));
            v.setFuelType(req.getParameter("fuelType"));
            v.setTransmission(req.getParameter("transmission"));
            v.setSeatingCapacity(Integer.parseInt(req.getParameter("seatingCapacity")));
            v.setPricePerDay(new BigDecimal(req.getParameter("pricePerDay")));
            v.setSecurityDeposit(new BigDecimal(req.getParameter("securityDeposit")));
            v.setImageUrl(req.getParameter("imageUrl"));
            v.setDescription(req.getParameter("description"));
            v.setFeatures(req.getParameter("features"));
            v.setRentalTerms(req.getParameter("rentalTerms"));

            boolean created = fleetService.listVehicle(v, req.getRemoteAddr());
            if (created) {
                resp.sendRedirect(req.getContextPath() + "/owner/vehicles?success=vehicle_listed");
            } else {
                resp.sendRedirect(req.getContextPath() + "/owner/vehicles/add?error=validation_failed");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles/add?error=invalid_data");
        }
    }
}
