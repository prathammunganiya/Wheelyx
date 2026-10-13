# Wheelyx — Implementation Plan & System Architecture

## Project Overview
**Wheelyx** is an enterprise-grade, integrated vehicle rental and fleet management platform engineered with modern Java Servlets (Jakarta EE / Tomcat 10.1 compatible), JDBC, MySQL 8.0, and responsive JSP/Bootstrap 5 frontend. It provides three strictly separated role-based portals (Customer, Vehicle Owner, Admin), 20 real Indian cities with 8–10 real-world pickup points each, 6 vehicle categories with 36 exact real models, atomic concurrency-safe booking workflows, billing & simulated payments, GPS tracking telemetry with graceful fallback, and verified customer reviews.

---

## 1. System Architecture
```
JSP / HTML5 / CSS3 / Vanilla JS / Bootstrap 5 / Chart.js
                   │
                   ▼ (HTTP Requests / Session Auth)
       Servlet Security & Auth Filters
   (CustomerFilter, OwnerFilter, AdminFilter)
                   │
                   ▼
          MVC Servlet Controllers
  (Auth, Fleet, Marketplace, Booking, Billing, Admin)
                   │
                   ▼
               Service Layer
  (Validation, Business Rules, State Machine, Calculations)
                   │
                   ▼
                 DAO Layer
        (PreparedStatements, Parameterized Queries)
                   │
                   ▼ (JDBC Connection Pool)
             MySQL 8.0 Database
         (wheelyx_vehicle_rental)
```

---

## 2. Database Schema Design (`wheelyx_vehicle_rental`)
- `users`: Core identity (id, name, email, phone, password_hash, role: CUSTOMER, OWNER, ADMIN, status, created_at)
- `roles`: Role definitions and permission flags
- `vehicle_owners`: Owner profile extensions (user_id, business_name, pan_number, bank_account, ifsc_code, verified_status)
- `vehicle_categories`: 6 categories (Cars, Bikes, Petrol Scooters, EV Scooters, EV Cars, Premium Vehicles)
- `cities`: 20 Indian cities (Delhi, Mumbai, Bengaluru, Hyderabad, Chennai, Kolkata, Pune, Ahmedabad, Jaipur, Lucknow, Chandigarh, Indore, Bhopal, Surat, Nagpur, Patna, Varanasi, Agra, Amritsar, Udaipur)
- `city_places`: 8–10 real locations per city (~180 real-world landmarks)
- `vehicles`: 36 exact models with specs, owner_id, category_id, city_id, place_id, price_per_day, deposit, status, image_url
- `bookings`: Reservations (code, customer_id, vehicle_id, start_date, end_date, duration_days, total_amount, status)
- `rentals`: Active rental lifecycles (rental_code, booking_id, vehicle_id, customer_id, handover_time, return_time, status)
- `bills`: Invoices (bill_no, booking_id, rental_id, base_amount, security_deposit, gst_amount, discount_amount, final_amount, status)
- `payments`: Simulated transactions (tx_id, bill_id, payment_method, amount, status, gateway_ref)
- `reviews`: Verified post-rental customer reviews (customer_id, vehicle_id, rental_id, rating, comment, verified_purchase)
- `maintenance`: Fleet servicing records (vehicle_id, maintenance_type, start_date, end_date, cost, status, notes)
- `vehicle_locations`: GPS coordinates (vehicle_id, rental_id, latitude, longitude, recorded_at, is_demo, source)
- `notifications`: User notifications (user_id, title, message, is_read, type, created_at)
- `audit_logs`: Platform activity audit trail (user_id, role, action, entity_type, entity_id, description, ip_address, created_at)

---

## 3. Technology Stack & Directory Structure
- **Runtime:** Java 17 / 25
- **Servlet Container:** Apache Tomcat 10.1 (Jakarta Servlet API 6.0)
- **Database:** MySQL 8.0 (`Root@123`)
- **Build Tool:** Apache Maven 3.9.9
- **Frontend:** JSP 3.1, JSTL 3.0, Bootstrap 5.3, Bootstrap Icons 1.11, Chart.js 4.4, Custom CSS/JS

### Directory Tree:
```
Wheelyx/
├── wheelyx-frontend/             # Web application resources
│   ├── assets/
│   │   ├── images/
│   │   │   ├── logo/             # Integrated Wheelyx logo assets
│   │   │   └── vehicles/         # 36 real vehicle images
│   │   ├── css/                  # Modern styles & dark mode
│   │   └── js/                   # Theme toggle, search, tracking
│   ├── components/               # Reusable JSP fragments
│   ├── pages/                    # Customer, Owner, Admin, Marketplace JSPs
│   └── WEB-INF/                  # web.xml, taglibs
├── wheelyx-backend/              # Java source & Maven
│   └── src/
│       ├── main/java/com/wheelyx/
│       │   ├── config/           # DBConnection, AppConfig
│       │   ├── model/            # Domain entities
│       │   ├── dao/              # Database access objects
│       │   ├── service/          # Business logic services
│       │   ├── filter/           # Security, role, auth filters
│       │   ├── controller/       # Jakarta servlet endpoints
│       │   └── util/             # Password, Date, Formatting utils
│       └── test/java/com/wheelyx/ # JUnit 5 test suites
├── wheelyx-database/             # SQL scripts
│   ├── schema.sql
│   ├── indexes.sql
│   └── seed.sql
├── documentation/                # Architecture, API, Deployment guides
├── pom.xml                       # Maven build configuration
├── README.md                     # Complete setup instructions
└── configuration-example.properties
```
