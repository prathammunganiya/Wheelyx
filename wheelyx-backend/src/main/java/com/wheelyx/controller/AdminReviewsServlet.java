package com.wheelyx.controller;

import com.wheelyx.dao.ReviewDAO;
import com.wheelyx.model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminReviewsServlet", urlPatterns = {"/admin/reviews"})
public class AdminReviewsServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Review> reviews = reviewDAO.findAll(100);
        req.setAttribute("reviews", reviews);
        req.getRequestDispatcher("/pages/admin/reviews.jsp").forward(req, resp);
    }
}
