# Component 08: Live Demonstration & Individual Viva Guide

## 1. Demonstration Script (Step-by-Step Flow)

### Phase 1: Customer Journey
1. **Search & Filter:** Navigate to `/vehicles`, filter by City: *Jaipur*, Category: *Cars*, Fuel: *Petrol*. Observe dynamic pickup hub loading via `/api/places`.
2. **Booking & Quotation:** Select *Maruti Swift* at *Hawa Mahal*. Choose a 7-day reservation interval. Verify automatic 10% multi-day discount, 18% GST calculation, and refundable security deposit.
3. **Simulated Payment:** Complete checkout via UPI simulation. View the generated tax invoice (`WX-INV-XXXXXXXX`).
4. **Live Telemetry:** Open `/tracking` to view vehicle location on the interactive radar telemetry screen.

### Phase 2: Vehicle Owner Journey
1. **Login:** Authenticate as `owner@wheelyx.com` (`Owner@123`).
2. **Review Bookings:** Open `/owner/bookings` to inspect the pending booking.
3. **Dispatch Handover:** Execute key handover by entering starting odometer (e.g., `45,200 km`), fuel level (`Full`), and condition notes. Observe status change to `ACTIVE_RENTAL`.
4. **Return Inspection:** Open `/owner/rentals` and process the return by recording ending odometer (e.g., `45,850 km`). Observe vehicle status returning to `AVAILABLE`.

### Phase 3: Verified Review Submission
1. **Customer Review:** Customer logs back in, visits `/customer/rentals`, clicks *Write Review*, gives 5 stars with comments. Verify review appears immediately on the homepage and vehicle detail page.

### Phase 4: Administrator Command Center
1. **Admin Login:** Authenticate as `admin@wheelyx.com` (`Admin@123`).
2. **Maintenance Grounding:** Schedule vehicle servicing for an active car. Verify its status updates to `MAINTENANCE` and disappears from public search results.
3. **Visual BI Analytics:** View Chart.js analytics at `/admin/reports` (fleet per city, category share).
4. **Security Audit Log:** View `/admin/audit` to demonstrate that every action (login, booking, dispatch, return) was logged with timestamp and IP address.

---

## 2. Frequently Asked Viva Questions & Answers

### Q1: Why did you choose Jakarta Servlets & JDBC over Spring Boot?
**Answer:** The project was engineered to demonstrate a deep, low-level mastery of enterprise Java fundamentals, HTTP protocol mechanics, session lifecycle management, raw thread-safe connection pooling (HikariCP), and SQL optimization without abstract framework overhead.

### Q2: How does Wheelyx prevent race conditions and double bookings?
**Answer:** Availability is evaluated atomically at the database level by querying overlapping date intervals (`WHERE vehicle_id = ? AND status != 'CANCELLED' AND ((start_date <= ? AND end_date >= ?) OR ...)`). If any confirmed booking or maintenance record overlaps with the requested range, the transaction is rejected.

### Q3: How is SQL Injection prevented throughout the application?
**Answer:** Wheelyx enforces a strict coding rule where 100% of SQL queries across all 15 DAOs exclusively use parameterized `PreparedStatement` with typed placeholders (`?`). Dynamic string concatenation in SQL queries is prohibited.

### Q4: How is password security guaranteed?
**Answer:** Passwords are never stored in plaintext. They are salted and hashed using BCrypt with an adaptive work factor of 12 rounds via `PasswordUtil.java`.

### Q5: How does the application handle missing Google Maps API keys?
**Answer:** `TrackingService.java` detects whether `google.maps.api.key` is populated. If empty, the frontend gracefully degrades to an interactive radar telemetry view powered by OpenStreetMap and simulated GPS coordinate polling.
