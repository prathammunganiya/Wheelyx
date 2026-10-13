<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="wx-footer">
  <div class="container">
    <div class="row g-4 mb-4">
      <!-- Brand & Mission -->
      <div class="col-lg-4 col-md-6">
        <img src="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png?v=2" 
             alt="Wheelyx — Move Your Way" 
             class="mb-3"
             style="height: 54px; width: auto; object-fit: contain; filter: brightness(1.2) drop-shadow(0 2px 8px rgba(0, 184, 217, 0.2));"
             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.svg';">
        <p class="text-white-50 small mb-2">
          <strong>Wheelyx</strong> — Integrated Vehicle Rental and Fleet Management Platform.
        </p>
        <p class="text-white-50 small">
          "Move Your Way." Find, book and manage your perfect ride with ease across 20 major Indian cities.
        </p>
        <div class="d-flex gap-3 mt-3 fs-5">
          <a href="#" class="text-white-50"><i class="bi bi-twitter-x"></i></a>
          <a href="#" class="text-white-50"><i class="bi bi-instagram"></i></a>
          <a href="#" class="text-white-50"><i class="bi bi-linkedin"></i></a>
          <a href="#" class="text-white-50"><i class="bi bi-github"></i></a>
        </div>
      </div>

      <!-- Vehicle Categories -->
      <div class="col-lg-2 col-md-6 col-6">
        <h5>Fleet Categories</h5>
        <ul class="list-unstyled small d-flex flex-column gap-2">
          <li><a href="${pageContext.request.contextPath}/vehicles?categoryId=1">Cars</a></li>
          <li><a href="${pageContext.request.contextPath}/vehicles?categoryId=2">Bikes</a></li>
          <li><a href="${pageContext.request.contextPath}/vehicles?categoryId=3">Petrol Scooters</a></li>
          <li><a href="${pageContext.request.contextPath}/vehicles?categoryId=4">EV Scooters</a></li>
          <li><a href="${pageContext.request.contextPath}/vehicles?categoryId=5">EV Cars</a></li>
          <li><a href="${pageContext.request.contextPath}/vehicles?categoryId=6">Premium Vehicles</a></li>
        </ul>
      </div>

      <!-- Quick Portals -->
      <div class="col-lg-2 col-md-6 col-6">
        <h5>Portals</h5>
        <ul class="list-unstyled small d-flex flex-column gap-2">
          <li><a href="${pageContext.request.contextPath}/auth/login?role=customer">Customer Portal</a></li>
          <li><a href="${pageContext.request.contextPath}/auth/login?role=owner">Vehicle Owner Hub</a></li>
          <li><a href="${pageContext.request.contextPath}/auth/login?role=admin">Admin Command Center</a></li>
          <li><a href="${pageContext.request.contextPath}/vehicles">Search Vehicles</a></li>
          <li><a href="${pageContext.request.contextPath}/home#how-it-works">How It Works</a></li>
        </ul>
      </div>

      <!-- Operational Hubs Highlights -->
      <div class="col-lg-4 col-md-6">
        <h5>Key Operational Hubs</h5>
        <p class="text-white-50 small mb-2">
          Serving 20 Indian cities with verified local pickup landmarks:
        </p>
        <div class="d-flex flex-wrap gap-1">
          <span class="badge bg-secondary opacity-75">Delhi</span>
          <span class="badge bg-secondary opacity-75">Mumbai</span>
          <span class="badge bg-secondary opacity-75">Bengaluru</span>
          <span class="badge bg-secondary opacity-75">Hyderabad</span>
          <span class="badge bg-secondary opacity-75">Chennai</span>
          <span class="badge bg-secondary opacity-75">Kolkata</span>
          <span class="badge bg-secondary opacity-75">Pune</span>
          <span class="badge bg-secondary opacity-75">Ahmedabad</span>
          <span class="badge bg-secondary opacity-75">Jaipur</span>
          <span class="badge bg-secondary opacity-75">Lucknow</span>
          <span class="badge bg-secondary opacity-75">Chandigarh</span>
          <span class="badge bg-secondary opacity-75">+9 More</span>
        </div>
        <div class="mt-3 text-white-50 small">
          <i class="bi bi-shield-check text-success me-1"></i> 100% Parameterized Security • GST Compliant
        </div>
      </div>
    </div>

    <hr class="border-secondary opacity-25 my-4">

    <div class="row align-items-center small text-white-50">
      <div class="col-md-6 text-center text-md-start mb-2 mb-md-0">
        &copy; <%= java.time.Year.now().getValue() %> Wheelyx. All rights reserved. Move Your Way.
      </div>
      <div class="col-md-6 text-center text-md-end">
        <a href="#" class="text-white-50 me-3">Terms of Service</a>
        <a href="#" class="text-white-50 me-3">Privacy Policy</a>
        <a href="#" class="text-white-50">Fleet Rules</a>
      </div>
    </div>
  </div>
</footer>
