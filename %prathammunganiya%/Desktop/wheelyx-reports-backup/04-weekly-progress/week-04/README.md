# Weekly Progress Report — Week 4

## 1. Metadata
- **Week Number:** Week 4
- **Date Interval:** 27 July 2026 – 02 August 2026
- **Milestone:** Database Design & UI Mockups / Wireframes
- **Primary Component:** [03-design](../../03-design/README.md)
- **Status:** `Completed`

---

## 2. Executive Summary
Week 4 bridged design and implementation by creating the physical relational database schema in MySQL 8.0 and developing high-fidelity responsive wireframes and UI mockups. The database was normalized to Third Normal Form (3NF), foreign keys and cascades were configured, and initial seed datasets covering 20 Indian cities and 200 landmarks were authored.

---

## 3. Key Activities & Work Completed
1. **Relational Database Design (`schema.sql`):**
   - Engineered 17 normalized relational tables in 3NF: `users`, `roles`, `vehicle_owners`, `vehicle_categories`, `cities`, `city_places`, `vehicles`, `availability`, `bookings`, `rentals`, `bills`, `payments`, `reviews`, `maintenance`, `vehicle_locations`, `notifications`, `audit_logs`.
   - Defined strict foreign keys, unique constraints (`uq_city_place`, `registration_no`, `booking_code`), and timestamp auditing triggers.
2. **Performance Indexing Strategy (`indexes.sql`):**
   - Designed composite indexes for high-frequency queries: `idx_vehicles_search` on `(city_id, category_id, status)`, `idx_bookings_vehicle_dates` on `(vehicle_id, start_date, end_date, status)`, and `idx_vehicle_locations_tracking`.
   - Created safe idempotent indexing stored procedures (`CreateIndexIfNotExists`).
3. **Data Seeding Authoring (`seed.sql`):**
   - Populated 20 major Indian cities with 10 verifiable landmarks each (200 hubs).
   - Populated 36 real vehicle specifications across 6 categories (Cars, Bikes, Petrol Scooters, EV Scooters, EV Cars, Premium Vehicles).
4. **UI Wireframing & Responsive Mockups:**
   - Created Bootstrap 5 mockups for Homepage, Catalog, Booking Checkout, Invoicing, Owner Dashboard, and Admin Command Center.
   - Designed responsive Light & Dark theme color system with CSS custom properties (`main.css`).

---

## 4. Deliverables & Artifacts Generated
- `wheelyx-database/schema.sql` (Complete DDL script for 17 tables).
- `wheelyx-database/indexes.sql` (Composite performance index procedure).
- `wheelyx-database/seed.sql` (20 cities, 200 places, 36 vehicles, test users).
- High-fidelity UI prototype templates and CSS stylesheet (`main.css`).

---

## 5. Review & Guide Feedback
- **Feedback:** Guide verified the database schema and commended the inclusion of authentic geographic data rather than generic test places.
- **Action Item for Week 5:** Initiate module coding, starting with Authentication, BCrypt security, and role-based filters.
