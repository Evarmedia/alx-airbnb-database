-- Booking Table Partitioning Strategy

-- Disable strict mode to allow partitioning
SET @@sql_mode = '';

-- Drop existing table if exists
DROP TABLE IF EXISTS Booking;

-- Create Partitioned Booking Table
CREATE TABLE Booking (
    booking_id VARCHAR(36) PRIMARY KEY,
    property_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION future VALUES LESS THAN MAXVALUE
);

-- Performance Test Query: Specific Year Range
EXPLAIN SELECT * FROM Booking 
WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31';

-- Performance Test Query: Specific Property in a Year
EXPLAIN SELECT * FROM Booking 
WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31' 
AND property_id = 'specific_property_id';

-- Index on Partitioned Columns for Additional Optimization
CREATE INDEX idx_booking_date ON Booking(start_date);