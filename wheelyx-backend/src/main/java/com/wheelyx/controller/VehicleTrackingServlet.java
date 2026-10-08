package com.wheelyx.controller;

import com.wheelyx.dao.RentalDAO;
import com.wheelyx.dao.VehicleDAO;
import com.wheelyx.model.Rental;
import com.wheelyx.model.User;
import com.wheelyx.model.Vehicle;
import com.wheelyx.model.VehicleLocation;
import com.wheelyx.service.TrackingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "VehicleTrackingServlet", urlPatterns = {"/tracking", "/customer/tracking"})
public class VehicleTrackingServlet extends HttpServlet {

    private final TrackingService trackingService = new TrackingService();
    private final RentalDAO rentalDAO = new RentalDAO();
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String rentalIdParam = req.getParameter("rentalId");
        String vehicleIdParam = req.getParameter("vehicleId");

        Rental rental = null;
        Vehicle vehicle = null;

        if (rentalIdParam != null && !rentalIdParam.trim().isEmpty()) {
            try {
                long rentalId = Long.parseLong(rentalIdParam.trim());
                rental = rentalDAO.findById(rentalId);
                if (rental != null) {
                    vehicle = vehicleDAO.findById(rental.getVehicleId());
                }
            } catch (NumberFormatException ignored) {}
        } else if (vehicleIdParam != null && !vehicleIdParam.trim().isEmpty()) {
            try {
                long vehicleId = Long.parseLong(vehicleIdParam.trim());
                vehicle = vehicleDAO.findById(vehicleId);
            } catch (NumberFormatException ignored) {}
        }

        if (vehicle == null) {
            resp.sendRedirect(req.getContextPath() + "/customer/rentals?error=vehicle_not_found");
            return;
        }

        VehicleLocation location = trackingService.getLatestVehicleLocation(vehicle.getId());
        boolean isMapsConfigured = trackingService.isGoogleMapsConfigured();
        String apiKey = trackingService.getGoogleMapsApiKey();

        req.setAttribute("vehicle", vehicle);
        req.setAttribute("rental", rental);
        req.setAttribute("location", location);
        req.setAttribute("isMapsConfigured", isMapsConfigured);
        req.setAttribute("googleMapsApiKey", apiKey);

        req.getRequestDispatcher("/pages/tracking/view.jsp").forward(req, resp);
    }
}
