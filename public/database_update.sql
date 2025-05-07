
-- Use existing database
USE careerrecommendationdb1;

-- Replace existing users table with updated schema
DROP TABLE IF EXISTS user_preferences;
DROP TABLE IF EXISTS transaction_logs;
DROP TABLE IF EXISTS users;

-- Create updated users table with additional fields
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(15),
  address VARCHAR(200),
  age INT,
  date_of_birth DATE,
  role ENUM('admin', 'user') DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- User Preferences Table (for saved job preferences)
CREATE TABLE IF NOT EXISTS user_preferences (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  keyword VARCHAR(100),
  location VARCHAR(100),
  job_type VARCHAR(50),
  salary_range VARCHAR(50),
  industry VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Transaction Log Table (for tracking operations)
CREATE TABLE IF NOT EXISTS transaction_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  operation VARCHAR(100),
  status ENUM('started', 'completed', 'failed', 'rolled_back'),
  details TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert Admin User
INSERT INTO users (username, password, email, name, role)
VALUES ('admin', '$2a$10$XdmT5Iw37ssvZdKuCWT9z.RbgT3cMzvcWHevKzXdbdY0uQpITkGES', 'admin@careerpathways.edu', 'System Administrator', 'admin');
-- Note: This is a hashed password for 'admin123'

-- Add some sample users for testing
INSERT INTO users (username, password, email, name, phone, address, age, date_of_birth, role)
VALUES 
('johndoe', '$2a$10$3Qmb7KKRrfqehpq2J.vKv.kmAh1Zk5OG.lHYN2bUm9WLkSSCom7Da', 'john@example.com', 'John Doe', '9876543210', '123 Main St, City', 25, '2000-05-15', 'user'),
('janesmith', '$2a$10$3Qmb7KKRrfqehpq2J.vKv.kmAh1Zk5OG.lHYN2bUm9WLkSSCom7Da', 'jane@example.com', 'Jane Smith', '8765432109', '456 Elm St, Town', 22, '2003-08-21', 'user');
-- Note: These users use the password 'user123' (hashed)

-- Add sample user preferences
INSERT INTO user_preferences (user_id, keyword, location, job_type, salary_range, industry)
VALUES 
(2, 'developer', 'Bangalore', 'full-time', '₹10-20 LPA', 'technology'),
(3, 'marketing', 'Mumbai', 'full-time', '₹8-15 LPA', 'marketing');

-- Add sample transaction logs
INSERT INTO transaction_logs (user_id, operation, status, details)
VALUES 
(2, 'profile_update', 'completed', 'User updated personal information'),
(3, 'course_view', 'completed', 'User viewed Computer Science courses');

-- Display information about users table structure
DESCRIBE users;
