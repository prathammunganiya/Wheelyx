package com.wheelyx.controller;

import com.wheelyx.dao.RentalDAO;
import com.wheelyx.model.Rental;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminRentalsServlet", urlPatterns = {"/admin/rentals"})
public class AdminRentalsServlet extends HttpServlet {

    private final RentalDAO rentalDAO = new RentalDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<Rental> rentals = rentalDAO.findAll(status, 0, 100);

        req.setAttribute("rentals", rentals);
        req.setAttribute("selectedStatus", status);

        req.getRequestDispatcher("/pages/admin/rentals.jsp").forward(req, resp);
    }
}
