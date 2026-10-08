<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Billing & Invoices | Wheelyx Admin</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo/wheelyx-logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
  <jsp:include page="/components/navbar.jsp" />

  <div class="container-fluid">
    <div class="row">
      <!-- Admin Sidebar -->
      <div class="col-lg-2 col-md-3 p-0 d-none d-md-block">
        <jsp:include page="/components/sidebar-admin.jsp">
          <jsp:param name="activeTab" value="bills"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Financial Invoices & Billing Records</h2>
            <p class="text-muted small mb-0">Overview of all customer invoices, GST tax breakdowns, deposits, and payment statuses.</p>
          </div>
          <span class="badge bg-success fs-6 px-3 py-2">
            ${bills.size()} Invoices Total
          </span>
        </div>

        <div class="wx-card p-4">
          <div class="table-responsive">
            <table class="wx-table">
              <thead>
                <tr>
                  <th>Invoice Number</th>
                  <th>Booking ID</th>
                  <th>Base Rental</th>
                  <th>Security Deposit</th>
                  <th>GST (18%)</th>
                  <th>Discount</th>
                  <th>Final Amount</th>
                  <th>Payment Status</th>
                  <th>Generated Date</th>
                  <th class="text-end">Invoice Action</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="bill" items="${bills}">
                  <tr>
                    <td>
                      <span class="font-monospace fw-bold text-primary">${bill.billNo}</span>
                    </td>
                    <td>
                      <span class="small font-monospace">#${bill.bookingId}</span>
                    </td>
                    <td class="small">₹<fmt:formatNumber value="${bill.baseAmount}" pattern="#,##0"/></td>
                    <td class="small text-muted">₹<fmt:formatNumber value="${bill.depositAmount}" pattern="#,##0"/></td>
                    <td class="small text-muted">₹<fmt:formatNumber value="${bill.taxAmount}" pattern="#,##0"/></td>
                    <td class="small text-success">
                      <c:choose>
                        <c:when test="${bill.discountAmount > 0}">
                          -₹<fmt:formatNumber value="${bill.discountAmount}" pattern="#,##0"/>
                        </c:when>
                        <c:otherwise>₹0</c:otherwise>
                      </c:choose>
                    </td>
                    <td class="fw-bold text-primary">₹<fmt:formatNumber value="${bill.finalAmount}" pattern="#,##0"/></td>
                    <td>
                      <span class="badge ${bill.status eq 'PAID' ? 'bg-success' : 'bg-warning text-dark'}">
                        ${bill.status}
                      </span>
                    </td>
                    <td class="small text-muted">
                      <fmt:formatDate value="${bill.generatedAt}" pattern="dd MMM yyyy, HH:mm"/>
                    </td>
                    <td class="text-end">
                      <a href="${pageContext.request.contextPath}/billing/invoice?billNo=${bill.billNo}" class="btn btn-sm btn-light border" title="View & Print Tax Invoice">
                        <i class="bi bi-printer me-1"></i> View
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
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
