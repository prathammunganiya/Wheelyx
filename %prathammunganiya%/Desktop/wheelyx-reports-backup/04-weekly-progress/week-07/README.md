# Weekly Progress Report — Week 7

## 1. Metadata
- **Week Number:** Week 7
- **Date Interval:** 17 August 2026 – 23 August 2026
- **Milestone:** Module Coding Phase 3: Concurrency-Safe Booking & Rental Lifecycle
- **Primary Component:** [05-implementation](../../05-implementation/README.md)
- **Status:** `Completed`

---

## 2. Executive Summary
Week 7 focused on the core transactional engine of Wheelyx: the concurrency-safe booking engine, quotation calculation service, booking modifications/cancellations, and the physical rental lifecycle spanning key handover dispatch and return inspection.

---

## 3. Key Activities & Work Completed
1. **Concurrency-Safe Availability Checking:**
   - Implemented `vehicleDAO.checkAvailability(vehicleId, startDate, endDate, excludeBookingId)` ensuring no overlapping bookings exist in the specified date range.
   - Enforced database-level locking and transaction consistency to prevent double-booking race conditions.
2. **Business Logic & Pricing Quotation Service:**
   - Developed `BookingService.java`:
     - Base Rent calculation: `pricePerDay * durationDays`
     - Long-Term Discount: Applied 10% discount for bookings >= 7 days
     - Tax calculation: 18% GST on base rental with half-up rounding
     - Total = `basePrice + securityDeposit + tax - discount`
     - Automatic generation of unique booking code (`WX-BK-XXXXXXXX`).
3. **Booking Controllers & User Flexibility:**
   - Developed `BookingServlet.java`, `BookingConfirmationServlet.java`.
   - Built `BookingEditServlet.java` enabling customers to modify pickup/return hubs or update dates prior to dispatch.
   - Built `BookingCancelServlet.java` enabling users and admins to cancel reservations, releasing vehicle availability.
4. **Active Rental Lifecycle & Digital Key Handover:**
   - Developed `RentalService.java` and `RentalDAO.java`.
   - Built `OwnerBookingsServlet.java` and `OwnerRentalsServlet.java`.
   - **Handover Dispatch:** Owner enters starting odometer, verifies fuel level, enters condition notes; system creates `Rental` record (`WX-RN-XXXXXXXX`) and sets vehicle status to `ACTIVE_RENTAL`.
   - **Return Inspection:** Owner enters ending odometer and fuel level; vehicle is returned to `AVAILABLE` and booking is marked `COMPLETED`.

---

## 4. Deliverables & Artifacts Generated
- `com.wheelyx.service.BookingService`, `com.wheelyx.service.RentalService`.
- `com.wheelyx.controller.BookingServlet`, `BookingEditServlet`, `BookingCancelServlet`.
- `com.wheelyx.controller.OwnerRentalsServlet`, `CustomerRentalsServlet`.
- JSP pages: `pages/booking/book.jsp`, `confirmation.jsp`, `pages/customer/booking-edit.jsp`, `pages/owner/rentals.jsp`.

---

## 5. Review & Guide Feedback
- **Feedback:** Guide tested simultaneous booking attempts for the same vehicle over overlapping dates, confirming the second attempt was rejected with an informative error message.
- **Action Item for Week 8:** Implement Billing, Invoicing, Simulated Payment Gateway, Live GPS Telemetry, and Verified Reviews.
