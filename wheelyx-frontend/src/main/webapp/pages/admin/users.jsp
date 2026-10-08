<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage User Accounts | Wheelyx Admin</title>
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
          <jsp:param name="activeTab" value="users"/>
        </jsp:include>
      </div>

      <!-- Main Content -->
      <main class="col-lg-10 col-md-9 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
          <div>
            <h2 class="h3 fw-bold mb-1">User Account Directory</h2>
            <p class="text-muted small mb-0">Manage customer profiles, vehicle owners, role authorizations, and account status.</p>
          </div>
          <div class="badge bg-primary fs-6 px-3 py-2">
            Total Accounts: ${totalCount}
          </div>
        </div>

        <c:if test="${param.success eq 'updated'}">
          <div class="alert alert-success py-2 small mb-3 alert-auto-dismiss">
            <i class="bi bi-check-circle-fill me-1"></i> Account status updated successfully. Security audit record created.
          </div>
        </c:if>

        <!-- Filters Form -->
        <div class="wx-card p-3 mb-4">
          <form action="${pageContext.request.contextPath}/admin/users" method="GET" class="row g-2 align-items-center">
            <div class="col-md-4">
              <label class="form-label small fw-semibold mb-1">Filter by Role</label>
              <select name="role" class="form-select form-select-sm" onchange="this.form.submit()">
                <option value="">All Roles (Customers & Owners)</option>
                <option value="CUSTOMER" ${roleFilter eq 'CUSTOMER' ? 'selected' : ''}>Customers Only</option>
                <option value="OWNER" ${roleFilter eq 'OWNER' ? 'selected' : ''}>Vehicle Owners Only</option>
                <option value="ADMIN" ${roleFilter eq 'ADMIN' ? 'selected' : ''}>Administrators</option>
              </select>
            </div>

            <div class="col-md-4">
              <label class="form-label small fw-semibold mb-1">Filter by Account Status</label>
              <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                <option value="">All Statuses</option>
                <option value="ACTIVE" ${statusFilter eq 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                <option value="SUSPENDED" ${statusFilter eq 'SUSPENDED' ? 'selected' : ''}>SUSPENDED</option>
                <option value="PENDING_VERIFICATION" ${statusFilter eq 'PENDING_VERIFICATION' ? 'selected' : ''}>PENDING VERIFICATION</option>
              </select>
            </div>

            <div class="col-md-4 d-flex align-items-end">
              <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-secondary w-100">
                <i class="bi bi-arrow-counterclockwise me-1"></i> Reset Filters
              </a>
            </div>
          </form>
        </div>

        <!-- Users Table -->
        <div class="wx-card p-4">
          <div class="table-responsive">
            <table class="wx-table">
              <thead>
                <tr>
                  <th>Account User</th>
                  <th>Contact Details</th>
                  <th>Role</th>
                  <th>Status</th>
                  <th>Registered Date</th>
                  <th class="text-end">Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="u" items="${users}">
                  <tr>
                    <td>
                      <div class="d-flex align-items-center gap-2">
                        <div class="rounded-circle ${u.role eq 'ADMIN' ? 'bg-danger' : (u.role eq 'OWNER' ? 'bg-success' : 'bg-primary')} text-white d-flex align-items-center justify-content-center" 
                             style="width: 36px; height: 36px; font-weight: bold;">
                          ${u.fullName.substring(0, 1).toUpperCase()}
                        </div>
                        <div>
                          <div class="fw-semibold">${u.fullName}</div>
                          <div class="small text-muted">ID: #${u.id}</div>
                        </div>
                      </div>
                    </td>
                    <td class="small">
                      <div>${u.email}</div>
                      <div class="text-muted"><i class="bi bi-telephone me-1"></i>${u.phone}</div>
                    </td>
                    <td>
                      <span class="badge ${u.role eq 'ADMIN' ? 'bg-danger' : (u.role eq 'OWNER' ? 'bg-success' : 'bg-primary')}">
                        ${u.role}
                      </span>
                    </td>
                    <td>
                      <span class="badge ${u.status eq 'ACTIVE' ? 'bg-success' : 'bg-warning text-dark'}">
                        ${u.status}
                      </span>
                    </td>
                    <td class="small text-muted">
                      <fmt:formatDate value="${u.createdAt}" pattern="dd MMM yyyy"/>
                    </td>
                    <td class="text-end">
                      <c:if test="${u.role ne 'ADMIN'}">
                        <form action="${pageContext.request.contextPath}/admin/users" method="POST" class="d-inline"
                              onsubmit="return confirm('Change status for user ${u.fullName}?');">
                          <input type="hidden" name="action" value="toggleStatus">
                          <input type="hidden" name="userId" value="${u.id}">
                          <input type="hidden" name="status" value="${u.status eq 'ACTIVE' ? 'SUSPENDED' : 'ACTIVE'}">
                          <button type="submit" class="btn btn-sm btn-light border ${u.status eq 'ACTIVE' ? 'text-warning' : 'text-success'}" 
                                  title="${u.status eq 'ACTIVE' ? 'Suspend Account' : 'Reactivate Account'}">
                            <i class="bi ${u.status eq 'ACTIVE' ? 'bi-slash-circle' : 'bi-check-circle'}"></i> 
                            ${u.status eq 'ACTIVE' ? 'Suspend' : 'Activate'}
                          </button>
                        </form>
                      </c:if>
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
