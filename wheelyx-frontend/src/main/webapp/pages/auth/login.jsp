<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign In | Wheelyx — Move Your Way</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <jsp:include page="/components/navbar.jsp" />

  <main class="container my-auto py-5">
    <div class="row justify-content-center">
      <div class="col-md-6 col-lg-5">
        <div class="wx-card p-4 p-sm-5 shadow-sm">
          <!-- Integrated Logo Lockup -->
          <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png" 
                 alt="Wheelyx — Move Your Way" 
                 style="height: 64px; width: auto; object-fit: contain;"
                 class="mb-3"
                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.svg';">
            <h3 class="fw-bold mb-1">Welcome Back</h3>
            <p class="text-muted small">Sign in to your dedicated portal to continue</p>
          </div>

          <!-- Role Selector Nav Tabs -->
          <ul class="nav nav-pills nav-fill mb-4 bg-light p-1 rounded-3 border" id="roleTabs">
            <li class="nav-item">
              <button class="nav-link py-2 fw-semibold ${activeRoleTab eq 'customer' ? 'active' : ''}" type="button" onclick="setRole('customer')">
                <i class="bi bi-person me-1"></i> Customer
              </button>
            </li>
            <li class="nav-item">
              <button class="nav-link py-2 fw-semibold ${activeRoleTab eq 'owner' ? 'active' : ''}" type="button" onclick="setRole('owner')">
                <i class="bi bi-briefcase me-1"></i> Owner
              </button>
            </li>
            <li class="nav-item">
              <button class="nav-link py-2 fw-semibold ${activeRoleTab eq 'admin' ? 'active' : ''}" type="button" onclick="setRole('admin')">
                <i class="bi bi-shield-lock me-1"></i> Admin
              </button>
            </li>
          </ul>

          <!-- Flash Notifications -->
          <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger py-2 small mb-3">
              <i class="bi bi-exclamation-triangle-fill me-1"></i> ${errorMessage}
            </div>
          </c:if>
          <c:if test="${param.success eq 'registered'}">
            <div class="alert alert-success py-2 small mb-3">
              <i class="bi bi-check-circle-fill me-1"></i> Registration successful! Please log in with your credentials.
            </div>
          </c:if>
          <c:if test="${param.info eq 'logged_out'}">
            <div class="alert alert-info py-2 small mb-3">
              <i class="bi bi-info-circle-fill me-1"></i> You have been logged out securely.
            </div>
          </c:if>
          <c:if test="${param.error eq 'login_required'}">
            <div class="alert alert-warning py-2 small mb-3">
              <i class="bi bi-shield-exclamation me-1"></i> Authentication required to access private portal.
            </div>
          </c:if>

          <!-- Login Form -->
          <form action="${pageContext.request.contextPath}/auth/login" method="POST">
            <input type="hidden" name="role" id="loginRoleInput" value="${empty activeRoleTab ? 'customer' : activeRoleTab}">

            <div class="mb-3">
              <label for="email" class="form-label">Email Address</label>
              <div class="input-group">
                <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                <input type="email" class="form-control" id="email" name="email" value="${email}" placeholder="you@domain.com" required>
              </div>
            </div>

            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <div class="input-group">
                <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
              </div>
            </div>

            <button type="submit" class="btn btn-wx-primary w-100 py-2 mb-3">
              <i class="bi bi-box-arrow-in-right me-1"></i> Sign In to Portal
            </button>

            <!-- Test Credentials Hint -->
            <div class="p-3 bg-light rounded-3 small border mb-3">
              <div class="fw-bold text-muted mb-1"><i class="bi bi-key-fill text-warning me-1"></i> Demo Credentials:</div>
              <div class="text-secondary" style="font-size: 0.8rem;">
                Customer: <code>customer@wheelyx.com</code> / <code>Customer@123</code><br>
                Owner: <code>owner@wheelyx.com</code> / <code>Owner@123</code><br>
                Admin: <code>admin@wheelyx.com</code> / <code>Admin@123</code>
              </div>
            </div>

            <div class="text-center small text-muted">
              Don't have an account? 
              <a href="${pageContext.request.contextPath}/auth/register?role=customer" class="fw-bold text-primary">Register as Customer</a>
              or 
              <a href="${pageContext.request.contextPath}/auth/register?role=owner" class="fw-bold text-success">List Fleet as Owner</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="/components/footer.jsp" />

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
  <script>
    function setRole(role) {
      document.getElementById('loginRoleInput').value = role;
      document.querySelectorAll('#roleTabs .nav-link').forEach(btn => btn.classList.remove('active'));
      event.target.closest('.nav-link').classList.add('active');
    }
  </script>
</body>
</html>
