package com.wheelyx.controller;

import com.wheelyx.dao.BillDAO;
import com.wheelyx.dao.BookingDAO;
import com.wheelyx.model.Bill;
import com.wheelyx.model.Booking;
import com.wheelyx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "InvoiceServlet", urlPatterns = {"/billing/invoice"})
public class InvoiceServlet extends HttpServlet {

    private final BillDAO billDAO = new BillDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String billNo = req.getParameter("billNo");
        String bookingIdParam = req.getParameter("bookingId");

        Bill bill = null;
        if (billNo != null && !billNo.trim().isEmpty()) {
            bill = billDAO.findByBillNo(billNo.trim());
        } else if (bookingIdParam != null && !bookingIdParam.trim().isEmpty()) {
            try {
                long bookingId = Long.parseLong(bookingIdParam.trim());
                bill = billDAO.findByBookingId(bookingId);
            } catch (NumberFormatException ignored) {}
        }

        if (bill == null) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings?error=invoice_not_found");
            return;
        }

        Booking booking = bookingDAO.findById(bill.getBookingId());

        // Authorization check: only customer who booked, vehicle owner, or admin can view
        if (!user.isAdmin() && !user.getId().equals(booking.getCustomerId())) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings?error=unauthorized");
            return;
        }

        req.setAttribute("bill", bill);
        req.setAttribute("booking", booking);

        req.getRequestDispatcher("/pages/billing/invoice.jsp").forward(req, resp);
    }
}
