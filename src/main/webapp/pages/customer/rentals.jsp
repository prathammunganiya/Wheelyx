<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Rental Lifecycles & Trips | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <div class="col-lg-2 col-md-3 p-0 d-none d-md-block">
        <jsp:include page="/components/sidebar-customer.jsp">
          <jsp:param name="activeTab" value="rentals"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Rental Trips & Vehicle Tracking</h2>
            <p class="text-muted small mb-0">Monitor active journeys, live GPS tracking, and leave verified reviews upon return.</p>
          </div>
          <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary">
            <i class="bi bi-car-front me-1"></i> Browse Fleet
          </a>
        </div>

        <c:if test="${param.success eq 'review_submitted'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Thank you! Your verified customer feedback has been published.
          </div>
        </c:if>

        <div class="wx-card p-4">
          <c:choose>
            <c:when test="${not empty rentals}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Rental Ref</th>
                      <th>Vehicle</th>
                      <th>Handover Time</th>
                      <th>Odometer Inspection</th>
                      <th>Status</th>
                      <th class="text-end">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="r" items="${rentals}">
                      <tr>
                        <td class="fw-bold text-primary">${r.rentalCode}</td>
                        <td>
                          <div class="d-flex align-items-center gap-2">
                            <img src="${pageContext.request.contextPath}/${r.vehicleImage}" 
                                 alt="${r.vehicleModel}" 
                                 style="width: 44px; height: 32px; object-fit: contain;" 
                                 class="rounded bg-light border">
                            <div>
                              <div class="fw-semibold">${r.vehicleModel}</div>
                              <div class="small text-muted">${r.registrationNo}</div>
                            </div>
                          </div>
                        </td>
                        <td class="small">
                          <fmt:formatDate value="${r.handoverTime}" pattern="dd MMM yyyy, HH:mm"/>
                        </td>
                        <td class="small">
                          <div>Start: <strong>${r.startOdometer} km</strong> (${r.fuelLevelStart})</div>
                          <c:if test="${r.returned}">
                            <div>Return: <strong>${r.endOdometer} km</strong> (${r.fuelLevelEnd})</div>
                          </c:if>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${r.active}">
                              <span class="badge bg-primary"><i class="bi bi-key-fill me-1"></i> Active Trip</span>
                            </c:when>
                            <c:when test="${r.returned}">
                              <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i> Returned</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-secondary">${r.status}</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td class="text-end">
                          <div class="d-inline-flex gap-1">
                            <!-- Track Vehicle Button (Active Trips) -->
                            <c:if test="${r.active}">
                              <a href="${pageContext.request.contextPath}/tracking?rentalId=${r.id}" class="btn btn-sm btn-wx-primary" title="Track Vehicle Live">
                                <i class="bi bi-geo-alt-fill me-1"></i> Track
                              </a>
                            </c:if>

                            <!-- Review Button (Completed/Returned Trips) -->
                            <c:if test="${r.returned and not r.hasReview}">
                              <a href="${pageContext.request.contextPath}/customer/review?rentalId=${r.id}" class="btn btn-sm btn-outline-warning text-dark" title="Rate & Review Experience">
                                <i class="bi bi-star-fill text-warning me-1"></i> Rate Ride
                              </a>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/billing/invoice?bookingId=${r.bookingId}" class="btn btn-sm btn-light border" title="Tax Invoice">
                              <i class="bi bi-receipt"></i>
                            </a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>

            <c:otherwise>
              <div class="empty-state-box py-5">
                <i class="bi bi-key empty-state-icon"></i>
                <h4 class="fw-bold mb-2">No Active or Completed Trips</h4>
                <p class="text-muted mb-4">When your vehicle keys are handed over, active trips and telemetry tracking will appear here.</p>
                <a href="${pageContext.request.contextPath}/customer/bookings" class="btn btn-wx-primary">
                  View Bookings
                </a>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </main>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
