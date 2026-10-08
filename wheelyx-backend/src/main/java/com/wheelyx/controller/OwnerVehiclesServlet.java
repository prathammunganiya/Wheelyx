package com.wheelyx.controller;

import com.wheelyx.model.User;
import com.wheelyx.model.Vehicle;
import com.wheelyx.service.FleetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OwnerVehiclesServlet", urlPatterns = {"/owner/vehicles"})
public class OwnerVehiclesServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=owner");
            return;
        }

        List<Vehicle> vehicles = fleetService.getOwnerVehicles(user.getId());
        req.setAttribute("vehicles", vehicles);

        req.getRequestDispatcher("/pages/owner/vehicles.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String action = req.getParameter("action");
        String idParam = req.getParameter("vehicleId");

        if ("toggleStatus".equalsIgnoreCase(action) && idParam != null) {
            long vehicleId = Long.parseLong(idParam.trim());
            String newStatus = req.getParameter("status");
            fleetService.updateVehicleStatus(vehicleId, newStatus, user.getId(), user.getRole(), req.getRemoteAddr());
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles?success=status_updated");
        } else if ("cancelListing".equalsIgnoreCase(action) && idParam != null) {
            long vehicleId = Long.parseLong(idParam.trim());
            fleetService.cancelOrRemoveListing(vehicleId, user.getId(), user.getRole(), req.getRemoteAddr());
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles?success=listing_cancelled");
        } else {
            resp.sendRedirect(req.getContextPath() + "/owner/vehicles");
        }
    }
}
