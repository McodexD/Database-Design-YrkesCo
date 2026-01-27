-- ==========================================
-- 1. BUILD THE STRUCTURE (THE SCHEMA)
-- ==========================================

CREATE TABLE programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL
);

CREATE TABLE facilities (
    facility_id SERIAL PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL
);

CREATE TABLE education_leaders (
    leader_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE classes (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(20) NOT NULL,
    program_id INT REFERENCES programs(program_id),
    leader_id INT REFERENCES education_leaders(leader_id),
    facility_id INT REFERENCES facilities(facility_id)
);

CREATE TABLE educators (
    educator_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    is_consultant BOOLEAN DEFAULT FALSE
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    class_id INT REFERENCES classes(class_id)
);

-- THE VAULT TABLES (VG REQUIREMENT - Privacy by Design)
CREATE TABLE student_details (
    student_id INT PRIMARY KEY REFERENCES students(student_id),
    personnummer VARCHAR(13) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE educator_details (
    educator_id INT PRIMARY KEY REFERENCES educators(educator_id),
    personnummer VARCHAR(13) NOT NULL,
    hourly_rate DECIMAL(10, 2),
    company_name VARCHAR(100)
);

CREATE TABLE leader_details (
    leader_id INT PRIMARY KEY REFERENCES education_leaders(leader_id),
    personnummer VARCHAR(13) NOT NULL
);

-- ==========================================
-- 2. FILL WITH DATA (THE MOCK DATA)
-- ==========================================

INSERT INTO programs (program_name) VALUES ('AI Developer'), ('UX Design');
INSERT INTO facilities (city_name) VALUES ('Stockholm'), ('Göteborg');
INSERT INTO education_leaders (name, email) VALUES ('Anders Svensson', 'anders@yrkesco.se');

INSERT INTO classes (class_name, program_id, leader_id, facility_id) 
VALUES ('AI24-STHLM', 1, 1, 1);

INSERT INTO educators (name, email, is_consultant) 
VALUES ('Dr. Data', 'data@pro.com', FALSE),
       ('Expert Consultant', 'expert@firm.com', TRUE);

INSERT INTO students (first_name, last_name, email, class_id) 
VALUES ('Erik', 'Johansson', 'erik@student.se', 1),
       ('Anna', 'Lind', 'anna@student.se', 1);

-- FILLING THE VAULTS
INSERT INTO student_details (student_id, personnummer, address)
VALUES (1, '19950101-1111', 'Main Street 1, Stockholm'),
       (2, '19980505-2222', 'Oak Road 45, Stockholm');

INSERT INTO educator_details (educator_id, personnummer, hourly_rate, company_name)
VALUES (2, '19801212-3333', 950.00, 'AI Experts AB');

INSERT INTO leader_details (leader_id, personnummer)
VALUES (1, '19750303-9999');