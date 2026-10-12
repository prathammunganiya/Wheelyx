<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer Dashboard | Wheelyx</title>
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
          <jsp:param name="activeTab" value="dashboard"/>
        </jsp:include>
      </div>

      <!-- Main Dashboard Stream -->
      <main class="col-lg-10 col-md-9 p-4">
        <!-- Welcome Banner -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Welcome back, ${user.name}!</h2>
            <p class="text-muted small mb-0">Here is your self-drive rental activity summary across India.</p>
          </div>
          <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary">
            <i class="bi bi-plus-circle me-1"></i> Book New Ride
          </a>
        </div>

        <!-- KPI Summary Cards -->
        <div class="row g-3 mb-4">
          <div class="col-md-4 col-sm-6">
            <div class="kpi-card">
              <div>
                <div class="kpi-label">Total Reservations</div>
                <div class="kpi-value text-primary">${totalBookings}</div>
              </div>
              <div class="kpi-icon bg-primary bg-opacity-10 text-primary">
                <i class="bi bi-calendar2-check"></i>
              </div>
            </div>
          </div>

          <div class="col-md-4 col-sm-6">
            <div class="kpi-card">
              <div>
                <div class="kpi-label">Completed Trips</div>
                <div class="kpi-value text-success">${totalRentals}</div>
              </div>
              <div class="kpi-icon bg-success bg-opacity-10 text-success">
                <i class="bi bi-check2-circle"></i>
              </div>
            </div>
          </div>

          <div class="col-md-4 col-sm-12">
            <div class="kpi-card">
              <div>
                <div class="kpi-label">Total Spend (INR)</div>
                <div class="kpi-value text-info">₹<fmt:formatNumber value="${totalSpend}" pattern="#,##0"/></div>
              </div>
              <div class="kpi-icon bg-info bg-opacity-10 text-info">
                <i class="bi bi-currency-rupee"></i>
              </div>
            </div>
          </div>
        </div>

        <!-- Active Rental Callout (With Track Vehicle Button) -->
        <c:if test="${not empty activeRental}">
          <div class="wx-card p-4 mb-4 border-primary border-2 bg-primary bg-opacity-10">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
              <div class="d-flex align-items-center gap-3">
                <img src="${pageContext.request.contextPath}/${activeRental.vehicleImage}" 
                     alt="${activeRental.vehicleModel}" 
                     style="width: 100px; height: 65px; object-fit: contain;" 
                     class="rounded bg-white p-1 border">
                <div>
                  <span class="badge bg-primary text-uppercase mb-1"><i class="bi bi-key-fill me-1"></i> Active On-Trip</span>
                  <h4 class="fw-bold mb-0">${activeRental.vehicleModel} (${activeRental.registrationNo})</h4>
                  <div class="small text-muted">Rental Code: <strong>${activeRental.rentalCode}</strong></div>
                </div>
              </div>
              <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/tracking?rentalId=${activeRental.id}" class="btn btn-wx-primary btn-lg">
                  <i class="bi bi-geo-alt-fill me-1"></i> Track Vehicle Live
                </a>
                <a href="${pageContext.request.contextPath}/billing/invoice?bookingId=${activeRental.bookingId}" class="btn btn-wx-secondary btn-lg">
                  <i class="bi bi-receipt me-1"></i> View Bill
                </a>
              </div>
            </div>
          </div>
        </c:if>

        <!-- Upcoming Booking -->
        <c:if test="${not empty upcomingBooking}">
          <div class="wx-card p-4 mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
              <h5 class="fw-bold mb-0"><i class="bi bi-clock-history text-warning me-2"></i> Upcoming Reservation</h5>
              <span class="badge bg-warning text-dark">${upcomingBooking.status}</span>
            </div>
            <div class="row align-items-center g-3">
              <div class="col-md-6">
                <div class="fw-bold fs-5">${upcomingBooking.vehicleModel}</div>
                <div class="small text-muted"><i class="bi bi-geo-alt text-danger me-1"></i> ${upcomingBooking.cityName} (${upcomingBooking.pickupPlaceName})</div>
                <div class="small text-muted"><i class="bi bi-calendar3 me-1"></i> From ${upcomingBooking.startDate} to ${upcomingBooking.endDate} (${upcomingBooking.durationDays} days)</div>
              </div>
              <div class="col-md-6 text-md-end d-flex gap-2 justify-content-md-end">
                <a href="${pageContext.request.contextPath}/customer/booking/edit?id=${upcomingBooking.id}" class="btn btn-wx-outline btn-sm">
                  <i class="bi bi-pencil me-1"></i> Edit Details
                </a>
                <form action="${pageContext.request.contextPath}/customer/booking/cancel" method="POST" onsubmit="return confirm('Cancel this reservation?');">
                  <input type="hidden" name="id" value="${upcomingBooking.id}">
                  <button type="submit" class="btn btn-wx-cancel btn-sm">
                    Cancel Booking
                  </button>
                </form>
                <a href="${pageContext.request.contextPath}/booking/confirmation?code=${upcomingBooking.bookingCode}" class="btn btn-wx-primary btn-sm">
                  View Receipt
                </a>
              </div>
            </div>
          </div>
        </c:if>

        <!-- Recent Bookings Table -->
        <div class="wx-card p-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold mb-0">Recent Reservations</h5>
            <a href="${pageContext.request.contextPath}/customer/bookings" class="small text-primary">View Full History</a>
          </div>

          <c:choose>
            <c:when test="${not empty bookings}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Booking Code</th>
                      <th>Vehicle</th>
                      <th>Pickup Landmark</th>
                      <th>Dates</th>
                      <th>Total (INR)</th>
                      <th>Status</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="b" items="${bookings}">
                      <tr>
                        <td class="fw-bold text-primary">${b.bookingCode}</td>
                        <td>${b.vehicleModel}</td>
                        <td>${b.pickupPlaceName}</td>
                        <td class="small">${b.startDate} to ${b.endDate}</td>
                        <td class="fw-bold">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0"/></td>
                        <td>
                          <span class="badge ${b.status eq 'CONFIRMED' ? 'bg-success' : (b.status eq 'CANCELLED' ? 'bg-danger' : 'bg-secondary')}">
                            ${b.status}
                          </span>
                        </td>
                        <td>
                          <div class="d-flex gap-1">
                            <a href="${pageContext.request.contextPath}/booking/confirmation?code=${b.bookingCode}" class="btn btn-sm btn-light border py-0 px-2" title="View Receipt">
                              <i class="bi bi-eye"></i>
                            </a>
                            <c:if test="${b.modifiable}">
                              <a href="${pageContext.request.contextPath}/customer/booking/edit?id=${b.id}" class="btn btn-sm btn-light border py-0 px-2 text-primary" title="Edit Booking">
                                <i class="bi bi-pencil"></i>
                              </a>
                            </c:if>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>
            <c:otherwise>
              <div class="empty-state-box py-4">
                <p class="text-muted mb-3">No reservation history recorded yet.</p>
                <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary btn-sm">Find a Ride</a>
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
