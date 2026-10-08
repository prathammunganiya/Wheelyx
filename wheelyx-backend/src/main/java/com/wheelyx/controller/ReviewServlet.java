package com.wheelyx.controller;

import com.wheelyx.dao.RentalDAO;
import com.wheelyx.model.Rental;
import com.wheelyx.model.User;
import com.wheelyx.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/customer/review"})
public class ReviewServlet extends HttpServlet {

    private final RentalDAO rentalDAO = new RentalDAO();
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String rentalIdParam = req.getParameter("rentalId");
        if (rentalIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/customer/rentals");
            return;
        }

        try {
            long rentalId = Long.parseLong(rentalIdParam.trim());
            Rental rental = rentalDAO.findById(rentalId);

            if (rental == null || !rental.getCustomerId().equals(user.getId()) || !rental.isReturned()) {
                resp.sendRedirect(req.getContextPath() + "/customer/rentals?error=cannot_review");
                return;
            }

            req.setAttribute("rental", rental);
            req.getRequestDispatcher("/pages/customer/review-add.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/customer/rentals");
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
            long rentalId = Long.parseLong(req.getParameter("rentalId"));
            int rating = Integer.parseInt(req.getParameter("rating"));
            String comment = req.getParameter("comment");

            boolean success = reviewService.submitReview(rentalId, user.getId(), rating, comment, req.getRemoteAddr());
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/customer/rentals?success=review_submitted");
            } else {
                resp.sendRedirect(req.getContextPath() + "/customer/review?rentalId=" + rentalId + "&error=submission_failed");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/customer/rentals?error=error");
        }
    }
}
