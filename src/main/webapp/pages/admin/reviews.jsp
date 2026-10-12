<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer Feedback & Reviews | Wheelyx Admin</title>
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
          <jsp:param name="activeTab" value="reviews"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Customer Reviews & Feedback Moderation</h2>
            <p class="text-muted small mb-0">Live MySQL-stored reviews submitted by verified customers following completed vehicle returns.</p>
          </div>
          <span class="badge bg-warning text-dark fs-6 px-3 py-2">
            ${reviews.size()} Verified Reviews
          </span>
        </div>

        <div class="wx-card p-4">
          <c:choose>
            <c:when test="${not empty reviews}">
              <div class="table-responsive">
                <table class="wx-table">
                  <thead>
                    <tr>
                      <th>Rating</th>
                      <th>Feedback Comment</th>
                      <th>Customer</th>
                      <th>Vehicle</th>
                      <th>Submitted Date</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="rev" items="${reviews}">
                      <tr>
                        <td>
                          <div class="text-warning">
                            <c:forEach begin="1" end="${rev.rating}">
                              <i class="bi bi-star-fill"></i>
                            </c:forEach>
                            <c:forEach begin="${rev.rating + 1}" end="5">
                              <i class="bi bi-star text-muted"></i>
                            </c:forEach>
                          </div>
                          <div class="small fw-bold text-muted">${rev.rating} / 5.0</div>
                        </td>
                        <td>
                          <div class="fw-semibold">&ldquo;${rev.comment}&rdquo;</div>
                        </td>
                        <td class="small">
                          <div class="fw-bold">${rev.customerName}</div>
                        </td>
                        <td class="small">
                          <div class="fw-bold text-primary">${rev.vehicleModel}</div>
                        </td>
                        <td class="small text-muted">
                          <fmt:formatDate value="${rev.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                        </td>
                        <td>
                          <span class="badge ${rev.approved ? 'bg-success' : 'bg-secondary'}">
                            ${rev.approved ? 'VISIBLE' : 'PENDING'}
                          </span>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>

            <c:otherwise>
              <!-- Genuine Empty State required by Prompt #13 & #32 -->
              <div class="empty-state-box py-5">
                <i class="bi bi-chat-square-quote text-muted fs-1 mb-2"></i>
                <h4 class="fw-bold mb-1">No customer feedback yet.</h4>
                <p class="text-muted mb-0">Be the first to share your experience. Genuine customer feedback is published once customers complete and return their self-drive trips.</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </main>
    </div>
  </div>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
