# Bookstore-groupwork
# 📚 BookstoreDB - SQL Database Project

## 📖 Overview
This project simulates a relational database system for managing a bookstore's operations. The database stores data on books, authors, publishers, customers, addresses, orders, shipping methods, and more.


## 🛠️ Tools & Technologies
- **MySQL** – Main database engine used for implementation
- **Draw.io** – For creating the entity-relationship diagram (ERD)

---

## 🎯 Project Objectives
- Create a MySQL database to manage bookstore operations.
- Implement multiple tables with correct relationships and data types.
- Use foreign keys for data integrity and normalization.
- Manage user access and query data securely and efficiently.


## 🗂️ Tables Included

| Table Name           | Purpose |
|----------------------|---------|
| `author`             | Stores author names. |
| `book_language`      | Holds available book languages. |
| `publisher`          | Contains publisher info. |
| `book`               | Book details with language and publisher. |
| `book_author`        | Many-to-many relationship between books and authors. |
| `country`            | List of countries for address reference. |
| `address_status`     | Defines address statuses like "current" or "old". |
| `address`            | Full address information with country reference. |
| `customer`           | Basic customer info. |
| `customer_address`   | Connects customers to addresses with a status. |
| `shipping_method`    | Available shipping options. |
| `order_status`       | Status of an order (pending, delivered, etc.). |
| `cust_order`         | Main customer order table. |
| `order_line`         | Items in an order, including quantity and price. |
| `order_history`      | Tracks status changes for orders over time. |


## 🔐 User Management
A secure user can be created to manage the bookstore system:

sql
CREATE USER 'bookstore_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.* TO 'bookstore_user'@'localhost';
