# Library_management_project_using_sql

## Project Overview
**Project Title:** Library Management System
**Database:** Project


This project highlights the development of a robust Library Management System leveraging SQL for efficient database operations. Key deliverables include:

- **Database Design & Architecture:** Structured table creation and schema design to optimize data organization.
- **CRUD Operations:** Seamless execution of Create, Read, Update, and Delete functions for dynamic data management.
- **Advanced Querying:** Implementation of complex SQL queries to extract actionable insights and ensure system efficiency.

## Project Objectives:
**1. Database Setup & Configuration**
- Design and implement a structured Library Management System database, including tables for branches, employees, members, books, issued status, and return status.
- Populate the database with relevant data to ensure a functional and scalable system.

**2. Data Management (CRUD Operations)**
- Perform Create, Read, Update, and Delete (CRUD) operations to maintain accurate and up-to-date records.
- Ensure data integrity and efficient manipulation of library records.

**3. Optimized Data Handling (CTAS)**
- Leverage Create Table As Select (CTAS) to generate derived tables from query results, improving data organization and reporting efficiency.

**4. Advanced Data Retrieval & Analytics**
- Develop complex SQL queries to extract meaningful insights, generate reports, and support decision-making.
- Demonstrate proficiency in query optimization and database performance tuning.

This structured approach ensures a scalable, efficient, and data-driven Library Management System, showcasing expertise in database design, SQL operations, and business intelligence.


## Project Structure:
![](https://github.com/Issita/Library_management_project_using_sql/blob/main/erd_library.png)

**Table Creation:**
```postgreSQL
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
	(
		branch_id VARCHAR(10) PRIMARY KEY,
		manager_id VARCHAR(10),
		branch_address VARCHAR(55),
		contact_no VARCHAR(10)
	);

ALTER TABLE branch
ALTER COLUMN contact_no TYPE VARCHAR(20);

DROP TABLE IF EXISTS employees;
CREATE TABLE employees
	(
		emp_id VARCHAR(10) PRIMARY KEY,
		emp_name VARCHAR(25),
		position VARCHAR(25),
		salary INT,
		branch_id VARCHAR(25) --FK
	);

DROP TABLE IF EXISTS books;
CREATE TABLE books
	(
		isbn VARCHAR(20) PRIMARY KEY,
		book_title VARCHAR(75),	
		category VARCHAR(20),	
		rental_price FLOAT,
		status	VARCHAR(15),
		author	VARCHAR(40),
		publisher VARCHAR(55)
	);
	

DROP TABLE IF EXISTS members;
CREATE TABLE members
	(
		member_id VARCHAR(20) PRIMARY KEY,
		member_name	VARCHAR(25),
		member_address VARCHAR(75),
		reg_date DATE
	);
	

DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
	(
		issued_id VARCHAR(10) PRIMARY KEY,
		issued_member_id VARCHAR(10), --FK
		issued_book_name VARCHAR(75),
		issued_date DATE,
		issued_book_isbn VARCHAR(40), --FK
		issued_emp_id VARCHAR(10) --FK
	);
	

DROP TABLE IF EXISTS retun_status;
CREATE TABLE retun_status
	(
		return_id VARCHAR(10),
		issued_id VARCHAR(10),
		return_book_name VARCHAR(75),	
		return_date DATE,
		return_book_isbn VARCHAR(20)
	);

```
