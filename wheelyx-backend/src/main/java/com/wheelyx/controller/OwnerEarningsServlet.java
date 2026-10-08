package com.wheelyx.controller;

import com.wheelyx.dao.ReportDAO;
import com.wheelyx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "OwnerEarningsServlet", urlPatterns = {"/owner/earnings"})
public class OwnerEarningsServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=owner");
            return;
        }

        Map<String, Object> kpis = reportDAO.getOwnerKpis(user.getId());
        req.setAttribute("kpis", kpis);

        req.getRequestDispatcher("/pages/owner/earnings.jsp").forward(req, resp);
    }
}
