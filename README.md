# WHEELYX — Integrated Vehicle Rental and Fleet Management Platform

> **"Move Your Way."**  
> *Find, book, and manage your perfect ride with ease.*

---

## 1. Executive Summary

**Wheelyx** is an enterprise-grade, full-stack vehicle rental and fleet management platform engineered using **Java 17+ (JDK 25 compatible)**, **Jakarta EE 10 (Servlet API 6.0)**, **JDBC**, and **MySQL 8.0+**. Designed with clean Model-View-Controller (MVC) architecture, HikariCP connection pooling, BCrypt cryptography, and responsive frontend interfaces, Wheelyx delivers a robust, real-world transportation solution.

The platform enforces strict role-based access control (RBAC) across three dedicated user ecosystems:
1. **Customer / User:** Search 36 authentic vehicle models across 20 major Indian cities, reserve self-drive vehicles with concurrency-safe availability validation, track active trips using live GPS telemetry, inspect tax invoices, complete multi-modal simulated payments (UPI, Card, Net Banking, Cash), edit or cancel reservations, and submit verified post-trip reviews.
2. **Vehicle Owner:** Manage commercial self-drive vehicle listings linked to authentic city landmark hubs, inspect and execute key dispatch handovers with starting odometer checks, process vehicle check-ins upon return, track fleet health, and monitor earnings analytics.
3. **Platform Administrator:** Comprehensive governance suite covering user lifecycle, fleet verification and status overrides, booking and rental lifecycles, billing and transaction ledgers, customer feedback moderation, vehicle maintenance scheduling and downtime management, geographic hub expansion, visual KPI reporting via Chart.js, and platform security audit logs.

---

## 2. Technology Stack & Libraries

### Backend Architecture
- **Language / Runtime:** Java 17+ (LTS, verified on JDK 25)
- **Servlet Specification:** Jakarta EE 10 / Jakarta Servlet API 6.0
- **View Layer:** Jakarta Server Pages (JSP) 3.1 & Jakarta Standard Tag Library (JSTL) 3.0 (GlassFish 3.0.1)
- **Architecture Pattern:** Model-View-Controller (MVC), Service Layer, Data Access Object (DAO) Pattern
- **Connection Pooling:** HikariCP 5.1.0 (High-performance JDBC connection pool with direct fallback)
- **Database Driver:** MySQL Connector/J 8.3.0
- **Security & Cryptography:** jBCrypt 0.4 (12 salt rounds), SecureRandom token generation, HTML entity sanitization
- **Serialization / JSON:** Google Gson 2.10.1
- **Testing Framework:** JUnit Jupiter 5.10.2 (JUnit 5) & Maven Surefire 3.2.5
- **Build System:** Apache Maven 3.9+ (WAR packaging)
- **Application Server:** Apache Tomcat 10.1+ (Jakarta EE 10 namespace)

### Frontend & Client-Side Design
- **Core:** Semantic HTML5, Vanilla JavaScript (ES6+), CSS3
- **CSS Framework:** Bootstrap 5.3.3 & Bootstrap Icons 1.11.3
- **Data Visualization:** Chart.js 4.4 (Admin KPI analytics, revenue trends, category distributions)
- **Mapping & Telemetry:** Dynamic GPS Telemetry with simulated radar telemetry and Google Maps JavaScript API integration (with graceful fallback)
- **Theme Engine:** Built-in Light & Dark mode switch persisted via `localStorage`
- **AJAX Support:** Fetch API for asynchronous city landmark loading and live GPS coordinate polling

### DevOps, Networking & Utilities
- **Containerization:** Multi-stage Dockerfile (Maven 3.9 / Eclipse Temurin 17 -> Tomcat 10.1)
- **Remote Sharing:** Cloudflare Tunnel (`cloudflared.exe`) integration for instant zero-configuration sharing to mobile devices
- **Automation Scripts:** Windows Command scripts (`START_WHEELYX.bat`, `STOP_WHEELYX.bat`, `SHARE_ON_ANY_DEVICE.bat`)

---

## 3. Real Fleet & Geographic Coverage

Wheelyx features pre-seeded, authentic vehicle specifications and geographic data across 20 major Indian cities and 200 verifiable landmark pickup hubs.

### 6 Vehicle Categories & 36 Real Vehicle Models

| Category | Count | Models Included | Typical Seating | Fuel Types |
| :--- | :---: | :--- | :---: | :--- |
| **Cars** | 6 | Maruti Swift, Hyundai i20, Tata Altroz, Honda City, Hyundai Creta, Kia Seltos | 5 Seats | Petrol, Diesel |
| **Bikes** | 6 | Hero Splendor Plus, Bajaj Pulsar 150, Yamaha FZ-FI, Yamaha MT-15, KTM Duke 250, Royal Enfield Classic 350 | 2 Seats | Petrol |
| **Petrol Scooters** | 6 | Honda Activa 6G, Honda Activa 125, Honda Dio, TVS Jupiter 125, TVS Ntorq 125, Yamaha Aerox 155 | 2 Seats | Petrol |
| **EV Scooters** | 6 | Ola S1 Pro, Ather 450X, Ather Rizta, TVS iQube, Bajaj Chetak, Suzuki e-Access | 2 Seats | Electric |
| **EV Cars** | 6 | Tata Tiago EV, Tata Punch EV, Tata Nexon EV, MG Comet EV, MG ZS EV, Hyundai Creta Electric | 4–5 Seats | Electric |
| **Premium Vehicles**| 6 | BMW 3 Series, Mercedes-Benz C-Class, Audi A4, Volvo S90, BMW X3, Mercedes-Benz GLC | 5 Seats | Petrol, Diesel |

