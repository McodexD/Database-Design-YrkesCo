DROP TABLE IF EXISTS student_details, educator_details, leader_details, program_courses, students, classes, programs, education_leaders, educators, courses, facilities CASCADE;

CREATE TABLE facilities (
    facility_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL
);

CREATE TABLE education_leaders (
    leader_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE leader_details (
    leader_id INT PRIMARY KEY REFERENCES education_leaders(leader_id) ON DELETE CASCADE,
    personnummer VARCHAR(15) NOT NULL
);

CREATE TABLE programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL
);

CREATE TABLE educators (
    educator_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    is_consultant BOOLEAN DEFAULT FALSE
);

CREATE TABLE educator_details (
    educator_id INT PRIMARY KEY REFERENCES educators(educator_id) ON DELETE CASCADE,
    personnummer VARCHAR(15) NOT NULL,
    hourly_rate INT,
    company_name VARCHAR(100)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    description TEXT,
    educator_id INT REFERENCES educators(educator_id)
);

CREATE TABLE program_courses (
    program_id INT REFERENCES programs(program_id),
    course_id INT REFERENCES courses(course_id),
    PRIMARY KEY (program_id, course_id)
);

CREATE TABLE classes (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    program_id INT REFERENCES programs(program_id),
    leader_id INT REFERENCES education_leaders(leader_id),
    facility_id INT REFERENCES facilities(facility_id)
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    class_id INT REFERENCES classes(class_id)
);

CREATE TABLE student_details (
    student_id INT PRIMARY KEY REFERENCES students(student_id) ON DELETE CASCADE,
    personnummer VARCHAR(15) NOT NULL,
    address TEXT
);

INSERT INTO facilities (city_name) VALUES ('Stockholm'), ('Göteborg');

INSERT INTO education_leaders (name, email) 
VALUES ('Anders Svensson', 'anders.svensson@yrkesco.se'), ('Maja Lundqvist', 'maja.lundqvist@yrkesco.se');

INSERT INTO leader_details (leader_id, personnummer)
VALUES (1, '19750312-1111'), (2, '19820824-2222');

INSERT INTO programs (program_name) VALUES ('Data Engineer 2024'), ('Cloud Architect 2024');

INSERT INTO educators (name, email, is_consultant) 
VALUES ('Stefan Karlsson', 'stefan.k@yrkesco.se', false), 
       ('Linda Berg', 'linda.b@dataconsulting.se', true);

INSERT INTO educator_details (educator_id, personnummer, hourly_rate, company_name) 
VALUES (1, '19800101-3333', NULL, 'YrkesCo Internal'), 
       (2, '19850505-4444', 1250, 'Data Experts AB');

INSERT INTO courses (course_code, course_name, credits, description, educator_id) 
VALUES ('DE101', 'Databasdesign med PostgreSQL', 25, '3NF implementation.', 1),
       ('PY200', 'Python för Data Engineers', 30, 'Data pipelines.', 1),
       ('CL300', 'Azure Cloud Fundamentals', 20, 'Cloud Infrastructure.', 2);

INSERT INTO program_courses (program_id, course_id) VALUES (1, 1), (1, 2), (2, 2), (2, 3);

INSERT INTO classes (class_name, program_id, leader_id, facility_id) 
VALUES ('DE-STHLM-24', 1, 1, 1), ('CLOUD-GBG-24', 2, 2, 2);

INSERT INTO students (first_name, last_name, email, class_id) 
VALUES ('Erik', 'Johansson', 'erik.j@student.se', 1),
       ('Anna', 'Lindgren', 'anna.l@student.se', 1),
       ('Michel', 'Svensson', 'michel.s@student.se', 2);

INSERT INTO student_details (student_id, personnummer, address)
VALUES (1, '19981201-5555', 'Vasagatan 10, Stockholm'),
       (2, '19990415-6666', 'Sveavägen 44, Stockholm'),
       (3, '19950722-7777', 'Avenyn 1, Göteborg');

SELECT 
    f.city_name AS "Campus",
    p.program_name AS "Program",
    cl.class_name AS "Class",
    el.name AS "Leader",
    eld.personnummer AS "Leader ID",
    s.first_name || ' ' || s.last_name AS "Student",
    sd.personnummer AS "Student ID",
    sd.address AS "Student Home",
    c.course_name AS "Course",
    e.name AS "Teacher",
    ed.hourly_rate AS "Consultant Rate"
FROM facilities f
JOIN classes cl ON f.facility_id = cl.facility_id
JOIN students s ON cl.class_id = s.class_id
JOIN student_details sd ON s.student_id = sd.student_id
JOIN programs p ON cl.program_id = p.program_id
JOIN education_leaders el ON cl.leader_id = el.leader_id
JOIN leader_details eld ON el.leader_id = eld.leader_id
JOIN program_courses pc ON p.program_id = pc.program_id
JOIN courses c ON pc.course_id = c.course_id
JOIN educators e ON c.educator_id = e.educator_id
JOIN educator_details ed ON e.educator_id = ed.educator_id
ORDER BY "Student", "Course";
