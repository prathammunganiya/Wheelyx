<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Account | Wheelyx — Move Your Way</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <jsp:include page="/components/navbar.jsp" />

  <main class="container-fluid px-3 px-md-4 px-xl-5 my-auto py-5">
    <div class="row justify-content-center">
      <div class="col-md-7 col-lg-6">
        <div class="wx-card p-4 p-sm-5 shadow-sm">
          <!-- Logo & Header -->
          <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png" 
                 alt="Wheelyx — Move Your Way" 
                 style="height: 64px; width: auto; object-fit: contain;"
                 class="mb-3"
                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.svg';">
            <h3 class="fw-bold mb-1">Join Wheelyx Platform</h3>
            <p class="text-muted small">Select your registration profile below</p>
          </div>

          <!-- Account Type Switcher -->
          <ul class="nav nav-pills nav-fill mb-4 bg-light p-1 rounded-3 border">
            <li class="nav-item">
              <button class="nav-link py-2 fw-semibold ${activeRoleTab ne 'owner' ? 'active' : ''}" type="button" onclick="setRegisterRole('CUSTOMER')">
                <i class="bi bi-person me-1"></i> Customer Account
              </button>
            </li>
            <li class="nav-item">
              <button class="nav-link py-2 fw-semibold ${activeRoleTab eq 'owner' ? 'active' : ''}" type="button" onclick="setRegisterRole('OWNER')">
                <i class="bi bi-briefcase me-1"></i> Vehicle Owner / Host
              </button>
            </li>
          </ul>

          <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger py-2 small mb-3">
              <i class="bi bi-exclamation-triangle-fill me-1"></i> ${errorMessage}
            </div>
          </c:if>

          <form action="${pageContext.request.contextPath}/auth/register" method="POST">
            <input type="hidden" name="role" id="registerRoleInput" value="${activeRoleTab eq 'owner' ? 'OWNER' : 'CUSTOMER'}">

            <div class="row g-3">
              <div class="col-sm-6">
                <label class="form-label">Full Name / Contact Person</label>
                <input type="text" name="name" class="form-control" value="${name}" placeholder="Rahul Verma" required>
              </div>

              <div class="col-sm-6">
                <label class="form-label">Phone Number</label>
                <input type="tel" name="phone" class="form-control" value="${phone}" placeholder="+91 9876543210" required>
              </div>

              <div class="col-12">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" value="${email}" placeholder="you@domain.com" required>
              </div>

              <!-- Owner Specific Fields -->
              <div id="ownerFields" style="display: ${activeRoleTab eq 'owner' ? 'block' : 'none'};" class="col-12">
                <div class="p-3 bg-light rounded-3 border mb-2">
                  <h6 class="fw-bold mb-3 text-primary"><i class="bi bi-building me-1"></i> Business & Financial Credentials</h6>
                  <div class="row g-2">
                    <div class="col-sm-6">
                      <label class="form-label small">Fleet / Business Name</label>
                      <input type="text" name="businessName" class="form-control form-control-sm" placeholder="Urban Wheels Enterprise">
                    </div>
                    <div class="col-sm-6">
                      <label class="form-label small">PAN Number</label>
                      <input type="text" name="panNumber" class="form-control form-control-sm" placeholder="ABCDE1234F">
                    </div>
                    <div class="col-sm-6">
                      <label class="form-label small">Bank Account Number</label>
                      <input type="text" name="bankAccount" class="form-control form-control-sm" placeholder="987654321098">
                    </div>
                    <div class="col-sm-6">
                      <label class="form-label small">Bank IFSC Code</label>
                      <input type="text" name="ifscCode" class="form-control form-control-sm" placeholder="HDFC0001234">
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-sm-6">
                <label class="form-label">Create Password</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
              </div>

              <div class="col-sm-6">
                <label class="form-label">Confirm Password</label>
                <input type="password" name="confirmPassword" class="form-control" placeholder="••••••••" required>
              </div>

              <!-- Actions: Edit/Register & Cancel Requirement -->
              <div class="col-12 mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-wx-primary flex-grow-1 py-2">
                  <i class="bi bi-person-plus me-1"></i> Create Account
                </button>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-wx-cancel py-2">
                  Cancel
                </a>
              </div>
            </div>

            <div class="text-center small text-muted mt-3">
              Already have an account? 
              <a href="${pageContext.request.contextPath}/auth/login" class="fw-bold text-primary">Sign in here</a>
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
    function setRegisterRole(role) {
      document.getElementById('registerRoleInput').value = role;
      const ownerBox = document.getElementById('ownerFields');
      if (role === 'OWNER') {
        ownerBox.style.display = 'block';
      } else {
        ownerBox.style.display = 'none';
      }
      document.querySelectorAll('.nav-pills .nav-link').forEach(btn => btn.classList.remove('active'));
      event.target.closest('.nav-link').classList.add('active');
    }
  </script>
</body>
</html>
