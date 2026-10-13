# Design Images Directory

This directory stores visual system architecture diagrams, database entity-relationship schema visualizations, and exported UML diagram assets for Wheelyx:

### Architecture & Component Models
- `component_architecture.png` (`architecture_overview.png`): Component Architecture diagram detailing Browser UI, Controllers, Security Filters, Service Layer, DAO/JDBC, and MySQL.
- `deployment_architecture.png`: Deployment Architecture diagram covering Client Devices, Apache Tomcat application server, and MySQL database server.
- `package_diagram.png`: Java Package diagram illustrating dependencies across `presentation`, `service`, `dao`, `model`, and `config/util/filter` packages.

### Use Case & Requirements Models
- `use_case_diagram.png`: Multi-actor platform use-case diagram detailing Admin, Vehicle Owner, and Customer functionalities.

### Data & Structural Models
- `class_diagram.png`: Domain Class diagram showing domain models, attributes, methods, and relationships.
- `database_er_diagram.png` (`er_diagram.png`): Entity-Relationship (ER) schema diagram of the Wheelyx relational database models and tables.

### Behavioral & Sequence Models
- `sequence_booking.png` (`sequence_booking_flow.png`): Sequence diagram for the vehicle booking flow (Customer -> JSP/Browser -> BookingServlet -> BookingService -> BookingDAO -> MySQL).
- `sequence_rental_payment.png`: Sequence diagram for rental start, dispatch, payment processing, and database updates.
- `sequence_user_login.png`: Sequence diagram for user authentication, password verification, and session redirection.

### Process & Activity Models
- `activity_booking_process.png`: Activity diagram for the end-to-end vehicle booking workflow with validation and availability branches.
- `activity_rental_return.png`: Activity diagram for the rental activation, usage, vehicle return, condition inspection, billing, and maintenance workflow.

### State Machine Models
- `vehicle_lifecycle_state_diagram.png`: Finite state machine diagram modeling vehicle statuses (`PENDING_APPROVAL`, `AVAILABLE`, `BOOKED`, `ACTIVE_RENTAL`, `RETURNED`, `MAINTENANCE`, `REJECTED`, `UNAVAILABLE`).

*(Note: Raw diagram sources are maintained in `../mermaid_source/` in standard Mermaid format).*
