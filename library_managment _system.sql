CREATE DATABASE IF NOT EXISTS smartlibrary;
USE smartlibrary;

DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS autheors;

CREATE TABLE autheor(
    autheor_id INT PRIMARY KEY AUTO_INCREMENT,
    autheor_name VARCHAR(50) Not NUll,
    email VARCHAR(100)
);

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    titel(100) NOT NULL,
    author_id INT,
    category VARCHAR(50),
    isbin VARCHAR (20) UNIQUE,
    publish_date  DATE,
    price DECIMAL(10,2));

    CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    membership_date DATE);

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

INSERT INTO authors(name ,email)
VALUES
('J.K. Rowling', 'jkrowling@gmail.com'),
('George Orwell', 'george@gmail.com'),
('Robert Martin', 'robert@gmail.com'),
('A.P.J. Abdul Kalam', 'apj@gmail.com'),
('Jane Austen', NULL),
('Unknown Author', NULL);

INSERT INTO Transactions
(member_id, book_id, borrow_date, return_date, fine_amount)
VALUES
(1, 1, '2025-01-05', '2025-01-15', 0),
(1, 3, '2025-03-10', '2025-03-25', 20),
(2, 2, '2025-02-01', '2025-02-10', 0),
(2, 3, '2025-04-12', NULL, 50),
(3, 4, '2025-05-01', '2025-05-12', 0),
(4, 1, '2024-06-10', '2024-06-20', 10),
(5, 6, '2025-07-15', NULL, 0),
(1, 2, '2026-01-10', NULL, 0),
(6, 5, '2026-02-05', '2026-02-15', 0);

SELECT * FROM authores,
SELECT * FROM books,
SELECT * FROM members,
SELECT * FROM transactions,

INSERT INTO authors(name,email)
VALUES(bharatpatel , 1234@gmail.com);

INSERT INTO books(title, author_id, category, isbn,
published_date, price, available_copies)
VALUES
('Five Point Someone', 7, 'Fiction',
'ISBN009', '2004-05-01', 500, 3);

INSERT INTO members( name ,email,phone_number,membership_date)
VALUE(roy ,roy@gmail.com,9876858412,'2026-10-1');

UPDATE books
SET price ='140'
WHERE book_id =1;

UPDATE book
SET avilabel_copies = avilable_copies+1
WHERE book_id =1;

DELETE FROM members
WHERE member_id NOT IN(
    SELECT member_id 
    FROM transctions
    WHERE BROWSER_id>=DATE_SUB(CURDATE(),INTERVAL 1 YEAR)
);

SELECT*FROM books
WHERE avilable_copies >0;

SELECT * FROM book
WHERE publish_date >'2026-5-1';

SELECT*FROM books
ORDER BY price DESC
LIMIT 5;

SELECT*FROM members
WHERE membership_date<'2022-1-1';

SELECT category ,count(*)AS
total books,
FROM books,
GROUP BY category
HAving COUNT(*)>1;

SELECT*FROM books
WHERE category ="SCIENC"
AND price<500;

SELECT* FROM books
WHERE avilable_copie >0;

SELECT
m.member_id,
m.name,
m.membership_date,
COUNT(t.transcations_id)AS total_borrowed
FROM members m

LEFT JOIN transction t ON m.member_id = t.member_id

GROUP BY
m.member_id,
m.name,
m.membership_date,

HAVING membershipdate >'2020-12-31'
ON COUNT (t.transction_id) >3; 

SELECT*FROM book
ORDER BY title ASC;

SELECT
m.member_id,
m.name
COUNT(t.transction_id)AS total_borrowed

FROM members m

LEFT JOIN transction t ON m.member_id = t.member_id 

GROUP BY 
m.member_id,
m.name;

SELECT  
category COUNT(*) AS total_book

FROM books
GROUP BY cetegory;

SELECT  
category COUNT(*) AS total_book

FROM books
GROUP BY cetegory;

SELECT AVG (price)AS average_price 
FORM books;

SELECT 
b.title,
COUNT(t.transction_id) AS total_borrowed

FROM books b
LEFT JOIN transction t ON b.book_id = t.book_id 

