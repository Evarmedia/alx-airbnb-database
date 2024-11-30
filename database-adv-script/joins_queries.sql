-- INNER JOIN on Booking and user
SELECT b.booking_id, b.start_date, b.end_date, u.user_id, u.first_name, u.last_name
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id;
-- LEFT JOIN: Properties and Reviews
SQL
SELECT p.property_id, p.name, r.review_id, r.rating, r.comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;
-- FULL OUTER JOIN: Users and Bookings
SQL
SELECT u.user_id, u.first_name, u.last_name, b.booking_id, b.start_date, b.end_date
FROM User u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;

-- FULL OUTER JOIN: Users and Bookings MYSQL
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM 
    Booking b
LEFT JOIN 
    User u ON b.user_id = u.user_id
WHERE 
    u.user_id IS NULL;