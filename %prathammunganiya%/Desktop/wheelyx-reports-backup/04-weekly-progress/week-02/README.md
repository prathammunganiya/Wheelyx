# Weekly Progress Report — Week 2

## 1. Metadata
- **Week Number:** Week 2
- **Date Interval:** 13 July 2026 – 19 July 2026
- **Milestone:** Software Requirements Specification (SRS)
- **Primary Component:** [02-srs](../../02-srs/README.md)
- **Status:** `Completed`

---

## 2. Executive Summary
Week 2 was dedicated to the systematic formulation of the Software Requirements Specification (SRS) for Wheelyx. We translated the broad project vision into precise, testable functional and non-functional requirements. The technical constraints and dependency matrices were formally locked down.

---

## 3. Key Activities & Work Completed
1. **User Role & Persona Definition:**
   - **Customer:** Needs frictionless search, multi-faceted filtering, transparent checkout, GPS tracking, and review capabilities.
   - **Vehicle Owner:** Requires fleet inventory controls, inspection-based handover/return workflows, and earnings visibility.
   - **Platform Administrator:** Requires system oversight, maintenance grounding controls, audit log visibility, and business reports.
2. **Detailed Functional Requirements (FR) Specification:**
   - Catalog browsing and AJAX-based city landmark hub dynamic loading.
   - Concurrency-safe reservation algorithm preventing overlapping bookings.
   - Statutory 18% GST calculation, 10% multi-day discount (for >= 7 days), and refundable security deposit calculation.
   - Digital handover inspection with start/end odometer readings and fuel level tracking.
   - Zero-fraud verified customer reviews strictly linked to completed `RETURNED` rentals.
3. **Non-Functional Requirements (NFR) Formulation:**
   - Sub-200ms catalog query response times utilizing composite MySQL B-tree indexes.
   - 100% Parameterized PreparedStatements across all database queries.
   - BCrypt hashing with 12 salt rounds for password storage.
   - High availability with HikariCP connection pool fallback.
4. **Hardware & Software Environment Mapping:**
   - JDK 17 / JDK 25 compatibility, Apache Tomcat 10.1 (Jakarta EE 10 namespace), MySQL 8.0, Apache Maven 3.9+.

---

## 4. Deliverables & Artifacts Generated
- Comprehensive Software Requirements Specification (SRS) document (IEEE 830 compliant structure).
- Functional Requirements Traceability Matrix.
- Non-Functional Quality Attributes documentation.

---

## 5. Review & Guide Feedback
- **Feedback:** Guide validated the requirement to restrict reviews strictly to verified returned rentals, calling it an exemplary anti-fraud measure.
- **Action Item for Week 3:** Proceed to UML Architectural Design and structural modeling.
