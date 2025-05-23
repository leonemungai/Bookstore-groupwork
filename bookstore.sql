-- 1. Create the database
CREATE DATABASE IF NOT EXISTS BookstoreDB;
USE BookstoreDB;

-- 2. Tables for Books and Authors
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10,2) NOT NULL,
    publish_date DATE,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 3. Tables for Customers and Addresses
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 4. Tables for Orders and Shipping
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL
);

CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL
);

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 5. Insert sample data for testing

-- Authors
INSERT INTO author (name) VALUES ('John Steinbeck'), ('Henry R. Ole Kulet'), ('Margaret A. Ogola');

-- Book Languages
INSERT INTO book_language (language_name) VALUES ('English'), ('Swahili'), ('French');

-- Publishers
INSERT INTO publisher (name) VALUES ('Penguin Books'), ('Longhorn Publishers'), ('East African Educational Publishers');

-- Books
INSERT INTO book (title, publisher_id, language_id, price, publish_date)
VALUES
('The Pearl', 1, 1, 990, '1947-11-01'),
('Blossoms of the Savannah', 2, 1, 1100, '2008-05-10'),
('The River and the Source', 3, 1, 1050, '1994-03-01');

-- Book-Author Links
INSERT INTO book_author (book_id, author_id)
VALUES (1, 1), (2, 2), (3, 3);

-- Countries
INSERT INTO country (country_name) VALUES ('Kenya'), ('United Kingdom'), ('United States');

-- Address Status
INSERT INTO address_status (status_name) VALUES ('Current'), ('Old');

-- Addresses
INSERT INTO address (street, city, postal_code, country_id)
VALUES
('123 Kenyatta Ave', 'Nairobi', '00100', 1),
('221B Baker Street', 'London', 'NW1 6XE', 2),
('742 Evergreen Terrace', 'Springfield', '49007', 3);

-- Customers
INSERT INTO customer (name, email)
VALUES ('Tony Wabuko', 'tonywabuko@gmail.com'),
       ('Leone Mungai', 'mungai.2leone@gmail.com'),
       ('Shalom Nyalila', 'shalomnyalila@gmail.com');

-- Customer Addresses
INSERT INTO customer_address (customer_id, address_id, status_id)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);

-- Shipping Methods
INSERT INTO shipping_method (method_name) VALUES ('Standard Shipping'), ('Express Shipping');

-- Order Statuses
INSERT INTO order_status (status_name) VALUES ('Pending'), ('Shipped'), ('Delivered'), ('Cancelled');

-- Orders
INSERT INTO cust_order (customer_id, shipping_method_id, status_id)
VALUES
(1, 1, 1),
(2, 2, 2);

-- Order Lines
INSERT INTO order_line (order_id, book_id, quantity, unit_price)
VALUES
(1, 1, 2, 990),
(1, 3, 1, 1050),
(2, 2, 1, 1100);

-- Order History
INSERT INTO order_history (order_id, status_id)
VALUES
(1, 1), -- Pending
(1, 3), -- Delivered
(2, 2); -- Shipped

-- 6. Create a secure user with limited access
CREATE USER IF NOT EXISTS 'bookstore_user'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.* TO 'bookstore_user'@'localhost';
