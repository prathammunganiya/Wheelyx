<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Command Center | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container-fluid">
    <div class="row">
      <!-- Admin Sidebar -->
      <div class="col-lg-2 col-md-3 p-0 d-none d-md-block">
        <jsp:include page="/components/sidebar-admin.jsp">
          <jsp:param name="activeTab" value="dashboard"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <!-- Top Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Wheelyx Platform Command Center</h2>
            <p class="text-muted small mb-0">Unified administration of customers, vehicle fleet, bookings, real-world hubs, and financial revenue.</p>
          </div>
          <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/reports" class="btn btn-outline-primary">
              <i class="bi bi-download me-1"></i> Export Reports
            </a>
            <a href="${pageContext.request.contextPath}/admin/maintenance" class="btn btn-wx-primary">
              <i class="bi bi-tools me-1"></i> Fleet Maintenance
            </a>
          </div>
        </div>

        <!-- 8 Core Metrics KPI Grid -->
        <div class="row g-3 mb-4">
          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-primary-subtle text-primary p-3 fs-3">
                <i class="bi bi-people-fill"></i>
              </div>
              <div>
                <div class="text-muted small">Registered Users</div>
                <div class="fs-4 fw-bold">${kpis.totalCustomers + kpis.totalOwners}</div>
                <div class="small text-muted">${kpis.totalCustomers} Customers &bull; ${kpis.totalOwners} Owners</div>
              </div>
            </div>
          </div>

          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-success-subtle text-success p-3 fs-3">
                <i class="bi bi-car-front-fill"></i>
              </div>
              <div>
                <div class="text-muted small">Commercial Fleet</div>
                <div class="fs-4 fw-bold">${kpis.totalVehicles}</div>
                <div class="small text-success">${kpis.availableVehicles} Available Now</div>
              </div>
            </div>
          </div>

          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-warning-subtle text-warning p-3 fs-3">
                <i class="bi bi-broadcast"></i>
              </div>
              <div>
                <div class="text-muted small">Active Rentals</div>
                <div class="fs-4 fw-bold">${kpis.activeRentals}</div>
                <div class="small text-muted">${kpis.bookedVehicles} Booked / Handover</div>
              </div>
            </div>
          </div>

          <div class="col-xl-3 col-sm-6">
            <div class="wx-card p-3 d-flex align-items-center gap-3">
              <div class="rounded-3 bg-info-subtle text-info p-3 fs-3">
                <i class="bi bi-currency-rupee"></i>
              </div>
              <div>
                <div class="text-muted small">Gross Revenue</div>
                <div class="fs-4 fw-bold text-success">₹<fmt:formatNumber value="${kpis.totalRevenue != null ? kpis.totalRevenue : 0}" pattern="#,##0"/></div>
                <div class="small text-muted">${kpis.totalBookings} Total Reservations</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Charts Row -->
        <div class="row g-4 mb-4">
          <div class="col-lg-6">
            <div class="wx-card p-4 h-100">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-pie-chart text-primary me-2"></i>Bookings by Vehicle Category</h5>
                <span class="badge bg-light text-dark border">All Time</span>
              </div>
              <div style="height: 280px; position: relative;">
                <canvas id="categoryChart"></canvas>
              </div>
            </div>
          </div>

          <div class="col-lg-6">
            <div class="wx-card p-4 h-100">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-geo-alt text-primary me-2"></i>Fleet Density Across Top Cities</h5>
                <span class="badge bg-light text-dark border">Top 8 Indian Metros</span>
              </div>
              <div style="height: 280px; position: relative;">
                <canvas id="cityChart"></canvas>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Reservations and Security Audit Feed -->
        <div class="row g-4">
          <!-- Recent Bookings -->
          <div class="col-lg-7">
            <div class="wx-card p-4 h-100">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-clock-history text-primary me-2"></i>Latest Reservations</h5>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="small text-primary text-decoration-none">View All</a>
              </div>

              <div class="table-responsive">
                <table class="wx-table table-sm">
                  <thead>
                    <tr>
                      <th>Ref Code</th>
                      <th>Vehicle</th>
                      <th>Customer</th>
                      <th>Dates</th>
                      <th>Tariff</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="b" items="${recentBookings}">
                      <tr>
                        <td class="font-monospace fw-bold text-primary">${b.bookingCode}</td>
                        <td class="fw-semibold">${b.vehicleModel}</td>
                        <td class="small">${b.customerName}</td>
                        <td class="small text-muted">${b.startDate} (${b.durationDays}d)</td>
                        <td class="fw-bold">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0"/></td>
                        <td>
                          <span class="badge ${b.status eq 'CONFIRMED' ? 'bg-success' : (b.status eq 'CANCELLED' ? 'bg-danger' : 'bg-secondary')}">
                            ${b.status}
                          </span>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <!-- Security Audit Log Snippet -->
          <div class="col-lg-5">
            <div class="wx-card p-4 h-100">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-shield-check text-success me-2"></i>Security Audit Activity</h5>
                <a href="${pageContext.request.contextPath}/admin/audit" class="small text-primary text-decoration-none">Full Log</a>
              </div>

              <div class="list-group list-group-flush small">
                <c:forEach var="log" items="${recentLogs}">
                  <div class="list-group-item px-0 py-2 border-bottom">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                      <span class="badge bg-secondary-subtle text-dark">${log.action}</span>
                      <span class="text-muted"><fmt:formatDate value="${log.createdAt}" pattern="HH:mm:ss"/></span>
                    </div>
                    <div class="text-truncate">${log.description}</div>
                    <div class="text-muted" style="font-size: 0.75rem;">Actor: ${log.role} &bull; IP: ${log.ipAddress}</div>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>

  <!-- Interactive Charts -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const categoryData = ${categoryDistJson};
      const cityData = ${cityDistJson};

      // 1. Category Chart
      const catCtx = document.getElementById('categoryChart');
      if (catCtx) {
        new Chart(catCtx, {
          type: 'doughnut',
          data: {
            labels: Object.keys(categoryData),
            datasets: [{
              data: Object.values(categoryData),
              backgroundColor: ['#155EEF', '#00B8D9', '#7C3AED', '#10B981', '#F59E0B', '#0B1F3A'],
              borderWidth: 2
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: { position: 'bottom', labels: { boxWidth: 12, font: { size: 11 } } }
            }
          }
        });
      }

      // 2. City Distribution Chart
      const cityCtx = document.getElementById('cityChart');
      if (cityCtx) {
        new Chart(cityCtx, {
          type: 'bar',
          data: {
            labels: Object.keys(cityData),
            datasets: [{
              label: 'Fleet Count',
              data: Object.values(cityData),
              backgroundColor: '#155EEF',
              borderRadius: 6
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
              y: { beginAtZero: true, ticks: { precision: 0 } },
              x: { ticks: { font: { size: 11 } } }
            }
          }
        });
      }
    });
  </script>
</body>
</html>
