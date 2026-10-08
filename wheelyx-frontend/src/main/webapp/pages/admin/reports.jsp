<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Analytics & Fleet Reports | Wheelyx Admin</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
  <style>
    @media print {
      body { background: #ffffff !important; }
      .no-print, .wx-sidebar, .navbar, .btn { display: none !important; }
      .col-lg-10 { width: 100% !important; max-width: 100% !important; }
    }
  </style>
</head>
<body>
  <div class="no-print">
    <jsp:include page="/components/navbar.jsp" />
  </div>

  <div class="container-fluid">
    <div class="row">
      <!-- Admin Sidebar -->
      <div class="col-lg-2 col-md-3 p-0 d-none d-md-block no-print">
        <jsp:include page="/components/sidebar-admin.jsp">
          <jsp:param name="activeTab" value="reports"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Fleet Analytics & Commercial Reports</h2>
            <p class="text-muted small mb-0">High-level financial summaries, fleet utilization metrics, and regional hub demand.</p>
          </div>
          <div class="d-flex gap-2 no-print">
            <button onclick="window.print()" class="btn btn-outline-secondary">
              <i class="bi bi-printer me-1"></i> Print / Export PDF
            </button>
          </div>
        </div>

        <!-- Financial Summary Banner -->
        <div class="wx-card p-4 mb-4">
          <div class="row align-items-center g-3">
            <div class="col-md-3 border-end">
              <div class="text-muted small">Total Realized Revenue</div>
              <div class="fs-3 fw-bold text-success">
                ₹<fmt:formatNumber value="${kpis.totalRevenue != null ? kpis.totalRevenue : 0}" pattern="#,##0.00"/>
              </div>
              <div class="small text-muted">Excluding active security deposits</div>
            </div>

            <div class="col-md-3 border-end">
              <div class="text-muted small">Total Customer Bookings</div>
              <div class="fs-3 fw-bold text-primary">${kpis.totalBookings}</div>
              <div class="small text-muted">Across all 20 Indian cities</div>
            </div>

            <div class="col-md-3 border-end">
              <div class="text-muted small">Commercial Fleet Size</div>
              <div class="fs-3 fw-bold text-dark">${kpis.totalVehicles} Models</div>
              <div class="small text-success">${kpis.availableVehicles} Currently Available</div>
            </div>

            <div class="col-md-3">
              <div class="text-muted small">Fleet Health & Maintenance</div>
              <div class="fs-3 fw-bold text-warning">${kpis.maintenanceVehicles}</div>
              <div class="small text-muted">Vehicles undergoing scheduled service</div>
            </div>
          </div>
        </div>

        <!-- Graphical Breakdown -->
        <div class="row g-4 mb-4">
          <div class="col-lg-6">
            <div class="wx-card p-4 h-100">
              <h5 class="fw-bold mb-3"><i class="bi bi-pie-chart text-primary me-2"></i>Category Volume Analysis</h5>
              <div style="height: 300px; position: relative;">
                <canvas id="categoryReportChart"></canvas>
              </div>
            </div>
          </div>

          <div class="col-lg-6">
            <div class="wx-card p-4 h-100">
              <h5 class="fw-bold mb-3"><i class="bi bi-bar-chart text-primary me-2"></i>Top Cities Fleet Allocation</h5>
              <div style="height: 300px; position: relative;">
                <canvas id="cityReportChart"></canvas>
              </div>
            </div>
          </div>
        </div>

        <!-- Tabular breakdown of category and city statistics -->
        <div class="row g-4">
          <div class="col-lg-6">
            <div class="wx-card p-4">
              <h5 class="fw-bold mb-3">Vehicle Categories Performance</h5>
              <div class="table-responsive">
                <table class="wx-table table-sm">
                  <thead>
                    <tr>
                      <th>Category</th>
                      <th class="text-end">Total Bookings</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="entry" items="${categoryDist}">
                      <tr>
                        <td class="fw-semibold">${entry.key}</td>
                        <td class="text-end fw-bold text-primary">${entry.value}</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <div class="col-lg-6">
            <div class="wx-card p-4">
              <h5 class="fw-bold mb-3">City Fleet Distribution</h5>
              <div class="table-responsive">
                <table class="wx-table table-sm">
                  <thead>
                    <tr>
                      <th>City</th>
                      <th class="text-end">Fleet Allocated</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="entry" items="${cityDist}">
                      <tr>
                        <td class="fw-semibold">${entry.key}</td>
                        <td class="text-end fw-bold text-success">${entry.value} vehicles</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>

  <div class="no-print">
    <jsp:include page="/components/footer.jsp" />
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const categoryData = ${categoryDistJson};
      const cityData = ${cityDistJson};

      // 1. Category Chart
      const catCtx = document.getElementById('categoryReportChart');
      if (catCtx) {
        new Chart(catCtx, {
          type: 'pie',
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
            plugins: { legend: { position: 'bottom' } }
          }
        });
      }

      // 2. City Chart
      const cityCtx = document.getElementById('cityReportChart');
      if (cityCtx) {
        new Chart(cityCtx, {
          type: 'bar',
          data: {
            labels: Object.keys(cityData),
            datasets: [{
              label: 'Fleet Count',
              data: Object.values(cityData),
              backgroundColor: '#00B8D9',
              borderRadius: 6
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
              y: { beginAtZero: true, ticks: { precision: 0 } }
            }
          }
        });
      }
    });
  </script>
</body>
</html>