GROUP BY 
b.book_id,
b.title
ORDER BY borrow_count DESC

SELECT *FROM members
WHERE member_id NOT IN (
    SELECT member_id,
    FROM transction
);

SELECT*FROM books
WHERE price>(
    SELECT AVG(price)
    FROM books
)

SELECT
    title,
    YEAR(published_date) AS publication_year

FROM Books;

SELECT
    transaction_id,
    borrow_date,
    return_date,
    DATEDIFF(return_date, borrow_date) AS days_borrowed

FROM Transactions

WHERE return_date IS NOT NULL;

SELECT
    transaction_id,
    borrow_date,
    return_date,

    GREATEST(
        DATEDIFF(return_date, borrow_date) - 14,
        0
    ) AS late_days,

    GREATEST(
        DATEDIFF(return_date, borrow_date) - 14,
        0
    ) * 5 AS calculated_fine

FROM Transactions

WHERE return_date IS NOT NULL;

SELECT
    transaction_id,
    DATE_FORMAT(borrow_date, '%d-%m-%Y') AS formatted_date

FROM Transactions;

SELECT UPPER (title)
FROM books;

SELECT TRIM(name)
FROM authors;

SELECT
title,
LENGTH(title) AS title_length
FROM books,

SELECT 
CONCAT(title,'--Library Book--') AS descraption
FROM books;

SELECT
    b.title,

    COUNT(t.transaction_id) AS borrow_count,

    RANK() OVER (
        ORDER BY COUNT(t.transaction_id) DESC
    ) AS book_rank

FROM Books b

LEFT JOIN Transactions t
ON b.book_id = t.book_id

GROUP BY
    b.book_id,
    b.title;

SELECT
    m.member_id,
    m.name,
    t.transaction_id,
    t.borrow_date,

    COUNT(t.transaction_id) OVER (
        PARTITION BY m.member_id
        ORDER BY t.borrow_date, t.transaction_id
    ) AS cumulative_borrowed

FROM Members m

LEFT JOIN Transactions t
ON m.member_id = t.member_id

WITH monthly_borrows AS (

    SELECT
        DATE_FORMAT(borrow_date, '%Y-%m-01') AS borrow_month,
        COUNT(*) AS total_borrowed

    FROM Transactions

    GROUP BY DATE_FORMAT(borrow_date, '%Y-%m-01')

)

SELECT
    borrow_month,
    total_borrowed,

    AVG(total_borrowed) OVER (
        ORDER BY borrow_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average

FROM monthly_borrows;

SELECT
    m.member_id,
    m.name,

    CASE

        WHEN MAX(t.borrow_date) >=
        DATE_SUB(CURDATE(), INTERVAL 6 MONTH)

        THEN 'Active'

        ELSE 'Inactive'

    END AS Membership_Status

FROM Members m

LEFT JOIN Transactions t
ON m.member_id = t.member_id

GROUP BY
    m.member_id,
    m.name;

SELECT
    title,
    published_date,

    CASE

        WHEN published_date > '2020-12-31'
        THEN 'New Arrival'

        WHEN published_date < '2000-01-01'
        THEN 'Classic'

        ELSE 'Regular'

    END AS book_type

FROM Books;

START TRANSACTION;

UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = 1
AND available_copies > 0;

INSERT INTO Transactions
(member_id, book_id, borrow_date, return_date, fine_amount)

SELECT 1, 1, CURDATE(), NULL, 0
WHERE EXISTS (
    SELECT 1
    FROM Books
    WHERE book_id = 1
    AND available_copies >= 0
);

COMMIT;

START TRANSACTION;

UPDATE Transactions
SET return_date = CURDATE()
WHERE transaction_id = 4
AND return_date IS NULL;

UPDATE Books
SET available_copies = available_copies + 1
WHERE book_id = 3
AND EXISTS (
    SELECT 1
    FROM Transactions
    WHERE transaction_id = 4
    AND return_date = CURDATE()
);

COMMIT;

SHOW DATABASES;

USE smartlibrary;

SELECT*FROM auther;
SELECT*FROM book;
SELECT*FROM members;
SELECT*FROM transaction;







 






