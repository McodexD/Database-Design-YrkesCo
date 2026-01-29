📊 YrkesCo Database Management SystemA professional, 3rd Normal Form (3NF) relational database designed for YrkesCo to manage students, courses, programs, and staff across multiple cities.🏛️ Architecture OverviewThis project implements a secure "Vault" strategy to separate public information from sensitive GDPR-protected data (addresses and social security numbers).Key Features:Many-to-Many Relationships: Courses are linked to multiple programs via a bridge table.Security: Separate tables for sensitive student, leader, and educator details to remove transitive dependencies.Swedish Tech Context: Specifically designed for Data Engineering and Cloud Architect programs.Scalable Design: Supports multiple facilities (Stockholm, Gothenburg, etc.) through a normalized location scheme.🗺️ Physical Model🛠️ Installation & UsageTo reproduce this database:Open DBeaver (or any PostgreSQL client).Ensure your Docker container is running the PostgreSQL image.Open and execute the Master_Script.sqlfile. This script cleans up existing tables and builds the entire system from scratch.🧪 Quick Enrollment CheckThis table demonstrates the basic enrollment connectivity:Student NameClassProgramLocationLeaderErik JohanssonDE-STHLM-24Data EngineerStockholmAnders SvenssonAnna LindgrenDE-STHLM-24Data EngineerStockholmAnders SvenssonMichel SvenssonCLOUD-GBG-24Cloud ArchitectGothenburgMaja Lundqvist🚀 Deep-Dive Verification QueryTo verify that all 11 tables are correctly linked and that the 3rd Normal Form (3NF) relationships are functioning, run the following "Grand Join" query.This query traverses the entire scheme—from the physical Facility all the way to the Consultant's Hourly Rate in the hidden details vault.Query Instructions:Open DBeaver or your SQL terminal.Ensure you have executed the Master_Script.sqlfirst.Paste and run the code below:SQLSELECT 
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
Created as part of the Database Management Lab by Michel - 2026.
