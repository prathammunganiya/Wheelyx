# Weekly Progress Report — Week 3

## 1. Metadata
- **Week Number:** Week 3
- **Date Interval:** 20 July 2026 – 26 July 2026
- **Milestone:** UML Design & System Modeling
- **Primary Component:** [03-design](../../03-design/README.md)
- **Status:** `Completed`

---

## 2. Executive Summary
During Week 3, the team translated the functional requirements into comprehensive architectural diagrams and structural models. We designed Use-Case diagrams, Class diagrams, Sequence diagrams, and Activity workflows to visualize interactions across the triple-role ecosystem.

---

## 3. Key Activities & Work Completed
1. **Use-Case Modeling:**
   - Identified 10 primary platform use-cases covering Customer, Owner, and Administrator interactions.
   - Modeled use-case actors and defined inclusion/extension relationships (e.g., checkout includes invoice generation).
2. **Domain Class Diagram Design:**
   - Modeled core entity classes: `User`, `VehicleOwner`, `Vehicle`, `VehicleCategory`, `City`, `CityPlace`, `Booking`, `Rental`, `Bill`, `Payment`, `Review`, `Maintenance`, `VehicleLocation`, `AuditLog`.
   - Defined entity relationships, cardinality constraints, and layer boundaries.
3. **Sequence Diagrams for Critical Lifecycles:**
   - **Booking Flow:** Modeled the sequence between Customer -> `BookingServlet` -> `BookingService` -> `VehicleDAO` -> Database, verifying concurrency checking before committing reservations.
   - **Handover & Return Lifecycle:** Modeled the digital key dispatch workflow between Owner -> `RentalService` -> `RentalDAO`, tracking odometer transitions and vehicle status mutations.
4. **Activity & State Machine Modeling:**
   - Modeled the vehicle status lifecycle: `AVAILABLE -> BOOKED -> ACTIVE_RENTAL -> RETURNED -> AVAILABLE` and `AVAILABLE -> MAINTENANCE -> AVAILABLE`.

---

## 4. Deliverables & Artifacts Generated
- UML Diagrams Suite (Mermaid & architectural models in `reports/03-design/mermaid_source/`).
- Sequence Diagrams for Booking, Key Handover, Return, and Review submission.
- Class Diagram specification document with method signatures and access scopes.

---

## 5. Review & Guide Feedback
- **Feedback:** Guide commended the separation between `Booking` (the financial reservation contract) and `Rental` (the physical execution of the trip with odometer and fuel tracking).
- **Action Item for Week 4:** Translate models into MySQL database DDL schemas and design responsive UI mockups.
