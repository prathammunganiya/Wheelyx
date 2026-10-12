# Component 03: System Design — UML & ER Models

## 1. Architectural Overview
Wheelyx is designed using an enterprise **Layered Architecture** adhering to the **Model-View-Controller (MVC)** design pattern:

```
[Presentation Layer]   JSP 3.1, JSTL, Bootstrap 5.3, Vanilla JavaScript, Chart.js
         │
         ▼ (HTTP Requests & Session Cookies)
[Security Filter Layer] CustomerAuthFilter, OwnerAuthFilter, AdminAuthFilter, CharsetEncodingFilter
         │
         ▼
[Controller Layer]      38 Jakarta Servlets (@WebServlet annotated controllers)
         │
         ▼
[Service Layer]         BookingService, RentalService, AuthService, FleetService, BillingService, etc.
         │
         ▼
[Data Access Layer]     15 Data Access Objects (DAO) executing Parameterized PreparedStatements
         │
         ▼
[Connection Pool Layer] HikariCP Connection Pool (Min: 5, Max: 20)
         │
         ▼ (TCP Port 3306)
[Database Layer]        MySQL 8.0 Engine (InnoDB, UTF-8 MB4)
```

---

## 2. Diagram Resources & Sources
- Raw Mermaid diagram source code is available in [`mermaid_source/`](mermaid_source/):
  - [`use_case_diagram.mmd`](mermaid_source/use_case_diagram.mmd)
  - [`class_diagram.mmd`](mermaid_source/class_diagram.mmd)
  - [`sequence_booking.mmd`](mermaid_source/sequence_booking.mmd)
  - [`er_diagram.mmd`](mermaid_source/er_diagram.mmd)
- Visual diagram exports are located in [`images/`](images/).

---

## 3. Platform Use-Case Model

```mermaid
flowchart LR
    Customer((Customer))
    Owner((Vehicle Owner))
    Admin((Platform Admin))

    subgraph Wheelyx Platform
        UC1[Browse & Filter Fleet]
        UC2[Book Vehicle & Checkout]
        UC3[Live GPS Tracking]
        UC4[Submit Verified Review]
        UC5[List / Edit Vehicle]
        UC6[Dispatch Handover / Return]
        UC7[View Earnings & Fleet KPIs]
        UC8[User Governance]
        UC9[Fleet Grounding & Maintenance]
        UC10[Audit Logs & Reports]
    end

    Customer --> UC1
    Customer --> UC2
    Customer --> UC3
    Customer --> UC4

    Owner --> UC5
    Owner --> UC6
    Owner --> UC7

    Admin --> UC8
    Admin --> UC9
    Admin --> UC10
    Admin --> UC1
```

---

## 4. Class Diagram & Entity Relationships

```mermaid
classDiagram
    class User {
        +Long id
        +String name
        +String email
        +String phone
        +String passwordHash
        +String role
        +String status
    }

    class Vehicle {
        +Long id
        +Long ownerId
        +Integer categoryId
        +Integer cityId
        +Long placeId
        +String brand
        +String modelName
        +String registrationNo
        +BigDecimal pricePerDay
        +BigDecimal securityDeposit
        +String status
    }

    class Booking {
        +Long id
        +String bookingCode
        +Long customerId
        +Long vehicleId
        +LocalDate startDate
        +LocalDate endDate
        +Integer durationDays
        +BigDecimal totalAmount
        +String status
    }

    class Rental {
        +Long id
        +String rentalCode
        +Long bookingId
        +Timestamp handoverTime
        +Timestamp returnTime
        +int startOdometer
        +int endOdometer
        +String status
    }

    class Bill {
        +Long id
        +String billNo
        +Long bookingId
        +BigDecimal baseAmount
        +BigDecimal taxAmount
        +BigDecimal finalAmount
        +String status
    }

    class Review {
        +Long id
        +Long rentalId
        +Long customerId
        +Long vehicleId
        +int rating
        +String comment
    }

    User "1" --> "*" Booking : places
    Vehicle "1" --> "*" Booking : reserved for
    Booking "1" --> "1" Rental : initiates
    Booking "1" --> "1" Bill : generates
    Rental "1" --> "0..1" Review : verified by
```

---

## 5. Sequence Diagram: Booking & Handover Lifecycle

```mermaid
sequenceDiagram
    autonumber
    actor Customer
    actor Owner
    participant BookingServlet
    participant BookingService
    participant VehicleDAO
    participant BookingDAO
    participant RentalService
    participant Database

    Customer->>BookingServlet: Submit Reservation Request (Dates, Hubs)
    BookingServlet->>BookingService: createBooking(params)
    BookingService->>VehicleDAO: checkAvailability(vehicleId, start, end)
    VehicleDAO->>Database: Query overlapping bookings
    Database-->>VehicleDAO: Available (True)
    BookingService->>BookingDAO: Persist booking & generate Bill
    BookingService->>VehicleDAO: Set vehicle status -> BOOKED
    BookingService-->>BookingServlet: Booking Confirmed (WX-BK-XXXX)
    BookingServlet-->>Customer: Display Confirmation & Invoice

    Note over Owner, RentalService: At Pickup Hub during Handover
    Owner->>RentalService: dispatchHandover(bookingId, startOdo, fuel)
    RentalService->>Database: Insert into rentals (ACTIVE_RENTAL)
    RentalService->>VehicleDAO: Set vehicle status -> ACTIVE_RENTAL
    RentalService-->>Customer: Notification: Trip Started & Tracking Live!
```
