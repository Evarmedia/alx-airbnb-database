-- High-Impact Column Index Creation Strategy

-- User Table High-Usage Column Indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_created_at ON User(created_at);

-- Booking Table High-Usage Column Indexes
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_date_range ON Booking(start_date, end_date);

-- Property Table High-Usage Column Indexes
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(price_per_night);

-- Composite Indexes for Complex Queries
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);
CREATE INDEX idx_property_location_price ON Property(location, price_per_night);

-- Measure Query Performance Using EXPLAIN or ANALYZE
EXPLAIN SELECT b.booking_id, b.start_date, u.first_name, u.last_name 
FROM Booking b
JOIN User u ON b.user_id = u.user_id
WHERE u.email = 'example@email.com';

-- Performance Analysis Queries

-- Before Index: Analyze Query Performance
EXPLAIN SELECT * FROM Booking 
WHERE user_id = 'some_user_id' AND status = 'confirmed';

-- After Index: Performance Check
EXPLAIN SELECT * FROM Booking 
WHERE user_id = 'some_user_id' AND status = 'confirmed';