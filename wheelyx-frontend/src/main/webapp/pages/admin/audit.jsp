<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Security Audit Trail | Wheelyx Admin</title>
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
          <jsp:param name="activeTab" value="audit"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">Platform Security Audit Log</h2>
            <p class="text-muted small mb-0">Immutable records of authentication events, fleet updates, reservations, payments, and admin operations.</p>
          </div>
          <span class="badge bg-secondary fs-6 px-3 py-2">
            ${totalCount} Recorded Events
          </span>
        </div>

        <div class="wx-card p-4">
          <div class="table-responsive">
            <table class="wx-table table-sm">
              <thead>
                <tr>
                  <th>Timestamp</th>
                  <th>Action Event</th>
                  <th>Actor Role</th>
                  <th>Target Entity</th>
                  <th>Audit Description</th>
                  <th>Origin IP</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="log" items="${logs}">
                  <tr>
                    <td class="small text-muted font-monospace text-nowrap">
                      <fmt:formatDate value="${log.createdAt}" pattern="dd MMM yyyy, HH:mm:ss"/>
                    </td>
                    <td>
                      <span class="badge bg-primary-subtle text-primary border border-primary-subtle">
                        ${log.action}
                      </span>
                    </td>
                    <td>
                      <span class="badge ${log.role eq 'ADMIN' ? 'bg-danger' : (log.role eq 'OWNER' ? 'bg-success' : (log.role eq 'CUSTOMER' ? 'bg-primary' : 'bg-secondary'))}">
                        ${log.role}
                      </span>
                    </td>
                    <td class="small font-monospace">
                      <c:if test="${not empty log.entityType}">
                        ${log.entityType} #${log.entityId}
                      </c:if>
                    </td>
                    <td class="small">${log.description}</td>
                    <td class="small text-muted font-monospace">${log.ipAddress}</td>
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
