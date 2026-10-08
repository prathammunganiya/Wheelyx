package com.wheelyx.controller;

import com.wheelyx.model.Booking;
import com.wheelyx.model.City;
import com.wheelyx.model.CityPlace;
import com.wheelyx.model.User;
import com.wheelyx.model.Vehicle;
import com.wheelyx.service.BookingService;
import com.wheelyx.service.FleetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking", "/booking/create"})
public class BookingServlet extends HttpServlet {

    private final FleetService fleetService = new FleetService();
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?role=customer&info=login_to_book");
            return;
        }

        String vehicleIdParam = req.getParameter("vehicleId");
        if (vehicleIdParam == null || vehicleIdParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/vehicles");
            return;
        }

        try {
            long vehicleId = Long.parseLong(vehicleIdParam.trim());
            Vehicle vehicle = fleetService.getVehicleDetails(vehicleId);
            if (vehicle == null || !vehicle.isAvailable()) {
                resp.sendRedirect(req.getContextPath() + "/vehicles?error=unavailable");
                return;
            }

            List<City> cities = fleetService.getAllCities();
            List<CityPlace> places = fleetService.getPlacesForCity(vehicle.getCityId());

            req.setAttribute("vehicle", vehicle);
            req.setAttribute("cities", cities);
            req.setAttribute("places", places);
            req.setAttribute("minDate", LocalDate.now().toString());

            req.getRequestDispatcher("/pages/booking/book.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/vehicles");
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
            long vehicleId = Long.parseLong(req.getParameter("vehicleId"));
            int cityId = Integer.parseInt(req.getParameter("cityId"));
            long pickupPlaceId = Long.parseLong(req.getParameter("pickupPlaceId"));
            long returnPlaceId = Long.parseLong(req.getParameter("returnPlaceId"));
            LocalDate startDate = LocalDate.parse(req.getParameter("startDate"));
            LocalDate endDate = LocalDate.parse(req.getParameter("endDate"));
            String notes = req.getParameter("notes");
            String clientIp = req.getRemoteAddr();

            Booking booking = bookingService.createBooking(
                    user.getId(), vehicleId, cityId, pickupPlaceId, returnPlaceId,
                    startDate, endDate, notes, clientIp
            );

            if (booking != null) {
                resp.sendRedirect(req.getContextPath() + "/booking/confirmation?code=" + booking.getBookingCode());
            } else {
                resp.sendRedirect(req.getContextPath() + "/booking?vehicleId=" + vehicleId + "&error=overlap_or_invalid_dates");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/vehicles?error=booking_failed");
        }
    }
}
