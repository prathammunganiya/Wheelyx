# Component 07: Presentation & Slide Deck

## 1. Presentation Overview
The Wheelyx project presentation is designed for academic evaluators, industry juries, and technical mentors. It summarizes the business motivation, technical architecture, engineering highlights, and live platform demonstration.

---

## 2. Slide Deck Structure (15 Slides)

1. **Slide 1: Title & Hero Banner**
   - Project: Wheelyx — Integrated Vehicle Rental and Fleet Management Platform
   - Tagline: *"Move Your Way."*
   - Team Members, Mentor/Guide Details, Academic Institution
2. **Slide 2: Problem Statement & Market Landscape**
   - Mobility challenges in Indian cities: fragmented rental services, hidden fees, lack of digital fleet dispatching, fake reviews.
3. **Slide 3: Proposed Solution & Core Value Proposition**
   - Full-stack digital operating system for customers, vehicle owners, and platform administrators.
4. **Slide 4: Technology Stack & Architectural Decisions**
   - Java 17 / Jakarta EE 10 (Tomcat 10.1), JDBC, MySQL 8.0, HikariCP, BCrypt, Bootstrap 5, Chart.js.
5. **Slide 5: Layered MVC System Architecture**
   - Architectural flow diagram showing request handling, auth filters, services, DAOs, and connection pooling.
6. **Slide 6: Real Fleet & Geographic Coverage**
   - 36 authentic vehicle models across 6 categories; 20 major Indian cities and 200 verifiable landmark pickup hubs.
7. **Slide 7: Concurrency-Safe Booking & Pricing Engine**
   - Overlap validation, 18% GST calculation, 10% 7-day discounts, refundable security deposits.
8. **Slide 8: Vehicle Lifecycle & Handover Management**
   - Digital key dispatch with starting odometer/fuel inspection; return check-in workflow.
9. **Slide 9: Live GPS Radar Telemetry & Mapping**
   - Simulated radar UI and Leaflet / Google Maps telemetry fallback.
10. **Slide 10: Tax Invoicing & Simulated Multi-Channel Payments**
    - GST-compliant invoices (`WX-INV-XXXXXXXX`); simulated UPI, Card, Net Banking, and Cash workflows.
11. **Slide 11: Zero-Fraud Verified Customer Reviews**
    - Enforced post-trip reviews linked strictly to completed returned rentals.
12. **Slide 12: Admin Command Center & Visual Business Intelligence**
    - Fleet grounding/maintenance manager; Chart.js visual analytics; platform security audit logs.
13. **Slide 13: Security Architecture & Code Quality**
    - 100% Parameterized PreparedStatements, BCrypt 12 rounds, CSRF tokens, XSS HTML sanitization.
14. **Slide 14: Demonstration on Mobile Devices**
    - Live mobile showcase via integrated Cloudflare Tunnel (`SHARE_ON_ANY_DEVICE.bat`).
15. **Slide 15: Conclusion, Learnings & Future Roadmap**
    - Real-world telematics hardware integration, automated FASTag toll reconciliation, and AI-driven dynamic pricing.
