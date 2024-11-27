# Normalize Your Database Design 
To achieve third normal form (3NF) in the database schema provided, let's first recap the original schema and then review it for normalization issues. 

## Review for Normalization
### First Normal Form (1NF)
All tables are in 1NF since each attribute has atomic values, and there are no repeating groups.
### Second Normal Form (2NF)
All tables are in 2NF since each table’s primary key is a single column, and all non-key attributes are fully functionally dependent on the primary key.
### Third Normal Form (3NF)
A table is in 3NF if it is in 2NF and no transitive dependencies exist between the primary key and the other attributes.
Potential Issues and Adjustments:

#### User Table: 

Appears to be in 3NF as there are no transitive dependencies between the primary key and other attributes.

#### Property Table:

Issue: The host_id attribute could imply redundancy if multiple properties are hosted by the same user and details about the host (from the User table) are needed frequently.
Resolution: Already normalized since host_id only stores a reference (foreign key), not duplicative data. Descriptions of properties might appear redundant but are likely unique to each property.

#### Booking Table:

Issue: total_price can be considered a derived attribute since it depends on the price_per_night in Property and the duration of stay (start_date to end_date).
Resolution: Remove total_price from the Booking table. It should be calculated dynamically in queries using start_date, end_date, and price_per_night.

#### Payment Table:

It is in 3NF as no non-key attribute is transitively dependent on the primary key, and all attributes are only dependent on payment_id.
Adjusted Schema for 3NF
Remove total_price from the Booking table and compute it when needed.


Here's how the schema changes are reflected in SQL:

sql

-- Remove total_price from Booking table
ALTER TABLE Booking
DROP COLUMN total_price;


Here's a Markdown content that explains the normalization process:
# Database Normalization to Third Normal Form (3NF)

## Introduction
Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.

## Original Schema Analysis
The original database schema includes tables for Users, Properties, Bookings, Payments, Review and Message. These tables were evaluated against normalization principles up to the Third Normal Form (3NF).

## Normalization Steps

### First Normal Form (1NF)
- **Achieved** - All tables had attributes with atomic values and no repeating groups.

### Second Normal Form (2NF)
- **Achieved** - All tables were already in 2NF as they had single-column primary keys, and all non-key attributes were fully functionally dependent on the primary keys.

### Third Normal Form (3NF)
- **Property Table**: No changes were required since it already met 3NF requirements.
- **Booking Table**: Modified to remove `total_price` which is a derived attribute. This change ensures that no attribute is dependent on non-key attributes, adhering to 3NF.
- **User and Payment Tables**: These tables were already in 3NF, with no transitive dependencies.

## Conclusion
The revised schema ensures that the database is free of anomalies that might lead to redundancy or inconsistencies, adhering to the Third Normal Form (3NF) principles.
This Markdown file explains the normalization process effectively and ensures the database adheres to 3NF. You can use this content in a Markdown (.md) file to document the changes and rationales behind them.

## Normalized Schema (3NF)

1. User Table
We keep the User table as-is, as it does not have any redundant data or transitive dependencies.

-- sql
``` 
CREATE TABLE User (
  user_id UUID PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  role ENUM('guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

2. Location Table (For Normalizing Location)
Since the location in the Property table could involve redundancy (e.g., same locations being repeated for different properties), we can normalize location into a separate table.

```
CREATE TABLE Location (
  location_id UUID PRIMARY KEY,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(50) NOT NULL,
  country VARCHAR(100) NOT NULL
);
````
3. Updated Property Table
```
CREATE TABLE Property (
  property_id UUID PRIMARY KEY,
  host_id UUID NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  location_id UUID NOT NULL,
  price_per_night DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES User(user_id),
  FOREIGN KEY (location_id) REFERENCES Location(location_id)
);
```
4. Booking Table
The Booking table is normalized by, removing the total_price attribute,
The total_price column in the Booking table is a derived attribute. Its value depends on:

    1. The price_per_night from the Property table.
    2. The number of nights between the start_date and end_date in the Booking table.

    Why is total_price a problem?
    Transitive Dependency: total_price can be computed by multiplying the price_per_night of the Property with the number of nights the user has booked (end_date - start_date). Therefore, total_price is transitively dependent on price_per_night via the property_id and the dates from the booking. This violates 3NF because it introduces redundancy—every time a booking is made, the total price would have to be recalculated, which increases the risk of inconsistency.

    Redundancy: By storing total_price, we are storing derived data that can easily be calculated on the fly from other attributes, which breaks the principle of eliminating redundancy.
```
CREATE TABLE Booking (
  booking_id UUID PRIMARY KEY,
  property_id UUID NOT NULL,
  user_id UUID NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES Property(property_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);
```
5. Payment Table
We normalize the Payment table by ensuring that payments are related only to bookings. The attributes depend solely on payment_id, and there are no transitive dependencies.

```
CREATE TABLE Payment (
  payment_id UUID PRIMARY KEY,
  booking_id UUID NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  payment_method ENUM('credit_card', 'paypal', 'bank_transfer') NOT NULL,
  payment_status ENUM('pending', 'completed', 'failed') NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);
```


6. Review
review_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
comment: TEXT, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

7. Message
message_id: Primary Key, UUID, Indexed
sender_id: Foreign Key, references User(user_id)
recipient_id: Foreign Key, references User(user_id)
message_body: TEXT, NOT NULL
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## 3NF Breakdown
#### User Table:

No transitive dependencies exist. Data is atomic and relates directly to the user.

#### Property Table:

We separated the location into its own table (the Location table) to avoid repeating location data for each property.

#### Booking Table:

To eliminate the transitive dependency of total_price on start_date, end_date, and price_per_night, we should calculate the total_price dynamically using a query, rather than storing it as a separate attribute in the Booking table.
```
SELECT 
  b.booking_id,
  b.user_id,
  b.property_id,
  p.price_per_night,
  DATEDIFF(b.end_date, b.start_date) AS nights_booked,
  (p.price_per_night * DATEDIFF(b.end_date, b.start_date)) AS total_price
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.booking_id = 'some_booking_id';

```

#### Payment Table:

No transitive dependencies exist. All attributes relate directly to the payment ID and booking ID.

#### Location Table:

The location information is now separated into its own table to avoid repetition and reduce redundancy. Multiple properties can refer to the same location, improving maintainability.
Advantages of Normalization to 3NF:
Avoids redundancy: No repeated data in the database (e.g., location is not repeated for each property).
Ensures consistency: Updates in one location will automatically reflect in all properties in that location.
Improves maintainability: Easier to manage, query, and update data because each table contains only relevant data.
Final Thoughts
Indexes: It would be helpful to add indexes on frequently queried columns, such as email in the User table, price_per_night in the Property table, and status in the Booking table, for faster lookups.

Foreign Keys: The foreign key relationships ensure referential integrity, which is important in relational database design.

### conclusion
This schema should now be fully normalized to 3NF, with no redundant data and clear separation of concerns between tables.