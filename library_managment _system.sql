-- 1. CREATE DATABASE

CREATE DATABASE IF NOT EXISTS SmartLibrary;

USE SmartLibrary;


-- 2. DROP EXISTING TABLES

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Authors;

SET FOREIGN_KEY_CHECKS = 1;


-- 3. CREATE AUTHORS TABLE

CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);


-- 4. CREATE BOOKS TABLE

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150),
    author_id INT,
    category VARCHAR(50),
    isbn VARCHAR(30) UNIQUE,
    published_date DATE,
    price DECIMAL(10,2),
    available_copies INT,

    FOREIGN KEY (author_id)
    REFERENCES Authors(author_id)
);


-- 5. CREATE MEMBERS TABLE

CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    membership_date DATE
);


-- 6. CREATE TRANSACTIONS TABLE

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0,

    FOREIGN KEY (member_id)
    REFERENCES Members(member_id),

    FOREIGN KEY (book_id)
    REFERENCES Books(book_id)
);


-- =====================================================
-- 7. INSERT SAMPLE DATA
-- =====================================================


-- INSERT AUTHORS

INSERT INTO Authors (name, email)
VALUES
('Chetan Bhagat', 'chetan@gmail.com'),
('R K Narayan', 'narayan@gmail.com'),
('J K Rowling', 'jk@gmail.com'),
('Ruskin Bond', 'ruskin@gmail.com'),
('William Shakespeare', 'william@gmail.com');


-- INSERT BOOKS

INSERT INTO Books
(title, author_id, category, isbn, published_date, price, available_copies)
VALUES
('Five Point Someone', 1, 'Fiction', 'ISBN001', '2004-05-01', 350, 5),
('The Guide', 2, 'Classic', 'ISBN002', '1958-01-01', 450, 3),
('Harry Potter', 3, 'Fantasy', 'ISBN003', '1997-06-26', 800, 4),
('The Blue Umbrella', 4, 'Fiction', 'ISBN004', '1980-01-01', 250, 6),
('Hamlet', 5, 'Drama', 'ISBN005', '1603-01-01', 600, 2),
('Half Girlfriend', 1, 'Romance', 'ISBN006', '2014-10-01', 400, 5),
('Malgudi Days', 2, 'Classic', 'ISBN007', '1943-01-01', 300, 4),
('Fantastic Beasts', 3, 'Fantasy', 'ISBN008', '2001-01-01', 700, 3),
('The Room on the Roof', 4, 'Fiction', 'ISBN009', '1956-01-01', 550, 2),
('Romeo and Juliet', 5, 'Drama', 'ISBN010', '1597-01-01', 650, 3);


-- INSERT MEMBERS

INSERT INTO Members
(name, email, phone_number, membership_date)
VALUES
('Rahul', 'rahul@gmail.com', '9876543210', '2021-05-10'),
('Priya', 'priya@gmail.com', '9876543211', '2022-03-15'),
('Amit', 'amit@gmail.com', '9876543212', '2023-06-20'),
('Riya', 'riya@gmail.com', '9876543213', '2024-01-10'),
('Neha', 'neha@gmail.com', '9876543214', '2025-02-15'),
('Karan', 'karan@gmail.com', '9876543215', '2026-01-10');


-- INSERT TRANSACTIONS

INSERT INTO Transactions
(member_id, book_id, borrow_date, return_date, fine_amount)
VALUES
(1, 1, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 5 DAY), 30),
(1, 2, DATE_SUB(CURDATE(), INTERVAL 10 DAY), NULL, 0),
(2, 3, DATE_SUB(CURDATE(), INTERVAL 15 DAY), DATE_SUB(CURDATE(), INTERVAL 2 DAY), 5),
(2, 4, DATE_SUB(CURDATE(), INTERVAL 30 DAY), DATE_SUB(CURDATE(), INTERVAL 10 DAY), 30),
(3, 5, DATE_SUB(CURDATE(), INTERVAL 8 DAY), NULL, 0),
(3, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), NULL, 0),
(4, 6, DATE_SUB(CURDATE(), INTERVAL 12 DAY), DATE_SUB(CURDATE(), INTERVAL 3 DAY), 0),
(4, 7, DATE_SUB(CURDATE(), INTERVAL 60 DAY), DATE_SUB(CURDATE(), INTERVAL 40 DAY), 30),
(5, 8, DATE_SUB(CURDATE(), INTERVAL 25 DAY), DATE_SUB(CURDATE(), INTERVAL 5 DAY), 30),
(5, 3, DATE_SUB(CURDATE(), INTERVAL 3 DAY), NULL, 0),
(1, 3, DATE_SUB(CURDATE(), INTERVAL 2 DAY), NULL, 0);


