CREATE SCHEMA IF NOT EXISTS LibraryManagement;

USE LibraryManagement;

CREATE TABLE IF NOT EXISTS authors (
author_id INT AUTO_INCREMENT PRIMARY KEY,
author_name VARCHAR(255));

CREATE TABLE IF NOT EXISTS genres (
genre_id INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(255));

CREATE TABLE IF NOT EXISTS books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255),
publication_year YEAR,
author_id INT,
FOREIGN KEY (author_id) REFERENCES authors(author_id),
genre_id INT,
FOREIGN KEY (genre_id) REFERENCES genres(genre_id));

CREATE TABLE IF NOT EXISTS users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(255),
email VARCHAR(255));

CREATE TABLE IF NOT EXISTS borrowed_books (
borrow_id INT AUTO_INCREMENT PRIMARY KEY,
book_id INT, 
FOREIGN KEY (book_id) REFERENCES books(book_id),
user_id INT, 
FOREIGN KEY (user_id) REFERENCES users(user_id),
borrow_date DATE,
return_date DATE);


INSERT INTO authors (author_name)
VALUES 
('Valerian Pidmohylny'),
('Mykola Khvyloviy'),
('Vasyl Symonenko');
        
INSERT INTO genres (genre_name)
VALUES 
('urban novel'),
('psychological novel'),
('poetry');

INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES
('The City', 1928, 1, 1),
('I am (Romance)', 1924, 2, 1),
('Silence and Thunder', 1962, 3, 3);

INSERT INTO users (user_name, email)
VALUES
('Robert', 'rob@mail.com'),
('Bob', 'bob@mail.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES
(2, 1, '2024-11-23', '2024-11-30'),
(3, 2, '2024-11-22', '2024-11-27');


-- 3 
USE mydb;

SELECT * FROM order_details
INNER JOIN orders ON order_details.order_id=orders.id
INNER JOIN products ON order_details.product_id=products.id
INNER JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id;

-- 4.1

SELECT COUNT(*) FROM order_details
INNER JOIN orders ON order_details.order_id=orders.id
INNER JOIN products ON order_details.product_id=products.id
INNER JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id;

-- 4.2

SELECT COUNT(*) FROM order_details
LEFT JOIN orders ON order_details.order_id=orders.id
LEFT JOIN products ON order_details.product_id=products.id
LEFT JOIN customers ON orders.customer_id=customers.id
LEFT JOIN employees ON orders.employee_id=employees.employee_id
LEFT JOIN shippers ON orders.shipper_id=shippers.id
LEFT JOIN categories ON products.category_id=categories.id
LEFT JOIN suppliers ON products.supplier_id=suppliers.id;


--  add time for server during query
SET GLOBAL net_read_timeout = 620;
SET GLOBAL net_write_timeout = 620;
SET GLOBAL wait_timeout = 1200;
SET GLOBAL interactive_timeout = 1200;
-- didn't help
-- replase some RIGHT JOIN to INNER JOIN

SELECT COUNT(*) FROM order_details
RIGHT JOIN orders ON order_details.order_id=orders.id
RIGHT JOIN products ON order_details.product_id=products.id
RIGHT JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id;

-- all of the queries return the same numbers of results because there is no missing data
-- for the columns we selected

-- 4.3

SELECT COUNT(*) FROM order_details
INNER JOIN orders ON order_details.order_id=orders.id
INNER JOIN products ON order_details.product_id=products.id
INNER JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id
WHERE employees.employee_id BETWEEN 3 AND 10;

-- 4.4 

SELECT categories.name, COUNT(*), AVG(order_details.quantity) FROM order_details
INNER JOIN orders ON order_details.order_id=orders.id
INNER JOIN products ON order_details.product_id=products.id
INNER JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id
WHERE employees.employee_id BETWEEN 3 AND 10
GROUP BY categories.name;

-- 4.5

SELECT categories.name, COUNT(*), AVG(order_details.quantity) AS average
FROM order_details
INNER JOIN orders ON order_details.order_id=orders.id
INNER JOIN products ON order_details.product_id=products.id
INNER JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id
WHERE employees.employee_id BETWEEN 3 AND 10
GROUP BY categories.name
HAVING average > 21;

-- 4.6

SELECT categories.name, COUNT(*), AVG(order_details.quantity) AS average
FROM order_details
INNER JOIN orders ON order_details.order_id=orders.id
INNER JOIN products ON order_details.product_id=products.id
INNER JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id
WHERE employees.employee_id BETWEEN 3 AND 10
GROUP BY categories.name
HAVING average > 21
ORDER BY COUNT(*) DESC;

-- 4.7

SELECT categories.name, COUNT(*), AVG(order_details.quantity) AS average
FROM order_details
INNER JOIN orders ON order_details.order_id=orders.id
INNER JOIN products ON order_details.product_id=products.id
INNER JOIN customers ON orders.customer_id=customers.id
INNER JOIN employees ON orders.employee_id=employees.employee_id
INNER JOIN shippers ON orders.shipper_id=shippers.id
INNER JOIN categories ON products.category_id=categories.id
INNER JOIN suppliers ON products.supplier_id=suppliers.id
WHERE employees.employee_id BETWEEN 3 AND 10
GROUP BY categories.name
HAVING average > 21
ORDER BY COUNT(*) DESC
LIMIT 4 OFFSET 1;