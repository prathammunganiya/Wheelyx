package com.wheelyx.controller;

import com.wheelyx.model.User;
import com.wheelyx.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/auth/login", "/admin/login", "/owner/login", "/customer/login", "/login"})
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        String roleParam = req.getParameter("role");

        String defaultRole = "customer";
        if (uri.contains("/admin") || "admin".equalsIgnoreCase(roleParam)) {
            defaultRole = "admin";
        } else if (uri.contains("/owner") || "owner".equalsIgnoreCase(roleParam)) {
            defaultRole = "owner";
        }

        req.setAttribute("activeRoleTab", defaultRole);
        req.getRequestDispatcher("/pages/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String requestedRole = req.getParameter("role");

        if (requestedRole == null || requestedRole.trim().isEmpty()) {
            requestedRole = "CUSTOMER";
        } else {
            requestedRole = requestedRole.trim().toUpperCase();
        }

        String clientIp = req.getRemoteAddr();
        User user = authService.login(email, password, requestedRole, clientIp);

        if (user != null) {
            // Prevent Session Fixation: Invalidate old session and create fresh
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("user", user);
            newSession.setAttribute("userId", user.getId());
            newSession.setAttribute("userName", user.getName());
            newSession.setAttribute("userEmail", user.getEmail());
            newSession.setAttribute("userRole", user.getRole());
            newSession.setMaxInactiveInterval(1800); // 30 minutes session timeout

            // Strict role redirection
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else if (user.isOwner()) {
                resp.sendRedirect(req.getContextPath() + "/owner/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/customer/dashboard");
            }
        } else {
            req.setAttribute("errorMessage", "Invalid credentials or unauthorized role access. Please verify your details.");
            req.setAttribute("activeRoleTab", requestedRole.toLowerCase());
            req.setAttribute("email", email);
            req.getRequestDispatcher("/pages/auth/login.jsp").forward(req, resp);
        }
    }
}
