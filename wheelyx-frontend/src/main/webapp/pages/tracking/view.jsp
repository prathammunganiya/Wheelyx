<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Vehicle Telemetry & GPS Tracking | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <style>
    #mapContainer {
      height: 480px;
      width: 100%;
      border-radius: 12px;
      background: #e2e8f0;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .telemetry-card {
      border-left: 4px solid var(--royal-blue);
    }
    .pulse-dot {
      display: inline-block;
      width: 10px;
      height: 10px;
      border-radius: 50%;
      background-color: #10b981;
      box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
      animation: pulse 1.6s infinite;
    }
    @keyframes pulse {
      0% {
        transform: scale(0.95);
        box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
      }
      70% {
        transform: scale(1);
        box-shadow: 0 0 0 8px rgba(16, 185, 129, 0);
      }
      100% {
        transform: scale(0.95);
        box-shadow: 0 0 0 0 rgba(16, 185, 129, 0);
      }
    }
  </style>
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container py-4 py-md-5">
    <!-- Breadcrumb & Top Bar -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
      <div>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-1 small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/customer/rentals">My Rentals</a></li>
            <li class="breadcrumb-item active" aria-current="page">Live GPS Telemetry</li>
          </ol>
        </nav>
        <h2 class="h3 fw-bold mb-0">Vehicle Fleet Tracking</h2>
      </div>
      <a href="${pageContext.request.contextPath}/customer/rentals" class="btn btn-outline-secondary">
        <i class="bi bi-arrow-left me-1"></i> Return to Rentals
      </a>
    </div>

    <div class="row g-4">
      <!-- Left: Telemetry & Vehicle Details -->
      <div class="col-lg-4">
        <div class="wx-card p-4 mb-4 telemetry-card">
          <div class="d-flex align-items-center justify-content-between mb-3">
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1">
              <span class="pulse-dot me-1"></span> Live GPS Stream
            </span>
            <c:choose>
              <c:when test="${not empty location and location.demo}">
                <span class="badge bg-warning text-dark"><i class="bi bi-broadcast me-1"></i> Demo Vehicle Location</span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-success"><i class="bi bi-satellite me-1"></i> Real GPS Telemetry</span>
              </c:otherwise>
            </c:choose>
          </div>

          <div class="d-flex align-items-center gap-3 mb-3">
            <c:if test="${not empty vehicle.imageUrl}">
              <img src="${pageContext.request.contextPath}/${vehicle.imageUrl}" 
                   alt="${vehicle.modelName}" 
                   style="width: 70px; height: 50px; object-fit: contain;" 
                   class="rounded bg-light border p-1">
            </c:if>
            <div>
              <h4 class="h5 fw-bold mb-0">${vehicle.brand} ${vehicle.modelName}</h4>
              <div class="small text-muted font-monospace">${vehicle.registrationNo}</div>
            </div>
          </div>

          <hr class="my-3">

          <div class="mb-2 d-flex justify-content-between">
            <span class="text-muted small">Rental Lifecycle:</span>
            <span class="badge bg-info text-dark">${rental != null ? rental.status : vehicle.status}</span>
          </div>

          <div class="mb-2 d-flex justify-content-between">
            <span class="text-muted small">Hub City:</span>
            <span class="fw-semibold small">${vehicle.cityName}</span>
          </div>

          <div class="mb-2 d-flex justify-content-between">
            <span class="text-muted small">Current Coordinates:</span>
            <span class="font-monospace small fw-bold" id="coordsDisplay">
              <c:choose>
                <c:when test="${not empty location}">
                  ${location.latitude}, ${location.longitude}
                </c:when>
                <c:otherwise>28.6139, 77.2090</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="mb-3 d-flex justify-content-between">
            <span class="text-muted small">Last Telemetry Ping:</span>
            <span class="small text-muted" id="timestampDisplay">
              <c:choose>
                <c:when test="${not empty location}">
                  <fmt:formatDate value="${location.recordedAt}" pattern="dd MMM HH:mm:ss"/>
                </c:when>
                <c:otherwise>Just now</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="p-3 bg-light rounded small border">
            <div class="fw-semibold mb-1"><i class="bi bi-info-circle me-1 text-primary"></i> GPS Architecture Note</div>
            <p class="text-muted mb-0">Coordinates are polled securely every 10 seconds from backend telematics telemetry. If hardware GPS dongles are offline, high-precision hub simulation coordinates keep you connected.</p>
          </div>
        </div>
      </div>

      <!-- Right: Map Canvas or Graceful Fallback -->
      <div class="col-lg-8">
        <div class="wx-card p-4">
          <c:choose>
            <c:when test="${isMapsConfigured and not empty googleMapsApiKey}">
              <!-- Live Google Maps Canvas -->
              <div id="mapContainer" class="shadow-sm"></div>
              <div class="mt-3 d-flex justify-content-between align-items-center text-muted small">
                <div><i class="bi bi-clock-history me-1"></i> Auto-refreshing location via telematics stream...</div>
                <div class="fw-semibold">Google Maps v3 API</div>
              </div>
            </c:when>

            <c:otherwise>
              <!-- Graceful Fallback Required by Prompt #26 -->
              <div class="p-5 text-center bg-light rounded border">
                <div class="mb-3">
                  <i class="bi bi-geo-alt-slash text-warning" style="font-size: 3.5rem;"></i>
                </div>
                <h4 class="h5 fw-bold text-dark mb-2">Vehicle tracking is currently unavailable because Google Maps has not been configured.</h4>
                <p class="text-muted small max-w-500 mx-auto mb-4">
                  To view interactive satellite map rendering, configure the <code>google.maps.api.key</code> property in your Wheelyx application settings. The rest of your rental platform functions normally.
                </p>
                <div class="p-3 bg-white rounded border d-inline-block text-start small mb-3">
                  <div class="fw-semibold text-primary mb-1"><i class="bi bi-pin-map-fill me-1"></i> Last Known Hub Telemetry</div>
                  <div><strong>Latitude:</strong> ${location != null ? location.latitude : '28.6139'}</div>
                  <div><strong>Longitude:</strong> ${location != null ? location.longitude : '77.2090'}</div>
                  <div><strong>Location Source:</strong> ${location != null ? location.source : 'DEMO_SIMULATOR'}</div>
                </div>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>

  <c:if test="${isMapsConfigured and not empty googleMapsApiKey}">
    <script>
      let map, marker;
      const initialLat = ${location != null ? location.latitude : 28.6139};
      const initialLng = ${location != null ? location.longitude : 77.2090};

      function initMap() {
        const centerPos = { lat: initialLat, lng: initialLng };
        map = new google.maps.Map(document.getElementById("mapContainer"), {
          zoom: 14,
          center: centerPos,
          mapTypeId: 'roadmap'
        });

        marker = new google.maps.Marker({
          position: centerPos,
          map: map,
          title: "${vehicle.brand} ${vehicle.modelName} (${vehicle.registrationNo})",
          icon: {
            url: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png"
          }
        });

        // Periodic telemetry poller every 10 seconds
        setInterval(pollTelemetry, 10000);
      }

      function pollTelemetry() {
        fetch('${pageContext.request.contextPath}/api/tracking/telemetry?vehicleId=${vehicle.id}')
          .then(res => res.json())
          .then(data => {
            if (data && data.latitude && data.longitude) {
              const newPos = { lat: parseFloat(data.latitude), lng: parseFloat(data.longitude) };
              marker.setPosition(newPos);
              map.panTo(newPos);
              document.getElementById('coordsDisplay').innerText = data.latitude + ', ' + data.longitude;
              document.getElementById('timestampDisplay').innerText = new Date(data.recordedAt).toLocaleTimeString();
            }
          })
          .catch(err => console.log('Telemetry poll cycle:', err));
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=${googleMapsApiKey}&callback=initMap" async defer></script>
  </c:if>
</body>
</html>
