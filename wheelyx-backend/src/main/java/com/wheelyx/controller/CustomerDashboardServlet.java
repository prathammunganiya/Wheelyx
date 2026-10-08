package com.wheelyx.controller;

import com.wheelyx.dao.BookingDAO;
import com.wheelyx.dao.PaymentDAO;
import com.wheelyx.dao.RentalDAO;
import com.wheelyx.model.Booking;
import com.wheelyx.model.Payment;
import com.wheelyx.model.Rental;
import com.wheelyx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "CustomerDashboardServlet", urlPatterns = {"/customer/dashboard"})
public class CustomerDashboardServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RentalDAO rentalDAO = new RentalDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        List<Booking> bookings = bookingDAO.findByCustomerId(user.getId());
        List<Rental> rentals = rentalDAO.findByCustomerId(user.getId());
        List<Payment> payments = paymentDAO.findByCustomerId(user.getId());

        // Find active rental (if any)
        Rental activeRental = rentals.stream()
                .filter(Rental::isActive)
                .findFirst()
                .orElse(null);

        // Find upcoming booking (if any)
        Booking upcomingBooking = bookings.stream()
                .filter(Booking::isModifiable)
                .findFirst()
                .orElse(null);

        BigDecimal totalSpend = payments.stream()
                .filter(p -> "SUCCESS".equalsIgnoreCase(p.getStatus()))
                .map(Payment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        req.setAttribute("user", user);
        req.setAttribute("bookings", bookings);
        req.setAttribute("rentals", rentals);
        req.setAttribute("activeRental", activeRental);
        req.setAttribute("upcomingBooking", upcomingBooking);
        req.setAttribute("totalBookings", bookings.size());
        req.setAttribute("totalRentals", rentals.size());
        req.setAttribute("totalSpend", totalSpend);

        req.getRequestDispatcher("/pages/customer/dashboard.jsp").forward(req, resp);
    }
}
