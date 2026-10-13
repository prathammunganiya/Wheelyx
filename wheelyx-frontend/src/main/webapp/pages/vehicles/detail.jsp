<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${vehicle.modelName} — Vehicle Details | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <header class="py-3 bg-white border-bottom">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb small mb-0">
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/vehicles">Marketplace</a></li>
          <li class="breadcrumb-item active" aria-current="page">${vehicle.modelName}</li>
        </ol>
      </nav>
    </div>
  </header>

  <main class="container-fluid px-3 px-md-4 px-xl-5 py-4">
    <div class="row g-4">
      <!-- Left Column: Large Vehicle Image & Specs -->
      <div class="col-lg-7">
        <div class="wx-card p-4 text-center mb-4 bg-white">
          <img src="${pageContext.request.contextPath}/${vehicle.imageUrl}" 
               alt="${vehicle.modelName}" 
               class="img-fluid rounded-3"
               style="max-height: 380px; object-fit: contain;"
               onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/vehicles/cars/swift.png';">
        </div>

        <!-- Specifications & Features -->
        <div class="wx-card p-4 mb-4">
          <h4 class="fw-bold mb-3">Vehicle Overview & Specifications</h4>
          <p class="text-muted">${vehicle.description}</p>

          <div class="row g-3 py-3 border-top border-bottom my-3">
            <div class="col-sm-4 col-6">
              <span class="text-muted small">Brand</span>
              <div class="fw-bold">${vehicle.brand}</div>
            </div>
            <div class="col-sm-4 col-6">
              <span class="text-muted small">Category</span>
              <div class="fw-bold text-primary">${vehicle.categoryName}</div>
            </div>
            <div class="col-sm-4 col-6">
              <span class="text-muted small">Fuel Type</span>
              <div class="fw-bold">${vehicle.fuelType}</div>
            </div>
            <div class="col-sm-4 col-6">
              <span class="text-muted small">Transmission</span>
              <div class="fw-bold">${vehicle.transmission}</div>
            </div>
            <div class="col-sm-4 col-6">
              <span class="text-muted small">Seating Capacity</span>
              <div class="fw-bold">${vehicle.seatingCapacity} Passengers</div>
            </div>
            <div class="col-sm-4 col-6">
              <span class="text-muted small">Registration</span>
              <div class="fw-bold text-monospace">${vehicle.registrationNo}</div>
            </div>
          </div>

          <h5 class="fw-bold mt-4 mb-2">Key Equipment & Features</h5>
          <p class="text-secondary small mb-4">${vehicle.features}</p>

          <h5 class="fw-bold mt-4 mb-2">Rental Policies & Terms</h5>
          <p class="text-secondary small mb-0">${vehicle.rentalTerms}</p>
        </div>

        <!-- Verified Reviews Section for this Vehicle -->
        <div class="wx-card p-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold mb-0">Verified Traveler Reviews</h5>
            <span class="badge bg-warning text-dark"><i class="bi bi-star-fill me-1"></i> ${vehicle.averageRating} (${vehicle.reviewCount})</span>
          </div>

          <c:choose>
            <c:when test="${not empty reviews}">
              <div class="d-flex flex-column gap-3">
                <c:forEach var="r" items="${reviews}">
                  <div class="p-3 rounded-3 bg-light border">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                      <strong class="small">${r.customerName}</strong>
                      <div class="text-warning small">
                        <c:forEach begin="1" end="${r.rating}"><i class="bi bi-star-fill"></i></c:forEach>
                      </div>
                    </div>
                    <p class="text-muted small mb-0">${r.comment}</p>
                  </div>
                </c:forEach>
              </div>
            </c:when>
            <c:otherwise>
              <div class="text-center py-3 text-muted small">
                <i class="bi bi-chat-left-dots fs-3 d-block mb-1"></i>
                No traveler reviews submitted for this vehicle yet.
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <!-- Right Column: Booking Card & Hub Information -->
      <div class="col-lg-5">
        <div class="wx-card p-4 sticky-top" style="top: 85px;">
          <div class="d-flex justify-content-between align-items-start mb-2">
            <div>
              <span class="badge bg-primary bg-opacity-10 text-primary mb-1">${vehicle.categoryName}</span>
              <h3 class="fw-bold mb-0">${vehicle.modelName}</h3>
            </div>
            <c:choose>
              <c:when test="${vehicle.status eq 'AVAILABLE'}">
                <span class="badge bg-success-subtle text-success fs-6"><i class="bi bi-check-circle me-1"></i> Available</span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-warning-subtle text-warning fs-6">${vehicle.status}</span>
              </c:otherwise>
            </c:choose>
          </div>

          <div class="text-muted small mb-4">
            <i class="bi bi-geo-alt-fill text-danger me-1"></i>
            Located in <strong>${vehicle.cityName}</strong> (${vehicle.placeName})
          </div>

          <!-- Price Highlight Box -->
          <div class="p-3 rounded-3 bg-primary bg-opacity-10 border border-primary border-opacity-25 mb-4">
            <div class="d-flex justify-content-between align-items-baseline">
              <span class="text-muted small">Rental Price / Day:</span>
              <div class="h3 fw-bold text-primary mb-0">₹<fmt:formatNumber value="${vehicle.pricePerDay}" pattern="#,##0"/></div>
            </div>
            <div class="d-flex justify-content-between align-items-baseline mt-2 small text-muted">
              <span>Refundable Security Deposit:</span>
              <span class="fw-bold">₹<fmt:formatNumber value="${vehicle.securityDeposit}" pattern="#,##0"/></span>
            </div>
            <div class="mt-2 pt-2 border-top border-primary border-opacity-25 small text-muted">
              <i class="bi bi-check2-circle text-success me-1"></i> 18% GST itemized transparently at reservation
            </div>
          </div>

          <!-- Fleet Partner Info -->
          <div class="mb-4 small p-3 rounded-3 bg-light border">
            <div class="text-muted">Fleet Managed By:</div>
            <div class="fw-bold">${vehicle.ownerName}</div>
            <div class="text-muted mt-1"><i class="bi bi-shield-check text-success me-1"></i> Verified Fleet Partner</div>
          </div>

          <!-- Action Buttons -->
          <div class="d-grid gap-2">
            <c:choose>
              <c:when test="${vehicle.status eq 'AVAILABLE'}">
                <a href="${pageContext.request.contextPath}/booking?vehicleId=${vehicle.id}" class="btn btn-wx-primary btn-lg">
                  <i class="bi bi-calendar-check me-2"></i> Book Now
                </a>
              </c:when>
              <c:otherwise>
                <button class="btn btn-secondary btn-lg" disabled>
                  Currently ${vehicle.status}
                </button>
              </c:otherwise>
            </c:choose>

            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-outline">
              <i class="bi bi-arrow-left me-1"></i> Back to Vehicles
            </a>
          </div>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
