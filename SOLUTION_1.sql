SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM retun_status;
SELECT * FROM members;

-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 
-- 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2','To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

SELECT * FROM books;

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 main street'
WHERE member_id = 'C101';

select * from members;

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
select * from issued_status
where issued_id = 'IS121';

delete from issued_status
where issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
select * from issued_status
where issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
issued_emp_id,
count(issued_id) as total_book_issued
FROM issued_status
group by issued_emp_id
having count(issued_id)>1 ;


-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results 
-- each book and total book_issued_cnt**

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


-- Task 7. Retrieve All Books in a Specific Category:

select * from books
where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:

select * from books;
select * from issued_status;

select 
category,
sum(rental_price)as total_rental_income
from books
group by 1;

-- Task 9 : List Members Who Registered in the Last 180 Days:

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


-- task 10 List Employees with Their Branch Manager's Name and their branch details:

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


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

CREATE TABLE books_price_more_than_seven
AS    
SELECT * FROM Books
WHERE rental_price > 7;

select * from books_price_more_than_seven


-- Task 12: Retrieve the List of Books Not Yet Returned

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