### 20 Real Indian Cities & 200 Landmark Hubs
Wheelyx operates across 20 tier-1 and tier-2 Indian metropolitan centers, with 10 authentic landmark hubs per city (200 total hubs):

- **Delhi:** India Gate, Red Fort, Qutub Minar, Lotus Temple, Humayun's Tomb, Akshardham, Connaught Place, Chandni Chowk, Gurudwara Bangla Sahib, Rashtrapati Bhavan
- **Mumbai:** Gateway of India, Marine Drive, Colaba Causeway, Chhatrapati Shivaji Maharaj Terminus, Elephanta Caves, Siddhivinayak Temple, Juhu Beach, Bandra-Worli Sea Link, Haji Ali, Sanjay Gandhi National Park
- **Bengaluru:** Bangalore Palace, Lalbagh Botanical Garden, Cubbon Park, Vidhana Soudha, ISKCON Temple, UB City, Bannerghatta National Park, Commercial Street, Nandi Hills, Wonderla
- **Hyderabad:** Charminar, Golconda Fort, Hussain Sagar, Salar Jung Museum, Chowmahalla Palace, Mecca Masjid, Necklace Road, Ramoji Film City, Birla Mandir, Qutb Shahi Tombs
- **Chennai:** Marina Beach, Kapaleeshwarar Temple, Fort St. George, Government Museum, San Thome Basilica, Guindy National Park, Valluvar Kottam, Elliot's Beach, Besant Nagar, DakshinaChitra
- **Kolkata:** Victoria Memorial, Howrah Bridge, Indian Museum, St. Paul's Cathedral, Park Street, Belur Math, Dakshineswar Kali Temple, Marble Palace, Eco Park, Science City
- **Pune:** Shaniwar Wada, Aga Khan Palace, Sinhagad Fort, Pataleshwar Cave Temple, Dagdusheth Halwai Ganpati Temple, Raja Dinkar Kelkar Museum, Vetal Tekdi, Koregaon Park, Khadakwasla Dam, Osho Garden
- **Ahmedabad:** Sabarmati Ashram, Kankaria Lake, Adalaj Stepwell, Sidi Saiyyed Mosque, Science City, Sabarmati Riverfront, Jhulta Minar, Auto World Vintage Car Museum, Law Garden, Calico Museum of Textiles
- **Jaipur:** Amber Fort, Hawa Mahal, City Palace, Jantar Mantar, Jal Mahal, Nahargarh Fort, Jaigarh Fort, Albert Hall Museum, Birla Mandir, Chokhi Dhani
- **Lucknow:** Bara Imambara, Chota Imambara, Rumi Darwaza, Ambedkar Memorial Park, Hazratganj, The Residency, Gomti Riverfront Park, Janeshwar Mishra Park, Dilkusha Kothi, Clock Tower
- **Chandigarh:** Rock Garden, Sukhna Lake, Rose Garden, Sector 17 Plaza, Elante Mall, Capitol Complex, Government Museum and Art Gallery, Japanese Garden, Terraced Garden, Pinjore Gardens
- **Indore:** Rajwada Palace, Lal Bagh Palace, Sarafa Bazaar, Chappan Dukan, Khajrana Ganesh Temple, Kanch Mandir, Annapurna Temple, Patalpani Waterfall, Ralamandal Wildlife Sanctuary, Central Museum
- **Bhopal:** Upper Lake (Bada Talab), Van Vihar National Park, Taj-ul-Masajid, Lower Lake, Bharat Bhavan, Birla Museum, Shaukat Mahal, Gohar Mahal, Sanchi Stupa approach, Regional Science Centre
- **Surat:** Dumas Beach, Surat Castle, Dutch Garden, Gopi Talav, Science Centre, Sardar Patel Museum, Ambika Niketan Temple, VR Surat Mall, Dandi Bridge, ISKCON Temple
- **Nagpur:** Deekshabhoomi, Sitabuldi Fort, Futala Lake, Ambazari Lake, Dragon Palace Temple, Raman Science Centre, Zero Mile Stone, Seminary Hills, Maharajbagh Zoo, Krazy Castle
- **Patna:** Golghar, Patna Museum, Bihar Museum, Takht Sri Patna Sahib, Sanjay Gandhi Jaivik Udyan, Gandhi Ghat, Kumhrar, Buddha Smriti Park, Nalanda approach hub, Funtasia Water Park
- **Varanasi:** Kashi Vishwanath Temple, Dashashwamedh Ghat, Assi Ghat, Manikarnika Ghat, Sarnath, Banaras Hindu University, Ramnagar Fort, Tulsi Manas Temple, Bharat Kala Bhavan, Sankat Mochan Temple
- **Agra:** Taj Mahal, Agra Fort, Fatehpur Sikri approach, Mehtab Bagh, Itmad-ud-Daulah's Tomb, Akbar's Tomb, Jama Masjid, Moti Masjid, Kinari Bazaar, Agra Cantonment
- **Amritsar:** Golden Temple, Jallianwala Bagh, Partition Museum, Durgiana Temple, Gobindgarh Fort, Hall Bazaar, Heritage Street, Maharaja Ranjit Singh Museum, Wagah Border, Ram Bagh Palace
- **Udaipur:** City Palace, Lake Pichola, Jag Mandir, Jagdish Temple, Saheliyon-ki-Bari, Fateh Sagar Lake, Sajjangarh Monsoon Palace, Bagore Ki Haveli, Gulab Bagh, Vintage & Classic Car Museum

