# Component 05: Implementation & Code Quality

## 1. Technical Implementation Standards
The Wheelyx codebase is constructed according to enterprise Java best practices, emphasizing modularity, separation of concerns, thread safety, and maintainability.

### Architecture Layering
1. **Controllers (`com.wheelyx.controller`):** 38 lightweight Jakarta Servlets handling HTTP request parsing, session verification, input sanitization, service delegation, and JSP view dispatching.
2. **Services (`com.wheelyx.service`):** Domain logic layer handling business validations, quotation algorithms, concurrency checks, status state machines, and notification dispatching.
3. **Data Access Objects (`com.wheelyx.dao`):** 15 DAOs encapsulating database interactions via JDBC. Strictly utilizes parameterized `PreparedStatement` queries to prevent SQL injection.
4. **Domain Models (`com.wheelyx.model`):** Plain Old Java Objects (POJOs) with encapsulation, typed fields, and getters/setters.
5. **Utilities (`com.wheelyx.util`):** Centralized helpers for BCrypt hashing (`PasswordUtil`), regex validation (`ValidationUtil`), CSRF & XSS protection (`SecurityUtil`), and JSON serialization (`JsonUtil`).
6. **Configuration (`com.wheelyx.config`):** Dynamic environment variable fallback (`AppConfig`) and connection pooling (`DBConnection`).

---

## 2. Code Quality & Security Highlights

### 100% Parameterized Queries (Zero SQL Injection)
All database calls avoid dynamic SQL string concatenation:
```java
String sql = "SELECT * FROM vehicles WHERE city_id = ? AND category_id = ? AND status = ?";
try (Connection conn = DBConnection.getConnection();
     PreparedStatement stmt = conn.prepareStatement(sql)) {
    stmt.setInt(1, cityId);
    stmt.setInt(2, categoryId);
    stmt.setString(3, "AVAILABLE");
    // Execution...
}
```

### Cryptographic Security
- **BCrypt Hashing:** Passwords hashed with 12 rounds of salt (`BCrypt.hashpw(plainText, BCrypt.gensalt(12))`).
- **CSRF Tokens:** Generated via `SecureRandom` and validated on all sensitive POST operations.
- **XSS HTML Sanitization:** User strings passed through `SecurityUtil.sanitizeHtml()` before storage or rendering.

### Connection Management
- **HikariCP Pool:** Configured with minimum 5 idle connections, maximum 20 connections, and a 30-second connection timeout.
- Graceful direct-connection fallback ensures high availability in resource-constrained environments.

---

## 3. Modular Code Statistics
- **Java Backend Classes:** 85+ classes (Controllers, Services, DAOs, Models, Filters, Utilities).
- **JSP Views & Fragments:** 30+ JSP pages structured by role (`pages/customer`, `pages/owner`, `pages/admin`).
- **Relational Tables:** 17 normalized MySQL tables with foreign key constraints and cascade rules.
- **Git Strategy:** 5 modular feature branches merged systematically into `main`.
