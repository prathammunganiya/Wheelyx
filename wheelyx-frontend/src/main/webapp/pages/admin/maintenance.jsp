<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fleet Maintenance Management | Wheelyx Admin</title>
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
          <jsp:param name="activeTab" value="maintenance"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Fleet Service & Maintenance Management</h2>
            <p class="text-muted small mb-0">Schedule mechanical servicing, inspect workshop status, and ground vehicles from active booking availability.</p>
          </div>
          <button type="button" class="btn btn-wx-primary" data-bs-toggle="modal" data-bs-target="#scheduleModal">
            <i class="bi bi-tools me-1"></i> Schedule Maintenance
          </button>
        </div>

        <c:if test="${param.success eq 'updated'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Fleet maintenance status updated. Vehicle availability synchronized.
          </div>
        </c:if>

        <!-- Maintenance Schedule Modal with mandatory Cancel button -->
        <div class="modal fade" id="scheduleModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/maintenance" method="POST">
                <input type="hidden" name="action" value="schedule">

                <div class="modal-header">
                  <h5 class="modal-title fw-bold">
                    <i class="bi bi-tools text-danger me-2"></i>Schedule Vehicle Maintenance
                  </h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Select Vehicle to Service <span class="text-danger">*</span></label>
                    <select name="vehicleId" class="form-select" required>
                      <c:forEach var="v" items="${vehicles}">
                        <option value="${v.id}">${v.brand} ${v.modelName} (${v.registrationNo}) - ${v.cityName}</option>
                      </c:forEach>
                    </select>
                    <div class="form-text text-danger">Grounded: vehicle status immediately switches to MAINTENANCE and cannot be booked.</div>
                  </div>

                  <div class="mb-3">
                    <label class="form-label fw-semibold">Service Type <span class="text-danger">*</span></label>
                    <select name="maintenanceType" class="form-select" required>
                      <option value="Periodic Oil & Filter Service">Periodic Oil & Filter Service</option>
                      <option value="Brake Pad & Disc Replacement">Brake Pad & Disc Replacement</option>
                      <option value="Tire Rotation & Wheel Alignment">Tire Rotation & Wheel Alignment</option>
                      <option value="EV Battery & Motor Diagnostics">EV Battery & Motor Diagnostics</option>
                      <option value="Bodywork & Detailing Inspection">Bodywork & Detailing Inspection</option>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label class="form-label fw-semibold">Detailed Description <span class="text-danger">*</span></label>
                    <input type="text" name="description" class="form-control" placeholder="e.g. 15,000 km routine manufacturer servicing" required>
                  </div>

                  <div class="row g-2 mb-3">
                    <div class="col-6">
                      <label class="form-label fw-semibold">Start Date <span class="text-danger">*</span></label>
                      <input type="date" name="startDate" class="form-control" value="${today}" required>
                    </div>
                    <div class="col-6">
                      <label class="form-label fw-semibold">Estimated End <span class="text-danger">*</span></label>
                      <input type="date" name="endDate" class="form-control" value="${today}" required>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label class="form-label fw-semibold">Estimated Cost (₹) <span class="text-danger">*</span></label>
                    <div class="input-group">
                      <span class="input-group-text">₹</span>
                      <input type="number" name="cost" class="form-control" placeholder="2500" min="0" step="50" required>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label class="form-label fw-semibold">Workshop Notes</label>
                    <textarea name="notes" class="form-control" rows="2" placeholder="Authorized workshop bay contact or details..."></textarea>
                  </div>
                </div>

                <div class="modal-footer">
                  <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" class="btn btn-danger">
                    <i class="bi bi-shield-slash me-1"></i> Confirm & Ground Vehicle
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Maintenance Records Table -->
        <div class="wx-card p-4">
          <c:choose>
            <c:when test="${not empty records}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Vehicle</th>
                      <th>Service Type & Description</th>
                      <th>Schedule Dates</th>
                      <th>Workshop Cost</th>
                      <th>Service Status</th>
                      <th class="text-end">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="m" items="${records}">
                      <tr>
                        <td>
                          <div class="fw-bold">${m.vehicleModel}</div>
                          <div class="small font-monospace text-muted">${m.registrationNo}</div>
                        </td>
                        <td>
                          <div class="fw-semibold">${m.maintenanceType}</div>
                          <div class="small text-muted">${m.description}</div>
                        </td>
                        <td class="small">
                          <div><strong>Start:</strong> ${m.startDate}</div>
                          <div><strong>Target:</strong> ${m.endDate}</div>
                        </td>
                        <td class="fw-bold text-dark">
                          ₹<fmt:formatNumber value="${m.cost}" pattern="#,##0"/>
                        </td>
                        <td>
                          <span class="badge ${m.status eq 'IN_PROGRESS' ? 'bg-warning text-dark' : (m.status eq 'COMPLETED' ? 'bg-success' : 'bg-secondary')}">
                            ${m.status}
                          </span>
                        </td>
                        <td class="text-end">
                          <c:if test="${m.status eq 'IN_PROGRESS'}">
                            <form action="${pageContext.request.contextPath}/admin/maintenance" method="POST" class="d-inline"
                                  onsubmit="return confirm('Complete service and return vehicle to available fleet?');">
                              <input type="hidden" name="action" value="complete">
                              <input type="hidden" name="maintenanceId" value="${m.id}">
                              <input type="hidden" name="vehicleId" value="${m.vehicleId}">
                              <button type="submit" class="btn btn-sm btn-success">
                                <i class="bi bi-check2-circle me-1"></i> Complete & Restore
                              </button>
                            </form>
                          </c:if>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>

            <c:otherwise>
              <div class="empty-state-box py-5">
                <i class="bi bi-check2-circle text-success fs-1 mb-2"></i>
                <h4 class="fw-bold mb-1">All Vehicles 100% Operational</h4>
                <p class="text-muted mb-0">No active maintenance work orders. All 36 vehicles are available for self-drive reservations.</p>
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