---

## 4. Key Architectural Features & Modules

### 4.1. Core Authentication & Role Security
- **Role Hierarchy:** Strictly segregated roles (`CUSTOMER`, `OWNER`, `ADMIN`).
- **Servlet Filters:** Route interception through `CustomerAuthFilter` (`/customer/*`, `/booking/*`), `OwnerAuthFilter` (`/owner/*`), and `AdminAuthFilter` (`/admin/*`).
- **Password Security:** BCrypt password hashing using cost factor 12. Passwords are never stored in plain text.
- **CSRF & XSS Safeguards:** Cross-Site Request Forgery tokens in transactional forms and HTML character entity escaping for user inputs.

### 4.2. Concurrency-Safe Booking & Pricing Engine
- **Atomic Availability Checks:** Prevents double-booking across identical date windows via database overlapping interval validation.
- **Dynamic Pricing Model:**
  - Base Rent = `Vehicle Daily Rate × Duration (Days)`
  - Long-Term Incentive: **10% discount** automatically applied for bookings of 7 or more days.
  - Statutory Tax: **18% Goods & Services Tax (GST)** computed on net base rental.
  - Security Deposit: Refundable deposit added to checkout total and held during trip lifecycle.
- **Editable Bookings:** Customers can modify pickup/return hubs or update schedules directly prior to vehicle handover.
- **Cancellation Controls:** User-initiated and administrative booking cancellation with automated fleet status rollback.

### 4.3. Vehicle Lifecycle & Handover Management
```
AVAILABLE ──► BOOKED ──► ACTIVE_RENTAL ──► RETURNED ──► AVAILABLE
   │                                                       ▲
   └────────────► MAINTENANCE (Grounding) ─────────────────┘
```
- **Key Dispatch Handover:** Owner records starting odometer reading, starting fuel/charge level, and physical inspection notes before marking the rental `ACTIVE_RENTAL`.
- **Return Inspection:** Upon return, end odometer and final fuel/charge levels are recorded. The system verifies rental completion, transitions the vehicle back to `AVAILABLE`, and unlocks customer review submission.
- **Fleet Grounding:** Administrators can schedule vehicle downtime (`SCHEDULED`, `IN_PROGRESS`, `COMPLETED`) with maintenance categorization and repair cost tracking.

### 4.4. Live GPS Telemetry & Interactive Radar Tracking
- **Real-Time Telemetry:** Queries latest vehicle coordinates from `vehicle_locations`.
- **Radar & Map UI:** Dynamic vehicle position plotting with pulse animations, speed simulation, compass bearing, and hub routing.
- **Dual Engine Architecture:** Gracefully switches between Google Maps JavaScript API and OpenStreetMap / Leaflet coordinates when no Google API key is configured.

### 4.5. Billing, Invoicing & Multi-Modal Payments
- **Tax Invoices:** System generates standardized tax bills (`WX-INV-XXXXXXXX`) detailing base rent, GST, discounts, and refundable security deposits.
- **Simulated Payment Gateway:** Multi-channel payment simulator supporting:
  - UPI (Virtual Payment Address simulation)
  - Credit & Debit Cards (Simulated card verification)
  - Net Banking (Major Indian banks)
  - Cash on Handover
- **Transaction Ledger:** Every payment is recorded in the `payments` table with unique transaction references (`WX-TX-XXXXXXXX`).

### 4.6. Verified Customer Reviews
- **Zero Fake Reviews:** Reviews cannot be created arbitrarily. A review form is only accessible if the customer has an authentic, completed, and returned rental (`RETURNED` status).
- **Anti-Duplication:** Enforces unique constraint per rental transaction (`uq_review_rental`).
- **Dynamic Showcase:** Verified ratings and feedback render on the homepage and vehicle detail pages.

### 4.7. Visual Analytics & Audit Logging
- **Chart.js Visual Dashboards:** Interactive pie, doughnut, and bar charts for category distribution, fleet distribution across cities, and reservation volume.
- **Enterprise Audit Logs:** Every critical operation (logins, bookings, dispatch handovers, returns, vehicle edits, admin maintenance actions) is logged with user ID, role, action tag, affected entity, timestamp, and client IP address.

---

## 5. System Architecture