-- =====================================================
-- 8. DISPLAY ALL TABLES
-- =====================================================

SHOW TABLES;

SELECT * FROM Authors;

SELECT * FROM Books;

SELECT * FROM Members;

SELECT * FROM Transactions;


-- =====================================================
-- 9. CRUD OPERATIONS
-- =====================================================


-- CREATE: INSERT NEW BOOK

INSERT INTO Books
(title, author_id, category, isbn, published_date, price, available_copies)
VALUES
('Learning SQL', 1, 'Science', 'ISBN011', '2021-05-10', 450, 5);


-- READ: DISPLAY ALL BOOKS

SELECT * FROM Books;


-- UPDATE: CHANGE BOOK PRICE

UPDATE Books
SET price = 500
WHERE book_id = 1;


-- UPDATE BOOK AVAILABILITY

UPDATE Books
SET available_copies = 10
WHERE book_id = 2;


-- DELETE: DELETE A BOOK

-- Example:
-- DELETE FROM Books WHERE book_id = 11;


-- RETRIEVE BOOKS WITH AVAILABLE COPIES

SELECT *
FROM Books
WHERE available_copies > 0;


-- DELETE MEMBERS WHO HAVE NOT BORROWED BOOKS
-- IN THE LAST ONE YEAR

-- Run only when deletion is required.

-- DELETE FROM Members
-- WHERE member_id NOT IN (
--     SELECT member_id
--     FROM Transactions
--     WHERE borrow_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
-- );


-- =====================================================
-- 10. WHERE, HAVING AND LIMIT
-- =====================================================


-- BOOKS PUBLISHED AFTER 2015

SELECT *
FROM Books
WHERE published_date > '2015-01-01';


-- TOP 5 EXPENSIVE BOOKS

SELECT *
FROM Books
ORDER BY price DESC
LIMIT 5;


-- MEMBERS WHO JOINED BEFORE 2022

SELECT *
FROM Members
WHERE membership_date < '2022-01-01';


-- =====================================================
-- 11. AND, OR AND NOT OPERATORS
-- =====================================================


-- SCIENCE CATEGORY AND PRICE LESS THAN 500

SELECT *
FROM Books
WHERE category = 'Science'
AND price < 500;


-- BOOKS NOT AVAILABLE FOR BORROWING

SELECT *
FROM Books
WHERE NOT available_copies > 0;


-- MEMBERS WHO JOINED AFTER 2020
-- OR BORROWED MORE THAN 3 BOOKS

SELECT m.member_id, m.name,
COUNT(t.transaction_id) AS total_borrowed
FROM Members m
LEFT JOIN Transactions t
ON m.member_id = t.member_id
GROUP BY m.member_id, m.name
HAVING m.membership_date > '2020-12-31'
OR COUNT(t.transaction_id) > 3;


-- =====================================================
-- 12. ORDER BY AND GROUP BY
-- =====================================================


-- SORT BOOKS BY TITLE

SELECT *
FROM Books
ORDER BY title ASC;


-- NUMBER OF BOOKS BORROWED BY EACH MEMBER

SELECT m.member_id, m.name,
COUNT(t.transaction_id) AS total_books
FROM Members m
LEFT JOIN Transactions t
ON m.member_id = t.member_id
GROUP BY m.member_id, m.name;


-- GROUP BOOKS BY CATEGORY

SELECT category,
COUNT(book_id) AS total_books
FROM Books
GROUP BY category;


-- =====================================================
-- 13. AGGREGATE FUNCTIONS
-- =====================================================


