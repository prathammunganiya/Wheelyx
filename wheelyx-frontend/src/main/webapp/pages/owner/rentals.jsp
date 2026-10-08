<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Active Fleet Rentals & Return Check-in | Wheelyx</title>
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
          <jsp:param name="activeTab" value="rentals"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Fleet Trips & Return Check-in</h2>
            <p class="text-muted small mb-0">Monitor vehicles currently on trips, track GPS telemetry, and inspect return condition upon check-in.</p>
          </div>
        </div>

        <c:if test="${param.success eq 'handover_dispatched'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-key-fill me-1"></i> Key handover recorded. Vehicle trip is now active and live telemetry initiated.
          </div>
        </c:if>
        <c:if test="${param.success eq 'return_completed'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Return check-in completed. The vehicle has been restored to AVAILABLE status for future bookings.
          </div>
        </c:if>

        <div class="wx-card p-4">
          <c:choose>
            <c:when test="${not empty rentals}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Trip Code</th>
                      <th>Vehicle</th>
                      <th>Handover Time</th>
                      <th>Odometer & Fuel Inspection</th>
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
                                 style="width: 48px; height: 32px; object-fit: contain;" 
                                 class="rounded bg-light border p-1">
                            <div>
                              <div class="fw-semibold">${r.vehicleModel}</div>
                              <div class="small text-muted font-monospace">${r.registrationNo}</div>
                            </div>
                          </div>
                        </td>
                        <td class="small">
                          <div><strong>Handover:</strong> <fmt:formatDate value="${r.handoverTime}" pattern="dd MMM yyyy, HH:mm"/></div>
                          <c:if test="${not empty r.returnTime}">
                            <div class="text-muted"><strong>Returned:</strong> <fmt:formatDate value="${r.returnTime}" pattern="dd MMM yyyy, HH:mm"/></div>
                          </c:if>
                        </td>
                        <td class="small">
                          <div>Start: <strong>${r.startOdometer} km</strong> (${r.fuelLevelStart})</div>
                          <c:if test="${r.returned}">
                            <div>Return: <strong>${r.endOdometer} km</strong> (${r.fuelLevelEnd})</div>
                            <c:if test="${r.endOdometer > r.startOdometer}">
                              <div class="text-muted">Distance: ${r.endOdometer - r.startOdometer} km driven</div>
                            </c:if>
                          </c:if>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${r.active}">
                              <span class="badge bg-primary"><i class="bi bi-broadcast me-1"></i> On Active Trip</span>
                            </c:when>
                            <c:when test="${r.returned}">
                              <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i> Trip Completed</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-secondary">${r.status}</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td class="text-end">
                          <div class="d-inline-flex gap-1">
                            <!-- Track telemetry -->
                            <c:if test="${r.active}">
                              <a href="${pageContext.request.contextPath}/tracking?rentalId=${r.id}" class="btn btn-sm btn-outline-primary" title="Live Telemetry">
                                <i class="bi bi-geo-alt-fill"></i> Track
                              </a>

                              <!-- Return Check-In Modal Trigger -->
                              <button type="button" class="btn btn-sm btn-wx-primary" data-bs-toggle="modal" data-bs-target="#returnModal${r.id}">
                                <i class="bi bi-box-arrow-in-left me-1"></i> Return Check-in
                              </button>

                              <!-- Return Check-In Modal -->
                              <div class="modal fade" id="returnModal${r.id}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered text-start">
                                  <div class="modal-content">
                                    <form action="${pageContext.request.contextPath}/owner/rentals" method="POST">
                                      <input type="hidden" name="action" value="returnCheckIn">
                                      <input type="hidden" name="rentalId" value="${r.id}">

                                      <div class="modal-header">
                                        <h5 class="modal-title fw-bold">
                                          <i class="bi bi-clipboard-check text-primary me-2"></i>Return Inspection: ${r.vehicleModel}
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                      </div>

                                      <div class="modal-body">
                                        <div class="p-3 bg-light rounded border mb-3 small">
                                          <div><strong>Rental Reference:</strong> ${r.rentalCode}</div>
                                          <div><strong>Starting Odometer:</strong> ${r.startOdometer} km (${r.fuelLevelStart})</div>
                                        </div>

                                        <div class="mb-3">
                                          <label class="form-label fw-semibold">Final Odometer Reading (km) <span class="text-danger">*</span></label>
                                          <input type="number" name="endOdometer" class="form-control" min="${r.startOdometer}" value="${r.startOdometer + 50}" required>
                                          <div class="form-text">Must be greater than or equal to initial odometer (${r.startOdometer} km)</div>
                                        </div>

                                        <div class="mb-3">
                                          <label class="form-label fw-semibold">Return Fuel / Battery Level <span class="text-danger">*</span></label>
                                          <select name="fuelLevelEnd" class="form-select" required>
                                            <option value="100% Full">100% Full Tank / Battery</option>
                                            <option value="75%">75% Fuel / Battery</option>
                                            <option value="50%">50% Half Tank / Battery</option>
                                            <option value="25%">25% Reserve Level</option>
                                          </select>
                                        </div>

                                        <div class="mb-3">
                                          <label class="form-label fw-semibold">Return Inspection Notes</label>
                                          <textarea name="returnNotes" class="form-control" rows="2" placeholder="Vehicle returned in satisfactory condition, security deposit released."></textarea>
                                        </div>
                                      </div>

                                      <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-wx-primary">
                                          <i class="bi bi-check2-all me-1"></i> Confirm & Release Vehicle
                                        </button>
                                      </div>
                                    </form>
                                  </div>
                                </div>
                              </div>
                            </c:if>

                            <c:if test="${r.returned}">
                              <a href="${pageContext.request.contextPath}/billing/invoice?bookingId=${r.bookingId}" class="btn btn-sm btn-light border" title="Tax Invoice">
                                <i class="bi bi-receipt"></i>
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
              <div class="empty-state-box py-5">
                <i class="bi bi-key text-muted fs-1 mb-2"></i>
                <h4 class="fw-bold mb-1">No Rentals Dispatched Yet</h4>
                <p class="text-muted mb-0">When customer bookings are handed over, active rental trips will appear here.</p>
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