```
                    ┌──────────────────────────────────────────────┐
                    │               Client Browser                 │
                    │  (HTML5, CSS3, Bootstrap 5, JS, Chart.js)   │
                    └──────────────────────┬───────────────────────┘
                                           │ HTTP / HTTPS
                                           ▼
                    ┌──────────────────────────────────────────────┐
                    │          Jakarta EE Security Filters         │
                    │ (CustomerAuthFilter, OwnerAuthFilter, Admin) │
                    └──────────────────────┬───────────────────────┘
                                           │
                                           ▼
                    ┌──────────────────────────────────────────────┐
                    │           MVC Servlet Controllers            │
                    │  (BookingServlet, OwnerVehiclesServlet, etc) │
                    └──────────────────────┬───────────────────────┘
                                           │
                                           ▼
                    ┌──────────────────────────────────────────────┐
                    │                Service Layer                 │
                    │ (BookingService, RentalService, AuthService) │
                    └──────────────────────┬───────────────────────┘
                                           │
                                           ▼
                    ┌──────────────────────────────────────────────┐
                    │            Data Access Object (DAO)          │
                    │  (Parameterized PreparedStatements / SQL)   │
                    └──────────────────────┬───────────────────────┘
                                           │
                                           ▼
                    ┌──────────────────────────────────────────────┐
                    │           HikariCP Connection Pool           │
                    │   (Min Idle: 5, Max Pool: 20, Timeout: 30s)  │
                    └──────────────────────┬───────────────────────┘
                                           │ TCP / JDBC (Port 3306)
                                           ▼
                    ┌──────────────────────────────────────────────┐
                    │            MySQL 8.0 Database Server         │
                    │          (wheelyx_vehicle_rental)            │
                    └──────────────────────────────────────────────┘
```

---

## 6. Database Schema & Data Dictionary

Wheelyx features a normalized relational database design with 17 interconnected tables:

| # | Table Name | Purpose & Description |
| :-: | :--- | :--- |
| **1** | `users` | Core user identity (id, name, email, phone, password_hash, role, status, timestamps). |
| **2** | `roles` | System roles definitions (`CUSTOMER`, `OWNER`, `ADMIN`) and descriptive flags. |
| **3** | `vehicle_owners` | Extended profile for vehicle owners (business name, PAN number, bank details, IFSC, verification flag). |
| **4** | `vehicle_categories` | 6 vehicle categories with semantic codes, descriptions, and Bootstrap icon classes. |
| **5** | `cities` | 20 operational Indian cities with state mappings and active flags. |
| **6** | `city_places` | 200 real-world landmark pickup and return hubs (10 hubs per city) with foreign key to `cities`. |
| **7** | `vehicles` | 36 fleet vehicles with brand, model, registration, fuel, transmission, price/day, deposit, and status. |
| **8** | `availability` | Calendar-based blackout and reservation intervals for vehicle scheduling. |
| **9** | `bookings` | Customer reservations with codes, durations, financial breakdowns, and statuses (`CONFIRMED`, `CANCELLED`, etc.). |
| **10** | `rentals` | Active rental lifecycles with handover/return timestamps, starting/ending odometers, fuel levels, and inspection notes. |
| **11** | `bills` | Tax invoices generated per booking with base charges, GST calculations, discounts, and payment status. |
| **12** | `payments` | Transaction records detailing payment method (`UPI`, `CARD`, `CASH`, `NET_BANKING`), gateway references, and status. |
| **13** | `reviews` | Customer ratings (1 to 5 stars) and comments strictly linked to completed `rentals`. |
| **14** | `maintenance` | Fleet servicing work orders (maintenance type, description, date ranges, repair costs, status). |
| **15** | `vehicle_locations`| Real-time and simulated GPS telemetry coordinates (`latitude`, `longitude`, timestamp, tracking source). |
| **16** | `notifications` | Role-based internal user notifications for booking confirmations, handovers, and system alerts. |
| **17** | `audit_logs` | Platform-wide audit trail recording user ID, action tag, entity type/ID, description, and client IP address. |

---

## 7. Project Structure

```
Wheelyx/
├── pom.xml                                   # Root Maven Project Configuration
├── Dockerfile                                # Multi-stage Docker deployment definition
├── START_WHEELYX.bat                         # Automated local launcher script
├── STOP_WHEELYX.bat                          # Graceful application shutdown script
├── SHARE_ON_ANY_DEVICE.bat                   # Instant Cloudflare Tunnel mobile sharing script
├── cloudflared.exe                           # Cloudflare tunnel utility
├── configuration-example.properties          # Environment configuration template
├── README.md                                 # Complete documentation
│
├── wheelyx-database/                         # Relational Database Assets
│   ├── schema.sql                            # DDL schema definition (17 tables)
│   ├── indexes.sql                           # Performance indexing procedures
│   ├── seed.sql                              # Seed data: 20 cities, 200 hubs, 36 vehicles
│   └── view_customer_data.sql                # Utility queries for MySQL Workbench
│
├── wheelyx-backend/                          # Java Enterprise Backend Source
│   └── src/
│       ├── main/
│       │   ├── java/com/wheelyx/
│       │   │   ├── config/                   # AppConfig, DBConnection (HikariCP pool)
│       │   │   ├── controller/               # 38 Jakarta Servlet Controllers
│       │   │   ├── dao/                      # 15 Data Access Objects (JDBC PreparedStatements)
│       │   │   ├── filter/                   # Security Filters (Customer, Owner, Admin, Charset)
│       │   │   ├── model/                    # 15 JavaBean Domain Entities
│       │   │   ├── service/                  # Business Logic Services (Booking, Rental, Auth, etc.)
│       │   │   └── util/                     # Security, Password (BCrypt), Validation, JSON utils
│       │   └── resources/
│       │       └── db.properties             # Local configuration file (git-ignored)
│       └── test/
│           └── java/com/wheelyx/             # JUnit 5 Test Suites
│               ├── BillingCalculationTest.java
│               ├── DatabaseIntegrationTest.java
│               ├── PasswordUtilTest.java
│               └── ValidationUtilTest.java
│
└── wheelyx-frontend/                         # Presentation Layer & Web Application
    └── src/main/webapp/
        ├── WEB-INF/
        │   └── web.xml                       # Servlet 6.0 deployment descriptor & error pages
        ├── assets/
        │   ├── css/
        │   │   └── main.css                  # Custom design system with CSS custom properties
        │   ├── js/
        │   │   └── theme.js                  # Dark/Light mode switcher & dynamic UI scripts
        │   └── images/
        │       ├── logo/                     # Wheelyx brand emblems and logos
        │       └── vehicles/                 # Categorized photographic fleet assets
        ├── components/                       # Modular JSP Fragments
        │   ├── navbar.jsp                    # Global navigation bar
        │   ├── footer.jsp                    # Responsive footer
        │   ├── sidebar-customer.jsp          # Customer portal navigation
        │   ├── sidebar-owner.jsp             # Owner portal navigation
        │   ├── sidebar-admin.jsp             # Admin command center navigation
        │   └── vehicle-card.jsp              # Reusable fleet display component
        └── pages/                            # Role-Segregated JSP Views
            ├── home/                         # Landing page with interactive search
            ├── auth/                         # Login, registration, user profile
            ├── vehicles/                     # Catalog browser & detailed specification view
            ├── booking/                      # Multi-step checkout & booking confirmation
            ├── billing/                      # Tax invoices & simulated payment gateway
            ├── tracking/                     # Real-time GPS trip telemetry with radar UI
            ├── customer/                     # Customer dashboard, booking history, rentals
            ├── owner/                        # Owner dashboard, vehicle add/edit, handover dispatch
            ├── admin/                        # Admin dashboards, maintenance, users, reports, audit
            └── error/                        # Custom HTTP 403, 404, and 500 error pages
```

