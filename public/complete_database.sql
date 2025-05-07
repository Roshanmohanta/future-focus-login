
-- Create Database
CREATE DATABASE IF NOT EXISTS careerrecommendationdb1;
USE careerrecommendationdb1;

-- Drop existing tables (if they exist) in reverse order to respect foreign key constraints
DROP TABLE IF EXISTS job_responsibilities;
DROP TABLE IF EXISTS job_requirements;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS college_company;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS course_college;
DROP TABLE IF EXISTS colleges;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS streams;
DROP TABLE IF EXISTS user_preferences;
DROP TABLE IF EXISTS transaction_logs;
DROP TABLE IF EXISTS users;

-- Create Users Table (Updated with additional fields)
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

-- Create Streams Table
CREATE TABLE IF NOT EXISTS streams (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  duration VARCHAR(50),
  eligibility TEXT,
  stream_id INT,
  image_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (stream_id) REFERENCES streams(id)
);

-- Colleges Table
CREATE TABLE IF NOT EXISTS colleges (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  location VARCHAR(100),
  avg_salary VARCHAR(50),
  fees VARCHAR(50),
  application_deadline VARCHAR(50),
  application_process TEXT,
  image_url VARCHAR(255),
  website_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Course-College Relationship
CREATE TABLE IF NOT EXISTS course_college (
  id INT AUTO_INCREMENT PRIMARY KEY,
  course_id INT,
  college_id INT,
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (college_id) REFERENCES colleges(id)
);

-- Companies Table
CREATE TABLE IF NOT EXISTS companies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  logo_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- College-Company Relationship (companies that visit for recruitment)
CREATE TABLE IF NOT EXISTS college_company (
  id INT AUTO_INCREMENT PRIMARY KEY,
  college_id INT,
  company_id INT,
  FOREIGN KEY (college_id) REFERENCES colleges(id),
  FOREIGN KEY (company_id) REFERENCES companies(id)
);

-- Jobs Table
CREATE TABLE IF NOT EXISTS jobs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  company VARCHAR(100),
  location VARCHAR(100),
  job_type VARCHAR(50),
  salary VARCHAR(50),
  experience VARCHAR(50),
  posted_date DATE,
  deadline DATE,
  description TEXT,
  company_logo_url VARCHAR(255),
  application_url VARCHAR(255),
  industry VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Job Requirements Table
CREATE TABLE IF NOT EXISTS job_requirements (
  id INT AUTO_INCREMENT PRIMARY KEY,
  job_id INT,
  requirement TEXT,
  FOREIGN KEY (job_id) REFERENCES jobs(id)
);

-- Job Responsibilities Table
CREATE TABLE IF NOT EXISTS job_responsibilities (
  id INT AUTO_INCREMENT PRIMARY KEY,
  job_id INT,
  responsibility TEXT,
  FOREIGN KEY (job_id) REFERENCES jobs(id)
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

-- Insert Streams
INSERT INTO streams (name, description) VALUES
('science', 'Scientific and technical education focusing on natural sciences, mathematics, and their applications'),
('commerce', 'Business-oriented education focusing on economics, accounting, and management'),
('arts', 'Education in humanities, social sciences, languages, and creative fields');

-- Insert Courses
INSERT INTO courses (title, description, duration, eligibility, stream_id, image_url) VALUES
('B.Tech Computer Science', 'Bachelor of Technology in Computer Science and Engineering focuses on software development, algorithms, data structures, and computer architecture.', '4 Years', '10+2 with PCM, Min 60%', 1, 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=1000&auto=format&fit=crop'),
('MBBS', 'Bachelor of Medicine and Bachelor of Surgery is a professional undergraduate medical degree that trains students in medicine and surgery.', '5.5 Years', '10+2 with PCB, Min 50%', 1, 'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?q=80&w=1000&auto=format&fit=crop'),
('B.Sc Physics', 'Bachelor of Science in Physics covers classical and modern physics, quantum mechanics, electromagnetism and thermodynamics.', '3 Years', '10+2 with PCM, Min 55%', 1, 'https://images.unsplash.com/photo-1636466497217-06a6f914e4f4?q=80&w=1000&auto=format&fit=crop'),
('BBA', 'Bachelor of Business Administration provides fundamental education in business and management principles.', '3 Years', '10+2 in any stream, Min 50%', 2, 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=1000&auto=format&fit=crop'),
('B.Com', 'Bachelor of Commerce covers accounting, economics, business law, taxation, and financial management.', '3 Years', '10+2 Commerce, Min 50%', 2, 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=1000&auto=format&fit=crop'),
('BA Literature', 'Bachelor of Arts in Literature explores literature across cultures, literary theory, critical analysis and creative writing.', '3 Years', '10+2 in any stream, Min 50%', 3, 'https://images.unsplash.com/photo-1474932430478-367dbb6832c1?q=80&w=1000&auto=format&fit=crop'),
('BA Psychology', 'Bachelor of Arts in Psychology provides understanding of human behavior, mental processes, research methods and psychological theories.', '3 Years', '10+2 in any stream, Min 50%', 3, 'https://images.unsplash.com/photo-1576669801775-ff43c5ab079d?q=80&w=1000&auto=format&fit=crop'),
('B.Sc Chemistry', 'Bachelor of Science in Chemistry covers organic, inorganic, physical chemistry, and laboratory techniques essential for research and industry.', '3 Years', '10+2 with PCM, Min 55%', 1, 'https://images.unsplash.com/photo-1603126857599-f6e157fa2fe6?q=80&w=1000&auto=format&fit=crop'),
('B.Tech Electronics', 'Bachelor of Technology in Electronics Engineering focuses on circuit design, signal processing, and communication systems.', '4 Years', '10+2 with PCM, Min 60%', 1, 'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=1000&auto=format&fit=crop'),
('B.Sc Mathematics', 'Bachelor of Science in Mathematics covers algebra, calculus, statistics, and numerical analysis for analytical problem-solving skills.', '3 Years', '10+2 with Mathematics, Min 55%', 1, 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?q=80&w=1000&auto=format&fit=crop'),
('Chartered Accountancy', 'Professional course covering accounting, auditing, taxation, and financial management for aspiring accountants.', '3-5 Years', '10+2 Commerce, Min 55%', 2, 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?q=80&w=1000&auto=format&fit=crop'),
('Bachelor of Economics', 'Bachelor degree focusing on economic theories, models, policy analysis, and financial systems.', '3 Years', '10+2 in Commerce/Arts with Economics, Min 50%', 2, 'https://images.unsplash.com/photo-1543286386-2e659306cd6c?q=80&w=1000&auto=format&fit=crop'),
('Hotel Management', 'Bachelor\'s program covering hospitality operations, food service management, and customer relations.', '3-4 Years', '10+2 in any stream, Min 50%', 2, 'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1000&auto=format&fit=crop'),
('BA Sociology', 'Bachelor of Arts in Sociology examines social structures, human interactions, and cultural phenomena across different societies.', '3 Years', '10+2 in any stream, Min 45%', 3, 'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=1000&auto=format&fit=crop'),
('Bachelor of Fine Arts', 'BFA program focuses on visual arts including painting, sculpture, photography, and digital media.', '4 Years', '10+2 in any stream + Portfolio, Min 50%', 3, 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?q=80&w=1000&auto=format&fit=crop'),
('Mass Communication', 'Bachelor\'s degree covering journalism, media production, advertising, and public relations.', '3 Years', '10+2 in any stream, Min 50%', 3, 'https://images.unsplash.com/photo-1503298506553-467f6af0cb8e?q=80&w=1000&auto=format&fit=crop');

-- Insert Colleges
INSERT INTO colleges (name, description, location, avg_salary, fees, application_deadline, application_process, image_url, website_url) VALUES
('Indian Institute of Technology, Delhi', 'IIT Delhi is one of India\'s premier technical institutions, known for its cutting-edge research and innovation in engineering and technology fields.', 'New Delhi', '₹16-25 LPA', '₹2.2 Lakhs per year', 'May 30, 2025', 'JEE Advanced followed by counseling', 'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=1000&auto=format&fit=crop', 'https://home.iitd.ac.in/'),
('All India Institute of Medical Sciences', 'AIIMS is India\'s leading medical institution offering world-class medical education and healthcare services with state-of-the-art facilities.', 'New Delhi', '₹12-18 LPA', '₹1.5 Lakhs per year', 'June 15, 2025', 'NEET-UG followed by counseling', 'https://images.unsplash.com/photo-1631248055158-edec7a3c072b?q=80&w=1000&auto=format&fit=crop', 'https://www.aiims.edu/'),
('St. Stephen\'s College', 'St. Stephen\'s is one of India\'s oldest and most prestigious liberal arts colleges, known for academic excellence and rich cultural heritage.', 'Delhi', '₹6-10 LPA', '₹40,000 per year', 'June 30, 2025', 'Merit-based through university portal', 'https://images.unsplash.com/photo-1607013407627-6848541c23ae?q=80&w=1000&auto=format&fit=crop', 'https://www.ststephens.edu/'),
('Shri Ram College of Commerce', 'SRCC is India\'s premier institution for commerce and economics education with a strong focus on research and industry-relevant curriculum.', 'Delhi', '₹8-15 LPA', '₹45,000 per year', 'June 25, 2025', 'Merit-based through university portal', 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1000&auto=format&fit=crop', 'https://www.srcc.edu/'),
('Indian Institute of Science', 'IISc is India\'s premier research institute offering advanced education in various scientific disciplines with state-of-the-art laboratories.', 'Bangalore', '₹14-22 LPA', '₹1.8 Lakhs per year', 'April 15, 2025', 'GATE score followed by interview', 'https://images.unsplash.com/photo-1591123120675-6f7f1aae0e5b?q=80&w=1000&auto=format&fit=crop', 'https://www.iisc.ac.in/'),
('Birla Institute of Technology and Science', 'BITS Pilani is known for its rigorous technical education and industry connections across engineering and science disciplines.', 'Pilani', '₹12-20 LPA', '₹2.0 Lakhs per year', 'May 20, 2025', 'BITSAT entrance exam', 'https://images.unsplash.com/photo-1595113229230-10f8ef6b26ae?q=80&w=1000&auto=format&fit=crop', 'https://www.bits-pilani.ac.in/'),
('Christian Medical College', 'CMC Vellore is one of India\'s top medical institutions known for excellent clinical training and community health programs.', 'Vellore', '₹10-16 LPA', '₹1.2 Lakhs per year', 'May 31, 2025', 'NEET-UG followed by CMC entrance exam', 'https://images.unsplash.com/photo-1516549655169-df83a0774514?q=80&w=1000&auto=format&fit=crop', 'https://www.cmch-vellore.edu/'),
('Faculty of Management Studies', 'FMS Delhi offers top-tier management education with a focus on practical business skills and strategic thinking.', 'Delhi', '₹20-32 LPA', '₹1.9 Lakhs total', 'January 15, 2025', 'CAT score followed by interview', 'https://images.unsplash.com/photo-1606761568499-6d2451b23c66?q=80&w=1000&auto=format&fit=crop', 'https://www.fms.edu/'),
('Narsee Monjee Institute of Management Studies', 'NMIMS is renowned for its commerce and business programs with strong industry connections and practical training.', 'Mumbai', '₹10-18 LPA', '₹1.4 Lakhs per year', 'April 10, 2025', 'NMIMS entrance test', 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1000&auto=format&fit=crop', 'https://www.nmims.edu/'),
('Institute of Chartered Accountants of India', 'ICAI is the apex professional body for chartered accountants in India, providing high-quality education and certification.', 'Multiple Centers', '₹8-25 LPA', '₹80,000 total', 'March 1, 2025 / September 1, 2025', 'CA Foundation entrance exam', 'https://images.unsplash.com/photo-1554224155-1696413565d3?q=80&w=1000&auto=format&fit=crop', 'https://www.icai.org/'),
('Lady Shri Ram College for Women', 'LSR is one of India\'s premier institutions for women\'s education in humanities and social sciences with an excellent academic reputation.', 'Delhi', '₹5-10 LPA', '₹30,000 per year', 'June 20, 2025', 'Merit-based through university portal', 'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=1000&auto=format&fit=crop', 'https://www.lsr.edu.in/'),
('Symbiosis Centre for Media & Communication', 'SCMC is a leading institute for media education with industry-relevant curriculum and state-of-the-art production facilities.', 'Pune', '₹6-12 LPA', '₹2.8 Lakhs per year', 'February 28, 2025', 'SET entrance exam followed by PI', 'https://images.unsplash.com/photo-1503298506053-867d7f3a42e2?q=80&w=1000&auto=format&fit=crop', 'https://www.scmc.edu.in/'),
('National Institute of Design', 'NID is India\'s premier design institute offering comprehensive education in various design disciplines with focus on innovation.', 'Ahmedabad', '₹8-15 LPA', '₹3.8 Lakhs per year', 'January 10, 2025', 'Design Aptitude Test followed by interview', 'https://images.unsplash.com/photo-1558655146-9f40138edfeb?q=80&w=1000&auto=format&fit=crop', 'https://www.nid.edu/'),
('Fergusson College', 'Fergusson College is known for its strong liberal arts programs and research-oriented approach to education.', 'Pune', '₹4-8 LPA', '₹25,000 per year', 'June 15, 2025', 'Merit-based through university portal', 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1000&auto=format&fit=crop', 'https://www.fergusson.edu/'),
('Jawaharlal Nehru University', 'JNU is renowned for its exceptional social sciences and humanities programs with a focus on critical thinking and research.', 'New Delhi', '₹5-9 LPA', '₹15,000 per year', 'March 31, 2025', 'JNU Entrance Examination', 'https://images.unsplash.com/photo-1607237138185-eedd9c632b0b?q=80&w=1000&auto=format&fit=crop', 'https://www.jnu.ac.in/'),
('National Institute of Technology, Warangal', 'NIT Warangal is among India\'s leading technical institutes known for quality education in engineering and research excellence.', 'Warangal', '₹10-18 LPA', '₹1.5 Lakhs per year', 'June 5, 2025', 'JEE Main followed by counseling', 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=1000&auto=format&fit=crop', 'https://www.nitw.ac.in/'),
('Vellore Institute of Technology', 'VIT is a prestigious private university known for its strong focus on research, innovation and global education standards.', 'Vellore', '₹8-16 LPA', '₹2.8 Lakhs per year', 'April 20, 2025', 'VITEEE entrance exam', 'https://images.unsplash.com/photo-1513077202514-c511b41bd4c7?q=80&w=1000&auto=format&fit=crop', 'https://vit.ac.in/'),
('King George\'s Medical University', 'KGMU is one of the oldest medical institutions in India with excellent clinical training and research facilities.', 'Lucknow', '₹10-15 LPA', '₹1.2 Lakhs per year', 'May 25, 2025', 'NEET-UG followed by counseling', 'https://images.unsplash.com/photo-1504439904031-93ded9f93e4e?q=80&w=1000&auto=format&fit=crop', 'https://www.kgmu.org/'),
('Seth G.S. Medical College', 'One of the premier medical institutions attached to the KEM Hospital with strong clinical exposure and research opportunities.', 'Mumbai', '₹12-16 LPA', '₹1.3 Lakhs per year', 'June 10, 2025', 'NEET-UG followed by state counseling', 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?q=80&w=1000&auto=format&fit=crop', 'https://www.kem.edu/'),
('St. Xavier\'s College', 'St. Xavier\'s College is renowned for its excellent science programs and research-oriented education in physics.', 'Mumbai', '₹5-9 LPA', '₹35,000 per year', 'June 15, 2025', 'Merit-based through university portal', 'https://images.unsplash.com/photo-1591123120675-6f7f1aae0e5b?q=80&w=1000&auto=format&fit=crop', 'https://www.xaviers.edu/'),
('Presidency College', 'Presidency College has a distinguished history of excellence in physics education with modern laboratory facilities.', 'Kolkata', '₹4-8 LPA', '₹18,000 per year', 'May 30, 2025', 'Merit-based admission through university', 'https://images.unsplash.com/photo-1636466497217-06a6f914e4f4?q=80&w=1000&auto=format&fit=crop', 'https://www.presiuniv.ac.in/'),
('Christ University', 'Christ University is known for its holistic approach to business education with strong industry connections.', 'Bangalore', '₹7-12 LPA', '₹1.5 Lakhs per year', 'April 10, 2025', 'Christ University Entrance Test and interview', 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1000&auto=format&fit=crop', 'https://www.christuniversity.in/'),
('Symbiosis Centre for Management Studies', 'SCMS provides industry-oriented business education with emphasis on practical exposure and entrepreneurship.', 'Pune', '₹8-14 LPA', '₹2.2 Lakhs per year', 'February 28, 2025', 'SET entrance exam followed by GE-PI', 'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=1000&auto=format&fit=crop', 'https://www.symbiosis.ac.in/');

-- Associate Colleges with Courses
INSERT INTO course_college (course_id, college_id) VALUES
(1, 1), -- B.Tech CS at IIT Delhi
(2, 2), -- MBBS at AIIMS
(6, 3), -- BA Literature at St. Stephen's
(5, 4), -- B.Com at SRCC
(3, 5), -- B.Sc Physics at IISc
(1, 6), -- B.Tech CS at BITS
(2, 7), -- MBBS at CMC
(4, 8), -- BBA at FMS
(5, 9), -- B.Com at NMIMS
(11, 10), -- Chartered Accountancy at ICAI
(6, 11), -- BA Literature at LSR
(16, 12), -- Mass Communication at SCMC
(15, 13), -- Bachelor of Fine Arts at NID
(14, 14), -- BA Sociology at Fergusson
(7, 15), -- BA Psychology at JNU
(1, 16), -- B.Tech CS at NIT Warangal
(1, 17), -- B.Tech CS at VIT
(2, 18), -- MBBS at KGMU
(2, 19), -- MBBS at Seth G.S. Medical College
(3, 20), -- B.Sc Physics at St. Xavier's
(3, 21), -- B.Sc Physics at Presidency College
(4, 22), -- BBA at Christ University
(4, 23); -- BBA at SCMS

-- Insert Companies
INSERT INTO companies (name, logo_url) VALUES
('Google', 'https://via.placeholder.com/150'),
('Microsoft', 'https://via.placeholder.com/150'),
('Amazon', 'https://via.placeholder.com/150'),
('Goldman Sachs', 'https://via.placeholder.com/150'),
('Shell', 'https://via.placeholder.com/150'),
('Apollo Hospitals', 'https://via.placeholder.com/150'),
('Fortis', 'https://via.placeholder.com/150'),
('Max Healthcare', 'https://via.placeholder.com/150'),
('HUL', 'https://via.placeholder.com/150'),
('ITC', 'https://via.placeholder.com/150'),
('Deloitte', 'https://via.placeholder.com/150'),
('EY', 'https://via.placeholder.com/150'),
('JP Morgan', 'https://via.placeholder.com/150'),
('KPMG', 'https://via.placeholder.com/150'),
('PwC', 'https://via.placeholder.com/150'),
('Bain & Company', 'https://via.placeholder.com/150'),
('TCS', 'https://via.placeholder.com/150'),
('Infosys', 'https://via.placeholder.com/150'),
('Wipro', 'https://via.placeholder.com/150'),
('HCL', 'https://via.placeholder.com/150');

-- Associate Companies with Colleges (for campus recruitment)
INSERT INTO college_company (college_id, company_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), -- IIT Delhi companies
(2, 6), (2, 7), (2, 8), -- AIIMS companies
(3, 9), (3, 10), (3, 11), (3, 12), -- St. Stephen's companies
(4, 13), (4, 14), (4, 15), (4, 16), -- SRCC companies
(5, 1), (5, 2), (5, 17), -- IISc companies
(6, 3), (6, 18), (6, 19), -- BITS companies
(7, 6), (7, 7), -- CMC companies
(8, 11), (8, 12), (8, 13), -- FMS companies
(9, 14), (9, 15), (9, 16), -- NMIMS companies
(16, 2), (16, 3), (16, 17), (16, 20), -- NIT Warangal companies
(17, 17), (17, 18), (17, 19), (17, 20); -- VIT companies

-- Insert Jobs
INSERT INTO jobs (title, company, location, job_type, salary, experience, posted_date, deadline, description, company_logo_url, application_url, industry) VALUES
('Software Engineer', 'TechSolutions Inc.', 'Bangalore', 'full-time', '₹12-18 LPA', '2-4 years', '2025-05-01', '2025-06-01', 'We\'re looking for a skilled Software Engineer to join our team. You will be responsible for developing high-quality applications using modern technologies and best practices.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'technology'),
('Data Scientist', 'Analytics Plus', 'Hyderabad', 'full-time', '₹15-22 LPA', '3-5 years', '2025-04-25', '2025-05-25', 'Join our data science team to build predictive models and extract insights from complex datasets. You\'ll work on challenging problems and collaborate with talented professionals.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'technology'),
('Marketing Manager', 'BrandBoost', 'Mumbai', 'full-time', '₹10-15 LPA', '5+ years', '2025-04-28', '2025-05-28', 'Lead our marketing efforts to increase brand awareness and drive customer engagement. You\'ll develop and execute marketing strategies across multiple channels.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'marketing'),
('Financial Analyst', 'Global Investments Ltd.', 'Delhi', 'full-time', '₹8-12 LPA', '2-4 years', '2025-05-02', '2025-06-02', 'Join our finance team to analyze market trends, prepare financial forecasts, and support investment decisions. You\'ll play a key role in our company\'s financial strategy.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'finance'),
('UX Designer', 'Creative Tech Solutions', 'Bangalore', 'full-time', '₹10-16 LPA', '3-5 years', '2025-05-03', '2025-06-03', 'We\'re looking for a talented UX Designer to create exceptional user experiences for our products. You\'ll conduct user research, create wireframes, and collaborate with developers to implement your designs.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'design'),
('Product Manager', 'InnovateNow', 'Mumbai', 'full-time', '₹18-25 LPA', '4-6 years', '2025-05-04', '2025-06-04', 'Join our product team to lead the development of innovative digital products. You\'ll work with cross-functional teams to define product strategy, gather requirements, and drive execution.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'technology'),
('HR Manager', 'Global Services Inc.', 'Delhi', 'full-time', '₹12-18 LPA', '5-7 years', '2025-05-05', '2025-06-05', 'We\'re looking for an experienced HR Manager to lead our talent acquisition and employee development initiatives. You\'ll design and implement HR strategies aligned with our business goals.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'human resources'),
('Content Writer', 'Digital Media Group', 'Hyderabad', 'full-time', '₹6-9 LPA', '2-4 years', '2025-05-06', '2025-06-06', 'Join our creative team to produce engaging content for various platforms. You\'ll research topics, write compelling copy, and collaborate with designers to create impactful content.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'media'),
('DevOps Engineer', 'Cloud Solutions Ltd.', 'Pune', 'full-time', '₹14-20 LPA', '3-6 years', '2025-05-07', '2025-06-07', 'We\'re seeking an experienced DevOps Engineer to streamline our development and deployment processes. You\'ll implement CI/CD pipelines and manage cloud infrastructure.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'technology'),
('Project Manager', 'Construction Experts', 'Chennai', 'full-time', '₹12-18 LPA', '5-8 years', '2025-05-08', '2025-06-08', 'Join our team to manage complex construction projects from inception to completion. You\'ll coordinate resources, monitor progress, and ensure quality standards are met.', 'https://via.placeholder.com/150', 'https://example.com/apply', 'construction');

-- Insert Job Requirements
INSERT INTO job_requirements (job_id, requirement) VALUES
(1, 'Bachelor\'s degree in Computer Science or related field'),
(1, '2+ years of experience in software development'),
(1, 'Proficiency in JavaScript, TypeScript, and React'),
(1, 'Experience with RESTful APIs and backend technologies'),
(1, 'Strong problem-solving skills and attention to detail'),
(2, 'Master\'s or PhD in Statistics, Computer Science, or related field'),
(2, '3+ years of experience in data science or analytics'),
(2, 'Proficiency in Python, R, and SQL'),
(2, 'Experience with machine learning frameworks'),
(2, 'Strong mathematical and statistical knowledge');
-- ... continuing with other job requirements

-- Insert Job Responsibilities
INSERT INTO job_responsibilities (job_id, responsibility) VALUES
(1, 'Design and develop high-quality code for various projects'),
(1, 'Collaborate with cross-functional teams to define and implement features'),
(1, 'Debug production issues and implement fixes'),
(1, 'Optimize applications for maximum speed and scalability'),
(1, 'Participate in code reviews and knowledge sharing'),
(2, 'Develop and implement machine learning algorithms'),
(2, 'Process, clean, and validate data for analysis'),
(2, 'Build data visualization tools and dashboards'),
(2, 'Communicate findings to non-technical stakeholders'),
(2, 'Keep up-to-date with the latest industry trends');
-- ... continuing with other job responsibilities

-- Add some sample user preferences
INSERT INTO user_preferences (user_id, keyword, location, job_type, salary_range, industry)
VALUES 
(2, 'developer', 'Bangalore', 'full-time', '₹10-20 LPA', 'technology'),
(3, 'marketing', 'Mumbai', 'full-time', '₹8-15 LPA', 'marketing');

-- Add sample transaction logs
INSERT INTO transaction_logs (user_id, operation, status, details)
VALUES 
(2, 'profile_update', 'completed', 'User updated personal information'),
(3, 'course_view', 'completed', 'User viewed Computer Science courses');

-- SQL queries for common operations

-- Query 1: Get user by username (used for login)
-- SELECT * FROM users WHERE username = ?;

-- Query 2: Get user by email (used for registration check)
-- SELECT * FROM users WHERE email = ?;

-- Query 3: Insert a new user
-- INSERT INTO users (username, email, password, name, phone, address, age, date_of_birth) 
-- VALUES (?, ?, ?, ?, ?, ?, ?, ?);

-- Query 4: Get user by ID
-- SELECT * FROM users WHERE id = ?;

-- Query 5: Update user profile
-- UPDATE users SET name = ?, phone = ?, address = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?;

-- Query 6: Get courses by stream
-- SELECT c.* FROM courses c WHERE c.stream_id = ?;

-- Query 7: Get colleges offering a specific course
-- SELECT col.* FROM colleges col
-- JOIN course_college cc ON col.id = cc.college_id
-- WHERE cc.course_id = ?;

-- Query 8: Get jobs by industry
-- SELECT * FROM jobs WHERE industry = ?;

-- Query 9: Get jobs by location
-- SELECT * FROM jobs WHERE location = ?;

-- Query 10: Get job details with requirements and responsibilities
-- SELECT j.*, 
--   (SELECT GROUP_CONCAT(jr.requirement SEPARATOR '|') FROM job_requirements jr WHERE jr.job_id = j.id) as requirements,
--   (SELECT GROUP_CONCAT(jres.responsibility SEPARATOR '|') FROM job_responsibilities jres WHERE jres.job_id = j.id) as responsibilities
-- FROM jobs j
-- WHERE j.id = ?;

-- Query 11: Get companies recruiting from a college
-- SELECT c.* FROM companies c
-- JOIN college_company cc ON c.id = cc.company_id
-- WHERE cc.college_id = ?;

-- Query 12: Save user preferences
-- INSERT INTO user_preferences (user_id, keyword, location, job_type, salary_range, industry)
-- VALUES (?, ?, ?, ?, ?, ?);

-- Query 13: Get user preferences
-- SELECT * FROM user_preferences WHERE user_id = ?;

-- Query 14: Log user transaction
-- INSERT INTO transaction_logs (user_id, operation, status, details)
-- VALUES (?, ?, ?, ?);

-- Query 15: Get user transaction history
-- SELECT * FROM transaction_logs WHERE user_id = ? ORDER BY created_at DESC;

-- Query 16: Search courses by keyword
-- SELECT * FROM courses WHERE title LIKE CONCAT('%', ?, '%') OR description LIKE CONCAT('%', ?, '%');

-- Query 17: Search colleges by location
-- SELECT * FROM colleges WHERE location LIKE CONCAT('%', ?, '%');

-- Query 18: Search jobs by salary range and location
-- SELECT * FROM jobs WHERE location = ? AND salary LIKE CONCAT('%', ?, '%');

-- Display table information
SHOW TABLES;
