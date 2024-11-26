-- Insert sample users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'John', 'Doe', 'john.doe@example.com', 'password_hash_1', '1234567890', 'guest'),
  ('22222222-2222-2222-2222-222222222222', 'Jane', 'Doe', 'jane.doe@example.com', 'password_hash_2', '9876543210', 'host'),
  ('33333333-3333-3333-3333-333333333333', 'Bob', 'Smith', 'bob.smith@example.com', 'password_hash_3', '5551234567', 'admin'),
  ('44444444-4444-4444-4444-444444444444', 'Alice', 'Johnson', 'alice.johnson@example.com', 'password_hash_4', '7654321098', 'guest'),
  ('55555555-5555-5555-5555-555555555555', 'Mike', 'Williams', 'mike.williams@example.com', 'password_hash_5', '6543210987', 'host');

-- Insert sample properties
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
  ('66666666-6666-6666-6666-666666666666', '22222222-2222-2222-2222-222222222222', 'Cozy Beach House', 'A beautiful beach house with 3 bedrooms and 2 bathrooms.', 'Miami Beach, FL', 200.00),
  ('77777777-7777-7777-7777-777777777777', '55555555-5555-5555-5555-555555555555', 'Modern City Apartment', 'A stylish apartment with 2 bedrooms and 1 bathroom.', 'New York City, NY', 300.00),
  ('88888888-8888-8888-8888-888888888888', '22222222-2222-2222-2222-222222222222', 'Seaside Cottage', 'A charming cottage with 2 bedrooms and 1 bathroom.', 'Outer Banks, NC', 250.00),
  ('99999999-9999-9999-9999-999999999999', '55555555-5555-5555-5555-555555555555', 'Luxury Villa', 'A luxurious villa with 5 bedrooms and 3 bathrooms.', 'Los Angeles, CA', 500.00);

-- Insert sample bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('10101010-1010-1010-1010-101010101010', '66666666-6666-6666-6666-666666666666', '11111111-1111-1111-1111-111111111111', '2024-03-01', '2024-03-05', 1000.00, 'confirmed'),
  ('20202020-2020-2020-2020-202020202020', '77777777-7777-7777-7777-777777777777', '44444444-4444-4444-4444-444444444444', '2024-04-01', '2024-04-03', 600.00, 'pending'),
  ('30303030-3030-3030-3030-303030303030', '88888888-8888-8888-8888-888888888888', '11111111-1111-1111-1111-111111111111', '2024-05-01', '2024-05-05', 1250.00, 'confirmed'),
  ('40404040-4040-4040-4040-404040404040', '99999999-9999-9999-9999-999999999999', '55555555-5555-5555-5555-555555555555', '2024-06-01', '2024-06-03', 1500.00, 'pending');

-- Insert sample payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  ('50505050-5050-5050-5050-505050505050', '10101010-1010-1010-1010-101010101010', 1000)

  -- Insert sample reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
  ('60606060-6060-6060-6060-606060606060', '66666666-6666-6666-6666-666666666666', '11111111-1111-1111-1111-111111111111', 5, 'Excellent stay! The house was clean and comfortable.'),
  ('70707070-7070-7070-7070-707070707070', '77777777-7777-7777-7777-777777777777', '44444444-4444-4444-4444-444444444444', 4, 'Great location, but the apartment could use some updates.'),
  ('80808080-8080-8080-8080-808080808080', '88888888-8888-8888-8888-888888888888', '11111111-1111-1111-1111-111111111111', 5, 'Wonderful stay! The cottage was cozy and the owners were friendly.');

-- Insert sample messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
  ('90909090-9090-9090-9090-909090909090', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi, I\'m interested in booking your beach house. Can you please send me more information?'),
  ('10101010-1010-1010-1010-101010101010', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi, thanks for your interest in my beach house! I\'ve sent you a message with more information.'),
  ('11111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', '55555555-5555-5555-5555-555555555555', 'Hi, I have a question about your apartment listing. Can you please respond?');