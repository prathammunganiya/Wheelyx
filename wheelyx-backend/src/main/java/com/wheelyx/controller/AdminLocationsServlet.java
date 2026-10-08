package com.wheelyx.controller;

import com.wheelyx.dao.AuditLogDAO;
import com.wheelyx.dao.CityDAO;
import com.wheelyx.model.City;
import com.wheelyx.model.CityPlace;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminLocationsServlet", urlPatterns = {"/admin/locations"})
public class AdminLocationsServlet extends HttpServlet {

    private final CityDAO cityDAO = new CityDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cityIdParam = req.getParameter("cityId");
        int selectedCityId = 1; // Default Delhi
        if (cityIdParam != null && !cityIdParam.trim().isEmpty()) {
            try { selectedCityId = Integer.parseInt(cityIdParam.trim()); } catch (NumberFormatException ignored) {}
        }

        List<City> cities = cityDAO.findAll();
        List<CityPlace> places = cityDAO.findPlacesByCityId(selectedCityId);
        City selectedCity = cityDAO.findById(selectedCityId);

        req.setAttribute("cities", cities);
        req.setAttribute("places", places);
        req.setAttribute("selectedCity", selectedCity);

        req.getRequestDispatcher("/pages/admin/locations.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // Cancel button support
        if (req.getParameter("cancel") != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/locations");
            return;
        }

        if ("addPlace".equalsIgnoreCase(action)) {
            try {
                int cityId = Integer.parseInt(req.getParameter("cityId"));
                String placeName = req.getParameter("placeName");
                String landmark = req.getParameter("landmarkDetails");

                CityPlace p = new CityPlace(null, cityId, placeName.trim(), landmark != null ? landmark.trim() : "", true);
                cityDAO.createPlace(p);
                AuditLogDAO.log(null, "ADMIN", "ADD_PLACE", "CITY_PLACE", p.getId(),
                        "Added real location " + placeName + " to city ID " + cityId, req.getRemoteAddr());

                resp.sendRedirect(req.getContextPath() + "/admin/locations?cityId=" + cityId + "&success=place_added");
                return;
            } catch (Exception ignored) {}
        }
        resp.sendRedirect(req.getContextPath() + "/admin/locations");
    }
}