---

## 8. Application URL Mappings & Servlet Catalog

| URL Pattern | Servlet Class | Authorization Level | Description |
| :--- | :--- | :--- | :--- |
| `/` | `HomeServlet` | Public | Homepage featuring search, fleet showcase, and verified reviews |
| `/login` | `LoginServlet` | Public | Authentication endpoint with BCrypt verification and role redirection |
| `/register` | `RegisterServlet` | Public | Customer / Vehicle Owner registration |
| `/logout` | `LogoutServlet` | Authenticated | Session invalidation and secure logout |
| `/profile` | `ProfileServlet` | Authenticated | User account details and profile update |
| `/vehicles` | `VehicleCatalogServlet` | Public | Filterable fleet catalog (by city, hub, fuel, price, category) |
| `/vehicles/detail` | `VehicleDetailServlet` | Public | Comprehensive specifications, pricing, and customer ratings |
| `/booking` | `BookingServlet` | Customer | Concurrency-checked vehicle reservation workflow |
| `/booking/edit` | `BookingEditServlet` | Customer | Modify pickup hub, return hub, or dates for scheduled bookings |
| `/booking/cancel`| `BookingCancelServlet`| Customer / Owner / Admin | Cancel active reservation and release vehicle status |
| `/booking/confirmation`| `BookingConfirmationServlet`| Customer | Post-booking receipt with booking reference code |
| `/invoice` | `InvoiceServlet` | Customer / Owner / Admin | Detailed printable tax invoice with 18% GST breakdown |
| `/payment` | `PaymentServlet` | Customer | Simulated multi-channel payment interface (UPI, Card, Net Banking) |
| `/tracking` | `VehicleTrackingServlet` | Customer / Admin | Live GPS radar telemetry view for active rentals |
| `/api/places` | `CityPlaceApiServlet` | Public | Asynchronous AJAX JSON endpoint returning hubs for a selected city |
| `/api/location`| `VehicleLocationApiServlet`| Authenticated | Real-time GPS coordinate telemetry polling endpoint |
| `/customer/dashboard` | `CustomerDashboardServlet` | Customer | Customer overview, active rentals, and past reservations |
| `/customer/bookings` | `CustomerBookingsServlet` | Customer | Comprehensive booking ledger with edit and cancel actions |
| `/customer/rentals` | `CustomerRentalsServlet` | Customer | Active trip monitoring and post-return review triggers |
| `/customer/review` | `ReviewServlet` | Customer | Submit verified rating and review for returned vehicles |
| `/owner/dashboard` | `OwnerDashboardServlet` | Vehicle Owner | Fleet KPI statistics, pending dispatches, and returns |
| `/owner/vehicles` | `OwnerVehiclesServlet` | Vehicle Owner | Owner fleet inventory with status badges |
| `/owner/vehicles/add` | `OwnerVehicleAddServlet` | Vehicle Owner | List new commercial self-drive vehicle with image asset |
| `/owner/vehicles/edit`| `OwnerVehicleEditServlet`| Vehicle Owner | Modify pricing, deposit, terms, and hub assignments |
| `/owner/bookings` | `OwnerBookingsServlet` | Vehicle Owner | Review incoming booking requests and handover dispatch triggers |
| `/owner/rentals` | `OwnerRentalsServlet` | Vehicle Owner | Execute key handover (start odometer) and return check-in |
| `/owner/earnings` | `OwnerEarningsServlet` | Vehicle Owner | Financial earnings summary and commission analytics |
| `/admin/dashboard` | `AdminDashboardServlet` | Administrator | Platform command center with global system metrics |
| `/admin/users` | `AdminUsersServlet` | Administrator | User governance, account suspension, and role auditing |
| `/admin/vehicles` | `AdminVehiclesServlet` | Administrator | Platform-wide fleet oversight and status management |
| `/admin/bookings` | `AdminBookingsServlet` | Administrator | Complete reservation ledger with administrative controls |
| `/admin/rentals` | `AdminRentalsServlet` | Administrator | Live rental lifecycle tracking across all cities |
| `/admin/bills` | `AdminBillsServlet` | Administrator | Invoicing ledger and revenue reconciliation |
| `/admin/reviews` | `AdminReviewsServlet` | Administrator | Review moderation and customer feedback auditing |
| `/admin/maintenance` | `AdminMaintenanceServlet` | Administrator | Vehicle grounding and scheduled maintenance manager |
| `/admin/locations` | `AdminLocationsServlet` | Administrator | Operational city and landmark hub management |
| `/admin/reports` | `AdminReportsServlet` | Administrator | Chart.js visual business intelligence and trend analysis |
| `/admin/audit` | `AdminAuditServlet` | Administrator | Platform security audit log explorer |

