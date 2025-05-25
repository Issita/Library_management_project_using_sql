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
```SQL
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
	(
		branch_id VARCHAR(10) PRIMARY KEY,
		manager_id VARCHAR(10),
		branch_address VARCHAR(55),
		contact_no VARCHAR(10)
	);



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
**Foreign Key**
```sql
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id) 
REFERENCES members(member_id);


ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn) 
REFERENCES books(isbn);


ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id) 
REFERENCES employees(emp_id);


ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id) 
REFERENCES branch(branch_id);


ALTER TABLE retun_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id) 
REFERENCES issued_status(issued_id);
```

**Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"**

```sql
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2','To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

SELECT * FROM books;
```

**Task 2: Update an Existing Member's Address**

```sql
UPDATE members
SET member_address = '125 main street'
WHERE member_id = 'C101';

select * from members;
```

**Task 3: Delete a Record from the Issued Status Table 
Objective: Delete the record with issued_id = 'IS121' from the issued_status table.**

```sql
select * from issued_status
where issued_id = 'IS121';

delete from issued_status
where issued_id = 'IS121';
```

**Task 4: Retrieve All Books Issued by a Specific Employee 
Objective: Select all books issued by the employee with emp_id = 'E101'.**

```sql
select * from issued_status
where issued_emp_id = 'E101';
```

**Task 5: List Members Who Have Issued More Than One Book 
Objective: Use GROUP BY to find members who have issued more than one book.**

```sql
SELECT 
issued_emp_id,
count(issued_id) as total_book_issued
FROM issued_status
group by issued_emp_id
having count(issued_id)>1 ;
```

**CTAS**
**Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results each book and total book_issued_cnt**

```sql
create table book_counts
as
SELECT 
	b.isbn,
	b.book_title,
	count(ist.issued_id) as no_issued
FROM books as b
join
issued_status as ist
on 
ist.issued_book_isbn = b.isbn
group by 1,2;

select * from book_counts;
```

**Task 7. Retrieve All Books in a Specific Category:**

```sql
select * from books
where category = 'Classic';
```

**Task 8: Find Total Rental Income by Category:**

```sql
select * from books;
select * from issued_status;

select 
category,
sum(rental_price)as total_rental_income
from books
group by 1;
```

**Task 9 : List Members Who Registered in the Last 180 Days:**

```sql
INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C120', 'sam', '145 Main St', '2024-06-01'),
('C121', 'john', '133 Main St', '2024-05-01'),
('C122', 'issita', '155 Main St', '2025-04-01');


SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'   ;

--or

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - 180 

--or 

SELECT * FROM members
WHERE reg_date >= NOW() - INTERVAL '6 months'

```

**Task 10: List Employees with Their Branch Manager's Name and their branch details:**

```sql
select * from branch;
select * from employees;

select 
e1.emp_id,
e1.emp_name,
e1.branch_id,
e2.emp_id as manager_id,
e2.emp_name as manager
from branch as b 
join
employees as e1
on
b.branch_id = e1.branch_id 
join
employees as e2
on
b.manager_id = e2.emp_id;
```

**Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:**

```sql
CREATE TABLE books_price_more_than_seven
AS    
SELECT * FROM Books
WHERE rental_price > 7;

select * from books_price_more_than_seven
```

**Task 12: Retrieve the List of Books Not Yet Returned**

```sql
select * from issued_status;
select * from retun_status;

select 
	iss.issued_book_isbn,
	iss.issued_book_name
from issued_status as iss
left join
retun_status as ret
on
iss.issued_id = ret.issued_id
where ret.return_date is null;
```
