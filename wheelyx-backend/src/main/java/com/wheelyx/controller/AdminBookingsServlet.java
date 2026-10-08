package com.wheelyx.controller;

import com.wheelyx.dao.BookingDAO;
import com.wheelyx.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminBookingsServlet", urlPatterns = {"/admin/bookings"})
public class AdminBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<Booking> bookings = bookingDAO.findAll(status, 0, 100);

        req.setAttribute("bookings", bookings);
        req.setAttribute("selectedStatus", status);

        req.getRequestDispatcher("/pages/admin/bookings.jsp").forward(req, resp);
    }
}
