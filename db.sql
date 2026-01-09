CREATE TABLE IF NOT EXISTS Users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255),
  phone_number VARCHAR(20) NOT NULL,
  role VARCHAR(10) NOT NULL,
  CONSTRAINT chk_role CHECK (role IN ('admin', 'customer')),
  CONSTRAINT chk_email_lowercase CHECK (email = LOWER(email)),
  CONSTRAINT chk_password_length CHECK (LENGTH(password) >= 6)
);

CREATE TABLE IF NOT EXISTS Vehicles (
  vehicle_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(10) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
  model varchar(4) not null,
  registration_number VARCHAR(50) NOT NULL UNIQUE,
  rental_price DECIMAL(10, 2) NOT NULL CHECK (rental_price > 0),
  status VARCHAR(15) DEFAULT 'available' CHECK (status IN ('available', 'rented', 'maintenance'))
);

CREATE TABLE IF NOT EXISTS Bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  vehicle_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(15) DEFAULT 'active' CHECK (
    status IN ('pending', 'confirmed', 'completed', 'cancelled')
  ),
  total_cost DECIMAL(10, 2) NOT NULL CHECK (total_cost >= 0),
  CONSTRAINT fk_customer FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE,
  CONSTRAINT fk_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicles (vehicle_id) ON DELETE CASCADE,
  CONSTRAINT chk_booking_dates CHECK (end_date > start_date)
);

INSERT INTO
  users (name, email, phone_number, role)
VALUES
  (
    'Alice',
    'alice@example.com',
    '1234567890',
    'customer'
  ),
  ('Bob', 'bob@example.com', '0987654321', 'admin'),
  (
    'Charlie',
    'charlie@example.com',
    '1122334455',
    'customer'
  );

INSERT INTO
  vehicles (
    name,
    type,
    model,
    registration_number,
    rental_price,
    status
  )
VALUES
  (
    'Toyota Corolla',
    'car',
    2022,
    'ABC-123',
    50,
    'available'
  ),
  (
    'Honda Civic',
    'car',
    2021,
    'DEF-456',
    60,
    'rented'
  ),
  (
    'Yamaha R15',
    'bike',
    2023,
    'GHI-789',
    30,
    'available'
  ),
  (
    'Ford F-150',
    'truck',
    2020,
    'JKL-012',
    100,
    'maintenance'
  );

INSERT INTO
  bookings (
    user_id,
    vehicle_id,
    start_date,
    end_date,
    status,
    total_cost
  )
VALUES
  (
    1,
    2,
    '2023-10-01',
    '2023-10-05',
    'completed',
    240
  ),
  (
    1,
    2,
    '2023-11-01',
    '2023-11-03',
    'completed',
    120
  ),
  (3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
  (1, 1, '2023-12-10', '2023-12-12', 'pending', 100);

select
  booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  start_date,
  end_date,
  b.status
from
  bookings as b
  join users as u on b.user_id = u.user_id
  join vehicles as v on b.vehicle_id = v.vehicle_id;

select
  *
from
  vehicles
where
  vehicle_id not in (
    select
      vehicle_id
    from
      bookings
  );

select
  *
from
  vehicles
where
  status = 'available'
  and type = 'car';

select name as vehicle_name,total_bookings from vehicles as v join (SELECT count(*) as total_bookings,vehicle_id
FROM bookings
GROUP BY vehicle_id
HAVING COUNT(*) > 2) as b on v.vehicle_id=b.vehicle_id;

