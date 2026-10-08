package com.wheelyx.controller;

import com.wheelyx.dao.ReportDAO;
import com.wheelyx.util.JsonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AdminReportsServlet", urlPatterns = {"/admin/reports"})
public class AdminReportsServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> kpis = reportDAO.getAdminKpis();
        Map<String, Integer> categoryDist = reportDAO.getBookingsByCategory();
        Map<String, Integer> cityDist = reportDAO.getVehiclesByCity();

        req.setAttribute("kpis", kpis);
        req.setAttribute("categoryDist", categoryDist);
        req.setAttribute("cityDist", cityDist);
        req.setAttribute("categoryDistJson", JsonUtil.toJson(categoryDist));
        req.setAttribute("cityDistJson", JsonUtil.toJson(cityDist));

        req.getRequestDispatcher("/pages/admin/reports.jsp").forward(req, resp);
    }
}
