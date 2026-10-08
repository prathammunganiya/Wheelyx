<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Explore Fleet | Wheelyx Vehicle Marketplace</title>
  <meta name="description" content="Search and filter verified rental cars, bikes, scooters and EVs across 20 Indian cities.">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <header class="py-4 bg-white border-bottom">
    <div class="container d-flex justify-content-between align-items-center flex-wrap gap-2">
      <div>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb small mb-1">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Fleet Marketplace</li>
          </ol>
        </nav>
        <h1 class="h3 fw-bold mb-0">Vehicle Marketplace</h1>
      </div>
      <div class="text-muted small">
        Showing <strong>${vehicles.size()}</strong> of <strong>${totalMatches}</strong> matching fleet models
      </div>
    </div>
  </header>

  <main class="container py-4">
    <div class="row g-4">
      <!-- Search & Filters Sidebar Panel -->
      <div class="col-lg-3 col-md-4">
        <div class="wx-card p-3 sticky-top" style="top: 85px; z-index: 10;">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0 fs-6 fw-bold"><i class="bi bi-funnel-fill text-primary me-1"></i> Filter Fleet</h5>
            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-sm text-primary p-0">Clear Filters</a>
          </div>

          <form action="${pageContext.request.contextPath}/vehicles" method="GET" id="filterForm">
            <!-- City -->
            <div class="mb-3">
              <label class="form-label">City</label>
              <select name="cityId" class="form-select form-select-sm" data-cascade-places="sidebarPlaceSelect">
                <option value="">All 20 Cities</option>
                <c:forEach var="c" items="${cities}">
                  <option value="${c.id}" ${c.id == selectedCityId ? 'selected' : ''}>${c.cityName}</option>
                </c:forEach>
              </select>
            </div>

            <!-- Place (Cascades from City) -->
            <div class="mb-3">
              <label class="form-label">Pickup Location</label>
              <select name="placeId" class="form-select form-select-sm" id="sidebarPlaceSelect" ${empty selectedCityId ? 'disabled' : ''}>
                <option value="">All Locations</option>
                <c:forEach var="p" items="${places}">
                  <option value="${p.id}" ${p.id == selectedPlaceId ? 'selected' : ''}>${p.placeName}</option>
                </c:forEach>
              </select>
            </div>

            <!-- Category -->
            <div class="mb-3">
              <label class="form-label">Category</label>
              <select name="categoryId" class="form-select form-select-sm">
                <option value="">All 6 Categories</option>
                <c:forEach var="cat" items="${categories}">
                  <option value="${cat.id}" ${cat.id == selectedCategoryId ? 'selected' : ''}>${cat.categoryName}</option>
                </c:forEach>
              </select>
            </div>

            <!-- Fuel Type -->
            <div class="mb-3">
              <label class="form-label">Fuel Type</label>
              <select name="fuelType" class="form-select form-select-sm">
                <option value="">All Fuels</option>
                <option value="Electric" ${'Electric' eq selectedFuelType ? 'selected' : ''}>Electric (EV)</option>
                <option value="Petrol" ${'Petrol' eq selectedFuelType ? 'selected' : ''}>Petrol</option>
                <option value="Diesel" ${'Diesel' eq selectedFuelType ? 'selected' : ''}>Diesel</option>
                <option value="CNG" ${'CNG' eq selectedFuelType ? 'selected' : ''}>CNG</option>
              </select>
            </div>

            <!-- Transmission -->
            <div class="mb-3">
              <label class="form-label">Transmission</label>
              <select name="transmission" class="form-select form-select-sm">
                <option value="">All Transmissions</option>
                <option value="Automatic" ${'Automatic' eq selectedTransmission ? 'selected' : ''}>Automatic</option>
                <option value="Manual" ${'Manual' eq selectedTransmission ? 'selected' : ''}>Manual</option>
              </select>
            </div>

            <!-- Min Seating -->
            <div class="mb-3">
              <label class="form-label">Min Seating Capacity</label>
              <select name="minSeats" class="form-select form-select-sm">
                <option value="">Any Capacity</option>
                <option value="2" ${2 == selectedMinSeats ? 'selected' : ''}>2+ Seats</option>
                <option value="4" ${4 == selectedMinSeats ? 'selected' : ''}>4+ Seats</option>
                <option value="5" ${5 == selectedMinSeats ? 'selected' : ''}>5+ Seats</option>
              </select>
            </div>

            <!-- Price Range -->
            <div class="row g-2 mb-3">
              <div class="col-6">
                <label class="form-label">Min Price (₹)</label>
                <input type="number" name="minPrice" class="form-control form-control-sm" placeholder="400" value="${selectedMinPrice}">
              </div>
              <div class="col-6">
                <label class="form-label">Max Price (₹)</label>
                <input type="number" name="maxPrice" class="form-control form-control-sm" placeholder="10000" value="${selectedMaxPrice}">
              </div>
            </div>

            <button type="submit" class="btn btn-wx-primary w-100 btn-sm">
              <i class="bi bi-search me-1"></i> Apply Filters
            </button>
          </form>
        </div>
      </div>

      <!-- Vehicle Catalog Grid -->
      <div class="col-lg-9 col-md-8">
        <c:choose>
          <%-- Results Found --%>
          <c:when test="${not empty vehicles}">
            <div class="row g-4">
              <c:forEach var="v" items="${vehicles}">
                <div class="col-xl-4 col-md-6">
                  <c:set var="v" value="${v}" scope="request" />
                  <jsp:include page="/components/vehicle-card.jsp" />
                </div>
              </c:forEach>
            </div>

            <!-- Pagination Controls if multiple pages -->
            <c:if test="${totalPages > 1}">
              <nav class="mt-5 d-flex justify-content-center" aria-label="Catalog pagination">
                <ul class="pagination pagination-sm">
                  <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                      <a class="page-link" href="${pageContext.request.contextPath}/vehicles?page=${i}&cityId=${selectedCityId}&placeId=${selectedPlaceId}&categoryId=${selectedCategoryId}&fuelType=${selectedFuelType}&transmission=${selectedTransmission}&minSeats=${selectedMinSeats}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}&status=${selectedStatus}">${i}</a>
                    </li>
                  </c:forEach>
                </ul>
              </nav>
            </c:if>
          </c:when>

          <%-- Requirement: If no vehicle matches, show "No vehicles found for your selected filters." --%>
          <c:otherwise>
            <div class="empty-state-box my-4">
              <i class="bi bi-search empty-state-icon"></i>
              <h3 class="fw-bold mb-2">No vehicles found for your selected filters.</h3>
              <p class="text-muted mb-4">Try broadening your search criteria or resetting filters to explore all available rides across India.</p>
              <div class="d-flex justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary">
                  <i class="bi bi-arrow-counterclockwise me-1"></i> Clear Filters
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-wx-secondary">
                  <i class="bi bi-house me-1"></i> Return Home
                </a>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </main>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
