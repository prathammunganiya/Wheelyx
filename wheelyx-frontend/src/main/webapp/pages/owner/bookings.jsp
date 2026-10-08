<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Rental Requests & Handovers | Wheelyx</title>
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
          <jsp:param name="activeTab" value="bookings"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Customer Rental Requests & Key Handovers</h2>
            <p class="text-muted small mb-0">Verify customer bookings, check driver license, record initial odometer reading, and dispatch handover.</p>
          </div>
          <a href="${pageContext.request.contextPath}/owner/rentals" class="btn btn-outline-secondary">
            <i class="bi bi-key me-1"></i> View Active Rentals
          </a>
        </div>

        <c:if test="${param.error eq 'handover_failed'}">
          <div class="alert alert-danger py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> Key handover failed. Please verify odometer reading and booking status.
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
                      <th>Vehicle</th>
                      <th>Customer Info</th>
                      <th>Hub & Schedule</th>
                      <th>Total Tariff</th>
                      <th>Status</th>
                      <th class="text-end">Handover Action</th>
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
                                 style="width: 48px; height: 32px; object-fit: contain;" 
                                 class="rounded bg-light border p-1">
                            <div>
                              <div class="fw-semibold">${b.vehicleModel}</div>
                              <div class="small text-muted font-monospace">${b.registrationNo}</div>
                            </div>
                          </div>
                        </td>
                        <td class="small">
                          <div class="fw-bold">${b.customerName}</div>
                          <div class="text-muted">${b.customerEmail}</div>
                          <div class="text-muted"><i class="bi bi-telephone me-1"></i>${b.customerPhone}</div>
                        </td>
                        <td class="small">
                          <div><i class="bi bi-geo-alt me-1 text-primary"></i>${b.pickupPlaceName} (${b.cityName})</div>
                          <div class="text-muted"><strong>From:</strong> ${b.startDate} &bull; <strong>To:</strong> ${b.endDate}</div>
                        </td>
                        <td class="small">
                          <div class="fw-bold text-success">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0"/></div>
                          <div class="text-muted">${b.durationDays} day(s)</div>
                        </td>
                        <td>
                          <span class="badge ${b.status eq 'CONFIRMED' ? 'bg-success' : (b.status eq 'CANCELLED' ? 'bg-danger' : 'bg-secondary')}">
                            ${b.status}
                          </span>
                        </td>
                        <td class="text-end">
                          <c:choose>
                            <c:when test="${b.status eq 'CONFIRMED'}">
                              <button type="button" class="btn btn-sm btn-wx-primary" 
                                      data-bs-toggle="modal" data-bs-target="#handoverModal${b.id}">
                                <i class="bi bi-key-fill me-1"></i> Handover Keys
                              </button>

                              <!-- Handover Modal -->
                              <div class="modal fade" id="handoverModal${b.id}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered text-start">
                                  <div class="modal-content">
                                    <form action="${pageContext.request.contextPath}/owner/bookings" method="POST">
                                      <input type="hidden" name="action" value="handover">
                                      <input type="hidden" name="bookingId" value="${b.id}">

                                      <div class="modal-header">
                                        <h5 class="modal-title fw-bold">
                                          <i class="bi bi-key text-primary me-2"></i>Handover Keys: ${b.vehicleModel}
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                      </div>

                                      <div class="modal-body">
                                        <div class="p-3 bg-light rounded border mb-3 small">
                                          <div><strong>Customer:</strong> ${b.customerName} (${b.customerPhone})</div>
                                          <div><strong>Booking Reference:</strong> ${b.bookingCode}</div>
                                          <div><strong>Pickup Location:</strong> ${b.pickupPlaceName}, ${b.cityName}</div>
                                        </div>

                                        <div class="mb-3">
                                          <label class="form-label fw-semibold">Current Odometer Reading (km) <span class="text-danger">*</span></label>
                                          <input type="number" name="startOdometer" class="form-control" placeholder="e.g. 15420" min="0" required>
                                          <div class="form-text">Verify odometer reading in vehicle dashboard</div>
                                        </div>

                                        <div class="mb-3">
                                          <label class="form-label fw-semibold">Fuel / Battery Level <span class="text-danger">*</span></label>
                                          <select name="fuelLevel" class="form-select" required>
                                            <option value="100% Full">100% Full / 100% Battery</option>
                                            <option value="75%">75% Fuel / Battery</option>
                                            <option value="50%">50% Half Tank / Battery</option>
                                            <option value="25%">25% Reserve Level</option>
                                          </select>
                                        </div>

                                        <div class="mb-3">
                                          <label class="form-label fw-semibold">Inspection Notes</label>
                                          <textarea name="notes" class="form-control" rows="2" placeholder="Vehicle spotless, spare wheel verified, tools intact..."></textarea>
                                        </div>
                                      </div>

                                      <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-wx-primary">
                                          <i class="bi bi-check-circle-fill me-1"></i> Confirm Key Handover
                                        </button>
                                      </div>
                                    </form>
                                  </div>
                                </div>
                              </div>
                            </c:when>

                            <c:otherwise>
                              <a href="${pageContext.request.contextPath}/billing/invoice?bookingId=${b.id}" class="btn btn-sm btn-light border" title="View Invoice">
                                <i class="bi bi-receipt"></i>
                              </a>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>

            <c:otherwise>
              <div class="empty-state-box py-5">
                <i class="bi bi-calendar-x text-muted fs-1 mb-2"></i>
                <h4 class="fw-bold mb-1">No Rental Requests Yet</h4>
                <p class="text-muted mb-0">When customers book your listed vehicles, their reservations appear here for key handover.</p>
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
