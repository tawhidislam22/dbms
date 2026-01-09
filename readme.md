# Vehicle Rental System - Database Design & SQL Queries

## Overview & Objectives

This assignment is designed to evaluate your understanding of database table design, ERD relationships and SQL queries. You will work with a simplified Vehicle Rental System database.

By completing this assignment, you will be able to:

- Design an ERD with 1 to 1, 1 to Many and Many to 1 relationships
- Understand primary keys and foreign keys
- Write SQL queries using JOIN, EXISTS and WHERE

---

## Database Design & Business Logic

The system manages:

- **Users**
- **Vehicles**
- **Bookings**

---

## Business Logic - What Your Database Must Handle

Your database design should support these real world scenarios:

### Users Table Must Store:

- User role (Admin or Customer)
- Name, email, password, phone number
- Each email must be unique (no duplicate accounts)

**Fields:**
- `user_id` (Primary Key, Auto Increment)
- `name` (VARCHAR, NOT NULL)
- `email` (VARCHAR, UNIQUE, NOT NULL)
- `password` (VARCHAR, NOT NULL)
- `phone_number` (VARCHAR)
- `role` (ENUM: 'Admin', 'Customer', DEFAULT 'Customer')

---

### Vehicles Table Must Store:

- Vehicle name, type (car/bike/truck), model
- Registration number (must be unique)
- Rental price per day
- Availability status (available/rented/maintenance)

**Fields:**
- `vehicle_id` (Primary Key, Auto Increment)
- `name` (VARCHAR, NOT NULL)
- `type` (ENUM: 'car', 'bike', 'truck', NOT NULL)
- `model` (VARCHAR, NOT NULL)
- `registration_number` (VARCHAR, UNIQUE, NOT NULL)
- `rental_price_per_day` (DECIMAL, NOT NULL)
- `availability_status` (ENUM: 'available', 'rented', 'maintenance', DEFAULT 'available')

---

### Bookings Table Must Store:

- Which user made the booking (link to Users table)
- Which vehicle was booked (link to Vehicles table)
- Start date and end date of rental
- Booking status (pending/confirmed/completed/cancelled)
- Total cost of the booking

**Fields:**
- `booking_id` (Primary Key, Auto Increment)
- `user_id` (Foreign Key → Users.user_id)
- `vehicle_id` (Foreign Key → Vehicles.vehicle_id)
- `start_date` (DATE, NOT NULL)
- `end_date` (DATE, NOT NULL)
- `booking_status` (ENUM: 'pending', 'confirmed', 'completed', 'cancelled', DEFAULT 'pending')
- `total_cost` (DECIMAL, NOT NULL)

---

## ERD Relationships

- **Users → Bookings**: One-to-Many (One user can make multiple bookings)
- **Vehicles → Bookings**: One-to-Many (One vehicle can have multiple bookings over time)
- **Bookings → Users**: Many-to-One (Many bookings belong to one user)
- **Bookings → Vehicles**: Many-to-One (Many bookings belong to one vehicle)

---

## Getting Started

1. Review the database schema in `db.sql`
2. Understand the relationships between tables
3. Practice writing SQL queries with JOIN, EXISTS, and WHERE clauses
4. Test your queries to ensure they return expected results

---

## Technologies Used

- SQL (MySQL/PostgreSQL)
- Database Design Principles
- ERD Modeling

---

## Author

**Tawhid Islam**
