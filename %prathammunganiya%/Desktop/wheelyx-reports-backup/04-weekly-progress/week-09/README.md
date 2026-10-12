# Weekly Progress Report — Week 9

## 1. Metadata
- **Week Number:** Week 9
- **Date Interval:** 31 August 2026 – 06 September 2026
- **Milestone:** Subsystem Integration & Testing
- **Primary Component:** [06-testing](../../06-testing/README.md)
- **Status:** `Completed`

---

## 2. Executive Summary
Week 9 centered on unifying all independent modules into a cohesive staging branch (`wheelyx-integration`), running extensive automated JUnit 5 test suites, executing end-to-end integration flows, resolving edge cases, and verifying cross-browser and cross-device responsiveness.

---

## 3. Key Activities & Work Completed
1. **Branch Integration & Conflict Resolution:**
   - Merged feature branches (`wheelyx-backend`, `wheelyx-frontend`, `wheelyx-database`) into `wheelyx-integration`.
   - Verified alignment between backend Servlet routing and JSP form action attributes.
2. **Automated Testing Suite Execution:**
   - Executed `BillingCalculationTest`: Verified exact pricing calculations, discount deductions, and GST rounding.
   - Executed `ValidationUtilTest`: Verified regex patterns for emails, phone numbers, and vehicle registration numbers.
   - Executed `PasswordUtilTest`: Verified BCrypt salt rounds and mismatch rejections.
   - Executed `DatabaseIntegrationTest`: Tested HikariCP pool resilience and rollback guarantees during simulated exceptions.
3. **Bug Fixes & Refinements:**
   - Fixed an edge case where updating a booking's dates could inadvertently conflict with the vehicle's own current booking ID.
   - Added `CharsetEncodingFilter` to eliminate character encoding anomalies across multipart and URL-encoded POST requests.
   - Refined mobile navigation collapse toggles in `components/navbar.jsp`.
4. **DevOps & Device Testing:**
   - Authored `START_WHEELYX.bat`, `STOP_WHEELYX.bat`, and `SHARE_ON_ANY_DEVICE.bat`.
   - Integrated Cloudflare Tunnel (`cloudflared.exe`) and validated mobile accessibility on physical iOS and Android smartphones over cellular networks.

---

## 4. Deliverables & Artifacts Generated
- Integrated and green build passing all 24+ JUnit 5 test cases (`mvn test`).
- Packaging of deployable `target/wheelyx.war`.
- Quick-launch automation scripts (`START_WHEELYX.bat`, `STOP_WHEELYX.bat`, `SHARE_ON_ANY_DEVICE.bat`).
- Multi-stage `Dockerfile` tested on Eclipse Temurin 17 / Tomcat 10.1.

---

## 5. Review & Guide Feedback
- **Feedback:** Guide reviewed the test output reports and verified smooth real-time execution via Cloudflare Tunnel on a mobile smartphone.
- **Action Item for Week 10:** Prepare final project documentation, presentation slide deck, demo video, and viva defense materials.
