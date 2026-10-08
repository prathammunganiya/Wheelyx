package com.wheelyx.controller;

import com.wheelyx.dao.BillDAO;
import com.wheelyx.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminBillsServlet", urlPatterns = {"/admin/bills"})
public class AdminBillsServlet extends HttpServlet {

    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Bill> bills = billDAO.findAll(0, 100);
        req.setAttribute("bills", bills);
        req.getRequestDispatcher("/pages/admin/bills.jsp").forward(req, resp);
    }
}
