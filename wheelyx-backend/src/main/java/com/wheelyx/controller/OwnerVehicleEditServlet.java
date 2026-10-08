package com.wheelyx.controller;

import com.wheelyx.model.City;
import com.wheelyx.model.CityPlace;
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

@WebServlet(name = "OwnerVehicleEditServlet", urlPatterns = {"/owner/vehicles/edit"})
public class OwnerVehicleEditServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=owner");
            return;
        }

        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles");
            return;
        }

        try {
            long vehicleId = Long.parseLong(idParam.trim());
            Vehicle vehicle = fleetService.getVehicleDetails(vehicleId);
            if (vehicle == null || !vehicle.getOwnerId().equals(user.getId())) {
                resp.sendRedirect(req.getContextPath() + "/owner/vehicles?error=unauthorized");
                return;
            }

            List<VehicleCategory> categories = fleetService.getAllCategories();
            List<City> cities = fleetService.getAllCities();
            List<CityPlace> places = fleetService.getPlacesForCity(vehicle.getCityId());

            req.setAttribute("vehicle", vehicle);
            req.setAttribute("categories", categories);
            req.setAttribute("cities", cities);
            req.setAttribute("places", places);

            req.getRequestDispatcher("/pages/owner/vehicle-edit.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String cancelAction = req.getParameter("cancel");
        if (cancelAction != null) {
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles");
            return;
        }

        try {
            long vehicleId = Long.parseLong(req.getParameter("id"));
            Vehicle v = fleetService.getVehicleDetails(vehicleId);
            if (v == null || !v.getOwnerId().equals(user.getId())) {
                resp.sendRedirect(req.getContextPath() + "/owner/vehicles?error=unauthorized");
                return;
            }

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
            v.setStatus(req.getParameter("status"));
            if (req.getParameter("imageUrl") != null && !req.getParameter("imageUrl").trim().isEmpty()) {
                v.setImageUrl(req.getParameter("imageUrl"));
            }
            v.setDescription(req.getParameter("description"));
            v.setFeatures(req.getParameter("features"));
            v.setRentalTerms(req.getParameter("rentalTerms"));

            boolean updated = fleetService.updateVehicle(v, user.getId(), user.getRole(), req.getRemoteAddr());
            if (updated) {
                resp.sendRedirect(req.getContextPath() + "/owner/vehicles?success=vehicle_updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/owner/vehicles/edit?id=" + vehicleId + "&error=update_failed");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles");
        }
    }
}
