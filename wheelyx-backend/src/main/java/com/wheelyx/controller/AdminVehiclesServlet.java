package com.wheelyx.controller;

import com.wheelyx.dao.AuditLogDAO;
import com.wheelyx.dao.VehicleDAO;
import com.wheelyx.model.City;
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

@WebServlet(name = "AdminVehiclesServlet", urlPatterns = {"/admin/vehicles"})
public class AdminVehiclesServlet extends HttpServlet {

    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final FleetService fleetService = new FleetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<Vehicle> vehicles = vehicleDAO.findFiltered(null, null, null, null, null, null, null, null, status, null, 0, 100);
        List<VehicleCategory> categories = fleetService.getAllCategories();
        List<City> cities = fleetService.getAllCities();

        req.setAttribute("vehicles", vehicles);
        req.setAttribute("categories", categories);
        req.setAttribute("cities", cities);

        req.getRequestDispatcher("/pages/admin/vehicles.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idParam = req.getParameter("vehicleId");

        if (idParam != null && "updateStatus".equalsIgnoreCase(action)) {
            try {
                long vehicleId = Long.parseLong(idParam.trim());
                String status = req.getParameter("status");
                vehicleDAO.updateStatus(vehicleId, status);
                AuditLogDAO.log(null, "ADMIN", "VEHICLE_STATUS_UPDATE", "VEHICLE", vehicleId,
                        "Admin changed status to " + status, req.getRemoteAddr());
            } catch (NumberFormatException ignored) {}
        }
        resp.sendRedirect(req.getContextPath() + "/admin/vehicles?success=updated");
    }
}
