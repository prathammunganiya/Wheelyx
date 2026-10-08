<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reserve ${vehicle.modelName} | Wheelyx Checkout</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body class="bg-light">
  <jsp:include page="/components/navbar.jsp" />

  <header class="py-3 bg-white border-bottom">
    <div class="container">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb small mb-0">
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/vehicles">Vehicles</a></li>
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/vehicles/detail?id=${vehicle.id}">${vehicle.modelName}</a></li>
          <li class="breadcrumb-item active" aria-current="page">Booking Checkout</li>
        </ol>
      </nav>
    </div>
  </header>

  <main class="container py-4">
    <div class="row justify-content-center">
      <div class="col-lg-10">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <div>
            <h2 class="h3 fw-bold mb-1">Confirm Reservation</h2>
            <p class="text-muted small mb-0">Review trip dates, pickup hub locations, and pricing calculation.</p>
          </div>
          <span class="badge bg-success-subtle text-success fs-6"><i class="bi bi-shield-check me-1"></i> Overlap Protected</span>
        </div>

        <c:if test="${param.error eq 'overlap_or_invalid_dates'}">
          <div class="alert alert-danger py-2 small mb-4">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> The selected vehicle is already booked for these dates or invalid date range entered.
          </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/booking" method="POST" id="bookingForm">
          <input type="hidden" name="vehicleId" value="${vehicle.id}">
          <input type="hidden" name="cityId" value="${vehicle.cityId}">

          <div class="row g-4">
            <!-- Left Side: Trip Details & Location -->
            <div class="col-lg-7">
              <div class="wx-card p-4 mb-4">
                <h5 class="fw-bold mb-3"><i class="bi bi-geo-alt text-primary me-2"></i> Pickup & Return Hub</h5>

                <div class="mb-3">
                  <label class="form-label">Rental City</label>
                  <input type="text" class="form-control bg-light" value="${vehicle.cityName}" readonly>
                </div>

                <div class="row g-3">
                  <div class="col-sm-6">
                    <label class="form-label">Pickup Landmark Hub</label>
                    <select name="pickupPlaceId" class="form-select" required>
                      <c:forEach var="p" items="${places}">
                        <option value="${p.id}" ${p.id == vehicle.placeId ? 'selected' : ''}>${p.placeName} (${p.landmarkDetails})</option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="col-sm-6">
                    <label class="form-label">Return Landmark Hub</label>
                    <select name="returnPlaceId" class="form-select" required>
                      <c:forEach var="p" items="${places}">
                        <option value="${p.id}" ${p.id == vehicle.placeId ? 'selected' : ''}>${p.placeName} (${p.landmarkDetails})</option>
                      </c:forEach>
                    </select>
                  </div>
                </div>
              </div>

              <!-- Dates & Duration -->
              <div class="wx-card p-4 mb-4">
                <h5 class="fw-bold mb-3"><i class="bi bi-calendar3 text-primary me-2"></i> Rental Schedule</h5>
                <div class="row g-3">
                  <div class="col-sm-6">
                    <label class="form-label">Pickup Date</label>
                    <input type="date" name="startDate" id="startDateInput" class="form-control" min="${minDate}" value="${minDate}" required onchange="calculateFare()">
                  </div>

                  <div class="col-sm-6">
                    <label class="form-label">Return Date</label>
                    <input type="date" name="endDate" id="endDateInput" class="form-control" min="${minDate}" required onchange="calculateFare()">
                  </div>

                  <div class="col-12">
                    <label class="form-label">Special Delivery / Trip Notes (Optional)</label>
                    <textarea name="notes" class="form-control" rows="2" placeholder="e.g. Flight arrival time, luggage count..."></textarea>
                  </div>
                </div>
              </div>
            </div>

            <!-- Right Side: Vehicle Summary & Fare Engine -->
            <div class="col-lg-5">
              <div class="wx-card p-4 mb-4 sticky-top" style="top: 85px;">
                <!-- Vehicle Thumbnail -->
                <div class="d-flex align-items-center gap-3 pb-3 border-bottom mb-3">
                  <img src="${pageContext.request.contextPath}/${vehicle.imageUrl}" 
                       alt="${vehicle.modelName}" 
                       style="width: 90px; height: 60px; object-fit: contain;" 
                       class="rounded bg-white p-1 border">
                  <div>
                    <h5 class="fw-bold mb-0">${vehicle.modelName}</h5>
                    <span class="badge bg-light text-dark border small">${vehicle.categoryName} • ${vehicle.fuelType}</span>
                  </div>
                </div>

                <!-- Fare Calculation Matrix -->
                <h6 class="fw-bold text-muted small mb-3">PRICE BREAKDOWN</h6>
                <div class="d-flex justify-content-between small mb-2">
                  <span>Daily Rate:</span>
                  <span class="fw-bold">₹<fmt:formatNumber value="${vehicle.pricePerDay}" pattern="#,##0"/> / day</span>
                </div>
                <div class="d-flex justify-content-between small mb-2">
                  <span>Rental Duration:</span>
                  <span class="fw-bold" id="fareDurationDisplay">1 Day(s)</span>
                </div>
                <div class="d-flex justify-content-between small mb-2">
                  <span>Base Rental Fee:</span>
                  <span class="fw-bold" id="fareBaseDisplay">₹<fmt:formatNumber value="${vehicle.pricePerDay}" pattern="#,##0"/></span>
                </div>
                <div class="d-flex justify-content-between small mb-2">
                  <span>Refundable Deposit:</span>
                  <span class="fw-bold">₹<fmt:formatNumber value="${vehicle.securityDeposit}" pattern="#,##0"/></span>
                </div>
                <div class="d-flex justify-content-between small mb-2">
                  <span>GST Tax (18%):</span>
                  <span class="fw-bold" id="fareGstDisplay">₹<fmt:formatNumber value="${vehicle.pricePerDay * 0.18}" pattern="#,##0"/></span>
                </div>
                <div class="d-flex justify-content-between small mb-2 text-success" id="discountRow" style="display: none;">
                  <span>Long-Term Discount (10%):</span>
                  <span class="fw-bold" id="fareDiscountDisplay">-₹0</span>
                </div>

                <hr class="my-3">

                <div class="d-flex justify-content-between align-items-baseline mb-4">
                  <span class="h6 fw-bold mb-0">Total Due (INR):</span>
                  <span class="h4 fw-bold text-primary mb-0" id="fareTotalDisplay">
                    ₹<fmt:formatNumber value="${vehicle.pricePerDay + vehicle.securityDeposit + (vehicle.pricePerDay * 0.18)}" pattern="#,##0"/>
                  </span>
                </div>

                <!-- Requirement 23: EDIT and CANCEL / Confirmation Actions -->
                <div class="d-grid gap-2">
                  <button type="submit" class="btn btn-wx-primary btn-lg">
                    <i class="bi bi-check-circle me-1"></i> Confirm & Reserve
                  </button>
                  <a href="${pageContext.request.contextPath}/vehicles/detail?id=${vehicle.id}" class="btn btn-wx-cancel">
                    Cancel & Return
                  </a>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </main>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>

  <script>
    const dailyPrice = ${vehicle.pricePerDay};
    const deposit = ${vehicle.securityDeposit};

    function calculateFare() {
      const startVal = document.getElementById('startDateInput').value;
      const endVal = document.getElementById('endDateInput').value;
      if (!startVal || !endVal) return;

      const d1 = new Date(startVal);
      const d2 = new Date(endVal);
      const diffTime = d2.getTime() - d1.getTime();
      let days = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      if (days < 1) days = 1;

      const base = dailyPrice * days;
      const gst = Math.round(base * 0.18);
      let discount = 0;
      if (days >= 7) {
        discount = Math.round(base * 0.10);
        document.getElementById('discountRow').style.display = 'flex';
        document.getElementById('fareDiscountDisplay').innerText = '-₹' + discount.toLocaleString();
      } else {
        document.getElementById('discountRow').style.display = 'none';
      }

      const total = base + deposit + gst - discount;

      document.getElementById('fareDurationDisplay').innerText = days + ' Day(s)';
      document.getElementById('fareBaseDisplay').innerText = '₹' + base.toLocaleString();
      document.getElementById('fareGstDisplay').innerText = '₹' + gst.toLocaleString();
      document.getElementById('fareTotalDisplay').innerText = '₹' + total.toLocaleString();
    }

    // Set default return date to tomorrow
    window.addEventListener('DOMContentLoaded', () => {
      const today = new Date();
      const tomorrow = new Date(today);
      tomorrow.setDate(tomorrow.getDate() + 1);
      document.getElementById('endDateInput').value = tomorrow.toISOString().split('T')[0];
      calculateFare();
    });
  </script>
</body>
</html>
