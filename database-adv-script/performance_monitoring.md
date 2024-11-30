-- Performance Monitoring and Optimization Script

-- Enable profiling
SET profiling = 1;

-- Query 1: Booking Performance Analysis
EXPLAIN ANALYZE
SELECT 
    b.booking_id, 
    u.first_name, 
    u.last_name, 
    p.name AS property_name
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.status = 'confirmed' 
    AND b.start_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Show profile for the last query
SHOW PROFILE;

-- Identify potential index improvements
SELECT 
    object_schema,
    object_name,
    index_name,
    column_name
FROM 
    performance_schema.table_columns
WHERE 
    object_schema = 'airbnb_db'
    AND (column_name IN ('status', 'start_date', 'user_id', 'property_id'));

-- Create targeted indexes based on analysis
CREATE INDEX idx_booking_status_date ON Booking(status, start_date);
CREATE INDEX idx_booking_user_property ON Booking(user_id, property_id);

-- Rerun analysis with new indexes
EXPLAIN ANALYZE
SELECT 
    b.booking_id, 
    u.first_name, 
    u.last_name, 
    p.name AS property_name
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.status = 'confirmed' 
    AND b.start_date BETWEEN '2023-01-01' AND '2023-12-31';

# Database Performance Optimization Report

## Key Findings
- Identified query bottlenecks in join operations
- Created targeted indexes
- Optimized date range and status filtering

## Performance Improvements
- Reduced join complexity
- Accelerated query execution
- Minimized full table scans

## Recommended Actions
1. Continuous index monitoring
2. Regular query plan analysis
3. Periodic schema review