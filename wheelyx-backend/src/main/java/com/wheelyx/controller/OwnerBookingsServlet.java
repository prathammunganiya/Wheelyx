package com.wheelyx.controller;

import com.wheelyx.dao.BookingDAO;
import com.wheelyx.model.Booking;
import com.wheelyx.model.Rental;
import com.wheelyx.model.User;
import com.wheelyx.service.RentalService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OwnerBookingsServlet", urlPatterns = {"/owner/bookings"})
public class OwnerBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RentalService rentalService = new RentalService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=owner");
            return;
        }

        List<Booking> bookings = bookingDAO.findByOwnerId(user.getId());
        req.setAttribute("bookings", bookings);

        req.getRequestDispatcher("/pages/owner/bookings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String action = req.getParameter("action");
        if ("handover".equalsIgnoreCase(action)) {
            try {
                long bookingId = Long.parseLong(req.getParameter("bookingId"));
                int startOdo = Integer.parseInt(req.getParameter("startOdometer"));
                String fuelLevel = req.getParameter("fuelLevel");
                String notes = req.getParameter("notes");

                Rental rental = rentalService.dispatchHandover(bookingId, startOdo, fuelLevel, notes, user.getId(), user.getRole(), req.getRemoteAddr());
                if (rental != null) {
                    resp.sendRedirect(req.getContextPath() + "/owner/rentals?success=handover_dispatched");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/owner/bookings?error=handover_failed");
                }
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/owner/bookings?error=error");
            }
        }
    }
}
