<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="wx-card vehicle-card">
  <!-- Vehicle Image & Status Badges -->
  <div class="vehicle-img-wrapper">
    <span class="vehicle-badge-category">
      <c:choose>
        <c:when test="${v.fuelType eq 'Electric'}"><i class="bi bi-lightning-charge-fill text-warning me-1"></i></c:when>
        <c:otherwise><i class="bi bi-car-front-fill text-info me-1"></i></c:otherwise>
      </c:choose>
      ${v.categoryName}
    </span>

    <c:choose>
      <c:when test="${v.status eq 'AVAILABLE'}">
        <span class="vehicle-badge-status status-available"><i class="bi bi-check-circle-fill me-1"></i> Available</span>
      </c:when>
      <c:when test="${v.status eq 'BOOKED'}">
        <span class="vehicle-badge-status status-booked"><i class="bi bi-clock-fill me-1"></i> Booked</span>
      </c:when>
      <c:when test="${v.status eq 'ACTIVE_RENTAL'}">
        <span class="vehicle-badge-status status-rental"><i class="bi bi-key-fill me-1"></i> In Trip</span>
      </c:when>
      <c:otherwise>
        <span class="vehicle-badge-status status-maintenance"><i class="bi bi-wrench me-1"></i> Grounded</span>
      </c:otherwise>
    </c:choose>

    <img src="${pageContext.request.contextPath}/${v.imageUrl}" 
         alt="${v.modelName}" 
         loading="lazy"
         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/vehicles/cars/swift.png';">
  </div>

  <!-- Vehicle Content -->
  <div class="p-3 d-flex flex-column flex-grow-1">
    <div class="d-flex justify-content-between align-items-start mb-1">
      <h5 class="mb-0 fs-6 fw-bold text-truncate">${v.modelName}</h5>
      <span class="badge bg-light text-dark border small">${v.brand}</span>
    </div>

    <div class="small text-muted mb-2 d-flex align-items-center gap-1 text-truncate">
      <i class="bi bi-geo-alt-fill text-danger"></i>
      <span>${v.cityName} • ${v.placeName}</span>
    </div>

    <!-- Specs Pills -->
    <div class="d-flex flex-wrap gap-1 mb-3">
      <span class="vehicle-spec-pill">
        <c:choose>
          <c:when test="${v.fuelType eq 'Electric'}"><i class="bi bi-lightning-charge text-warning"></i> EV</c:when>
          <c:when test="${v.fuelType eq 'Diesel'}"><i class="bi bi-fuel-pump text-primary"></i> Diesel</c:when>
          <c:otherwise><i class="bi bi-fuel-pump text-info"></i> Petrol</c:otherwise>
        </c:choose>
      </span>
      <span class="vehicle-spec-pill">
        <i class="bi bi-gear"></i> ${v.transmission}
      </span>
      <span class="vehicle-spec-pill">
        <i class="bi bi-people"></i> ${v.seatingCapacity} Seats
      </span>
      <c:if test="${v.averageRating > 0}">
        <span class="vehicle-spec-pill text-warning fw-bold">
          <i class="bi bi-star-fill"></i> <fmt:formatNumber value="${v.averageRating}" maxFractionDigits="1"/>
        </span>
      </c:if>
    </div>

    <!-- Price & Actions Footer -->
    <div class="mt-auto pt-2 border-top d-flex align-items-center justify-content-between">
      <div>
        <span class="text-muted small">Daily Rate</span>
        <div class="fw-bold fs-5 text-primary">₹<fmt:formatNumber value="${v.pricePerDay}" pattern="#,##0"/></div>
      </div>
      <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/vehicles/detail?id=${v.id}" class="btn btn-sm btn-wx-outline">
          Details
        </a>
        <c:choose>
          <c:when test="${v.status eq 'AVAILABLE'}">
            <a href="${pageContext.request.contextPath}/booking?vehicleId=${v.id}" class="btn btn-sm btn-wx-primary">
              Book
            </a>
          </c:when>
          <c:otherwise>
            <button class="btn btn-sm btn-secondary" disabled>Unavailable</button>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
