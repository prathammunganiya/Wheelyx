<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wx-sidebar">
  <div class="d-flex align-items-center gap-2 mb-4 px-2">
    <div class="rounded-circle bg-danger text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; font-weight: bold;">
      <i class="bi bi-shield-lock"></i>
    </div>
    <div class="overflow-hidden">
      <div class="fw-bold text-truncate">${sessionScope.userName}</div>
      <div class="small text-danger fw-bold">Platform Admin</div>
    </div>
  </div>

  <nav class="d-flex flex-column gap-1">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="wx-sidebar-link ${param.activeTab eq 'dashboard' ? 'active' : ''}">
      <i class="bi bi-speedometer2 text-primary"></i> Command Center
    </a>
    <a href="${pageContext.request.contextPath}/admin/users" class="wx-sidebar-link ${param.activeTab eq 'users' ? 'active' : ''}">
      <i class="bi bi-people text-info"></i> User Accounts
    </a>
    <a href="${pageContext.request.contextPath}/admin/vehicles" class="wx-sidebar-link ${param.activeTab eq 'vehicles' ? 'active' : ''}">
      <i class="bi bi-car-front text-success"></i> Fleet Vehicles
    </a>
    <a href="${pageContext.request.contextPath}/admin/bookings" class="wx-sidebar-link ${param.activeTab eq 'bookings' ? 'active' : ''}">
      <i class="bi bi-calendar-check text-warning"></i> Reservations
    </a>
    <a href="${pageContext.request.contextPath}/admin/rentals" class="wx-sidebar-link ${param.activeTab eq 'rentals' ? 'active' : ''}">
      <i class="bi bi-key text-primary"></i> Active Rentals
    </a>
    <a href="${pageContext.request.contextPath}/admin/bills" class="wx-sidebar-link ${param.activeTab eq 'bills' ? 'active' : ''}">
      <i class="bi bi-receipt text-secondary"></i> Billing & Invoices
    </a>
    <a href="${pageContext.request.contextPath}/admin/reviews" class="wx-sidebar-link ${param.activeTab eq 'reviews' ? 'active' : ''}">
      <i class="bi bi-star text-warning"></i> Customer Feedback
    </a>
    <a href="${pageContext.request.contextPath}/admin/maintenance" class="wx-sidebar-link ${param.activeTab eq 'maintenance' ? 'active' : ''}">
      <i class="bi bi-tools text-danger"></i> Fleet Maintenance
    </a>
    <a href="${pageContext.request.contextPath}/admin/locations" class="wx-sidebar-link ${param.activeTab eq 'locations' ? 'active' : ''}">
      <i class="bi bi-geo-alt text-success"></i> 20 Hubs & Places
    </a>
    <a href="${pageContext.request.contextPath}/admin/reports" class="wx-sidebar-link ${param.activeTab eq 'reports' ? 'active' : ''}">
      <i class="bi bi-bar-chart-line text-info"></i> Analytics & Reports
    </a>
    <a href="${pageContext.request.contextPath}/admin/audit" class="wx-sidebar-link ${param.activeTab eq 'audit' ? 'active' : ''}">
      <i class="bi bi-shield-check text-muted"></i> Security Audit Log
    </a>
    <a href="${pageContext.request.contextPath}/profile" class="wx-sidebar-link ${param.activeTab eq 'profile' ? 'active' : ''}">
      <i class="bi bi-person-gear text-secondary"></i> Security Profile
    </a>
    <hr class="my-2 border-secondary opacity-25">
    <a href="${pageContext.request.contextPath}/auth/logout" class="wx-sidebar-link text-danger">
      <i class="bi bi-box-arrow-right"></i> Sign Out
    </a>
  </nav>
</div>
