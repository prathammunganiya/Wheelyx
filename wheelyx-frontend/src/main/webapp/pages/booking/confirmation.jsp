<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Booking Confirmed: ${booking.bookingCode} | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body class="bg-light">
  <jsp:include page="/components/navbar.jsp" />

  <main class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <!-- Success Banner -->
        <div class="text-center mb-4">
          <div class="rounded-circle bg-success text-white d-inline-flex align-items-center justify-content-center mb-3 shadow" style="width: 72px; height: 72px; font-size: 2.2rem;">
            <i class="bi bi-check-lg"></i>
          </div>
          <h2 class="fw-bold mb-1">Reservation Confirmed!</h2>
          <p class="text-muted">Your booking reference code is <strong class="text-primary">${booking.bookingCode}</strong></p>
        </div>

        <div class="wx-card p-4 p-sm-5 mb-4 shadow-sm bg-white">
          <!-- Reservation Header -->
          <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-4 flex-wrap gap-2">
            <div>
              <span class="text-muted small">Status:</span>
              <span class="badge bg-success ms-1">${booking.status}</span>
            </div>
            <div class="text-muted small">
              Reserved On: <fmt:formatDate value="${booking.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
            </div>
          </div>

          <!-- Vehicle & Hubs Summary -->
          <div class="row g-4 align-items-center mb-4">
            <div class="col-sm-4 text-center">
              <img src="${pageContext.request.contextPath}/${booking.vehicleImage}" 
                   alt="${booking.vehicleModel}" 
                   class="img-fluid rounded border p-2"
                   style="max-height: 140px; object-fit: contain;">
            </div>
            <div class="col-sm-8">
              <h4 class="fw-bold mb-1">${booking.vehicleModel}</h4>
              <div class="small text-muted mb-2">Registration: <strong>${booking.registrationNo}</strong></div>
              <div class="small mb-1"><i class="bi bi-geo-alt-fill text-danger me-1"></i> Pickup Hub: <strong>${booking.pickupPlaceName} (${booking.cityName})</strong></div>
              <div class="small mb-1"><i class="bi bi-geo-alt text-primary me-1"></i> Return Hub: <strong>${booking.returnPlaceName}</strong></div>
              <div class="small"><i class="bi bi-calendar3 me-1"></i> Dates: <strong>${booking.startDate}</strong> to <strong>${booking.endDate}</strong> (${booking.durationDays} days)</div>
            </div>
          </div>

          <!-- Price & Billing Details -->
          <div class="p-3 bg-light rounded-3 border mb-4">
            <h6 class="fw-bold text-muted small mb-3">BILLING SPECIFICATION</h6>
            <div class="d-flex justify-content-between small mb-2">
              <span>Base Rental Amount:</span>
              <span>₹<fmt:formatNumber value="${booking.baseAmount}" pattern="#,##0"/></span>
            </div>
            <div class="d-flex justify-content-between small mb-2">
              <span>Refundable Security Deposit:</span>
              <span>₹<fmt:formatNumber value="${booking.depositAmount}" pattern="#,##0"/></span>
            </div>
            <div class="d-flex justify-content-between small mb-2">
              <span>GST Tax (18%):</span>
              <span>₹<fmt:formatNumber value="${booking.taxAmount}" pattern="#,##0"/></span>
            </div>
            <c:if test="${booking.discountAmount > 0}">
              <div class="d-flex justify-content-between small mb-2 text-success">
                <span>Long-Term Discount (10%):</span>
                <span>-₹<fmt:formatNumber value="${booking.discountAmount}" pattern="#,##0"/></span>
              </div>
            </c:if>
            <hr class="my-2">
            <div class="d-flex justify-content-between fw-bold fs-5">
              <span>Total Amount:</span>
              <span class="text-primary">₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0"/></span>
            </div>
          </div>

          <!-- Actions: Edit, Cancel, Print Invoice, Dashboard -->
          <div class="d-flex flex-wrap gap-2 justify-content-between">
            <div class="d-flex gap-2">
              <c:if test="${booking.modifiable}">
                <a href="${pageContext.request.contextPath}/customer/booking/edit?id=${booking.id}" class="btn btn-wx-outline btn-sm">
                  <i class="bi bi-pencil me-1"></i> Edit Details
                </a>
                <form action="${pageContext.request.contextPath}/customer/booking/cancel" method="POST" onsubmit="return confirm('Cancel this reservation?');" class="d-inline">
                  <input type="hidden" name="id" value="${booking.id}">
                  <button type="submit" class="btn btn-wx-cancel btn-sm">
                    Cancel Booking
                  </button>
                </form>
              </c:if>
            </div>

            <div class="d-flex gap-2">
              <c:if test="${not empty bill}">
                <a href="${pageContext.request.contextPath}/billing/invoice?billNo=${bill.billNo}" class="btn btn-wx-secondary btn-sm" target="_blank">
                  <i class="bi bi-printer me-1"></i> Tax Invoice
                </a>
              </c:if>
              <a href="${pageContext.request.contextPath}/customer/dashboard" class="btn btn-wx-primary btn-sm">
                Go to Dashboard
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
