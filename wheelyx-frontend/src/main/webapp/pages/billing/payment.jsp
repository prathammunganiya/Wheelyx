<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Complete Payment | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-7 col-md-9">
        <div class="wx-card p-4 p-md-5">
          <div class="text-center mb-4">
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle mb-2 px-3 py-2">
              <i class="bi bi-shield-lock-fill me-1"></i> 256-Bit SSL Encrypted Checkout
            </span>
            <h2 class="h3 fw-bold mb-1">Payment Gateway Simulation</h2>
            <p class="text-muted small">Choose your preferred payment method to finalize reservation billing.</p>
          </div>

          <c:if test="${param.error eq 'failed'}">
            <div class="alert alert-danger py-2 small mb-4">
              <i class="bi bi-exclamation-octagon-fill me-1"></i> Payment transaction could not be processed. Please retry or choose an alternative method.
            </div>
          </c:if>

          <!-- Bill Summary Card -->
          <div class="p-3 rounded bg-light border mb-4">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <span class="text-muted small">Invoice Number</span>
              <span class="fw-bold font-monospace">${bill.billNo}</span>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-2">
              <span class="text-muted small">Rental Base & Security Deposit</span>
              <span>₹<fmt:formatNumber value="${bill.baseAmount + bill.depositAmount}" pattern="#,##0"/></span>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-2">
              <span class="text-muted small">GST (18%)</span>
              <span>₹<fmt:formatNumber value="${bill.taxAmount}" pattern="#,##0"/></span>
            </div>
            <div class="d-flex justify-content-between align-items-center border-top pt-2 mt-2">
              <span class="fw-bold">Total Amount Due</span>
              <span class="fs-4 fw-bold text-primary">₹<fmt:formatNumber value="${bill.finalAmount}" pattern="#,##0"/></span>
            </div>
          </div>

          <form action="${pageContext.request.contextPath}/billing/payment" method="POST" id="paymentForm">
            <input type="hidden" name="billId" value="${bill.id}">

            <h5 class="fw-bold mb-3">Select Payment Method</h5>

            <!-- Tabs / Radio for Methods -->
            <div class="list-group mb-4">
              <label class="list-group-item d-flex gap-3 align-items-center p-3 cursor-pointer">
                <input class="form-check-input flex-shrink-0" type="radio" name="paymentMethod" value="UPI" checked onchange="toggleMethodFields('upi')">
                <div class="flex-grow-1">
                  <div class="fw-bold"><i class="bi bi-qr-code-scan text-primary me-2"></i>UPI (Google Pay, PhonePe, Paytm, BHIM)</div>
                  <div class="small text-muted">Instant transfer via Virtual Payment Address or QR</div>
                </div>
              </label>

              <label class="list-group-item d-flex gap-3 align-items-center p-3 cursor-pointer">
                <input class="form-check-input flex-shrink-0" type="radio" name="paymentMethod" value="Card" onchange="toggleMethodFields('card')">
                <div class="flex-grow-1">
                  <div class="fw-bold"><i class="bi bi-credit-card-2-front text-primary me-2"></i>Credit / Debit Card</div>
                  <div class="small text-muted">Visa, Mastercard, RuPay, Maestro</div>
                </div>
              </label>

              <label class="list-group-item d-flex gap-3 align-items-center p-3 cursor-pointer">
                <input class="form-check-input flex-shrink-0" type="radio" name="paymentMethod" value="Net Banking" onchange="toggleMethodFields('netbanking')">
                <div class="flex-grow-1">
                  <div class="fw-bold"><i class="bi bi-bank text-primary me-2"></i>Net Banking</div>
                  <div class="small text-muted">HDFC, ICICI, SBI, Axis, Kotak & 50+ Indian banks</div>
                </div>
              </label>

              <label class="list-group-item d-flex gap-3 align-items-center p-3 cursor-pointer">
                <input class="form-check-input flex-shrink-0" type="radio" name="paymentMethod" value="Cash" onchange="toggleMethodFields('cash')">
                <div class="flex-grow-1">
                  <div class="fw-bold"><i class="bi bi-cash-stack text-success me-2"></i>Pay on Vehicle Handover (Cash/POS)</div>
                  <div class="small text-muted">Settle payment in person during key collection at hub</div>
                </div>
              </label>
            </div>

            <!-- Dynamic Sub-forms for simulated inputs -->
            <div id="upiFields" class="mb-4 p-3 rounded bg-light border">
              <label class="form-label fw-semibold">Enter UPI ID (VPA)</label>
              <input type="text" class="form-control" placeholder="e.g. yourname@okhdfcbank or 9876543210@paytm">
              <div class="form-text">A simulation request will be confirmed immediately.</div>
            </div>

            <div id="cardFields" class="mb-4 p-3 rounded bg-light border d-none">
              <div class="mb-3">
                <label class="form-label fw-semibold">Card Number</label>
                <input type="text" class="form-control font-monospace" placeholder="4111 2222 3333 4444" maxlength="19">
              </div>
              <div class="row g-2">
                <div class="col-6">
                  <label class="form-label fw-semibold">Expiry Date</label>
                  <input type="text" class="form-control" placeholder="MM/YY" maxlength="5">
                </div>
                <div class="col-6">
                  <label class="form-label fw-semibold">CVV / CVC</label>
                  <input type="password" class="form-control" placeholder="&bull;&bull;&bull;" maxlength="4">
                </div>
              </div>
            </div>

            <div id="netbankingFields" class="mb-4 p-3 rounded bg-light border d-none">
              <label class="form-label fw-semibold">Select Bank</label>
              <select class="form-select">
                <option value="HDFC">HDFC Bank</option>
                <option value="SBI">State Bank of India</option>
                <option value="ICICI">ICICI Bank</option>
                <option value="AXIS">Axis Bank</option>
                <option value="KOTAK">Kotak Mahindra Bank</option>
              </select>
            </div>

            <div id="cashFields" class="mb-4 p-3 rounded bg-light border d-none">
              <p class="small text-muted mb-0"><i class="bi bi-info-circle me-1"></i> You will pay ₹<fmt:formatNumber value="${bill.finalAmount}" pattern="#,##0"/> directly at the hub counter before handover inspection.</p>
            </div>

            <!-- Actions: Edit/Cancel and Submit Payment -->
            <div class="d-flex justify-content-between align-items-center pt-3 border-top gap-2">
              <a href="${pageContext.request.contextPath}/customer/bookings" class="btn btn-outline-secondary px-4">
                <i class="bi bi-x-circle me-1"></i> Cancel & Return
              </a>
              <button type="submit" class="btn btn-wx-primary px-4 py-2">
                <i class="bi bi-lock-fill me-1"></i> Authorize & Pay ₹<fmt:formatNumber value="${bill.finalAmount}" pattern="#,##0"/>
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
  <script>
    function toggleMethodFields(method) {
      document.getElementById('upiFields').classList.toggle('d-none', method !== 'upi');
      document.getElementById('cardFields').classList.toggle('d-none', method !== 'card');
      document.getElementById('netbankingFields').classList.toggle('d-none', method !== 'netbanking');
      document.getElementById('cashFields').classList.toggle('d-none', method !== 'cash');
    }
  </script>
</body>
</html>
