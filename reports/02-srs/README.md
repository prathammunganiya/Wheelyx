# Component 02: Software Requirements Specification (SRS)

## 1. Introduction & Project Scope
This document details the complete functional and non-functional requirements for the **Wheelyx** platform, conforming to IEEE 830 standards for software requirements specifications.

---

## 2. Functional Requirements (FR)

### Module 1: User & Authentication Management
- **FR 1.1:** System shall provide registration for Customers and Owners with regex validation for emails and Indian mobile phone numbers (`+91XXXXXXXXXX`).
- **FR 1.2:** System shall salt and hash all passwords using BCrypt with 12 rounds before database storage.
- **FR 1.3:** System shall enforce role segregation (`CUSTOMER`, `OWNER`, `ADMIN`) using Jakarta EE Filters (`CustomerAuthFilter`, `OwnerAuthFilter`, `AdminAuthFilter`).
- **FR 1.4:** System shall support profile updates and secure session termination (`LogoutServlet`).

### Module 2: Fleet Catalog & Geographic Hubs
- **FR 2.1:** System shall render 36 pre-seeded vehicles across 6 categories (Cars, Bikes, Petrol Scooters, EV Scooters, EV Cars, Premium Vehicles).
- **FR 2.2:** System shall provide multi-parameter filtering: City, Landmark Hub, Category, Fuel Type, Transmission, Seating Capacity, and Price Range.
- **FR 2.3:** System shall implement an asynchronous AJAX JSON endpoint (`/api/places`) to dynamically populate landmark hubs when a city is chosen.

### Module 3: Booking & Availability Engine
- **FR 3.1:** System shall run atomic date-range overlap checks preventing double-booking of any vehicle over identical or intersecting dates.
- **FR 3.2:** System shall calculate transparent quotations:
  - Base Rent = `Daily Rate × Duration (Days)`
  - Multi-Day Discount: 10% discount automatically applied for rentals >= 7 days
  - Tax: 18% statutory GST computed on net base rental
  - Security Deposit: Refundable deposit added to final total
- **FR 3.3:** System shall permit customers and admins to modify hubs, adjust dates, or cancel active reservations.

### Module 4: Rental Lifecycle & Key Handover
- **FR 4.1:** Vehicle Owners shall dispatch confirmed bookings into `ACTIVE_RENTAL` by entering starting odometer readings, fuel/charge level, and inspection notes.
- **FR 4.2:** Vehicle Owners shall process vehicle returns by entering ending odometer readings, returning the vehicle status to `AVAILABLE`.

### Module 5: Billing & Multi-Channel Payments
- **FR 5.1:** System shall generate standardized tax invoices (`WX-INV-XXXXXXXX`) with tax breakdowns.
- **FR 5.2:** System shall provide a simulated payment gateway supporting UPI, Credit/Debit Cards, Net Banking, and Cash on Handover.

### Module 6: Live GPS Telemetry
- **FR 6.1:** System shall render real-time vehicle coordinates on an interactive radar telemetry screen.
- **FR 6.2:** System shall support dual mapping engines (Google Maps JavaScript API with Leaflet / OpenStreetMap fallback).

### Module 7: Verified Customer Reviews
- **FR 7.1:** System shall strictly restrict review submissions to customers who have completed and returned a rental (`RETURNED` status).
- **FR 7.2:** System shall enforce a unique constraint (`uq_review_rental`) preventing multiple reviews for the same rental.

### Module 8: Administrative Governance & Maintenance
- **FR 8.1:** Platform Administrators shall ground vehicles for servicing (`SCHEDULED`, `IN_PROGRESS`, `COMPLETED`) with maintenance cost and downtime tracking.
- **FR 8.2:** System shall log all critical actions (logins, bookings, dispatches, returns, maintenance) in `audit_logs` with timestamps and client IP addresses.

---

## 3. Non-Functional Requirements (NFR)
- **Performance:** Catalog query response times < 200ms using composite MySQL B-tree indexes.
- **Concurrency & Scalability:** HikariCP connection pool managing min 5 idle and max 20 connections.
- **Security:** 100% Parameterized PreparedStatements; XSS HTML entity sanitization; CSRF session tokens.
- **Reliability:** Custom error handling for HTTP 403, 404, and 500 error pages.
- **Responsiveness:** Bootstrap 5 mobile-first layout with persistent Light and Dark mode switcher (`theme.js`).
