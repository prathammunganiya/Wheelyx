package com.wheelyx.controller;

import com.wheelyx.dao.NotificationDAO;
import com.wheelyx.dao.UserDAO;
import com.wheelyx.dao.VehicleOwnerDAO;
import com.wheelyx.model.Notification;
import com.wheelyx.model.User;
import com.wheelyx.model.VehicleOwner;
import com.wheelyx.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile", "/customer/profile", "/owner/profile"})
public class ProfileServlet extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final UserDAO userDAO = new UserDAO();
    private final VehicleOwnerDAO ownerDAO = new VehicleOwnerDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        User freshUser = userDAO.findById(user.getId());
        req.setAttribute("user", freshUser);

        if (freshUser.isOwner()) {
            VehicleOwner ownerDetails = ownerDAO.findByUserId(freshUser.getId());
            req.setAttribute("ownerDetails", ownerDetails);
        }

        List<Notification> notifications = notificationDAO.findByUserId(freshUser.getId(), 10);
        req.setAttribute("notifications", notifications);

        req.getRequestDispatcher("/pages/auth/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = req.getParameter("action");
        String clientIp = req.getRemoteAddr();

        if ("updateProfile".equalsIgnoreCase(action)) {
            String name = req.getParameter("name");
            String phone = req.getParameter("phone");
            boolean success = authService.updateProfile(user.getId(), name, phone, clientIp);
            if (success) {
                user.setName(name);
                user.setPhone(phone);
                session.setAttribute("user", user);
                session.setAttribute("userName", name);
                resp.sendRedirect(req.getRequestURI() + "?success=profile_updated");
            } else {
                resp.sendRedirect(req.getRequestURI() + "?error=invalid_data");
            }
        } else if ("changePassword".equalsIgnoreCase(action)) {
            String oldPass = req.getParameter("currentPassword");
            String newPass = req.getParameter("newPassword");
            String confirmPass = req.getParameter("confirmPassword");

            if (!newPass.equals(confirmPass)) {
                resp.sendRedirect(req.getRequestURI() + "?error=password_mismatch");
                return;
            }

            boolean success = authService.changePassword(user.getId(), oldPass, newPass, clientIp);
            if (success) {
                resp.sendRedirect(req.getRequestURI() + "?success=password_changed");
            } else {
                resp.sendRedirect(req.getRequestURI() + "?error=incorrect_password");
            }
        }
    }
}
