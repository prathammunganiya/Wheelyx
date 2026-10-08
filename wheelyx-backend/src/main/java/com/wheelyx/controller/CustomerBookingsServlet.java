package com.wheelyx.controller;

import com.wheelyx.dao.BookingDAO;
import com.wheelyx.model.Booking;
import com.wheelyx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerBookingsServlet", urlPatterns = {"/customer/bookings"})
public class CustomerBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        List<Booking> bookings = bookingDAO.findByCustomerId(user.getId());
        req.setAttribute("bookings", bookings);

        req.getRequestDispatcher("/pages/customer/bookings.jsp").forward(req, resp);
    }
}
