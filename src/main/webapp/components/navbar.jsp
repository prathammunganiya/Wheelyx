<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg wx-navbar py-2">
  <div class="container">
    <!-- Brand Logo Lockup (Integrated Wheelyx Mark) -->
    <a class="navbar-brand d-flex align-items-center me-3 me-lg-4 py-1" href="${pageContext.request.contextPath}/home" title="Wheelyx — Move Your Way">
      <img src="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png" 
           alt="Wheelyx — Move Your Way" 
           class="wx-brand-logo"
           onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.svg';">
    </a>

    <!-- Mobile Toggler -->
    <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#wxNavbarNav" aria-controls="wxNavbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <i class="bi bi-list fs-2"></i>
    </button>

    <!-- Nav Links -->
    <div class="collapse navbar-collapse" id="wxNavbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-lg-center">
        <li class="nav-item">
          <a class="nav-link wx-nav-link" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-house me-1"></i> Home
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link wx-nav-link" href="${pageContext.request.contextPath}/vehicles">
            <i class="bi bi-car-front me-1"></i> Explore Fleet
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link wx-nav-link" href="${pageContext.request.contextPath}/home#categories">
            <i class="bi bi-grid me-1"></i> Categories
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link wx-nav-link" href="${pageContext.request.contextPath}/home#cities">
            <i class="bi bi-geo-alt me-1"></i> 20 Cities
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link wx-nav-link" href="${pageContext.request.contextPath}/home#how-it-works">
            <i class="bi bi-info-circle me-1"></i> How It Works
          </a>
        </li>
      </ul>

      <!-- Right Header Actions (Theme Toggle & Auth) -->
      <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0">
        <!-- Light / Dark Theme Switch -->
        <button type="button" class="theme-toggle-btn" id="themeToggleBtn" aria-label="Toggle theme">
          <i class="bi bi-moon-stars-fill text-primary"></i> <span>Dark</span>
        </button>

        <c:choose>
          <c:when test="${not empty sessionScope.user}">
            <!-- Authenticated User Menu -->
            <div class="dropdown">
              <button class="btn btn-wx-secondary dropdown-toggle d-flex align-items-center gap-2" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle text-primary"></i>
                <span class="d-none d-sm-inline">${sessionScope.userName}</span>
                <span class="badge bg-primary text-uppercase" style="font-size: 0.65rem;">${sessionScope.userRole}</span>
              </button>
              <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                <li class="px-3 py-2 border-bottom">
                  <div class="fw-bold">${sessionScope.userName}</div>
                  <div class="small text-muted">${sessionScope.userEmail}</div>
                </li>
                
                <c:choose>
                  <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 text-primary me-2"></i> Admin Portal</a></li>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/vehicles"><i class="bi bi-car-front text-primary me-2"></i> Fleet Command</a></li>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/bookings"><i class="bi bi-calendar-check text-primary me-2"></i> All Bookings</a></li>
                  </c:when>
                  <c:when test="${sessionScope.userRole eq 'OWNER'}">
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/owner/dashboard"><i class="bi bi-speedometer2 text-primary me-2"></i> Owner Dashboard</a></li>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/owner/vehicles"><i class="bi bi-car-front text-primary me-2"></i> My Fleet</a></li>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/owner/vehicles/add"><i class="bi bi-plus-circle text-success me-2"></i> List Vehicle</a></li>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/owner/bookings"><i class="bi bi-calendar-check text-primary me-2"></i> Rental Requests</a></li>
                  </c:when>
                  <c:otherwise>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/customer/dashboard"><i class="bi bi-speedometer2 text-primary me-2"></i> Dashboard</a></li>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/customer/bookings"><i class="bi bi-calendar-check text-primary me-2"></i> My Bookings</a></li>
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/customer/rentals"><i class="bi bi-key text-primary me-2"></i> Active Rentals</a></li>
                  </c:otherwise>
                </c:choose>
                
                <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile"><i class="bi bi-gear text-secondary me-2"></i> Profile & Security</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
              </ul>
            </div>
          </c:when>

          <c:otherwise>
            <!-- Public Auth Buttons -->
            <div class="dropdown">
              <button class="btn btn-wx-outline dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-box-arrow-in-right me-1"></i> Sign In
              </button>
              <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/auth/login?role=customer"><i class="bi bi-person text-primary me-2"></i> Customer Login</a></li>
                <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/auth/login?role=owner"><i class="bi bi-briefcase text-success me-2"></i> Vehicle Owner Login</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/auth/login?role=admin"><i class="bi bi-shield-lock text-danger me-2"></i> Admin Login</a></li>
              </ul>
            </div>

            <a href="${pageContext.request.contextPath}/auth/register?role=customer" class="btn btn-wx-primary d-none d-sm-inline-flex">
              Sign Up
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</nav>

<script>
  window.WHEELYX_CONTEXT_PATH = '${pageContext.request.contextPath}';
</script>
