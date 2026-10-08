package com.wheelyx.controller;

import com.wheelyx.dao.BookingDAO;
import com.wheelyx.dao.RentalDAO;
import com.wheelyx.dao.ReportDAO;
import com.wheelyx.dao.VehicleDAO;
import com.wheelyx.model.Booking;
import com.wheelyx.model.Rental;
import com.wheelyx.model.User;
import com.wheelyx.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "OwnerDashboardServlet", urlPatterns = {"/owner/dashboard"})
public class OwnerDashboardServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();
    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final RentalDAO rentalDAO = new RentalDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !user.isOwner()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=owner");
            return;
        }

        Map<String, Object> kpis = reportDAO.getOwnerKpis(user.getId());
        List<Vehicle> vehicles = vehicleDAO.findByOwnerId(user.getId());
        List<Booking> recentBookings = bookingDAO.findByOwnerId(user.getId());
        List<Rental> activeRentals = rentalDAO.findByOwnerId(user.getId());

        req.setAttribute("kpis", kpis);
        req.setAttribute("vehicles", vehicles);
        req.setAttribute("recentBookings", recentBookings);
        req.setAttribute("activeRentals", activeRentals);

        req.getRequestDispatcher("/pages/owner/dashboard.jsp").forward(req, resp);
    }
}