---

## 9. Database Setup & Installation

### Step 1: Install MySQL Server 8.0+
Ensure MySQL Server 8.0 or higher is installed and active on your system.

### Step 2: Create the Database
Connect to your MySQL instance using MySQL Command Line Client or MySQL Workbench:
```sql
CREATE DATABASE IF NOT EXISTS wheelyx_vehicle_rental
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Step 3: Execute Database Scripts in Order
Execute the three database scripts located in the `wheelyx-database/` folder:

```bash
# 1. Create normalized relational tables
mysql -u root -p wheelyx_vehicle_rental < wheelyx-database/schema.sql

# 2. Apply performance and search indexes
mysql -u root -p wheelyx_vehicle_rental < wheelyx-database/indexes.sql

# 3. Seed 20 cities, 200 hubs, 6 categories, and 36 vehicles
mysql -u root -p wheelyx_vehicle_rental < wheelyx-database/seed.sql
```

*(Optional)* To inspect customer records and run audit queries in MySQL Workbench, use `wheelyx-database/view_customer_data.sql`.

---

## 10. Configuration & Environment Variables

Wheelyx uses an externalized configuration hierarchy managed by `AppConfig.java`. It first checks system environment variables, then falls back to `wheelyx-backend/src/main/resources/db.properties`.

### Configuration Template
Copy `configuration-example.properties` to `wheelyx-backend/src/main/resources/db.properties`:

```properties
# =====================================================================
# Wheelyx Platform — Configuration Template
# =====================================================================

# Database Connection Settings
db.host=localhost
db.port=3306
db.name=wheelyx_vehicle_rental
db.username=root
db.password=YOUR_LOCAL_MYSQL_PASSWORD

# HikariCP Connection Pool Settings
db.pool.minIdle=5
db.pool.maxPoolSize=20
db.pool.connectionTimeout=30000

# Google Maps API Key (Optional: Radar and Leaflet fallback active when empty)
google.maps.api.key=

# File Upload Directory for Vehicle Images
upload.dir=./uploads/vehicles
```

### Environment Variable Overrides (Recommended for Production)
You can configure settings via environment variables without modifying configuration files:
- `DB_HOST` (e.g., `localhost`)
- `DB_PORT` (e.g., `3306`)
- `DB_NAME` (e.g., `wheelyx_vehicle_rental`)
- `DB_USERNAME` (e.g., `wheelyx_user`)
- `DB_PASSWORD` (Your secure database password)
- `GOOGLE_MAPS_API_KEY` (Optional Google Maps API key)

> [!IMPORTANT]
> Never commit active database passwords, private keys, or API tokens to version control. Keep `db.properties` in your `.gitignore`.

---

## 11. Building & Deploying to Apache Tomcat

### Prerequisites
- **JDK 17 or higher** (Oracle JDK, Eclipse Temurin, or OpenJDK)
- **Apache Maven 3.9+**
- **Apache Tomcat 10.1+** (Requires Jakarta EE 10 servlet container)
- **MySQL 8.0+**

### Step 1: Compile and Package the Maven WAR
From the repository root directory, execute:
```bash
mvn clean package
```
Maven will compile the backend classes, execute unit test suites, bundle the web application resources from `wheelyx-frontend/`, and generate the artifact at:
`target/wheelyx.war`

### Step 2: Deploy WAR to Apache Tomcat
Copy the generated WAR archive into your Tomcat `webapps/` folder:

**Windows:**
```cmd
copy target\wheelyx.war %CATALINA_HOME%\webapps\
```

**Linux / macOS:**
```bash
cp target/wheelyx.war $CATALINA_HOME/webapps/
```

### Step 3: Start Apache Tomcat

**Windows:**
```cmd
%CATALINA_HOME%\bin\startup.bat
```

**Linux / macOS:**
```bash
$CATALINA_HOME/bin/startup.sh
```

### Step 4: Access Wheelyx in Browser
Open your browser and navigate to:
```
http://localhost:8080/wheelyx/
```

---

## 12. Quick Start Automation Scripts (Windows)

For rapid local testing and demonstrations, convenient automation scripts are provided in the repository root:

### 1. `START_WHEELYX.bat`
- Checks whether the local MySQL Windows service (`MySQL80`) is running and starts it if necessary.
- Boots Apache Tomcat 10.1 in a detached background console window.
- Automatically launches your default web browser directly to `http://localhost:8080/wheelyx/`.

