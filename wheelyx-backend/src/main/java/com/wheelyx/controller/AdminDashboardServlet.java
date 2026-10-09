package com.wheelyx.controller;

import com.wheelyx.dao.*;
import com.wheelyx.model.*;
import com.wheelyx.util.JsonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final AuditLogDAO auditLogDAO = new AuditLogDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> kpis = reportDAO.getAdminKpis();
        Map<String, Integer> categoryDist = reportDAO.getBookingsByCategory();
        Map<String, Integer> cityDist = reportDAO.getVehiclesByCity();

        List<Booking> recentBookings = bookingDAO.findAll(null, 0, 5);
        List<AuditLog> recentLogs = auditLogDAO.findAll(0, 8);

        req.setAttribute("kpis", kpis);
        req.setAttribute("recentBookings", recentBookings);
        req.setAttribute("recentLogs", recentLogs);
        req.setAttribute("categoryDistJson", JsonUtil.toJson(categoryDist));
        req.setAttribute("cityDistJson", JsonUtil.toJson(cityDist));

        req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
    }
}
