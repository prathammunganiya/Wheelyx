<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Rentals | Wheelyx Admin</title>
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
          <jsp:param name="activeTab" value="rentals"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Rental Lifecycles & Handover Records</h2>
            <p class="text-muted small mb-0">Track all vehicles handed over to customers, active trips, odometer inspections, and return settlements.</p>
          </div>
          <span class="badge bg-primary fs-6 px-3 py-2">
            ${rentals.size()} Rentals Loaded
          </span>
        </div>

        <!-- Filter Bar -->
        <div class="wx-card p-3 mb-4">
          <form action="${pageContext.request.contextPath}/admin/rentals" method="GET" class="row g-2 align-items-center">
            <div class="col-md-4">
              <label class="form-label small fw-semibold mb-1">Filter by Rental Status</label>
              <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                <option value="">All Statuses (Active Trips & Returned)</option>
                <option value="ACTIVE_RENTAL" ${selectedStatus eq 'ACTIVE_RENTAL' ? 'selected' : ''}>Active Trips Only</option>
                <option value="RETURNED" ${selectedStatus eq 'RETURNED' ? 'selected' : ''}>Returned & Settled</option>
              </select>
            </div>
            <div class="col-md-2">
              <label class="form-label d-block small mb-1">&nbsp;</label>
              <a href="${pageContext.request.contextPath}/admin/rentals" class="btn btn-sm btn-outline-secondary w-100">
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
                  <th>Rental Ref</th>
                  <th>Vehicle</th>
                  <th>Handover & Return Times</th>
                  <th>Odometer Reading & Fuel</th>
                  <th>Status</th>
                  <th class="text-end">Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="r" items="${rentals}">
                  <tr>
                    <td>
                      <span class="fw-bold font-monospace text-primary">${r.rentalCode}</span>
                    </td>
                    <td>
                      <div class="d-flex align-items-center gap-2">
                        <img src="${pageContext.request.contextPath}/${r.vehicleImage}" 
                             alt="${r.vehicleModel}" 
                             style="width: 44px; height: 30px; object-fit: contain;" 
                             class="rounded bg-light border p-1">
                        <div>
                          <div class="fw-semibold">${r.vehicleModel}</div>
                          <div class="small font-monospace text-muted">${r.registrationNo}</div>
                        </div>
                      </div>
                    </td>
                    <td class="small">
                      <div><strong>Handover:</strong> <fmt:formatDate value="${r.handoverTime}" pattern="dd MMM yyyy, HH:mm"/></div>
                      <c:if test="${not empty r.returnTime}">
                        <div class="text-muted"><strong>Return:</strong> <fmt:formatDate value="${r.returnTime}" pattern="dd MMM yyyy, HH:mm"/></div>
                      </c:if>
                    </td>
                    <td class="small">
                      <div>Start: <strong>${r.startOdometer} km</strong> (${r.fuelLevelStart})</div>
                      <c:if test="${r.returned}">
                        <div>End: <strong>${r.endOdometer} km</strong> (${r.fuelLevelEnd})</div>
                      </c:if>
                    </td>
                    <td>
                      <span class="badge ${r.active ? 'bg-primary' : (r.returned ? 'bg-success' : 'bg-secondary')}">
                        ${r.status}
                      </span>
                    </td>
                    <td class="text-end">
                      <div class="d-inline-flex gap-1">
                        <c:if test="${r.active}">
                          <a href="${pageContext.request.contextPath}/tracking?rentalId=${r.id}" class="btn btn-sm btn-outline-primary" title="Live Telemetry">
                            <i class="bi bi-geo-alt-fill"></i> Track
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
        </div>
      </main>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
