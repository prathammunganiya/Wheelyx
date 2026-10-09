package com.wheelyx.controller;

import com.wheelyx.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/auth/register", "/owner/register", "/register"})
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String roleParam = req.getParameter("role");
        String uri = req.getRequestURI();
        String activeRole = (uri.contains("/owner") || "owner".equalsIgnoreCase(roleParam)) ? "owner" : "customer";

        req.setAttribute("activeRoleTab", activeRole);
        req.getRequestDispatcher("/pages/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String role = req.getParameter("role");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String clientIp = req.getRemoteAddr();

        if (role == null) role = "CUSTOMER";
        role = role.trim().toUpperCase();

        if (password == null || !password.equals(confirmPassword)) {
            req.setAttribute("errorMessage", "Passwords do not match.");
            req.setAttribute("activeRoleTab", role.toLowerCase());
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/pages/auth/register.jsp").forward(req, resp);
            return;
        }

        boolean success;
        if ("OWNER".equalsIgnoreCase(role)) {
            String businessName = req.getParameter("businessName");
            String panNumber = req.getParameter("panNumber");
            String bankAccount = req.getParameter("bankAccount");
            String ifscCode = req.getParameter("ifscCode");
            success = authService.registerOwner(name, email, phone, password, businessName, panNumber, bankAccount, ifscCode, clientIp);
        } else {
            success = authService.registerCustomer(name, email, phone, password, clientIp);
        }

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=" + role.toLowerCase() + "&success=registered");
        } else {
            req.setAttribute("errorMessage", "Registration failed. Email may already be registered or invalid information provided.");
            req.setAttribute("activeRoleTab", role.toLowerCase());
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/pages/auth/register.jsp").forward(req, resp);
        }
    }
}
