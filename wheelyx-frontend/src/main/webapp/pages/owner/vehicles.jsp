<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage My Fleet | Wheelyx</title>
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
          <jsp:param name="activeTab" value="vehicles"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">My Vehicle Fleet</h2>
            <p class="text-muted small mb-0">Monitor listed vehicles, update daily pricing, modify pickup locations, or toggle operational status.</p>
          </div>
          <a href="${pageContext.request.contextPath}/owner/vehicles/add" class="btn btn-wx-primary">
            <i class="bi bi-plus-circle me-1"></i> List New Vehicle
          </a>
        </div>

        <c:if test="${param.success eq 'vehicle_listed'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> New vehicle listing submitted successfully.
          </div>
        </c:if>
        <c:if test="${param.success eq 'vehicle_updated'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Vehicle specifications and pricing saved successfully.
          </div>
        </c:if>
        <c:if test="${param.success eq 'status_updated'}">
          <div class="alert alert-info py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-info-circle-fill me-1"></i> Vehicle operational availability status updated.
          </div>
        </c:if>
        <c:if test="${param.success eq 'listing_cancelled'}">
          <div class="alert alert-warning py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-trash3-fill me-1"></i> Vehicle listing has been cancelled/deactivated.
          </div>
        </c:if>

        <div class="wx-card p-4">
          <c:choose>
            <c:when test="${not empty vehicles}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Vehicle Info</th>
                      <th>Category & Specs</th>
                      <th>Hub Location</th>
                      <th>Tariff & Deposit</th>
                      <th>Fleet Status</th>
                      <th class="text-end">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="v" items="${vehicles}">
                      <tr>
                        <td>
                          <div class="d-flex align-items-center gap-3">
                            <img src="${pageContext.request.contextPath}/${v.imageUrl}" 
                                 alt="${v.modelName}" 
                                 style="width: 60px; height: 42px; object-fit: contain;" 
                                 class="rounded bg-light border p-1">
                            <div>
                              <div class="fw-bold">${v.brand} ${v.modelName}</div>
                              <div class="small font-monospace text-muted">${v.registrationNo}</div>
                            </div>
                          </div>
                        </td>
                        <td class="small">
                          <div><strong>Category:</strong> ${v.categoryName}</div>
                          <div class="text-muted">${v.fuelType} &bull; ${v.transmission} &bull; ${v.seatingCapacity} Seats</div>
                        </td>
                        <td class="small">
                          <div class="fw-semibold">${v.placeName}</div>
                          <div class="text-muted"><i class="bi bi-geo-alt me-1"></i>${v.cityName}</div>
                        </td>
                        <td class="small">
                          <div class="fw-bold text-primary">₹<fmt:formatNumber value="${v.pricePerDay}" pattern="#,##0"/> / day</div>
                          <div class="text-muted">Deposit: ₹<fmt:formatNumber value="${v.securityDeposit}" pattern="#,##0"/></div>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${v.status eq 'AVAILABLE'}">
                              <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i> Available</span>
                            </c:when>
                            <c:when test="${v.status eq 'ACTIVE_RENTAL'}">
                              <span class="badge bg-primary"><i class="bi bi-key-fill me-1"></i> On Trip</span>
                            </c:when>
                            <c:when test="${v.status eq 'BOOKED'}">
                              <span class="badge bg-info text-dark"><i class="bi bi-bookmark-fill me-1"></i> Booked</span>
                            </c:when>
                            <c:when test="${v.status eq 'MAINTENANCE'}">
                              <span class="badge bg-warning text-dark"><i class="bi bi-tools me-1"></i> Maintenance</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-secondary">${v.status}</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td class="text-end">
                          <div class="d-inline-flex gap-1">
                            <a href="${pageContext.request.contextPath}/owner/vehicles/edit?id=${v.id}" class="btn btn-sm btn-light border text-primary" title="Edit Vehicle Details">
                              <i class="bi bi-pencil"></i> Edit
                            </a>

                            <!-- Toggle Available / Unavailable if not on active trip -->
                            <c:if test="${v.status eq 'AVAILABLE' or v.status eq 'UNAVAILABLE'}">
                              <form action="${pageContext.request.contextPath}/owner/vehicles" method="POST" class="d-inline">
                                <input type="hidden" name="action" value="toggleStatus">
                                <input type="hidden" name="vehicleId" value="${v.id}">
                                <input type="hidden" name="status" value="${v.status eq 'AVAILABLE' ? 'UNAVAILABLE' : 'AVAILABLE'}">
                                <button type="submit" class="btn btn-sm btn-light border ${v.status eq 'AVAILABLE' ? 'text-warning' : 'text-success'}" 
                                        title="${v.status eq 'AVAILABLE' ? 'Mark Unavailable' : 'Mark Available'}">
                                  <i class="bi ${v.status eq 'AVAILABLE' ? 'bi-pause-circle' : 'bi-play-circle'}"></i>
                                </button>
                              </form>
                            </c:if>

                            <!-- Cancel/Remove listing if allowed -->
                            <c:if test="${v.status ne 'ACTIVE_RENTAL' and v.status ne 'BOOKED'}">
                              <form action="${pageContext.request.contextPath}/owner/vehicles" method="POST" 
                                    onsubmit="return confirm('Cancel and deactivate listing for ${v.brand} ${v.modelName}?');" class="d-inline">
                                <input type="hidden" name="action" value="cancelListing">
                                <input type="hidden" name="vehicleId" value="${v.id}">
                                <button type="submit" class="btn btn-sm btn-light border text-danger" title="Cancel Listing">
                                  <i class="bi bi-trash"></i>
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
                <i class="bi bi-car-front text-muted fs-1 mb-2"></i>
                <h4 class="fw-bold mb-1">No Vehicles in Your Fleet</h4>
                <p class="text-muted mb-4">Start earning by listing self-drive cars, bikes, or electric scooters.</p>
                <a href="${pageContext.request.contextPath}/owner/vehicles/add" class="btn btn-wx-primary">
                  <i class="bi bi-plus-circle me-1"></i> List Your Vehicle
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
