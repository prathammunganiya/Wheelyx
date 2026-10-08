package com.wheelyx.controller;

import com.wheelyx.dao.RentalDAO;
import com.wheelyx.model.Rental;
import com.wheelyx.model.User;
import com.wheelyx.service.RentalService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OwnerRentalsServlet", urlPatterns = {"/owner/rentals"})
public class OwnerRentalsServlet extends HttpServlet {

    private final RentalDAO rentalDAO = new RentalDAO();
    private final RentalService rentalService = new RentalService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=owner");
            return;
        }

        List<Rental> rentals = rentalDAO.findByOwnerId(user.getId());
        req.setAttribute("rentals", rentals);

        req.getRequestDispatcher("/pages/owner/rentals.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String action = req.getParameter("action");
        if ("returnCheckIn".equalsIgnoreCase(action)) {
            try {
                long rentalId = Long.parseLong(req.getParameter("rentalId"));
                int endOdo = Integer.parseInt(req.getParameter("endOdometer"));
                String fuelLevel = req.getParameter("fuelLevelEnd");
                String returnNotes = req.getParameter("returnNotes");

                boolean success = rentalService.processReturn(rentalId, endOdo, fuelLevel, returnNotes, user.getId(), user.getRole(), req.getRemoteAddr());
                if (success) {
                    resp.sendRedirect(req.getContextPath() + "/owner/rentals?success=return_completed");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/owner/rentals?error=return_failed");
                }
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/owner/rentals?error=error");
            }
        }
    }
}
