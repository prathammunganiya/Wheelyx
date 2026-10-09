# WHEELYX
### Integrated Vehicle Rental and Fleet Management Platform

> **"Move Your Way."**  
> *Find, book and manage your perfect ride with ease.*

---

## 1. Overview

**Wheelyx** is a full-stack, enterprise-grade vehicle rental and fleet management platform engineered using Java Jakarta Servlets, JDBC, and MySQL. It provides strict role separation and dedicated dashboards for three distinct user types:

1. **Customer / User:** Search 36 real vehicle models across 20 major Indian cities, reserve self-drive vehicles, track trips with live GPS telemetry, inspect bills, complete simulated payments (UPI, Card, Net Banking, Cash), and leave verified reviews post-trip.
2. **Vehicle Owner:** List commercial self-drive vehicles with real-world city landmarks, dispatch key handovers with starting odometer inspections, check returning vehicles, track active fleet, and monitor earnings.
3. **Platform Administrator:** Complete command center over users, vehicles, reservations, rental lifecycles, billing, verified customer feedback, grounding vehicles for fleet maintenance, and auditing platform security logs.

---

## 2. Technology Stack

- **Architecture:** MVC (Model - View - Controller), Service Layer, DAO Layer, JDBC
- **Backend:** Java 17+ (JDK 25 compatible), Jakarta Servlet API 6.0, HikariCP Connection Pool, BCrypt (12 rounds), Gson
- **Frontend:** JSP, HTML5, CSS3, Vanilla JavaScript, Bootstrap 5.3, Bootstrap Icons 1.11, Chart.js 4.4
- **Database:** MySQL 8.0+
- **Application Server:** Apache Tomcat 10.1+ (Jakarta EE 10 namespace)
- **Build System:** Apache Maven 3.9+
- **Version Control:** Git (5 development branches)

---

## 3. Real Fleet and Geographic Coverage

### 6 Vehicle Categories & 36 Real Vehicles
- **Cars (6):** Maruti Swift, Hyundai i20, Tata Altroz, Honda City, Hyundai Creta, Kia Seltos
- **Bikes (6):** Hero Splendor Plus, Bajaj Pulsar 150, Yamaha FZ-FI, Yamaha MT-15, KTM Duke 250, Royal Enfield Classic 350
- **Petrol Scooters (6):** Honda Activa 6G, Honda Activa 125, Honda Dio, TVS Jupiter 125, TVS Ntorq 125, Yamaha Aerox 155
- **EV Scooters (6):** Ola S1 Pro, Ather 450X, Ather Rizta, TVS iQube, Bajaj Chetak, Suzuki e-Access
- **EV Cars (6):** Tata Tiago EV, Tata Punch EV, Tata Nexon EV, MG Comet EV, MG ZS EV, Hyundai Creta Electric
- **Premium Vehicles (6):** BMW 3 Series, Mercedes-Benz C-Class, Audi A4, Volvo S90, BMW X3, Mercedes-Benz GLC

### 20 Real Indian Cities & 200 Real Pickup Hubs
Delhi, Mumbai, Bengaluru, Hyderabad, Chennai, Kolkata, Pune, Ahmedabad, Jaipur, Lucknow, Chandigarh, Indore, Bhopal, Surat, Nagpur, Patna, Varanasi, Agra, Amritsar, and Udaipur. Each city features 10 authentic, verifiable landmark hubs.

---

## 4. Database Setup & Installation

### Step 1: Install MySQL 8.0
Ensure MySQL Server 8.0 or higher is installed and running on your system.

### Step 2: Create the Database
Open MySQL Command Line or Workbench:
```sql
CREATE DATABASE IF NOT EXISTS wheelyx_vehicle_rental
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Step 3: Run SQL Scripts in Order
Execute the three database scripts located in `wheelyx-database/`:
```bash
# 1. Create normalized tables
mysql -u root -p wheelyx_vehicle_rental < wheelyx-database/schema.sql

# 2. Create performance indexes
mysql -u root -p wheelyx_vehicle_rental < wheelyx-database/indexes.sql

# 3. Seed real fleet, categories, 20 cities, and 200 landmarks
mysql -u root -p wheelyx_vehicle_rental < wheelyx-database/seed.sql
```

### Step 4: Configure Database Credentials
Copy `configuration-example.properties` to `wheelyx-backend/src/main/resources/db.properties` (or set environment variables):
```properties
db.host=localhost
db.port=3306
db.name=wheelyx_vehicle_rental
db.username=root
db.password=YourSecurePassword
db.pool.max=20
db.pool.min=5

# Optional: Google Maps Telemetry API Key (Application provides graceful fallback if left blank)
google.maps.api.key=
```

---

## 5. Building & Deploying to Apache Tomcat

### Step 1: Build the Maven WAR
From the repository root directory, execute:
```bash
mvn clean package
```
This runs the full JUnit 5 test suite and outputs the deployable archive at:
`target/wheelyx.war`

### Step 2: Deploy to Tomcat 10.1
Copy `target/wheelyx.war` into Tomcat's `webapps/` folder:
```bash
# Windows
copy target\wheelyx.war %CATALINA_HOME%\webapps\

# Linux / macOS
cp target/wheelyx.war $CATALINA_HOME/webapps/
```

### Step 3: Start Apache Tomcat
```bash
# Windows
%CATALINA_HOME%\bin\startup.bat

# Linux / macOS
$CATALINA_HOME/bin/startup.sh
```

### Step 4: Access Wheelyx in Browser
Open your browser and navigate to:
```
http://localhost:8080/wheelyx/
```

---

## 7. Security & Key Features

- **Strict Role Separation:** Dynamic `CustomerAuthFilter`, `OwnerAuthFilter`, and `AdminAuthFilter` protect private routes. Cross-role tampering is blocked with session validation.
- **SQL Injection Prevention:** Every database query exclusively uses parameterized `PreparedStatement`.
- **Zero Fake Reviews:** Reviews section begins in a clean empty state and dynamically renders authentic feedback only after a customer completes and returns a rental.
- **Edit & Cancel:** Every user-facing transaction form (bookings, vehicle listings, maintenance work orders) contains functional **Edit Details** and **Cancel** controls.
- **GPS Telemetry Architecture:** Supports simulated and telematics vehicle tracking with graceful degradation when Google Maps API key is unconfigured.
- **Light & Dark Mode:** Accessible color system persisted via `localStorage`.

---

## 8. Git Branching Strategy

The repository structure follows a clean 5-branch release lifecycle:
1. `main`: Production-ready stable release.
2. `wheelyx-frontend`: JSP pages, components, CSS design system, and client-side interactions.
3. `wheelyx-backend`: Controllers, Services, DAOs, Security Filters, and utilities.
4. `wheelyx-database`: Schema definitions, indexes, migrations, and seed datasets.
5. `wheelyx-testing`: JUnit 5 test suite and integration tests.
6. `wheelyx-integration`: Unified staging branch merging all subsystems into `main`.

---

## 9. License & Attribution

Designed and developed as an integrated vehicle rental and fleet management platform demonstration.
