-- =====================================================================
-- Wheelyx Vehicle Rental - Customer Data Queries for MySQL Workbench
-- Use this script in MySQL Workbench to view and manage customer data.
-- =====================================================================

USE wheelyx_vehicle_rental;

-- 1. View all Customer Profiles (Registered Customers)
SELECT 
    id AS customer_id,
    name,
    email,
    phone,
    role,
    status,
    created_at AS registered_on
FROM users
WHERE role = 'CUSTOMER'
ORDER BY id DESC;

-- 2. View All Customer Bookings with Vehicle & Pricing details
SELECT 
    b.id AS booking_id,
    b.booking_code,
    u.name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    CONCAT(v.brand, ' ', v.model_name) AS vehicle_rented,
    v.registration_no,
    c.city_name,
    b.start_date,
    b.end_date,
    b.duration_days,
    b.total_amount,
    b.status AS booking_status,
    b.created_at AS booked_at
FROM bookings b
JOIN users u ON b.customer_id = u.id
JOIN vehicles v ON b.vehicle_id = v.id
JOIN cities c ON b.city_id = c.id
ORDER BY b.id DESC;

-- 3. View Customer Payments & Transactions
SELECT 
    p.id AS payment_id,
    p.transaction_id,
    u.name AS customer_name,
    b.booking_code,
    p.payment_method,
    p.amount,
    p.status AS payment_status,
    p.payment_date
FROM payments p
JOIN users u ON p.customer_id = u.id
LEFT JOIN bookings b ON p.booking_id = b.id
ORDER BY p.id DESC;

-- 4. View Customer Reviews & Ratings
SELECT 
    r.id AS review_id,
    u.name AS customer_name,
    CONCAT(v.brand, ' ', v.model_name) AS vehicle,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM reviews r
JOIN users u ON r.customer_id = u.id
JOIN vehicles v ON r.vehicle_id = v.id
ORDER BY r.id DESC;
