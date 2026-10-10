<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Account Settings | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container-fluid">
    <div class="row">
      <!-- Role Sidebar -->
      <div class="col-lg-2 col-md-3 p-0 d-none d-md-block">
        <c:choose>
          <c:when test="${user.admin}"><jsp:include page="/components/sidebar-admin.jsp"><jsp:param name="activeTab" value="profile"/></jsp:include></c:when>
          <c:when test="${user.owner}"><jsp:include page="/components/sidebar-owner.jsp"><jsp:param name="activeTab" value="profile"/></jsp:include></c:when>
          <c:otherwise><jsp:include page="/components/sidebar-customer.jsp"><jsp:param name="activeTab" value="profile"/></jsp:include></c:otherwise>
        </c:choose>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <div>
            <h2 class="h3 fw-bold mb-1">Account & Security Profile</h2>
            <p class="text-muted small mb-0">Manage your contact credentials and authentication password.</p>
          </div>
          <span class="badge bg-primary text-uppercase fs-6 px-3 py-2">${user.role}</span>
        </div>

        <c:if test="${param.success eq 'profile_updated'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Profile details updated successfully.
          </div>
        </c:if>
        <c:if test="${param.success eq 'password_changed'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-shield-check me-1"></i> Security password changed successfully.
          </div>
        </c:if>
        <c:if test="${param.error eq 'incorrect_password'}">
          <div class="alert alert-danger py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> Current password does not match.
          </div>
        </c:if>

        <div class="row g-4">
          <!-- Edit Contact Profile -->
          <div class="col-lg-6">
            <div class="wx-card p-4">
              <h5 class="fw-bold mb-3"><i class="bi bi-person text-primary me-2"></i> Contact Details</h5>
              <form action="${pageContext.request.contextPath}/profile" method="POST">
                <input type="hidden" name="action" value="updateProfile">

                <div class="mb-3">
                  <label class="form-label">Full Name</label>
                  <input type="text" name="name" class="form-control" value="${user.name}" required>
                </div>

                <div class="mb-3">
                  <label class="form-label">Email Address (Read-Only)</label>
                  <input type="email" class="form-control bg-light" value="${user.email}" readonly>
                  <div class="form-text small">Email cannot be modified for security and audit integrity.</div>
                </div>

                <div class="mb-3">
                  <label class="form-label">Phone Number</label>
                  <input type="tel" name="phone" class="form-control" value="${user.phone}" required>
                </div>

                <c:if test="${user.owner and not empty ownerDetails}">
                  <div class="p-3 bg-light rounded-3 border mb-3">
                    <h6 class="fw-bold small text-muted mb-2">Fleet Organization</h6>
                    <div class="small">Business: <strong>${ownerDetails.businessName}</strong></div>
                    <div class="small">PAN: <strong>${ownerDetails.panNumber}</strong></div>
                  </div>
                </c:if>

                <!-- EDIT and CANCEL Buttons -->
                <div class="d-flex gap-2 mt-4">
                  <button type="submit" class="btn btn-wx-primary flex-grow-1">Save Changes</button>
                  <a href="${pageContext.request.contextPath}/home" class="btn btn-wx-cancel">Cancel</a>
                </div>
              </form>
            </div>
          </div>

          <!-- Change Password -->
          <div class="col-lg-6">
            <div class="wx-card p-4">
              <h5 class="fw-bold mb-3"><i class="bi bi-shield-lock text-danger me-2"></i> Change Password</h5>
              <form action="${pageContext.request.contextPath}/profile" method="POST">
                <input type="hidden" name="action" value="changePassword">

                <div class="mb-3">
                  <label class="form-label">Current Password</label>
                  <input type="password" name="currentPassword" class="form-control" placeholder="••••••••" required>
                </div>

                <div class="mb-3">
                  <label class="form-label">New Password</label>
                  <input type="password" name="newPassword" class="form-control" placeholder="••••••••" required>
                </div>

                <div class="mb-3">
                  <label class="form-label">Confirm New Password</label>
                  <input type="password" name="confirmPassword" class="form-control" placeholder="••••••••" required>
                </div>

                <div class="d-flex gap-2 mt-4">
                  <button type="submit" class="btn btn-wx-primary flex-grow-1">Update Password</button>
                  <a href="${pageContext.request.contextPath}/home" class="btn btn-wx-cancel">Cancel</a>
                </div>
              </form>
            </div>

            <!-- Notifications Feed -->
            <div class="wx-card p-4 mt-4">
              <h5 class="fw-bold mb-3"><i class="bi bi-bell text-warning me-2"></i> Recent Alerts</h5>
              <c:choose>
                <c:when test="${not empty notifications}">
                  <div class="d-flex flex-column gap-2">
                    <c:forEach var="n" items="${notifications}">
                      <div class="p-2 border-bottom small">
                        <div class="fw-bold">${n.title}</div>
                        <div class="text-muted">${n.message}</div>
                      </div>
                    </c:forEach>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="text-muted small">No unread notifications.</div>
                </c:otherwise>
              </c:choose>
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
