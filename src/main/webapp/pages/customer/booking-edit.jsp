<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Booking ${booking.bookingCode} | Wheelyx</title>
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
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/customer/bookings">My Bookings</a></li>
          <li class="breadcrumb-item active" aria-current="page">Edit ${booking.bookingCode}</li>
        </ol>
      </nav>
    </div>
  </header>

  <main class="container py-4">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <div class="wx-card p-4 p-sm-5 shadow-sm bg-white">
          <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
              <h3 class="fw-bold mb-1">Edit Reservation Details</h3>
              <p class="text-muted small mb-0">Modify your pickup location and rental schedule before trip commencement.</p>
            </div>
            <span class="badge bg-primary text-uppercase">${booking.bookingCode}</span>
          </div>

          <c:if test="${param.error eq 'update_failed'}">
            <div class="alert alert-danger py-2 small mb-4">
              <i class="bi bi-exclamation-triangle-fill me-1"></i> Update failed: vehicle is unavailable on these modified dates.
            </div>
          </c:if>

          <!-- Vehicle Reminder -->
          <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 border mb-4">
            <img src="${pageContext.request.contextPath}/${booking.vehicleImage}" 
                 alt="${booking.vehicleModel}" 
                 style="width: 80px; height: 50px; object-fit: contain;" 
                 class="rounded bg-white p-1 border">
            <div>
              <h5 class="fw-bold mb-0">${booking.vehicleModel}</h5>
              <div class="small text-muted">${booking.cityName} • Registration: ${booking.registrationNo}</div>
            </div>
          </div>

          <form action="${pageContext.request.contextPath}/customer/booking/edit" method="POST">
            <input type="hidden" name="id" value="${booking.id}">

            <div class="row g-3">
              <div class="col-sm-6">
                <label class="form-label">Pickup Landmark Hub</label>
                <select name="pickupPlaceId" class="form-select" required>
                  <c:forEach var="p" items="${places}">
                    <option value="${p.id}" ${p.id == booking.pickupPlaceId ? 'selected' : ''}>${p.placeName}</option>
                  </c:forEach>
                </select>
              </div>

              <div class="col-sm-6">
                <label class="form-label">Return Landmark Hub</label>
                <select name="returnPlaceId" class="form-select" required>
                  <c:forEach var="p" items="${places}">
                    <option value="${p.id}" ${p.id == booking.returnPlaceId ? 'selected' : ''}>${p.placeName}</option>
                  </c:forEach>
                </select>
              </div>

              <div class="col-sm-6">
                <label class="form-label">New Pickup Date</label>
                <input type="date" name="startDate" class="form-control" min="${minDate}" value="${booking.startDate}" required>
              </div>

              <div class="col-sm-6">
                <label class="form-label">New Return Date</label>
                <input type="date" name="endDate" class="form-control" min="${minDate}" value="${booking.endDate}" required>
              </div>

              <div class="col-12">
                <label class="form-label">Special Delivery / Trip Notes</label>
                <textarea name="notes" class="form-control" rows="2">${booking.notes}</textarea>
              </div>

              <!-- Requirement 23: EDIT and CANCEL Buttons -->
              <div class="col-12 mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-wx-primary flex-grow-1 py-2">
                  <i class="bi bi-check2-circle me-1"></i> Save Changes
                </button>
                <a href="${pageContext.request.contextPath}/customer/bookings" class="btn btn-wx-cancel py-2">
                  Cancel
                </a>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
