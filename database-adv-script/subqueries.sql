-- Finding properties with average rating > 4.0 using a subquery:
SELECT 
    p.property_id, 
    p.name, 
    p.location,
    (SELECT AVG(rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS average_rating
FROM 
    Property p
WHERE 
    (SELECT AVG(rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) > 4.0;

-- Correlated subquery to find users with more than 3 bookings:
SELECT 
    u.user_id, 
    u.first_name, 
    u.last_name,
    u.email
FROM 
    User u
WHERE 
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) > 3;