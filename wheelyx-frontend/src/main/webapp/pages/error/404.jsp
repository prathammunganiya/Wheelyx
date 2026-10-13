<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>404 — Page Not Found | Wheelyx</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body class="d-flex flex-column min-vh-100">
  <jsp:include page="/components/navbar.jsp" />

  <main class="container-fluid px-3 px-md-4 px-xl-5 my-auto py-5 text-center">
    <div class="row justify-content-center">
      <div class="col-md-7 col-lg-5">
        <div class="display-1 fw-bold text-primary mb-3">404</div>
        <h2 class="mb-3">Route Not Found</h2>
        <p class="text-muted mb-4">
          The vehicle or destination you requested does not exist or may have been relocated.
        </p>
        <div class="d-flex justify-content-center gap-3">
          <a href="${pageContext.request.contextPath}/home" class="btn btn-wx-primary">
            <i class="bi bi-house me-1"></i> Return Home
          </a>
          <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-wx-secondary">
            <i class="bi bi-car-front me-1"></i> Browse Fleet
          </a>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="/components/footer.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
</html>
