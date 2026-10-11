<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Bookings | Wheelyx</title>
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
          <jsp:param name="activeTab" value="bookings"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">My Booking History</h2>
            <p class="text-muted small mb-0">View, modify, or cancel your upcoming and past self-drive reservations.</p>
          </div>
          <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary">
            <i class="bi bi-plus-circle me-1"></i> Reserve Another Vehicle
          </a>
        </div>

        <c:if test="${param.success eq 'booking_updated'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Booking schedule and location updated successfully.
          </div>
        </c:if>
        <c:if test="${param.success eq 'cancelled'}">
          <div class="alert alert-info py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-info-circle-fill me-1"></i> Reservation cancelled successfully. The vehicle has been restored to available fleet.
          </div>
        </c:if>

        <div class="wx-card p-4">
          <c:choose>
            <c:when test="${not empty bookings}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Booking Ref</th>
                      <th>Vehicle Model</th>
                      <th>Pickup Landmark Hub</th>
                      <th>Scheduled Dates</th>
                      <th>Total Amount</th>
                      <th>Status</th>
                      <th class="text-end">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="b" items="${bookings}">
                      <tr>
                        <td class="fw-bold text-primary">${b.bookingCode}</td>
                        <td>
                          <div class="d-flex align-items-center gap-2">
                            <img src="${pageContext.request.contextPath}/${b.vehicleImage}" 
                                 alt="${b.vehicleModel}" 
                                 style="width: 44px; height: 32px; object-fit: contain;" 
                                 class="rounded bg-light border">
                            <div>
                              <div class="fw-semibold">${b.vehicleModel}</div>
                              <div class="small text-muted">${b.registrationNo}</div>
                            </div>
                          </div>
                        </td>
                        <td>${b.pickupPlaceName} <span class="text-muted small">(${b.cityName})</span></td>
                        <td class="small">
                          <div><strong>From:</strong> ${b.startDate}</div>
                          <div><strong>To:</strong> ${b.endDate} (${b.durationDays}d)</div>
                        </td>
                        <td class="fw-bold">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0"/></td>
                        <td>
                          <span class="badge ${b.status eq 'CONFIRMED' ? 'bg-success' : (b.status eq 'CANCELLED' ? 'bg-danger' : 'bg-secondary')}">
                            ${b.status}
                          </span>
                        </td>
                        <td class="text-end">
                          <div class="d-inline-flex gap-1">
                            <a href="${pageContext.request.contextPath}/booking/confirmation?code=${b.bookingCode}" class="btn btn-sm btn-light border" title="View Details">
                              <i class="bi bi-eye"></i>
                            </a>

                            <c:if test="${b.modifiable}">
                              <a href="${pageContext.request.contextPath}/customer/booking/edit?id=${b.id}" class="btn btn-sm btn-light border text-primary" title="Edit Booking">
                                <i class="bi bi-pencil"></i> Edit
                              </a>
                              <form action="${pageContext.request.contextPath}/customer/booking/cancel" method="POST" onsubmit="return confirm('Are you sure you want to cancel booking ${b.bookingCode}?');" class="d-inline">
                                <input type="hidden" name="id" value="${b.id}">
                                <button type="submit" class="btn btn-sm btn-light border text-danger" title="Cancel Booking">
                                  <i class="bi bi-x-circle"></i> Cancel
                                </button>
                              </form>
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
              <div class="empty-state-box py-5">
                <i class="bi bi-calendar-x empty-state-icon"></i>
                <h4 class="fw-bold mb-2">No Bookings Yet</h4>
                <p class="text-muted mb-4">You have not reserved any self-drive vehicles. Explore our 36 fleet models.</p>
                <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary">
                  Browse Fleet
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
