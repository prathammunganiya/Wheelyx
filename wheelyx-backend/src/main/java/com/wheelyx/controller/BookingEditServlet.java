package com.wheelyx.controller;

import com.wheelyx.dao.BookingDAO;
import com.wheelyx.model.Booking;
import com.wheelyx.model.CityPlace;
import com.wheelyx.model.User;
import com.wheelyx.service.BookingService;
import com.wheelyx.service.FleetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "BookingEditServlet", urlPatterns = {"/customer/booking/edit"})
public class BookingEditServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final BookingService bookingService = new BookingService();
    private final FleetService fleetService = new FleetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings");
            return;
        }

        try {
            long bookingId = Long.parseLong(idParam.trim());
            Booking booking = bookingDAO.findById(bookingId);

            if (booking == null || !booking.getCustomerId().equals(user.getId()) || !booking.isModifiable()) {
                resp.sendRedirect(req.getContextPath() + "/customer/bookings?error=not_editable");
                return;
            }

            List<CityPlace> places = fleetService.getPlacesForCity(booking.getCityId());
            req.setAttribute("booking", booking);
            req.setAttribute("places", places);
            req.setAttribute("minDate", LocalDate.now().toString());

            req.getRequestDispatcher("/pages/customer/booking-edit.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        try {
            long bookingId = Long.parseLong(req.getParameter("id"));
            long pickupPlaceId = Long.parseLong(req.getParameter("pickupPlaceId"));
            long returnPlaceId = Long.parseLong(req.getParameter("returnPlaceId"));
            LocalDate startDate = LocalDate.parse(req.getParameter("startDate"));
            LocalDate endDate = LocalDate.parse(req.getParameter("endDate"));
            String notes = req.getParameter("notes");
            String clientIp = req.getRemoteAddr();

            boolean updated = bookingService.editBooking(
                    bookingId, user.getId(), pickupPlaceId, returnPlaceId, startDate, endDate, notes, clientIp
            );

            if (updated) {
                resp.sendRedirect(req.getContextPath() + "/customer/bookings?success=booking_updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/customer/booking/edit?id=" + bookingId + "&error=update_failed");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings?error=error");
        }
    }
}