```cmd
START_WHEELYX.bat
```

### 2. `STOP_WHEELYX.bat`
- Gracefully shuts down the Apache Tomcat server process.

```cmd
STOP_WHEELYX.bat
```

### 3. `SHARE_ON_ANY_DEVICE.bat` (Public Mobile Testing)
- Leverages the bundled, lightweight `cloudflared.exe` utility to establish a secure, instant HTTPS tunnel to your local Wheelyx instance without port forwarding, dynamic DNS, or ngrok configuration.
- Outputs a secure public URL (e.g., `https://xxxx-xxxx.trycloudflare.com/wheelyx/`).
- Allows you to test responsive layouts and perform live booking flows from any physical smartphone, tablet, or remote PC anywhere in the world.

```cmd
SHARE_ON_ANY_DEVICE.bat
```

---

## 13. Docker Deployment

A production-ready, multi-stage `Dockerfile` is provided at the root of the repository.

### Build and Run with Docker

```bash
# 1. Build the Docker container image
docker build -t wheelyx .

# 2. Run the container with environment variables
docker run -d -p 8080:8080 \
  -e DB_HOST=host.docker.internal \
  -e DB_PORT=3306 \
  -e DB_NAME=wheelyx_vehicle_rental \
  -e DB_USERNAME=root \
  -e DB_PASSWORD=YOUR_SECURE_PASSWORD \
  --name wheelyx-app \
  wheelyx
```

The application will be accessible at:
```
http://localhost:8080/
```

---

## 14. Pre-Seeded Demonstration Accounts

For evaluation and testing purposes, `seed.sql` populates default demonstration accounts representing each platform role:

| Role | Email Address | Default Demo Password | Access Rights & Responsibilities |
| :--- | :--- | :--- | :--- |
| **System Administrator** | `admin@wheelyx.com` | `Admin@123` | Complete command center access, maintenance scheduler, user governance, audit explorer |
| **Vehicle Owner (Elite Fleet)** | `owner@wheelyx.com` | `Owner@123` | Fleet management, vehicle onboarding, key dispatch handover, return check-in |
| **Vehicle Owner (Apex Rides)** | `owner2@wheelyx.com` | `Owner@123` | Additional owner account with listings in Mumbai, Hyderabad, and Pune |
| **Customer** | `customer@wheelyx.com` | `Customer@123` | Vehicle reservations, simulated payments, live trip radar tracking, verified reviews |

> [!WARNING]
> The demonstration credentials above are generated solely for local evaluation environments. For production deployments, all administrative and user credentials must be modified immediately.

---

## 15. Security Architecture & Quality Engineering

- **SQL Injection Prevention:** 100% of database interactions across all 15 DAOs utilize parameterized `PreparedStatement` queries. No raw user strings are concatenated into SQL queries.
- **BCrypt Password Hashing:** Industry-standard adaptive hashing using 12 salt rounds via `PasswordUtil.java`.
- **Role Isolation & Session Guards:** Custom Jakarta EE filters intercept all protected paths, immediately invalidating unauthorized session attempts.
- **Cross-Site Scripting (XSS) Mitigation:** Input strings are sanitized via `SecurityUtil.sanitizeHtml()`, converting special characters into safe HTML entities.
- **CSRF Token Validation:** Transactional actions validate unique, crypto-random session tokens.
- **Audit Logging:** Administrative and financial events record client IP addresses and user actions in the `audit_logs` table.
- **Comprehensive Unit Testing:** JUnit 5 test cases (`src/test/java/com/wheelyx`) validate billing calculations, password hashing, date range validations, and database connectivity. Run tests via:
  ```bash
  mvn test
  ```

---

## 16. 10-Week Development Timeline & Progress Tracking

### Progress Summary
- **Project Start Date:** 06 July 2026
- **Project Completion Date:** 13 September 2026
- **Total Duration:** 10 Weeks (70 Days)
- **Completed Weeks:** 10 / 10 (100% Progress)
- **Pending Weeks:** 0 / 10 (0% Pending)

### Weekly Progress Tracking Table

