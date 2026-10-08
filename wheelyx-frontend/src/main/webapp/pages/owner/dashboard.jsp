<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Owner Fleet Dashboard | Wheelyx</title>
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
        <jsp:include page="/components/sidebar-owner.jsp">
          <jsp:param name="activeTab" value="dashboard"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Fleet Owner Control Center</h2>
            <p class="text-muted small mb-0">Manage listed vehicles, dispatch customer handovers, monitor active trips, and track earnings.</p>
          </div>
          <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/owner/vehicles/add" class="btn btn-wx-primary">
              <i class="bi bi-plus-circle me-1"></i> List New Vehicle
            </a>
          </div>
        </div>

        <!-- Metrics Cards -->
        <div class="row g-3 mb-4">
          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-primary-subtle text-primary p-3 fs-3">
                <i class="bi bi-car-front-fill"></i>
              </div>
              <div>
                <div class="text-muted small">Total Fleet Listed</div>
                <div class="fs-4 fw-bold">${kpis.totalVehicles != null ? kpis.totalVehicles : 0}</div>
                <div class="small text-success">${kpis.availableVehicles != null ? kpis.availableVehicles : 0} Available</div>
              </div>
            </div>
          </div>

          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-warning-subtle text-warning p-3 fs-3">
                <i class="bi bi-key-fill"></i>
              </div>
              <div>
                <div class="text-muted small">Active on Trips</div>
                <div class="fs-4 fw-bold">${kpis.rentedVehicles != null ? kpis.rentedVehicles : 0}</div>
                <div class="small text-muted">Currently Rented</div>
              </div>
            </div>
          </div>

          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-info-subtle text-info p-3 fs-3">
                <i class="bi bi-calendar-check-fill"></i>
              </div>
              <div>
                <div class="text-muted small">Upcoming Bookings</div>
                <div class="fs-4 fw-bold">${kpis.pendingRequests != null ? kpis.pendingRequests : 0}</div>
                <div class="small text-muted">Awaiting Handover</div>
              </div>
            </div>
          </div>

          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-success-subtle text-success p-3 fs-3">
                <i class="bi bi-currency-rupee"></i>
              </div>
              <div>
                <div class="text-muted small">Gross Revenue</div>
                <div class="fs-4 fw-bold text-success">₹<fmt:formatNumber value="${kpis.totalEarnings != null ? kpis.totalEarnings : 0}" pattern="#,##0"/></div>
                <div class="small text-muted">${kpis.completedRentals != null ? kpis.completedRentals : 0} trips settled</div>
              </div>
            </div>
          </div>
        </div>

        <div class="row g-4 mb-4">
          <!-- Active Handover / Trips Panel -->
          <div class="col-lg-6">
            <div class="wx-card p-4 h-100">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-broadcast text-danger me-2"></i>Active Customer Trips</h5>
                <a href="${pageContext.request.contextPath}/owner/rentals" class="small text-primary text-decoration-none">View All Rentals</a>
              </div>

              <c:choose>
                <c:when test="${not empty activeRentals}">
                  <div class="list-group list-group-flush">
                    <c:forEach var="r" items="${activeRentals}">
                      <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <div class="d-flex align-items-center gap-3">
                          <c:if test="${not empty r.vehicleImage}">
                            <img src="${pageContext.request.contextPath}/${r.vehicleImage}" alt="${r.vehicleModel}" 
                                 style="width: 50px; height: 35px; object-fit: contain;" class="rounded bg-light border p-1">
                          </c:if>
                          <div>
                            <div class="fw-bold">${r.vehicleModel}</div>
                            <div class="small text-muted">Trip Code: <span class="font-monospace text-primary">${r.rentalCode}</span></div>
                          </div>
                        </div>
                        <div class="d-flex gap-2">
                          <a href="${pageContext.request.contextPath}/tracking?rentalId=${r.id}" class="btn btn-sm btn-outline-primary" title="Track Live">
                            <i class="bi bi-geo-alt-fill"></i> Track
                          </a>
                          <a href="${pageContext.request.contextPath}/owner/rentals" class="btn btn-sm btn-wx-primary" title="Inspect & Return">
                            Return Check-in
                          </a>
                        </div>
                      </div>
                    </c:forEach>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="empty-state-box py-4">
                    <i class="bi bi-car-front text-muted fs-1 mb-2"></i>
                    <p class="text-muted small mb-0">No vehicles are currently out on active rentals.</p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <!-- Pending Handover Reservations -->
          <div class="col-lg-6">
            <div class="wx-card p-4 h-100">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-calendar-event text-primary me-2"></i>Upcoming Bookings</h5>
                <a href="${pageContext.request.contextPath}/owner/bookings" class="small text-primary text-decoration-none">Manage Bookings</a>
              </div>

              <c:choose>
                <c:when test="${not empty recentBookings}">
                  <div class="list-group list-group-flush">
                    <c:forEach var="b" items="${recentBookings}">
                      <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <div>
                          <div class="fw-bold">${b.vehicleModel}</div>
                          <div class="small text-muted">Ref: <strong>${b.bookingCode}</strong> &bull; Pickup: ${b.startDate} (${b.durationDays}d)</div>
                          <div class="small text-muted"><i class="bi bi-geo-alt me-1"></i>${b.pickupPlaceName}, ${b.cityName}</div>
                        </div>
                        <div class="text-end">
                          <span class="badge ${b.status eq 'CONFIRMED' ? 'bg-success' : 'bg-secondary'} mb-1">${b.status}</span>
                          <div>
                            <a href="${pageContext.request.contextPath}/owner/bookings" class="btn btn-sm btn-outline-secondary">
                              Handover Keys
                            </a>
                          </div>
                        </div>
                      </div>
                    </c:forEach>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="empty-state-box py-4">
                    <i class="bi bi-calendar-check text-muted fs-1 mb-2"></i>
                    <p class="text-muted small mb-0">No pending reservations waiting for handover.</p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <!-- Fleet Overview Table -->
        <div class="wx-card p-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold mb-0"><i class="bi bi-grid text-primary me-2"></i>Listed Fleet Highlights</h5>
            <a href="${pageContext.request.contextPath}/owner/vehicles" class="btn btn-sm btn-outline-primary">Manage Fleet</a>
          </div>

          <c:choose>
            <c:when test="${not empty vehicles}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Vehicle</th>
                      <th>Category</th>
                      <th>Hub Location</th>
                      <th>Daily Tariff</th>
                      <th>Status</th>
                      <th class="text-end">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="v" items="${vehicles}">
                      <tr>
                        <td>
                          <div class="d-flex align-items-center gap-2">
                            <img src="${pageContext.request.contextPath}/${v.imageUrl}" 
                                 alt="${v.modelName}" 
                                 style="width: 48px; height: 34px; object-fit: contain;" 
                                 class="rounded bg-light border p-1">
                            <div>
                              <div class="fw-bold">${v.brand} ${v.modelName}</div>
                              <div class="small text-muted font-monospace">${v.registrationNo}</div>
                            </div>
                          </div>
                        </td>
                        <td>${v.categoryName}</td>
                        <td>${v.placeName} <span class="text-muted small">(${v.cityName})</span></td>
                        <td class="fw-bold">₹<fmt:formatNumber value="${v.pricePerDay}" pattern="#,##0"/>/day</td>
                        <td>
                          <span class="badge ${v.status eq 'AVAILABLE' ? 'bg-success' : (v.status eq 'ACTIVE_RENTAL' ? 'bg-primary' : (v.status eq 'MAINTENANCE' ? 'bg-warning text-dark' : 'bg-secondary'))}">
                            ${v.status}
                          </span>
                        </td>
                        <td class="text-end">
                          <a href="${pageContext.request.contextPath}/owner/vehicles/edit?id=${v.id}" class="btn btn-sm btn-light border text-primary" title="Edit Listing">
                            <i class="bi bi-pencil"></i> Edit
                          </a>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>
            <c:otherwise>
              <div class="empty-state-box py-4">
                <i class="bi bi-plus-circle text-muted fs-1 mb-2"></i>
                <h5 class="fw-bold mb-1">No Vehicles Listed</h5>
                <p class="text-muted small mb-3">Add your first vehicle to start earning self-drive rental revenue.</p>
                <a href="${pageContext.request.contextPath}/owner/vehicles/add" class="btn btn-wx-primary">
                  List Your First Vehicle
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
