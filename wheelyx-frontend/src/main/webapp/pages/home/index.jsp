<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Wheelyx — Move Your Way | Integrated Vehicle Rental and Fleet Management Platform</title>
  <meta name="description" content="Find, book and manage your perfect ride with ease. Verified self-drive cars, bikes, scooters, and EV fleet across 20 Indian cities.">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <!-- Global Navbar -->
  <jsp:include page="/components/navbar.jsp" />

  <!-- Hero Section -->
  <header class="wx-hero-section">
    <div class="container-fluid px-3 px-md-4 px-xl-5 position-relative">
      <div class="row align-items-center g-5">
        <div class="col-lg-7">
          <div class="hero-tagline mb-2">
            <i class="bi bi-geo-alt-fill me-1"></i> Available Across 20 Indian Hubs
          </div>
          <h1 class="hero-title mb-3">
            Move Your Way.
          </h1>
          <p class="hero-subtitle mb-4">
            Find, book and manage your perfect ride with ease. Premium hatchbacks, electric cruisers, agile scooters, and executive sedans ready for pickup.
          </p>
          <div class="d-flex flex-wrap gap-3">
            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary btn-lg px-4">
              <i class="bi bi-car-front me-2"></i> Explore Vehicles
            </a>
            <a href="${pageContext.request.contextPath}/vehicles?status=AVAILABLE" class="btn btn-wx-outline btn-lg px-4 text-white border-white">
              <i class="bi bi-calendar-check me-2"></i> Book a Vehicle
            </a>
          </div>

          <div class="d-flex align-items-center gap-4 mt-5 pt-3 border-top border-white-50">
            <div>
              <div class="h3 fw-bold mb-0 text-cyan">36</div>
              <div class="small opacity-75">Real Fleet Models</div>
            </div>
            <div class="vr bg-white opacity-25"></div>
            <div>
              <div class="h3 fw-bold mb-0 text-cyan">20</div>
              <div class="small opacity-75">Major Indian Cities</div>
            </div>
            <div class="vr bg-white opacity-25"></div>
            <div>
              <div class="h3 fw-bold mb-0 text-cyan">200</div>
              <div class="small opacity-75">Real-World Places</div>
            </div>
          </div>
        </div>

        <div class="col-lg-5 text-center d-none d-lg-block">
          <div class="p-3 bg-white bg-opacity-10 rounded-4 border border-white border-opacity-25 shadow-lg">
            <img src="${pageContext.request.contextPath}/assets/images/vehicles/cars/swift.png" 
                 alt="Wheelyx Fleet Vehicle" 
                 class="img-fluid rounded-3"
                 style="max-height: 290px; object-fit: contain;">
            <div class="text-white-50 small mt-2">
              <i class="bi bi-shield-check text-cyan me-1"></i> Guaranteed Cleaned & Sanitized Fleet
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>

  <!-- Database-Driven Fast Search Filter Bar -->
  <section class="container-fluid px-3 px-md-4 px-xl-5">
    <div class="wx-search-bar">
      <form action="${pageContext.request.contextPath}/vehicles" method="GET" class="row g-3 align-items-end">
        <!-- City Selector -->
        <div class="col-md-3 col-sm-6">
          <label class="form-label text-muted small fw-bold">1. Select City</label>
          <select name="cityId" class="form-select" data-cascade-places="heroPlaceSelect" id="heroCitySelect" required>
            <option value="">Choose Indian City</option>
            <c:forEach var="c" items="${cities}">
              <option value="${c.id}">${c.cityName} (${c.vehicleCount} vehicles)</option>
            </c:forEach>
          </select>
        </div>

        <!-- Place Selector (Cascading AJAX) -->
        <div class="col-md-3 col-sm-6">
          <label class="form-label text-muted small fw-bold">2. Pickup Location</label>
          <select name="placeId" class="form-select" id="heroPlaceSelect" disabled>
            <option value="">Select City First</option>
          </select>
        </div>

        <!-- Category Selector -->
        <div class="col-md-3 col-sm-6">
          <label class="form-label text-muted small fw-bold">3. Fleet Category</label>
          <select name="categoryId" class="form-select">
            <option value="">All 6 Categories</option>
            <c:forEach var="cat" items="${categories}">
              <option value="${cat.id}">${cat.categoryName}</option>
            </c:forEach>
          </select>
        </div>

        <!-- Search Action Button -->
        <div class="col-md-3 col-sm-6">
          <button type="submit" class="btn btn-wx-primary w-100 py-2">
            <i class="bi bi-search me-1"></i> Find Vehicles
          </button>
        </div>
      </form>
    </div>
  </section>

  <!-- 6 Completely Separate Vehicle Categories -->
  <section class="py-5 mt-4" id="categories">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <div class="text-center mb-5">
        <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-2 rounded-pill mb-2">Fleet Taxonomies</span>
        <h2 class="display-6 fw-bold">Six Dedicated Vehicle Categories</h2>
        <p class="text-muted">Choose your preferred style of mobility engineered for city commuting or long-haul cruising.</p>
      </div>

      <div class="row g-4">
        <c:forEach var="cat" items="${categories}">
          <div class="col-lg-2 col-md-4 col-6">
            <a href="${pageContext.request.contextPath}/vehicles?categoryId=${cat.id}" class="text-decoration-none">
              <div class="category-card">
                <div class="category-icon-box">
                  <i class="bi ${cat.iconClass}"></i>
                </div>
                <h5 class="fs-6 fw-bold mb-1">${cat.categoryName}</h5>
                <span class="badge bg-light text-dark border small">${cat.vehicleCount} Models</span>
              </div>
            </a>
          </div>
        </c:forEach>
      </div>
    </div>
  </section>

  <!-- Featured Vehicles Section -->
  <section class="py-5 bg-white bg-opacity-50 border-top border-bottom" id="featured">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <div class="d-flex justify-content-between align-items-end mb-4 flex-wrap gap-2">
        <div>
          <span class="badge bg-success bg-opacity-10 text-success fw-bold px-3 py-2 rounded-pill mb-2">Prime Recommendations</span>
          <h2 class="display-6 fw-bold mb-1">Featured Mobility Fleet</h2>
          <p class="text-muted mb-0">High-demand vehicles verified and available for instant reservation.</p>
        </div>
        <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-outline">
          View All Fleet <i class="bi bi-arrow-right ms-1"></i>
        </a>
      </div>

      <div class="row g-4">
        <c:forEach var="v" items="${featuredVehicles}">
          <div class="col-lg-3 col-md-6">
            <c:set var="v" value="${v}" scope="request" />
            <jsp:include page="/components/vehicle-card.jsp" />
          </div>
        </c:forEach>
      </div>
    </div>
  </section>

  <!-- Why Choose Wheelyx -->
  <section class="py-5" id="why-us">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <div class="text-center mb-5">
        <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-2 rounded-pill mb-2">Platform Excellence</span>
        <h2 class="display-6 fw-bold">Why Ride With Wheelyx</h2>
        <p class="text-muted">Built from the ground up for seamless self-drive freedom.</p>
      </div>

      <div class="row g-4">
        <div class="col-md-3">
          <div class="wx-card p-4 h-100 text-center">
            <div class="fs-1 text-primary mb-3"><i class="bi bi-calendar2-check-fill"></i></div>
            <h5 class="fw-bold">Overlap Protection</h5>
            <p class="text-muted small mb-0">Database interval locking eliminates double-booking hazards so your vehicle is always guaranteed.</p>
          </div>
        </div>

        <div class="col-md-3">
          <div class="wx-card p-4 h-100 text-center">
            <div class="fs-1 text-success mb-3"><i class="bi bi-cash-stack"></i></div>
            <h5 class="fw-bold">Transparent Billing</h5>
            <p class="text-muted small mb-0">Clear GST taxation, no hidden surcharges, and refundable security deposits handled safely.</p>
          </div>
        </div>

        <div class="col-md-3">
          <div class="wx-card p-4 h-100 text-center">
            <div class="fs-1 text-info mb-3"><i class="bi bi-geo-alt-fill"></i></div>
            <h5 class="fw-bold">Live GPS Telemetry</h5>
            <p class="text-muted small mb-0">Track active rentals in real time with Google Maps compatibility and graceful fallback resilience.</p>
          </div>
        </div>

        <div class="col-md-3">
          <div class="wx-card p-4 h-100 text-center">
            <div class="fs-1 text-warning mb-3"><i class="bi bi-shield-shaded"></i></div>
            <h5 class="fw-bold">100% Real Vehicles</h5>
            <p class="text-muted small mb-0">Strict policy ensuring zero fabricated vehicles or fictional locations across our 20 Indian hubs.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- How It Works Section -->
  <section class="py-5 bg-white bg-opacity-50 border-top" id="how-it-works">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <div class="text-center mb-5">
        <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-2 rounded-pill mb-2">Seamless Workflow</span>
        <h2 class="display-6 fw-bold">How Wheelyx Operates</h2>
        <p class="text-muted">Four simple steps from discovery to the open highway.</p>
      </div>

      <div class="row g-4 text-center">
        <div class="col-md-3">
          <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px; font-size: 1.4rem; font-weight: bold;">1</div>
          <h5 class="fw-bold">Choose Ride & Hub</h5>
          <p class="text-muted small">Select from 20 cities and 200 real pickup locations to find matching vehicles.</p>
        </div>
        <div class="col-md-3">
          <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px; font-size: 1.4rem; font-weight: bold;">2</div>
          <h5 class="fw-bold">Book & Deposit</h5>
          <p class="text-muted small">Reserve instantly with clear day rates, refundable security deposit, and GST calculation.</p>
        </div>
        <div class="col-md-3">
          <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px; font-size: 1.4rem; font-weight: bold;">3</div>
          <h5 class="fw-bold">Handover & Drive</h5>
          <p class="text-muted small">Complete key handover, odometer inspection, and unlock live GPS vehicle tracking.</p>
        </div>
        <div class="col-md-3">
          <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px; font-size: 1.4rem; font-weight: bold;">4</div>
          <h5 class="fw-bold">Return & Review</h5>
          <p class="text-muted small">Check-in at the destination hub and share genuine post-rental feedback.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- 20 Indian Cities Highlights -->
  <section class="py-5" id="cities">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <div class="text-center mb-5">
        <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-2 rounded-pill mb-2">National Footprint</span>
        <h2 class="display-6 fw-bold">Operational Across 20 Indian Hubs</h2>
        <p class="text-muted">Serving major metropolitan corridors and tourist destinations with real-world pickup points.</p>
      </div>

      <div class="row g-3">
        <c:forEach var="c" items="${cities}">
          <div class="col-xxl-2 col-xl-3 col-lg-4 col-sm-6">
            <a href="${pageContext.request.contextPath}/vehicles?cityId=${c.id}" class="text-decoration-none">
              <div class="wx-card p-3 d-flex align-items-center justify-content-between">
                <div>
                  <h6 class="fw-bold mb-0">${c.cityName}</h6>
                  <span class="text-muted small">${c.placeCount} Pickup Places</span>
                </div>
                <span class="badge bg-primary bg-opacity-10 text-primary">${c.vehicleCount} Rides</span>
              </div>
            </a>
          </div>
        </c:forEach>
      </div>
    </div>
  </section>

  <!-- Customer Feedback Section (Strictly Real Reviews Only / Empty State If None) -->
  <section class="py-5 bg-white bg-opacity-50 border-top border-bottom" id="customer-feedback">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <div class="text-center mb-5">
        <span class="badge bg-warning bg-opacity-10 text-warning fw-bold px-3 py-2 rounded-pill mb-2">Verified Travelers</span>
        <h2 class="display-6 fw-bold">Customer Feedback</h2>
        <p class="text-muted">Authentic experiences shared by verified renters following completed journeys.</p>
      </div>

      <c:choose>
        <%-- Dynamically display genuine reviews stored in MySQL --%>
        <c:when test="${not empty customerReviews}">
          <div class="row g-4">
            <c:forEach var="rev" items="${customerReviews}">
              <div class="col-lg-4 col-md-6">
                <div class="wx-card p-4 h-100 d-flex flex-column">
                  <div class="d-flex align-items-center justify-content-between mb-3">
                    <div class="text-warning">
                      <c:forEach begin="1" end="${rev.rating}">
                        <i class="bi bi-star-fill"></i>
                      </c:forEach>
                      <c:forEach begin="${rev.rating + 1}" end="5">
                        <i class="bi bi-star"></i>
                      </c:forEach>
                    </div>
                    <span class="badge bg-success bg-opacity-10 text-success small"><i class="bi bi-patch-check-fill me-1"></i> Verified Rental</span>
                  </div>
                  <p class="text-muted fst-italic mb-3 flex-grow-1">"${rev.comment}"</p>
                  <div class="pt-2 border-top d-flex align-items-center gap-2">
                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; font-weight: bold;">
                      ${rev.customerName.substring(0, 1)}
                    </div>
                    <div>
                      <div class="fw-bold small">${rev.customerName}</div>
                      <div class="text-muted" style="font-size: 0.75rem;">Rented ${rev.vehicleModel}</div>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:when>

        <%-- Initial Empty State Requirement: Zero fake names or fake reviews! --%>
        <c:otherwise>
          <div class="empty-state-box max-w-md mx-auto my-4 py-5">
            <i class="bi bi-chat-square-quote empty-state-icon"></i>
            <h4 class="fw-bold mb-2">No customer feedback yet.</h4>
            <p class="text-muted mb-4">Be the first to share your experience after completing a rental journey.</p>
            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary">
              <i class="bi bi-car-front me-1"></i> Book Your First Ride
            </a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </section>

  <!-- Call to Action Banner -->
  <section class="py-5">
    <div class="container-fluid px-3 px-md-4 px-xl-5">
      <div class="p-5 rounded-4 text-center text-white position-relative overflow-hidden" style="background: var(--wx-hero-gradient);">
        <h2 class="display-5 fw-bold mb-3">Ready to Hit the Open Road?</h2>
        <p class="lead mb-4 text-white-50">Discover self-drive freedom across India with verified safety, GPS telemetry, and instant bookings.</p>
        <div class="d-flex justify-content-center gap-3 flex-wrap">
          <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-primary btn-lg px-4 bg-white text-primary">
            Explore Vehicles
          </a>
          <a href="${pageContext.request.contextPath}/auth/register?role=owner" class="btn btn-outline-light btn-lg px-4">
            List Your Fleet as an Owner
          </a>
        </div>
      </div>
    </div>
  </section>

  <!-- Global Footer -->
  <jsp:include page="/components/footer.jsp" />

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
