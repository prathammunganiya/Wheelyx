package com.wheelyx.controller;

import com.wheelyx.dao.AuditLogDAO;
import com.wheelyx.dao.MaintenanceDAO;
import com.wheelyx.dao.VehicleDAO;
import com.wheelyx.model.Maintenance;
import com.wheelyx.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "AdminMaintenanceServlet", urlPatterns = {"/admin/maintenance"})
public class AdminMaintenanceServlet extends HttpServlet {

    private final MaintenanceDAO maintenanceDAO = new MaintenanceDAO();
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<Maintenance> records = maintenanceDAO.findAll(status, 0, 100);
        List<Vehicle> vehicles = vehicleDAO.findFiltered(null, null, null, null, null, null, null, null, null, null, 0, 100);

        req.setAttribute("records", records);
        req.setAttribute("vehicles", vehicles);
        req.setAttribute("today", LocalDate.now().toString());

        req.getRequestDispatcher("/pages/admin/maintenance.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // Cancel button support
        if (req.getParameter("cancel") != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/maintenance");
            return;
        }

        if ("schedule".equalsIgnoreCase(action)) {
            try {
                long vehicleId = Long.parseLong(req.getParameter("vehicleId"));
                String type = req.getParameter("maintenanceType");
                String desc = req.getParameter("description");
                LocalDate start = LocalDate.parse(req.getParameter("startDate"));
                LocalDate end = LocalDate.parse(req.getParameter("endDate"));
                BigDecimal cost = new BigDecimal(req.getParameter("cost"));
                String notes = req.getParameter("notes");

                Maintenance m = new Maintenance();
                m.setVehicleId(vehicleId);
                m.setMaintenanceType(type);
                m.setDescription(desc);
                m.setStartDate(Date.valueOf(start));
                m.setEndDate(Date.valueOf(end));
                m.setCost(cost);
                m.setStatus("IN_PROGRESS");
                m.setNotes(notes);

                boolean created = maintenanceDAO.create(m);
                if (created) {
                    // Ground vehicle: status becomes MAINTENANCE
                    vehicleDAO.updateStatus(vehicleId, "MAINTENANCE");
                    AuditLogDAO.log(null, "ADMIN", "MAINTENANCE_SCHEDULED", "MAINTENANCE", m.getId(),
                            "Vehicle " + vehicleId + " grounded for " + type, req.getRemoteAddr());
                }
            } catch (Exception ignored) {}
        } else if ("complete".equalsIgnoreCase(action)) {
            try {
                long id = Long.parseLong(req.getParameter("maintenanceId"));
                long vehicleId = Long.parseLong(req.getParameter("vehicleId"));
                maintenanceDAO.updateStatus(id, "COMPLETED");
                // Vehicle returns to AVAILABLE
                vehicleDAO.updateStatus(vehicleId, "AVAILABLE");
                AuditLogDAO.log(null, "ADMIN", "MAINTENANCE_COMPLETED", "MAINTENANCE", id,
                        "Vehicle " + vehicleId + " returned from maintenance to active fleet", req.getRemoteAddr());
            } catch (Exception ignored) {}
        }
        resp.sendRedirect(req.getContextPath() + "/admin/maintenance?success=updated");
    }
}
