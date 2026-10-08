package com.wheelyx.controller;

import com.wheelyx.dao.BillDAO;
import com.wheelyx.dao.BookingDAO;
import com.wheelyx.model.Bill;
import com.wheelyx.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "BookingConfirmationServlet", urlPatterns = {"/booking/confirmation"})
public class BookingConfirmationServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        if (code == null || code.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings");
            return;
        }

        Booking booking = bookingDAO.findByCode(code.trim());
        if (booking == null) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings?error=not_found");
            return;
        }

        Bill bill = billDAO.findByBookingId(booking.getId());

        req.setAttribute("booking", booking);
        req.setAttribute("bill", bill);

        req.getRequestDispatcher("/pages/booking/confirmation.jsp").forward(req, resp);
    }
}
