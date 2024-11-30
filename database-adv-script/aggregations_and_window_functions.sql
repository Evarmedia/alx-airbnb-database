-- Airbnb Database Analytics Queries

-- Query 1: Total Number of Bookings per User
-- This query uses COUNT and GROUP BY to aggregate booking data
-- Provides insights into user booking frequency
SELECT 
    u.user_id,           -- Unique user identifier
    u.first_name,        -- User's first name
    u.last_name,         -- User's last name
    COUNT(b.booking_id) AS total_bookings  -- Count of bookings for each user
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, 
    u.first_name, 
    u.last_name
ORDER BY 
    total_bookings DESC;  -- Sort by number of bookings in descending order

-- Query 2: Property Booking Ranking using Window Functions
-- Uses ROW_NUMBER() and RANK() to analyze property popularity
-- Demonstrates different window function ranking techniques
WITH PropertyBookingCounts AS (
    SELECT 
        p.property_id,       -- Unique property identifier
        p.name,              -- Property name
        p.location,          -- Property location
        COUNT(b.booking_id) AS booking_count  -- Total number of bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id, 
        p.name, 
        p.location
)

SELECT 
    property_id,
    name,
    location,
    booking_count,
    ROW_NUMBER() OVER (ORDER BY booking_count DESC) AS booking_rank,
    RANK() OVER (ORDER BY booking_count DESC) AS booking_dense_rank
FROM 
    PropertyBookingCounts
ORDER BY 
    booking_count DESC;