| Week # | Date Interval | Milestone & Core Focus | Weekly Work Description in Brief | Status | Detailed Report |
| :---: | :---: | :--- | :--- | :---: | :---: |
| **Week 1** | 06 Jul 2026 – 12 Jul 2026 | Team Formation + Guide Selection + Abstract | Finalized project concept, formed development team, selected faculty project guide, and submitted official Wheelyx abstract proposal. | `Completed` | [Week 1 Report](reports/04-weekly-progress/week-01/README.md) |
| **Week 2** | 13 Jul 2026 – 19 Jul 2026 | Software Requirements Specification (SRS) | Formulated IEEE 830 functional and non-functional requirements, mapped user roles (Customer, Owner, Admin), and defined architectural constraints. | `Completed` | [Week 2 Report](reports/04-weekly-progress/week-02/README.md) |
| **Week 3** | 20 Jul 2026 – 26 Jul 2026 | UML Design & System Modeling | Created UML Use-Case diagrams, domain Class diagrams, Sequence workflows for booking and key dispatch handovers, and state machines. | `Completed` | [Week 3 Report](reports/04-weekly-progress/week-03/README.md) |
| **Week 4** | 27 Jul 2026 – 02 Aug 2026 | Database Design & UI Mockups / Wireframes | Designed 17 normalized MySQL 3NF tables, performance B-tree indexes, authored seed datasets (20 cities, 200 hubs, 36 vehicles), and built HTML/CSS mockups. | `Completed` | [Week 4 Report](reports/04-weekly-progress/week-04/README.md) |
| **Week 5** | 03 Aug 2026 – 09 Aug 2026 | Module Coding: Auth, RBAC & Connection Pool | Engineered HikariCP pool, BCrypt hashing (12 rounds), session handlers, and Jakarta EE security filters (`CustomerAuthFilter`, `OwnerAuthFilter`, `AdminAuthFilter`). | `Completed` | [Week 5 Report](reports/04-weekly-progress/week-05/README.md) |
| **Week 6** | 10 Aug 2026 – 16 Aug 2026 | Module Coding: Vehicle Catalog, Search & Cities | Built multi-parameter vehicle catalog search, implemented AJAX landmark retrieval (`/api/places`), and owner vehicle onboarding/listing tools. | `Completed` | [Week 6 Report](reports/04-weekly-progress/week-06/README.md) |
| **Week 7** | 17 Aug 2026 – 23 Aug 2026 | Module Coding: Concurrency Booking & Handover | Implemented atomic date-range overlap validation, pricing quotation service (18% GST, 10% discount for >= 7 days), and key dispatch handover workflow. | `Completed` | [Week 7 Report](reports/04-weekly-progress/week-07/README.md) |
| **Week 8** | 24 Aug 2026 – 30 Aug 2026 | Module Coding: Billing, Telemetry & Reviews | Implemented GST tax invoicing, multi-channel payment simulator (UPI, Card), live GPS radar telemetry dashboard, and verified post-trip customer reviews. | `Completed` | [Week 8 Report](reports/04-weekly-progress/week-08/README.md) |
| **Week 9** | 31 Aug 2026 – 06 Sep 2026 | Subsystem Integration & Automated Testing | Merged branches into `wheelyx-integration`, ran 24+ JUnit 5 test suites, resolved edge-case race conditions, and validated mobile tunnel sharing via Cloudflare. | `Completed` | [Week 9 Report](reports/04-weekly-progress/week-09/README.md) |
| **Week 10** | 07 Sep 2026 – 13 Sep 2026 | Final Report + PPT + Video + Final Viva Prep | Compiled comprehensive project dissertation, designed 15-slide presentation deck (PPT), recorded demo video, and completed individual viva preparations. | `Completed` | [Week 10 Report](reports/04-weekly-progress/week-10/README.md) |

---

## 17. Project Documentation & Academic Reports (9 Components)

The project documentation is structured in [`reports/`](reports/) across 9 specialized components:

| Component | Title | Key Contents | Documentation Link |
| :---: | :--- | :--- | :--- |
| **01** | **Idea & Abstract** | Problem statement, proposed solution, innovation highlights | [`reports/01-idea-abstract/`](reports/01-idea-abstract/README.md) |
| **02** | **SRS / Documentation** | IEEE 830 functional & non-functional requirements | [`reports/02-srs/`](reports/02-srs/README.md) |
| **03** | **Design (Use-case, Class, ER)** | System models, sequence flows, Mermaid sources & ER diagram | [`reports/03-design/`](reports/03-design/README.md) |
| **04** | **Weekly Progress** | 10-Week reports, commit logs (`commit_log.csv`), velocity analytics | [`reports/04-weekly-progress/`](reports/04-weekly-progress/README.md) |
| **05** | **Implementation & Code Quality** | Layered MVC, security filters, DAO patterns & metrics | [`reports/05-implementation/`](reports/05-implementation/README.md) |
| **06** | **Testing** | Automated JUnit 5 test suites & verification results | [`reports/06-testing/`](reports/06-testing/README.md) |
| **07** | **Presentation** | 15-Slide Presentation Deck structure & storyline | [`reports/07-presentation/`](reports/07-presentation/README.md) |
| **08** | **Demo & Viva (Individual)** | 4-Phase demonstration walkthrough script & Viva Q&A guide | [`reports/08-demo-viva/`](reports/08-demo-viva/README.md) |
| **09** | **Timeline** | Master 10-Week schedule table without report links | [`reports/09-timeline/`](reports/09-timeline/README.md) |

---

## 18. Git Development & Branching Strategy

The Wheelyx repository follows a structured 5-branch modular development lifecycle:

1. `main`: Production-ready release branch containing stable, unified releases.
2. `wheelyx-frontend`: Presentation layer, JSP views, components, CSS design system, and client-side scripts.
3. `wheelyx-backend`: Java enterprise source code, controllers, service business logic, DAOs, and security filters.
4. `wheelyx-database`: Relational database schemas, migrations, performance indexes, and seed datasets.
5. `wheelyx-testing`: JUnit 5 unit test suites and integration validation routines.
6. `wheelyx-integration`: Unified staging branch used to merge and test subsystems prior to tagging production releases.

---

## 19. License & Attribution

Designed and developed as an integrated vehicle rental and fleet management platform demonstration.
