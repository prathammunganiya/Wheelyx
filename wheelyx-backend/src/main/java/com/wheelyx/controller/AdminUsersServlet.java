package com.wheelyx.controller;

import com.wheelyx.dao.AuditLogDAO;
import com.wheelyx.dao.UserDAO;
import com.wheelyx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUsersServlet", urlPatterns = {"/admin/users"})
public class AdminUsersServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String roleFilter = req.getParameter("role");
        String statusFilter = req.getParameter("status");

        List<User> users = userDAO.findAll(roleFilter, statusFilter, 0, 50);
        int total = userDAO.countAll(roleFilter, statusFilter);

        req.setAttribute("users", users);
        req.setAttribute("totalCount", total);
        req.setAttribute("roleFilter", roleFilter);
        req.setAttribute("statusFilter", statusFilter);

        req.getRequestDispatcher("/pages/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idParam = req.getParameter("userId");

        if (idParam != null && "toggleStatus".equalsIgnoreCase(action)) {
            try {
                long userId = Long.parseLong(idParam.trim());
                String newStatus = req.getParameter("status");
                userDAO.updateStatus(userId, newStatus);
                AuditLogDAO.log(null, "ADMIN", "UPDATE_USER_STATUS", "USER", userId,
                        "User status updated to " + newStatus, req.getRemoteAddr());
            } catch (NumberFormatException ignored) {}
        }
        resp.sendRedirect(req.getContextPath() + "/admin/users?success=updated");
    }
}
