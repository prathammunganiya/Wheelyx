<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage 20 Cities & Hub Locations | Wheelyx Admin</title>
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
          <jsp:param name="activeTab" value="locations"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">20 Indian Cities & 200 Real Pickup Hubs</h2>
            <p class="text-muted small mb-0">Verified real-world landmarks and hub locations across 20 major Indian cities.</p>
          </div>
          <button type="button" class="btn btn-wx-primary" data-bs-toggle="modal" data-bs-target="#addPlaceModal">
            <i class="bi bi-geo-alt-fill me-1"></i> Add Hub Landmark
          </button>
        </div>

        <!-- Add Landmark Modal with Cancel button -->
        <div class="modal fade" id="addPlaceModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/locations" method="POST">
                <input type="hidden" name="action" value="addPlace">

                <div class="modal-header">
                  <h5 class="modal-title fw-bold">
                    <i class="bi bi-pin-map-fill text-primary me-2"></i>Add Real Pickup Hub Landmark
                  </h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                  <div class="mb-3">
                    <label class="form-label fw-semibold">City <span class="text-danger">*</span></label>
                    <select name="cityId" class="form-select" required>
                      <c:forEach var="c" items="${cities}">
                        <option value="${c.id}" ${c.id eq selectedCity.id ? 'selected' : ''}>${c.cityName} (${c.stateName})</option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label class="form-label fw-semibold">Real-World Landmark Name <span class="text-danger">*</span></label>
                    <input type="text" name="placeName" class="form-control" placeholder="e.g. Connaught Place, MG Road Hub" required>
                    <div class="form-text">Must be an authentic, verifiable real-world landmark.</div>
                  </div>

                  <div class="mb-3">
                    <label class="form-label fw-semibold">Hub Details / Metro Access</label>
                    <input type="text" name="landmarkDetails" class="form-control" placeholder="e.g. Gate 2, Metro Station Exit, 24/7 self-drive parking">
                  </div>
                </div>

                <div class="modal-footer">
                  <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" class="btn btn-wx-primary">
                    <i class="bi bi-check-circle me-1"></i> Save Landmark
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div class="row g-4">
          <!-- City Selection List -->
          <div class="col-lg-4">
            <div class="wx-card p-3">
              <h5 class="fw-bold mb-3 px-2">20 Major Indian Cities</h5>
              <div class="list-group list-group-flush" style="max-height: 580px; overflow-y: auto;">
                <c:forEach var="city" items="${cities}">
                  <a href="${pageContext.request.contextPath}/admin/locations?cityId=${city.id}" 
                     class="list-group-item list-group-item-action d-flex justify-content-between align-items-center py-2 px-3 ${city.id eq selectedCity.id ? 'active' : ''}">
                    <div>
                      <span class="fw-semibold">${city.cityName}</span>
                      <span class="small d-block ${city.id eq selectedCity.id ? 'text-white-50' : 'text-muted'}">${city.stateName}</span>
                    </div>
                    <i class="bi bi-chevron-right small"></i>
                  </a>
                </c:forEach>
              </div>
            </div>
          </div>

          <!-- Places in Selected City -->
          <div class="col-lg-8">
            <div class="wx-card p-4">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0">
                  <i class="bi bi-geo-alt-fill text-danger me-2"></i>Pickup Landmarks in ${selectedCity.cityName}
                </h5>
                <span class="badge bg-primary">${places.size()} Famous Locations</span>
              </div>

              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Landmark Location Name</th>
                      <th>Hub Description / Access</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="p" items="${places}" varStatus="status">
                      <tr>
                        <td class="text-muted small">${status.count}</td>
                        <td class="fw-semibold text-primary">
                          <i class="bi bi-pin-map text-danger me-1"></i> ${p.placeName}
                        </td>
                        <td class="small text-muted">
                          ${not empty p.landmarkDetails ? p.landmarkDetails : 'Verified Wheelyx self-drive key collection hub'}
                        </td>
                        <td>
                          <span class="badge bg-success-subtle text-success border border-success-subtle">
                            ACTIVE HUB
                          </span>
                        </td>
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

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