-- TOTAL BOOKS IN EACH CATEGORY

SELECT category,
COUNT(*) AS total_books
FROM Books
GROUP BY category;


-- AVERAGE BOOK PRICE

SELECT AVG(price) AS average_price
FROM Books;


-- MOST BORROWED BOOK

SELECT b.title,
COUNT(t.transaction_id) AS total_borrowed
FROM Books b
JOIN Transactions t
ON b.book_id = t.book_id
GROUP BY b.book_id, b.title
ORDER BY total_borrowed DESC
LIMIT 1;


-- TOTAL FINES COLLECTED

SELECT SUM(fine_amount) AS total_fines
FROM Transactions;


-- MAXIMUM BOOK PRICE

SELECT MAX(price) AS maximum_price
FROM Books;


-- MINIMUM BOOK PRICE

SELECT MIN(price) AS minimum_price
FROM Books;


-- TOTAL NUMBER OF BOOKS

SELECT COUNT(*) AS total_books
FROM Books;


-- =====================================================
-- 14. PRIMARY KEY AND FOREIGN KEY RELATIONSHIPS
-- =====================================================


-- AUTHOR AND BOOK RELATIONSHIP

SELECT *
FROM Books b
JOIN Authors a
ON b.author_id = a.author_id;


-- MEMBER AND TRANSACTION RELATIONSHIP

SELECT *
FROM Members m
JOIN Transactions t
ON m.member_id = t.member_id;


-- BOOK AND TRANSACTION RELATIONSHIP

SELECT *
FROM Books b
JOIN Transactions t
ON b.book_id = t.book_id;


-- =====================================================
-- 15. IMPLEMENT JOINS
-- =====================================================


-- INNER JOIN: BOOKS WITH AUTHOR NAMES

SELECT
b.book_id,
b.title,
a.name AS author_name
FROM Books b
INNER JOIN Authors a
ON b.author_id = a.author_id;


-- LEFT JOIN: MEMBERS WITH BORROWED BOOKS

SELECT
m.name,
t.book_id,
t.borrow_date
FROM Members m
LEFT JOIN Transactions t
ON m.member_id = t.member_id;


-- RIGHT JOIN: BOOKS THAT HAVE NOT BEEN BORROWED

SELECT
b.title,
t.transaction_id
FROM Transactions t
RIGHT JOIN Books b
ON t.book_id = b.book_id
WHERE t.transaction_id IS NULL;


-- FULL OUTER JOIN EQUIVALENT USING UNION

SELECT
m.member_id,
m.name,
t.transaction_id
FROM Members m
LEFT JOIN Transactions t
ON m.member_id = t.member_id

UNION

SELECT
m.member_id,
m.name,
t.transaction_id
FROM Members m
RIGHT JOIN Transactions t
ON m.member_id = t.member_id;


-- =====================================================
-- 16. SUBQUERIES
-- =====================================================


-- BOOKS BORROWED BY MEMBERS REGISTERED AFTER 2022

SELECT *
FROM Books
WHERE book_id IN (
    SELECT book_id
    FROM Transactions
    WHERE member_id IN (
        SELECT member_id
        FROM Members
        WHERE membership_date > '2022-12-31'
    )
);


-- MOST BORROWED BOOK USING SUBQUERY

