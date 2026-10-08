package com.wheelyx.controller;

import com.wheelyx.dao.BillDAO;
import com.wheelyx.model.Bill;
import com.wheelyx.model.Payment;
import com.wheelyx.model.User;
import com.wheelyx.service.BillingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/billing/payment"})
public class PaymentServlet extends HttpServlet {

    private final BillDAO billDAO = new BillDAO();
    private final BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String billIdParam = req.getParameter("billId");
        if (billIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings");
            return;
        }

        try {
            long billId = Long.parseLong(billIdParam.trim());
            Bill bill = billDAO.findById(billId);
            if (bill == null) {
                resp.sendRedirect(req.getContextPath() + "/customer/bookings?error=bill_not_found");
                return;
            }

            req.setAttribute("bill", bill);
            req.getRequestDispatcher("/pages/billing/payment.jsp").forward(req, resp);
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
            long billId = Long.parseLong(req.getParameter("billId"));
            String method = req.getParameter("paymentMethod");
            Payment payment = billingService.processPayment(billId, user.getId(), method, req.getRemoteAddr());

            if (payment != null) {
                resp.sendRedirect(req.getContextPath() + "/billing/invoice?billNo=" + payment.getBillNo() + "&success=paid");
            } else {
                resp.sendRedirect(req.getContextPath() + "/billing/payment?billId=" + billId + "&error=failed");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/customer/bookings");
        }
    }
}
