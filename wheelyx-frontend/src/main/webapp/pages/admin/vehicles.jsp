<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Fleet Vehicles | Wheelyx Admin</title>
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
          <jsp:param name="activeTab" value="vehicles"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Platform Vehicle Fleet Inventory</h2>
            <p class="text-muted small mb-0">Overview of all 36 verified self-drive vehicles across 6 categories and 20 Indian cities.</p>
          </div>
          <span class="badge bg-success fs-6 px-3 py-2">
            ${vehicles.size()} Vehicles Managed
          </span>
        </div>

        <c:if test="${param.success eq 'updated'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Vehicle fleet status successfully changed.
          </div>
        </c:if>

        <div class="wx-card p-4">
          <div class="table-responsive">
            <table class="wx-table">
              <thead>
                <tr>
                  <th>Vehicle Details</th>
                  <th>Category</th>
                  <th>Specifications</th>
                  <th>Hub Location</th>
                  <th>Daily Tariff</th>
                  <th>Fleet Status</th>
                  <th class="text-end">Administrative Control</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="v" items="${vehicles}">
                  <tr>
                    <td>
                      <div class="d-flex align-items-center gap-2">
                        <img src="${pageContext.request.contextPath}/${v.imageUrl}" 
                             alt="${v.modelName}" 
                             style="width: 52px; height: 36px; object-fit: contain;" 
                             class="rounded bg-light border p-1">
                        <div>
                          <div class="fw-bold">${v.brand} ${v.modelName}</div>
                          <div class="small font-monospace text-muted">${v.registrationNo}</div>
                        </div>
                      </div>
                    </td>
                    <td>${v.categoryName}</td>
                    <td class="small text-muted">
                      <div>${v.fuelType} &bull; ${v.transmission}</div>
                      <div>${v.seatingCapacity} Seats</div>
                    </td>
                    <td class="small">
                      <div class="fw-semibold">${v.placeName}</div>
                      <div class="text-muted"><i class="bi bi-geo-alt me-1"></i>${v.cityName}</div>
                    </td>
                    <td class="small">
                      <div class="fw-bold text-primary">₹<fmt:formatNumber value="${v.pricePerDay}" pattern="#,##0"/> / d</div>
                      <div class="text-muted">Deposit: ₹<fmt:formatNumber value="${v.securityDeposit}" pattern="#,##0"/></div>
                    </td>
                    <td>
                      <span class="badge ${v.status eq 'AVAILABLE' ? 'bg-success' : (v.status eq 'ACTIVE_RENTAL' ? 'bg-primary' : (v.status eq 'MAINTENANCE' ? 'bg-warning text-dark' : 'bg-secondary'))}">
                        ${v.status}
                      </span>
                    </td>
                    <td class="text-end">
                      <form action="${pageContext.request.contextPath}/admin/vehicles" method="POST" class="d-inline-flex gap-1 align-items-center">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="vehicleId" value="${v.id}">
                        <select name="status" class="form-select form-select-sm" style="width: auto;" onchange="this.form.submit()">
                          <option value="AVAILABLE" ${v.status eq 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
                          <option value="MAINTENANCE" ${v.status eq 'MAINTENANCE' ? 'selected' : ''}>MAINTENANCE</option>
                          <option value="UNAVAILABLE" ${v.status eq 'UNAVAILABLE' ? 'selected' : ''}>UNAVAILABLE</option>
                          <option value="ACTIVE_RENTAL" ${v.status eq 'ACTIVE_RENTAL' ? 'selected' : ''}>ON TRIP</option>
                        </select>
                        <a href="${pageContext.request.contextPath}/vehicle?id=${v.id}" class="btn btn-sm btn-light border" title="Public Listing Page" target="_blank">
                          <i class="bi bi-box-arrow-up-right"></i>
                        </a>
                      </form>
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