SELECT *
FROM Books
WHERE book_id = (
    SELECT book_id
    FROM Transactions
    GROUP BY book_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- MEMBERS WHO HAVE NEVER BORROWED A BOOK

SELECT *
FROM Members
WHERE member_id NOT IN (
    SELECT member_id
    FROM Transactions
);


-- =====================================================
-- 17. DATE AND TIME FUNCTIONS
-- =====================================================


-- EXTRACT YEAR FROM PUBLISHED DATE

SELECT
title,
YEAR(published_date) AS publication_year
FROM Books;


-- DIFFERENCE BETWEEN BORROW AND RETURN DATE

SELECT
transaction_id,
borrow_date,
return_date,
DATEDIFF(return_date, borrow_date) AS total_days
FROM Transactions
WHERE return_date IS NOT NULL;


-- DISPLAY BORROW DATE IN DD-MM-YYYY FORMAT

SELECT
transaction_id,
DATE_FORMAT(borrow_date, '%d-%m-%Y') AS formatted_date
FROM Transactions;


-- CURRENT DATE

SELECT CURDATE();


-- CURRENT TIME

SELECT CURTIME();


-- =====================================================
-- 18. STRING MANIPULATION FUNCTIONS
-- =====================================================


-- CONVERT ALL BOOK TITLES TO UPPERCASE

SELECT UPPER(title) AS book_title
FROM Books;


-- TRIM WHITESPACE FROM AUTHOR NAMES

SELECT TRIM(name) AS author_name
FROM Authors;


-- REPLACE MISSING EMAIL VALUES WITH NOT PROVIDED

SELECT
name,
COALESCE(email, 'Not Provided') AS email
FROM Members;


-- LENGTH OF BOOK TITLES

SELECT
title,
LENGTH(title) AS title_length
FROM Books;


-- =====================================================
-- 19. WINDOW FUNCTIONS
-- =====================================================


-- RANK BOOKS BASED ON BORROWING COUNT

SELECT
b.title,
COUNT(t.transaction_id) AS total_borrowed,

RANK() OVER (
    ORDER BY COUNT(t.transaction_id) DESC
) AS book_rank

FROM Books b
LEFT JOIN Transactions t
ON b.book_id = t.book_id

GROUP BY b.book_id, b.title;


-- CUMULATIVE NUMBER OF BOOKS BORROWED PER MEMBER

SELECT
member_id,
transaction_id,
borrow_date,

COUNT(*) OVER (
    PARTITION BY member_id
    ORDER BY borrow_date, transaction_id
) AS cumulative_books

FROM Transactions;


-- MOVING AVERAGE OF BOOKS BORROWED
-- IN THE LAST 3 MONTHS

WITH MonthlyBorrow AS (
    SELECT
        DATE_FORMAT(borrow_date, '%Y-%m') AS borrow_month,
        COUNT(*) AS total_books
    FROM Transactions
    WHERE borrow_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    GROUP BY DATE_FORMAT(borrow_date, '%Y-%m')
)

SELECT
borrow_month,
total_books,

AVG(total_books) OVER (
    ORDER BY borrow_month
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_average

FROM MonthlyBorrow;


-- =====================================================
-- 20. CASE EXPRESSIONS
-- =====================================================


-- MEMBERSHIP STATUS

SELECT
m.member_id,
m.name,

CASE
    WHEN MAX(
        CASE
            WHEN t.borrow_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
            THEN 1 ELSE 0
        END
    ) = 1
    THEN 'Active'

    ELSE 'Inactive'

END AS Membership_Status

FROM Members m
LEFT JOIN Transactions t
ON m.member_id = t.member_id

GROUP BY m.member_id, m.name;


-- CATEGORIZE BOOKS

SELECT
title,
published_date,

CASE
    WHEN YEAR(published_date) > 2020
    THEN 'New Arrival'

    WHEN YEAR(published_date) < 2000
    THEN 'Classic'

    ELSE 'Regular'

END AS Book_Category

FROM Books;


-- =====================================================
-- 21. BORROW AND RETURN BOOK
-- =====================================================


-- BORROW BOOK
-- Example: Member ID 6 borrows Book ID 4

START TRANSACTION;

UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = 4
AND available_copies > 0;

SET @borrowed = ROW_COUNT();

INSERT INTO Transactions
(member_id, book_id, borrow_date, return_date, fine_amount)

SELECT 6, 4, CURDATE(), NULL, 0
WHERE @borrowed = 1;

COMMIT;


-- RETURN BOOK
-- Example: Transaction ID 2

START TRANSACTION;

SET @return_book_id = NULL;
SET @borrow_date = NULL;

SELECT book_id, borrow_date
INTO @return_book_id, @borrow_date
FROM Transactions
WHERE transaction_id = 2
AND return_date IS NULL;

SET @return_fine =
GREATEST(DATEDIFF(CURDATE(), @borrow_date) - 14, 0) * 5;

UPDATE Transactions
