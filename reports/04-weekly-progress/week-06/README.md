# Weekly Progress Report — Week 6

## 1. Metadata
- **Week Number:** Week 6
- **Date Interval:** 10 August 2026 – 16 August 2026
- **Milestone:** Module Coding Phase 2: Vehicle Catalog, Search & Hub Management
- **Primary Component:** [05-implementation](../../05-implementation/README.md)
- **Status:** `Completed`

---

## 2. Executive Summary
During Week 6, the team implemented the public-facing fleet marketplace, catalog search engine, dynamic city/place relationship handlers, and vehicle inventory management for vehicle owners and platform administrators.

---

## 3. Key Activities & Work Completed
1. **Catalog & Location Data Access:**
   - Implemented `VehicleDAO.java` supporting complex multi-parameter filtering: City ID, Landmark Hub ID, Category ID, Fuel Type, Transmission, Seating Capacity, Price Range, and Availability Status.
   - Implemented `CityDAO.java` and `CategoryDAO.java` for managing active operational cities and vehicle categories.
2. **AJAX Hub Retrieval Engine:**
   - Developed `CityPlaceApiServlet.java` (`/api/places`) to return JSON representations of landmark pickup hubs based on selected city IDs.
   - Wired vanilla JavaScript on the frontend catalog search forms to asynchronously update landmark dropdowns without page reloads.
3. **Vehicle Marketplace & Detail Controllers:**
   - Developed `HomeServlet.java` displaying featured vehicles, categories, and customer feedback.
   - Developed `VehicleCatalogServlet.java` with responsive sidebar filters, sorting options, and pagination.
   - Developed `VehicleDetailServlet.java` displaying technical specifications, pricing breakdown, rental terms, and verified reviews.
4. **Owner Inventory Controls:**
   - Developed `OwnerVehiclesServlet.java`, `OwnerVehicleAddServlet.java`, and `OwnerVehicleEditServlet.java`.
   - Enabled fleet owners to list new vehicles, assign city landmark hubs, configure pricing and deposits, and edit vehicle specifications.

---

## 4. Deliverables & Artifacts Generated
- `com.wheelyx.controller.VehicleCatalogServlet`, `VehicleDetailServlet`, `CityPlaceApiServlet`.
- `com.wheelyx.controller.OwnerVehiclesServlet`, `OwnerVehicleAddServlet`, `OwnerVehicleEditServlet`.
- Reusable JSP fragment `components/vehicle-card.jsp`.
- Complete catalog views in `pages/vehicles/catalog.jsp` and `pages/vehicles/detail.jsp`.

---

## 5. Review & Guide Feedback
- **Feedback:** Guide tested the AJAX landmark dropdown on the homepage and catalog, confirming seamless performance across all 20 cities.
- **Action Item for Week 7:** Implement the Booking Engine, concurrency checks, pricing quotation algorithms, and key handover dispatching.
