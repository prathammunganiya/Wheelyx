package com.wheelyx.controller;

import com.wheelyx.model.User;
import com.wheelyx.service.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "BookingCancelServlet", urlPatterns = {"/customer/booking/cancel"})
public class BookingCancelServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String idParam = req.getParameter("id");
        String reason = req.getParameter("reason");
        if (reason == null) reason = "Cancelled by user";

        try {
            long bookingId = Long.parseLong(idParam.trim());
            boolean success = bookingService.cancelBooking(bookingId, user.getId(), user.getRole(), reason, req.getRemoteAddr());
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/customer/bookings?success=cancelled");
            } else {
                resp.sendRedirect(req.getContextPath() + "/customer/bookings?error=cancellation_failed");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings");
        }
    }
}
