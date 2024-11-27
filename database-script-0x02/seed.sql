USE airbnb_db;

-- Insert Sample Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  (UUID(), 'John', 'Doe', 'john.doe@example.com', 'hashedpassword1', '123-456-7890', 'guest'),
  (UUID(), 'Alice', 'Smith', 'alice.smith@example.com', 'hashedpassword2', '987-654-3210', 'host'),
  (UUID(), 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashedpassword3', '555-123-4567', 'admin'),
  (UUID(), 'Eve', 'Williams', 'eve.williams@example.com', 'hashedpassword4', '444-555-6666', 'guest'),
  (UUID(), 'Charlie', 'Brown', 'charlie.brown@example.com', 'hashedpassword5', '777-888-9999', 'host');

-- Insert Sample Properties
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at)
VALUES
  (UUID(), (SELECT user_id FROM User WHERE email = 'alice.smith@example.com'), 'Cozy Apartment', 'A lovely 2-bedroom apartment in the city center, perfect for short stays.', 'New York, NY', 150.00, CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM User WHERE email = 'charlie.brown@example.com'), 'Luxury Penthouse', 'A spacious penthouse with amazing city views and modern amenities.', 'Los Angeles, CA', 500.00, CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM User WHERE email = 'alice.smith@example.com'), 'Beachfront Cottage', 'Charming 1-bedroom cottage just steps away from the beach.', 'Miami, FL', 200.00, CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM User WHERE email = 'charlie.brown@example.com'), 'Mountain Retreat', 'Relax and enjoy nature in this cozy mountain cabin.', 'Aspen, CO', 250.00, CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM User WHERE email = 'bob.johnson@example.com'), 'Modern Loft', 'Stylish and spacious loft located in a prime downtown area.', 'Chicago, IL', 180.00, CURRENT_TIMESTAMP);

-- Insert Sample Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Cozy Apartment' AND location = 'New York, NY'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), '2024-12-01', '2024-12-07', 900.00, 'confirmed', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Luxury Penthouse' AND location = 'Los Angeles, CA'), (SELECT user_id FROM User WHERE email = 'eve.williams@example.com'), '2024-12-10', '2024-12-15', 2500.00, 'pending', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Beachfront Cottage' AND location = 'Miami, FL'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), '2024-11-20', '2024-11-25', 1000.00, 'confirmed', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Mountain Retreat' AND location = 'Aspen, CO'), (SELECT user_id FROM User WHERE email = 'bob.johnson@example.com'), '2024-12-05', '2024-12-12', 1750.00, 'canceled', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Modern Loft' AND location = 'Chicago, IL'), (SELECT user_id FROM User WHERE email = 'charlie.brown@example.com'), '2024-12-15', '2024-12-20', 900.00, 'confirmed', CURRENT_TIMESTAMP);

-- Insert Sample Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method, payment_status, payment_date)
VALUES
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'confirmed' AND property_id = (SELECT property_id FROM Property WHERE name = 'Cozy Apartment')), 900.00, 'credit_card', 'completed', CURRENT_TIMESTAMP),
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'pending' AND property_id = (SELECT property_id FROM Property WHERE name = 'Luxury Penthouse')), 2500.00, 'paypal', 'pending', CURRENT_TIMESTAMP),
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'confirmed' AND property_id = (SELECT property_id FROM Property WHERE name = 'Beachfront Cottage')), 1000.00, 'bank_transfer', 'completed', CURRENT_TIMESTAMP),
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'canceled' AND property_id = (SELECT property_id FROM Property WHERE name = 'Mountain Retreat')), 1750.00, 'credit_card', 'failed', CURRENT_TIMESTAMP),
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'confirmed' AND property_id = (SELECT property_id FROM Property WHERE name = 'Modern Loft')), 900.00, 'credit_card', 'completed', CURRENT_TIMESTAMP);
