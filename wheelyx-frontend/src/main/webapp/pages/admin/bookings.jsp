<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Bookings | Wheelyx Admin</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container-fluid">
    <div class="row">
      <!-- Admin Sidebar -->
      <div class="col-lg-2 col-md-3 p-0 d-none d-md-block">
        <jsp:include page="/components/sidebar-admin.jsp">
          <jsp:param name="activeTab" value="bookings"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Global Customer Reservations</h2>
            <p class="text-muted small mb-0">Monitor all customer self-drive bookings, payment amounts, and operational schedules.</p>
          </div>
          <span class="badge bg-primary fs-6 px-3 py-2">
            ${bookings.size()} Reservations Loaded
          </span>
        </div>

        <!-- Filter Bar -->
        <div class="wx-card p-3 mb-4">
          <form action="${pageContext.request.contextPath}/admin/bookings" method="GET" class="row g-2 align-items-center">
            <div class="col-md-4">
              <label class="form-label small fw-semibold mb-1">Filter by Reservation Status</label>
              <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                <option value="">All Statuses (Confirmed, Cancelled, Completed)</option>
                <option value="CONFIRMED" ${selectedStatus eq 'CONFIRMED' ? 'selected' : ''}>CONFIRMED</option>
                <option value="CANCELLED" ${selectedStatus eq 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                <option value="COMPLETED" ${selectedStatus eq 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
              </select>
            </div>
            <div class="col-md-2">
              <label class="form-label d-block small mb-1">&nbsp;</label>
              <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-sm btn-outline-secondary w-100">
                Reset
              </a>
            </div>
          </form>
        </div>

        <div class="wx-card p-4">
          <div class="table-responsive">
            <table class="wx-table">
              <thead>
                <tr>
                  <th>Booking Ref</th>
                  <th>Vehicle</th>
                  <th>Customer Information</th>
                  <th>Pickup Hub & City</th>
                  <th>Schedule</th>
                  <th>Total Tariff</th>
                  <th>Status</th>
                  <th class="text-end">Invoice</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="b" items="${bookings}">
                  <tr>
                    <td>
                      <span class="fw-bold font-monospace text-primary">${b.bookingCode}</span>
                      <div class="small text-muted"><fmt:formatDate value="${b.createdAt}" pattern="dd MMM, HH:mm"/></div>
                    </td>
                    <td>
                      <div class="d-flex align-items-center gap-2">
                        <img src="${pageContext.request.contextPath}/${b.vehicleImage}" 
                             alt="${b.vehicleModel}" 
                             style="width: 44px; height: 30px; object-fit: contain;" 
                             class="rounded bg-light border p-1">
                        <div>
                          <div class="fw-semibold">${b.vehicleModel}</div>
                          <div class="small font-monospace text-muted">${b.registrationNo}</div>
                        </div>
                      </div>
                    </td>
                    <td class="small">
                      <div class="fw-bold">${b.customerName}</div>
                      <div class="text-muted">${b.customerEmail}</div>
                      <div class="text-muted"><i class="bi bi-telephone me-1"></i>${b.customerPhone}</div>
                    </td>
                    <td class="small">
                      <div class="fw-semibold">${b.pickupPlaceName}</div>
                      <div class="text-muted"><i class="bi bi-geo-alt me-1"></i>${b.cityName}</div>
                    </td>
                    <td class="small">
                      <div>${b.startDate} &rarr; ${b.endDate}</div>
                      <div class="text-muted fw-semibold">(${b.durationDays} Days)</div>
                    </td>
                    <td class="small">
                      <div class="fw-bold text-success">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0"/></div>
                    </td>
                    <td>
                      <span class="badge ${b.status eq 'CONFIRMED' ? 'bg-success' : (b.status eq 'CANCELLED' ? 'bg-danger' : 'bg-secondary')}">
                        ${b.status}
                      </span>
                    </td>
                    <td class="text-end">
                      <a href="${pageContext.request.contextPath}/billing/invoice?bookingId=${b.id}" class="btn btn-sm btn-light border" title="Tax Invoice">
                        <i class="bi bi-receipt text-primary"></i>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
