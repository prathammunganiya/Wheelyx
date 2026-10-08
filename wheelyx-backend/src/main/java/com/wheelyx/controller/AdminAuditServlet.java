package com.wheelyx.controller;

import com.wheelyx.dao.AuditLogDAO;
import com.wheelyx.model.AuditLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminAuditServlet", urlPatterns = {"/admin/audit"})
public class AdminAuditServlet extends HttpServlet {

    private final AuditLogDAO auditLogDAO = new AuditLogDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<AuditLog> logs = auditLogDAO.findAll(0, 100);
        int total = auditLogDAO.countAll();

        req.setAttribute("logs", logs);
        req.setAttribute("totalCount", total);

        req.getRequestDispatcher("/pages/admin/audit.jsp").forward(req, resp);
    }
}
