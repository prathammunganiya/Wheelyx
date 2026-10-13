<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tax Invoice ${bill.billNo} | Wheelyx</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <style>
    .invoice-card {
      background: var(--surface);
      border: 1px solid var(--border-color);
      border-radius: 12px;
      padding: 2.5rem;
      box-shadow: 0 4px 20px rgba(0,0,0,0.06);
    }
    @media print {
      body {
        background: #ffffff !important;
        color: #000000 !important;
      }
      .no-print, header, footer, .navbar, .btn {
        display: none !important;
      }
      .invoice-card {
        border: none !important;
        box-shadow: none !important;
        padding: 0 !important;
      }
    }
  </style>
</head>
<body>
  <div class="no-print">
    <jsp:include page="/components/navbar.jsp" />
  </div>

  <div class="container-fluid px-3 px-md-4 px-xl-5 py-4 py-md-5">
    <!-- Action buttons for user -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2 no-print">
      <a href="${pageContext.request.contextPath}/customer/bookings" class="btn btn-outline-secondary">
        <i class="bi bi-arrow-left me-1"></i> Back to Bookings
      </a>
      <div class="d-flex gap-2">
        <button onclick="window.print()" class="btn btn-light border">
          <i class="bi bi-printer me-1"></i> Print Invoice
        </button>
        <c:if test="${bill.status ne 'PAID'}">
          <a href="${pageContext.request.contextPath}/billing/payment?billId=${bill.id}" class="btn btn-wx-primary">
            <i class="bi bi-credit-card me-1"></i> Pay Now (₹<fmt:formatNumber value="${bill.finalAmount}" pattern="#,##0"/>)
          </a>
        </c:if>
      </div>
    </div>

    <c:if test="${param.success eq 'paid'}">
      <div class="alert alert-success py-2 small mb-4 no-print alert-auto-dismiss">
        <i class="bi bi-check-circle-fill me-1"></i> Payment processed successfully! Transaction receipt attached below.
      </div>
    </c:if>

    <div class="invoice-card mx-auto" style="max-width: 860px;">
      <!-- Invoice Header -->
      <div class="row align-items-center mb-4 pb-4 border-bottom">
        <div class="col-sm-6 mb-3 mb-sm-0">
          <div class="d-flex align-items-center gap-2 mb-2">
            <img src="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png" 
                 alt="Wheelyx" style="height: 52px; width: auto; object-fit: contain;" class="rounded">
            <div>
              <h1 class="h4 fw-bold mb-0">Wheelyx</h1>
              <div class="text-muted small">Move Your Way.</div>
            </div>
          </div>
          <div class="small text-muted">
            Wheelyx Mobility Solutions Pvt Ltd<br>
            GSTIN: 27AABCT8842Q1Z9<br>
            Fleet Hub: ${booking.pickupPlaceName}, ${booking.cityName}
          </div>
        </div>
        <div class="col-sm-6 text-sm-end">
          <div class="badge ${bill.status eq 'PAID' ? 'bg-success' : 'bg-warning text-dark'} fs-6 px-3 py-2 mb-2">
            ${bill.status eq 'PAID' ? 'TAX INVOICE - PAID' : 'PAYMENT DUE'}
          </div>
          <div class="h5 fw-bold mb-1">Invoice #${bill.billNo}</div>
          <div class="small text-muted">Date: <fmt:formatDate value="${bill.generatedAt}" pattern="dd MMM yyyy, HH:mm"/></div>
          <div class="small text-muted">Booking Ref: <strong class="text-primary">${booking.bookingCode}</strong></div>
        </div>
      </div>

      <!-- Customer & Rental Details -->
      <div class="row mb-4">
        <div class="col-sm-6 mb-3 mb-sm-0">
          <div class="text-uppercase text-muted small fw-bold mb-2">Billed To</div>
          <div class="fw-bold">${booking.customerName}</div>
          <div class="small text-muted">${booking.customerEmail}</div>
          <div class="small text-muted">Contact: ${booking.customerPhone}</div>
        </div>
        <div class="col-sm-6 text-sm-end">
          <div class="text-uppercase text-muted small fw-bold mb-2">Reservation Period</div>
          <div>Pickup: <strong>${booking.startDate}</strong></div>
          <div>Return: <strong>${booking.endDate}</strong></div>
          <div class="text-muted small">Total Duration: <strong>${booking.durationDays} Days</strong></div>
        </div>
      </div>

      <!-- Vehicle Summary -->
      <div class="p-3 rounded bg-light border mb-4">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
          <div class="d-flex align-items-center gap-3">
            <c:if test="${not empty booking.vehicleImage}">
              <img src="${pageContext.request.contextPath}/${booking.vehicleImage}" 
                   alt="${booking.vehicleModel}" 
                   style="width: 60px; height: 42px; object-fit: contain;" 
                   class="rounded bg-white border p-1">
            </c:if>
            <div>
              <div class="fw-bold fs-6">${booking.vehicleModel}</div>
              <div class="small text-muted">Reg No: ${booking.registrationNo} &bull; Hub: ${booking.pickupPlaceName}</div>
            </div>
          </div>
          <div class="text-sm-end">
            <div class="small text-muted">City / Region</div>
            <div class="fw-semibold">${booking.cityName}</div>
          </div>
        </div>
      </div>

      <!-- Line Items Table -->
      <div class="table-responsive mb-4">
        <table class="table align-middle">
          <thead class="table-light">
            <tr>
              <th>Description</th>
              <th class="text-center">Duration / Qty</th>
              <th class="text-end">Amount (₹)</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                <div class="fw-semibold">Self-Drive Rental Tariff</div>
                <div class="small text-muted">Base rate for ${booking.durationDays} day(s)</div>
              </td>
              <td class="text-center">${booking.durationDays} day(s)</td>
              <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.baseAmount}" pattern="#,##0.00"/></td>
            </tr>
            <tr>
              <td>
                <div class="fw-semibold">Refundable Security Deposit</div>
                <div class="small text-muted">Auto-refunded upon inspection & safe vehicle handover</div>
              </td>
              <td class="text-center">1 unit</td>
              <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.depositAmount}" pattern="#,##0.00"/></td>
            </tr>
            <tr>
              <td>
                <div class="fw-semibold">Goods & Services Tax (GST 18%)</div>
                <div class="small text-muted">CGST 9% + SGST 9% on base rental tariff</div>
              </td>
              <td class="text-center">18%</td>
              <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.taxAmount}" pattern="#,##0.00"/></td>
            </tr>
            <c:if test="${bill.discountAmount > 0}">
              <tr class="text-success">
                <td>
                  <div class="fw-semibold">Promotional Privilege Discount</div>
                  <div class="small text-muted">Applied discount coupon</div>
                </td>
                <td class="text-center">-</td>
                <td class="text-end fw-semibold">- ₹<fmt:formatNumber value="${bill.discountAmount}" pattern="#,##0.00"/></td>
              </tr>
            </c:if>
          </tbody>
          <tfoot>
            <tr class="border-top border-dark-subtle">
              <th colspan="2" class="fs-5 text-end">Total Payable / Paid:</th>
              <th class="fs-5 text-end text-primary">₹<fmt:formatNumber value="${bill.finalAmount}" pattern="#,##0.00"/></th>
            </tr>
          </tfoot>
        </table>
      </div>

      <!-- Payment & Rental Terms Notice -->
      <div class="border-top pt-3 small text-muted">
        <div class="row">
          <div class="col-md-8">
            <p class="mb-1"><strong>Terms & Conditions:</strong> Valid driving license and original government ID are mandatory during key handover. Fuel level is returned as received. Security deposit is credited back to the source method within 2-4 working hours post return inspection.</p>
          </div>
          <div class="col-md-4 text-md-end">
            <p class="mb-0">Computer-generated tax invoice.<br>No physical signature required.</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="no-print">
    <jsp:include page="/components/footer.jsp" />
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
