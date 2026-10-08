package com.wheelyx.controller;

import com.wheelyx.dao.RentalDAO;
import com.wheelyx.model.Rental;
import com.wheelyx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerRentalsServlet", urlPatterns = {"/customer/rentals"})
public class CustomerRentalsServlet extends HttpServlet {

    private final RentalDAO rentalDAO = new RentalDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        List<Rental> rentals = rentalDAO.findByCustomerId(user.getId());
        req.setAttribute("rentals", rentals);

        req.getRequestDispatcher("/pages/customer/rentals.jsp").forward(req, resp);
    }
}
