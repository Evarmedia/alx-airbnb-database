
-- Create the Database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS airbnb_db;
USE airbnb_db;

-- Create User table
CREATE TABLE IF NOT EXISTS User (
  user_id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),  -- Using UUID() 
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  role ENUM('guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Property table
CREATE TABLE IF NOT EXISTS Property (
  property_id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),  -- Using UUID() 
  host_id VARCHAR(36) NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR(100) NOT NULL,
  price_per_night DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES User(user_id)
);

-- Create Booking table
CREATE TABLE IF NOT EXISTS Booking (
  booking_id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),  -- Using UUID()
  property_id VARCHAR(36) NOT NULL,
  user_id VARCHAR(36) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES Property(property_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Create Payment table
CREATE TABLE IF NOT EXISTS Payment (
  payment_id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),  -- Using UUID() 
  booking_id VARCHAR(36) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  payment_method ENUM('credit_card', 'paypal', 'bank_transfer') NOT NULL,
  payment_status ENUM('pending', 'completed', 'failed') NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Create Review table
CREATE TABLE IF NOT EXISTS Review (
  review_id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
  property_id VARCHAR(36) NOT NULL,
  user_id VARCHAR(36) NOT NULL,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES Property(property_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Create Message table
CREATE TABLE IF NOT EXISTS Message (
  message_id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
  sender_id VARCHAR(36) NOT NULL,
  recipient_id VARCHAR(36) NOT NULL,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES User(user_id),
  FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);

-- Create indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_property_property_id ON Property(property_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_booking_id ON Booking(booking_id);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);