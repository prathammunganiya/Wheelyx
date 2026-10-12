# Weekly Progress Report — Week 5

## 1. Metadata
- **Week Number:** Week 5
- **Date Interval:** 03 August 2026 – 09 August 2026
- **Milestone:** Module Coding Phase 1: Authentication, RBAC & User Management
- **Primary Component:** [05-implementation](../../05-implementation/README.md)
- **Status:** `Completed`

---

## 2. Executive Summary
Week 5 marked the commencement of hands-on module coding. The development team established the core backend infrastructure: dynamic configuration management (`AppConfig`), high-performance connection pooling (`DBConnection` via HikariCP), input sanitization, and the complete authentication and role security subsystem.

---

## 3. Key Activities & Work Completed
1. **Infrastructure & Connection Pooling:**
   - Implemented `AppConfig.java` to support external environment variables with properties file fallback.
   - Built `DBConnection.java` utilizing HikariCP with connection validation and graceful direct-connection fallback.
2. **Security & Cryptography Utilities:**
   - Implemented `PasswordUtil.java` using jBCrypt (12 rounds) for salted password hashing and verification.
   - Implemented `SecurityUtil.java` for CSRF token generation/validation and HTML entity escaping.
   - Implemented `ValidationUtil.java` for email, phone, and registration number regex validation.
3. **Data Access Layer for Identity:**
   - Implemented `UserDAO.java` and `VehicleOwnerDAO.java` for user lookup, registration, profile updates, and status modifications using parameterized SQL.
4. **Authentication Controllers & Filters:**
   - Developed `LoginServlet.java`, `RegisterServlet.java`, `LogoutServlet.java`, and `ProfileServlet.java`.
   - Engineered Jakarta EE route interceptor filters:
     - `CustomerAuthFilter.java` guarding `/customer/*` and `/booking/*`
     - `OwnerAuthFilter.java` guarding `/owner/*`
     - `AdminAuthFilter.java` guarding `/admin/*`
     - `CharsetEncodingFilter.java` enforcing UTF-8 character encoding across all requests.
5. **Frontend Integration:**
   - Built responsive JSP login, register, and profile views with Bootstrap 5 client-side validation.

---

## 4. Deliverables & Artifacts Generated
- `com.wheelyx.config` package (`AppConfig`, `DBConnection`).
- `com.wheelyx.util` package (`PasswordUtil`, `SecurityUtil`, `ValidationUtil`).
- `com.wheelyx.filter` package (`CustomerAuthFilter`, `OwnerAuthFilter`, `AdminAuthFilter`).
- `com.wheelyx.controller` authentication servlets and matching JSP pages in `pages/auth/`.

---

## 5. Review & Guide Feedback
- **Feedback:** Guide reviewed the security filters and verified that attempting to access `/admin/dashboard` or `/owner/vehicles` without appropriate credentials triggers an immediate HTTP 302 redirect to `/login`.
- **Action Item for Week 6:** Implement the Vehicle Catalog, search filtering, and AJAX landmark retrieval.
