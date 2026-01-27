# 📊 YrkesCo Database Management System

A professional, 3rd Normal Form (3NF) relational database designed for **YrkesCo** to manage students, courses, programs, and staff across multiple cities.

## 🏛️ Architecture Overview
This project implements a secure "Vault" strategy to separate public information from sensitive GDPR-protected data (addresses and personnummer).

### Key Features:
* **Many-to-Many Relationships:** Courses are linked to multiple programs via a bridge table.
* **Security:** Separate tables for sensitive student, leader, and educator details.
* **Swedish Tech Context:** Specifically designed for Data Engineering and Cloud Architect programs.
* **Scalable Design:** Supports multiple facilities (Stockholm, Göteborg, etc.).

## 🗺️ Physical Model
![Database Diagram](./Physical_Model_Diagram.png)

## 🛠️ Installation & Usage
To reproduce this database:
1. Open **DBeaver** (or any PostgreSQL client).
2. Create a new database named `postgres`.
3. Open and execute the `Script.sql` file.

## 🧪 Verification Query
The following SQL join is used to verify the connectivity of all 11 tables:

| Student Name | Class | Program | Location | Leader |
| :--- | :--- | :--- | :--- | :--- |
| Erik Johansson | DE-STHLM-24 | Data Engineer | Stockholm | Anders Svensson |
| Anna Lindgren | DE-STHLM-24 | Data Engineer | Stockholm | Anders Svensson |
| Michel Svensson | CLOUD-GBG-24 | Cloud Architect | Göteborg | Maja Lundqvist |

---
*Created as part of the Database Management Lab - 2024.*# Database-Design-YrkesCo