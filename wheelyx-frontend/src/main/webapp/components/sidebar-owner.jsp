<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wx-sidebar">
  <div class="d-flex align-items-center gap-2 mb-4 px-2">
    <div class="rounded-circle bg-success text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; font-weight: bold;">
      ${sessionScope.userName.substring(0, 1).toUpperCase()}
    </div>
    <div class="overflow-hidden">
      <div class="fw-bold text-truncate">${sessionScope.userName}</div>
      <div class="small text-muted">Vehicle Owner</div>
    </div>
  </div>

  <nav class="d-flex flex-column gap-1">
    <a href="${pageContext.request.contextPath}/owner/dashboard" class="wx-sidebar-link ${param.activeTab eq 'dashboard' ? 'active' : ''}">
      <i class="bi bi-speedometer2 text-primary"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/owner/vehicles" class="wx-sidebar-link ${param.activeTab eq 'vehicles' ? 'active' : ''}">
      <i class="bi bi-car-front text-info"></i> My Fleet
    </a>
    <a href="${pageContext.request.contextPath}/owner/vehicles/add" class="wx-sidebar-link ${param.activeTab eq 'add-vehicle' ? 'active' : ''}">
      <i class="bi bi-plus-circle text-success"></i> List New Vehicle
    </a>
    <a href="${pageContext.request.contextPath}/owner/bookings" class="wx-sidebar-link ${param.activeTab eq 'bookings' ? 'active' : ''}">
      <i class="bi bi-calendar-check text-warning"></i> Rental Requests
    </a>
    <a href="${pageContext.request.contextPath}/owner/rentals" class="wx-sidebar-link ${param.activeTab eq 'rentals' ? 'active' : ''}">
      <i class="bi bi-key text-primary"></i> Active Rentals
    </a>
    <a href="${pageContext.request.contextPath}/owner/earnings" class="wx-sidebar-link ${param.activeTab eq 'earnings' ? 'active' : ''}">
      <i class="bi bi-currency-rupee text-success"></i> Revenue & Earnings
    </a>
    <a href="${pageContext.request.contextPath}/profile" class="wx-sidebar-link ${param.activeTab eq 'profile' ? 'active' : ''}">
      <i class="bi bi-person-gear text-secondary"></i> Owner Profile
    </a>
    <hr class="my-2 border-secondary opacity-25">
    <a href="${pageContext.request.contextPath}/auth/logout" class="wx-sidebar-link text-danger">
      <i class="bi bi-box-arrow-right"></i> Sign Out
    </a>
  </nav>
</div>
