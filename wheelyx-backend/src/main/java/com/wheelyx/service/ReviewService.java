package com.wheelyx.service;

import com.wheelyx.dao.*;
import com.wheelyx.model.*;
import com.wheelyx.util.ValidationUtil;

import java.util.List;

public class ReviewService {

    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final RentalDAO rentalDAO = new RentalDAO();

    public boolean submitReview(Long rentalId, Long customerId, int rating, String comment, String ipAddress) {
        if (!ValidationUtil.isValidRating(rating) || !ValidationUtil.isNotEmpty(comment)) {
            return false;
        }

        Rental rental = rentalDAO.findById(rentalId);
        if (rental == null) return false;

        // Must belong to this customer
        if (!rental.getCustomerId().equals(customerId)) {
            return false;
        }

        // Must be in RETURNED status
        if (!"RETURNED".equalsIgnoreCase(rental.getStatus())) {
            return false;
        }

        // Prevent duplicate review for the same rental
        if (reviewDAO.findByRentalId(rentalId) != null) {
            return false;
        }

        Review r = new Review();
        r.setRentalId(rentalId);
        r.setCustomerId(customerId);
        r.setVehicleId(rental.getVehicleId());
        r.setRating(rating);
        r.setComment(comment.trim());

        boolean created = reviewDAO.create(r);
        if (created) {
            AuditLogDAO.log(customerId, "CUSTOMER", "SUBMIT_REVIEW", "REVIEW", r.getId(),
                    "Submitted verified " + rating + "-star review for vehicle id " + rental.getVehicleId(), ipAddress);
        }
        return created;
    }

    public List<Review> getHomepageReviews(int limit) {
        return reviewDAO.findAll(limit > 0 ? limit : 6);
    }

    public List<Review> getVehicleReviews(Long vehicleId) {
        return reviewDAO.findByVehicleId(vehicleId);
    }
}
