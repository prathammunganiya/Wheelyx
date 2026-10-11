# Wheelyx — Project Idea & Abstract Proposal

> **"Move Your Way."**  
> *Find, book, and manage your perfect ride with ease.*

---

## 1. Project Title & Domain
- **Project Title:** Wheelyx — Integrated Vehicle Rental and Fleet Management Platform
- **Domain:** Web Application Engineering / Cloud Mobility / Enterprise Systems
- **Platform Architecture:** Java 17+, Jakarta EE 10 (Servlet API 6.0), JDBC, MySQL 8.0, Bootstrap 5

---

## 2. Problem Statement
In India's rapidly expanding mobility market, urban travelers and tourists struggle with fragmented rental services, hidden charges, lack of transparent availability, and opaque vehicle conditions. At the same time, individual vehicle owners and small fleet operators lack a unified digital operating system to list, track, and manage commercial self-drive vehicles. Traditional vehicle rental systems often suffer from:
1. Inaccurate inventory and double-booking conflicts across overlapping dates.
2. Absence of real-time GPS telemetry and vehicle safety tracking.
3. Opaque pricing without upfront statutory tax (GST) and refundable deposit breakdowns.
4. Rampant unverified or fabricated customer reviews that mislead consumers.
5. Disconnected handover and return inspection processes, leading to security deposit disputes.

---

## 3. Proposed Solution
**Wheelyx** solves these challenges through an enterprise-grade, full-stack vehicle rental and fleet management platform engineered with modern Java Servlets (Jakarta EE 10 / Tomcat 10.1 compatible), JDBC, MySQL 8.0, and responsive JSP/Bootstrap 5 frontend. 

The platform features:
1. **Three Strictly Segregated Portals:** Dedicated web consoles for **Customers**, **Vehicle Owners**, and **Platform Administrators**.
2. **Real-World Geographic Scale:** Authentic coverage across **20 major Indian cities** with **200 verified landmark pickup and return hubs** (10 hubs per city).
3. **Diverse 36-Vehicle Fleet:** Real specifications across **6 categories** (Cars, Bikes, Petrol Scooters, EV Scooters, EV Cars, Premium Vehicles).
4. **Concurrency-Safe Reservation Engine:** Overlap detection preventing double-booking during identical date windows.
5. **Transparent Financial Workflows:** Automatic 18% GST calculation, 10% multi-day discounts (for >= 7 days), and simulated multi-modal checkout (UPI, Card, Net Banking, Cash).
6. **Live Telemetry Tracking:** GPS telemetry dashboard featuring simulated radar tracking and Google Maps / Leaflet integration.
7. **Verified-Only Reviews:** Reviews can strictly only be submitted after vehicle return is completed by the customer.

---

## 4. Key Innovation Highlights
- **100% Parameterized PreparedStatements:** Zero vulnerability to SQL injection across all 15 DAOs.
- **BCrypt Work Factor 12:** Cryptographically secure password salting and hashing.
- **HikariCP Connection Pool:** High-throughput thread-safe connection pooling with fallback.
- **Instant Cloudflare Tunneling:** Zero-config public HTTPS link generation via `SHARE_ON_ANY_DEVICE.bat` for live testing on mobile phones anywhere in the world.
