<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Rate & Review Vehicle | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <style>
    .star-rating {
      display: inline-flex;
      flex-direction: row-reverse;
      font-size: 2rem;
      gap: 0.25rem;
    }
    .star-rating input {
      display: none;
    }
    .star-rating label {
      color: #cbd5e1;
      cursor: pointer;
      transition: color 0.15s ease-in-out;
    }
    .star-rating input:checked ~ label,
    .star-rating label:hover,
    .star-rating label:hover ~ label {
      color: #f59e0b;
    }
  </style>
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-7 col-md-9">
        <div class="wx-card p-4 p-md-5">
          <div class="d-flex align-items-center gap-3 mb-4 border-bottom pb-3">
            <c:if test="${not empty rental.vehicleImage}">
              <img src="${pageContext.request.contextPath}/${rental.vehicleImage}" 
                   alt="${rental.vehicleModel}" 
                   style="width: 80px; height: 55px; object-fit: contain;" 
                   class="rounded bg-light border p-1">
            </c:if>
            <div>
              <span class="badge bg-success-subtle text-success border border-success-subtle mb-1">Trip Completed</span>
              <h2 class="h4 fw-bold mb-0">${rental.vehicleModel}</h2>
              <div class="small text-muted">Trip Code: <span class="fw-semibold text-primary">${rental.rentalCode}</span></div>
            </div>
          </div>

          <div class="mb-4">
            <h3 class="h5 fw-bold mb-1">Share Your Experience</h3>
            <p class="text-muted small">Your verified feedback helps fellow mobility users choose the best self-drive ride across India.</p>
          </div>

          <c:if test="${param.error eq 'submission_failed'}">
            <div class="alert alert-danger py-2 small mb-4">
              <i class="bi bi-exclamation-triangle-fill me-1"></i> Failed to submit feedback. A review may already exist for this completed rental.
            </div>
          </c:if>

          <form action="${pageContext.request.contextPath}/customer/review" method="POST" id="reviewForm">
            <input type="hidden" name="rentalId" value="${rental.id}">

            <!-- Rating Stars (1 to 5) -->
            <div class="mb-4 text-center p-3 rounded bg-light border">
              <label class="form-label d-block fw-semibold mb-2">Overall Vehicle & Rental Rating</label>
              <div class="star-rating mb-1">
                <input type="radio" id="star5" name="rating" value="5" required>
                <label for="star5" title="5 stars - Outstanding"><i class="bi bi-star-fill"></i></label>
                <input type="radio" id="star4" name="rating" value="4">
                <label for="star4" title="4 stars - Very Good"><i class="bi bi-star-fill"></i></label>
                <input type="radio" id="star3" name="rating" value="3" checked>
                <label for="star3" title="3 stars - Average"><i class="bi bi-star-fill"></i></label>
                <input type="radio" id="star2" name="rating" value="2">
                <label for="star2" title="2 stars - Poor"><i class="bi bi-star-fill"></i></label>
                <input type="radio" id="star1" name="rating" value="1">
                <label for="star1" title="1 star - Terrible"><i class="bi bi-star-fill"></i></label>
              </div>
              <div class="small text-muted">Click to select rating stars</div>
            </div>

            <!-- Comment -->
            <div class="mb-4">
              <label for="comment" class="form-label fw-semibold">Review Comments</label>
              <textarea class="form-control" id="comment" name="comment" rows="4" 
                        placeholder="Describe vehicle cleanliness, driving smoothness, pickup convenience, and overall satisfaction..." 
                        required minlength="10" maxlength="800"></textarea>
              <div class="form-text">Minimum 10 characters. Real feedback will be published on the Wheelyx platform.</div>
            </div>

            <!-- Edit / Submit / Cancel actions -->
            <div class="d-flex justify-content-between align-items-center pt-3 border-top gap-2">
              <a href="${pageContext.request.contextPath}/customer/rentals" class="btn btn-outline-secondary px-4">
                <i class="bi bi-x-circle me-1"></i> Cancel
              </a>
              <button type="submit" class="btn btn-wx-primary px-4">
                <i class="bi bi-send-fill me-1"></i> Submit Verified Review
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
