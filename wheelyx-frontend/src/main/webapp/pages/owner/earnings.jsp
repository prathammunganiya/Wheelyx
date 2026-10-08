<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Revenue & Earnings | Wheelyx</title>
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
          <jsp:param name="activeTab" value="earnings"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Fleet Revenue & Financial Analytics</h2>
            <p class="text-muted small mb-0">Track cumulative gross earnings from customer reservations, settled trips, and automated bank payouts.</p>
          </div>
        </div>

        <!-- KPI Cards -->
        <div class="row g-3 mb-4">
          <div class="col-md-4">
            <div class="wx-card p-4">
              <div class="d-flex align-items-center justify-content-between mb-2">
                <span class="text-muted small">Total Realized Revenue</span>
                <span class="badge bg-success-subtle text-success border border-success-subtle">Paid</span>
              </div>
              <div class="h2 fw-bold text-success mb-1">
                ₹<fmt:formatNumber value="${kpis.totalEarnings != null ? kpis.totalEarnings : 0}" pattern="#,##0"/>
              </div>
              <div class="small text-muted">Across all completed customer rental journeys</div>
            </div>
          </div>

          <div class="col-md-4">
            <div class="wx-card p-4">
              <div class="d-flex align-items-center justify-content-between mb-2">
                <span class="text-muted small">Completed & Settled Trips</span>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle">100% Fulfilled</span>
              </div>
              <div class="h2 fw-bold text-primary mb-1">
                ${kpis.completedRentals != null ? kpis.completedRentals : 0}
              </div>
              <div class="small text-muted">Verified trips checked back in successfully</div>
            </div>
          </div>

          <div class="col-md-4">
            <div class="wx-card p-4">
              <div class="d-flex align-items-center justify-content-between mb-2">
                <span class="text-muted small">Active Commercial Fleet</span>
                <span class="badge bg-info-subtle text-info border border-info-subtle">Active</span>
              </div>
              <div class="h2 fw-bold text-dark mb-1">
                ${kpis.totalVehicles != null ? kpis.totalVehicles : 0}
              </div>
              <div class="small text-muted">${kpis.availableVehicles != null ? kpis.availableVehicles : 0} ready for bookings right now</div>
            </div>
          </div>
        </div>

        <!-- Payout Policies & Settlement Details -->
        <div class="wx-card p-4">
          <h5 class="fw-bold mb-3"><i class="bi bi-bank text-primary me-2"></i>Payout & Billing Settlement Structure</h5>
          <div class="row g-4">
            <div class="col-md-6">
              <div class="p-3 bg-light rounded border h-100">
                <div class="fw-bold mb-2"><i class="bi bi-shield-check text-success me-1"></i> Transparent Revenue Model</div>
                <ul class="small text-muted ps-3 mb-0">
                  <li class="mb-1"><strong>Daily Tariff:</strong> 100% of your designated base tariff belongs to you.</li>
                  <li class="mb-1"><strong>Security Deposit:</strong> Held in escrow and refunded directly to the customer after return inspection.</li>
                  <li class="mb-1"><strong>GST Taxation:</strong> 18% GST is handled by the platform invoice engine and remitted systematically.</li>
                  <li><strong>Payout Schedule:</strong> Direct NEFT/IMPS bank transfer dispatched within 24 hours of trip check-in.</li>
                </ul>
              </div>
            </div>

            <div class="col-md-6">
              <div class="p-3 bg-light rounded border h-100">
                <div class="fw-bold mb-2"><i class="bi bi-wallet2 text-primary me-1"></i> Bank Payout Account</div>
                <div class="small text-muted mb-2">Settlement Account linked to your verified Wheelyx Fleet Owner profile:</div>
                <div class="p-2 bg-white rounded border small font-monospace mb-2">
                  <div><strong>Beneficiary:</strong> ${sessionScope.userName}</div>
                  <div><strong>Account:</strong> &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; 8821 (HDFC Bank)</div>
                  <div><strong>IFSC Code:</strong> HDFC0001245</div>
                </div>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-sm btn-outline-secondary">
                  <i class="bi bi-pencil me-1"></i> Update Banking Details in Profile
                </a>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
