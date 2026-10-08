<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Vehicle Listing | Wheelyx</title>
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
          <jsp:param name="activeTab" value="vehicles"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Edit Vehicle Specifications</h2>
            <p class="text-muted small mb-0">Modify vehicle pricing, hub location, features, and operational availability status.</p>
          </div>
          <a href="${pageContext.request.contextPath}/owner/vehicles" class="btn btn-outline-secondary">
            <i class="bi bi-x-circle me-1"></i> Cancel & Back
          </a>
        </div>

        <c:if test="${param.error eq 'invalid_data'}">
          <div class="alert alert-danger py-2 small mb-4">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> Error updating vehicle. Please verify input fields and pricing.
          </div>
        </c:if>

        <div class="wx-card p-4 p-md-5">
          <form action="${pageContext.request.contextPath}/owner/vehicles/edit" method="POST" id="vehicleEditForm">
            <input type="hidden" name="id" value="${vehicle.id}">

            <!-- Vehicle Identity -->
            <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">
              <i class="bi bi-info-circle me-2"></i>Vehicle Identity & Category
            </h5>

            <div class="row g-3 mb-4">
              <div class="col-md-4">
                <label class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                <select name="categoryId" class="form-select" required>
                  <c:forEach var="c" items="${categories}">
                    <option value="${c.id}" ${c.id eq vehicle.categoryId ? 'selected' : ''}>${c.categoryName}</option>
                  </c:forEach>
                </select>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Brand / Manufacturer <span class="text-danger">*</span></label>
                <input type="text" name="brand" class="form-control" value="${vehicle.brand}" required>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Model Name <span class="text-danger">*</span></label>
                <input type="text" name="modelName" class="form-control" value="${vehicle.modelName}" required>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Registration Number <span class="text-danger">*</span></label>
                <input type="text" name="registrationNo" class="form-control font-monospace text-uppercase" value="${vehicle.registrationNo}" required>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Fuel / Energy Type <span class="text-danger">*</span></label>
                <select name="fuelType" class="form-select" required>
                  <option value="Petrol" ${vehicle.fuelType eq 'Petrol' ? 'selected' : ''}>Petrol</option>
                  <option value="Diesel" ${vehicle.fuelType eq 'Diesel' ? 'selected' : ''}>Diesel</option>
                  <option value="Electric" ${vehicle.fuelType eq 'Electric' ? 'selected' : ''}>Electric (EV)</option>
                  <option value="CNG" ${vehicle.fuelType eq 'CNG' ? 'selected' : ''}>CNG</option>
                </select>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Transmission <span class="text-danger">*</span></label>
                <select name="transmission" class="form-select" required>
                  <option value="Manual" ${vehicle.transmission eq 'Manual' ? 'selected' : ''}>Manual</option>
                  <option value="Automatic" ${vehicle.transmission eq 'Automatic' ? 'selected' : ''}>Automatic</option>
                </select>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Seating Capacity <span class="text-danger">*</span></label>
                <input type="number" name="seatingCapacity" class="form-control" value="${vehicle.seatingCapacity}" min="1" max="10" required>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Operational Status <span class="text-danger">*</span></label>
                <select name="status" class="form-select" required>
                  <option value="AVAILABLE" ${vehicle.status eq 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
                  <option value="UNAVAILABLE" ${vehicle.status eq 'UNAVAILABLE' ? 'selected' : ''}>UNAVAILABLE</option>
                  <option value="MAINTENANCE" ${vehicle.status eq 'MAINTENANCE' ? 'selected' : ''}>MAINTENANCE</option>
                </select>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Vehicle Image Asset Path <span class="text-danger">*</span></label>
                <input type="text" name="imageUrl" class="form-control" value="${vehicle.imageUrl}" required>
              </div>
            </div>

            <!-- Location & Hub Placement -->
            <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">
              <i class="bi bi-geo-alt me-2"></i>Hub Placement
            </h5>

            <div class="row g-3 mb-4">
              <div class="col-md-6">
                <label class="form-label fw-semibold">City <span class="text-danger">*</span></label>
                <select name="cityId" id="citySelect" class="form-select" required>
                  <c:forEach var="city" items="${cities}">
                    <option value="${city.id}" ${city.id eq vehicle.cityId ? 'selected' : ''}>${city.cityName}</option>
                  </c:forEach>
                </select>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Pickup Hub Landmark <span class="text-danger">*</span></label>
                <select name="placeId" id="placeSelect" class="form-select" required>
                  <c:forEach var="p" items="${places}">
                    <option value="${p.id}" ${p.id eq vehicle.placeId ? 'selected' : ''}>${p.placeName}</option>
                  </c:forEach>
                </select>
              </div>
            </div>

            <!-- Pricing & Deposit -->
            <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">
              <i class="bi bi-currency-rupee me-2"></i>Tariff & Security Deposit
            </h5>

            <div class="row g-3 mb-4">
              <div class="col-md-6">
                <label class="form-label fw-semibold">Daily Rental Rate (₹) <span class="text-danger">*</span></label>
                <div class="input-group">
                  <span class="input-group-text">₹</span>
                  <input type="number" name="pricePerDay" class="form-control" value="${vehicle.pricePerDay}" min="200" step="50" required>
                  <span class="input-group-text">/ day</span>
                </div>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Refundable Security Deposit (₹) <span class="text-danger">*</span></label>
                <div class="input-group">
                  <span class="input-group-text">₹</span>
                  <input type="number" name="securityDeposit" class="form-control" value="${vehicle.securityDeposit}" min="500" step="100" required>
                </div>
              </div>
            </div>

            <!-- Features & Terms -->
            <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">
              <i class="bi bi-card-text me-2"></i>Description & Rental Rules
            </h5>

            <div class="row g-3 mb-4">
              <div class="col-12">
                <label class="form-label fw-semibold">Description</label>
                <textarea name="description" class="form-control" rows="3">${vehicle.description}</textarea>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Features (Comma-separated)</label>
                <input type="text" name="features" class="form-control" value="${vehicle.features}">
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Rental Terms & Conditions</label>
                <input type="text" name="rentalTerms" class="form-control" value="${vehicle.rentalTerms}">
              </div>
            </div>

            <!-- Mandatory EDIT DETAILS and CANCEL buttons -->
            <div class="d-flex justify-content-between align-items-center pt-3 border-top gap-2">
              <a href="${pageContext.request.contextPath}/owner/vehicles" class="btn btn-outline-secondary px-4">
                <i class="bi bi-x-circle me-1"></i> Cancel
              </a>
              <button type="submit" class="btn btn-wx-primary px-4 py-2">
                <i class="bi bi-save2 me-1"></i> Save Changes
              </button>
            </div>
          </form>
        </div>
      </main>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
