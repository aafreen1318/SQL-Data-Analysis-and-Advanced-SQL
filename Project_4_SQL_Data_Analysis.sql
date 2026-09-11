-- Project 4: SQL Data Analysis & Advanced SQL
-- Database: ClassicModels (MySQL)

USE classicmodels;

-- Database Validation
SHOW TABLES;

-- Customer Data Filtering
SELECT customerNumber, customerName, city, country, creditLimit
FROM customers
WHERE city = 'NYC' AND creditLimit > 100000;

-- Employee Data Filtering
SELECT employeeNumber, firstName, lastName, jobTitle, officeCode
FROM employees
WHERE officeCode = 1 AND jobTitle = 'Sales Rep';

-- SQL Aggregation Analysis
SELECT COUNT(*) AS total_customers,
       ROUND(AVG(creditLimit), 2) AS average_credit_limit,
       ROUND(MIN(creditLimit), 2) AS minimum_credit_limit,
       ROUND(MAX(creditLimit), 2) AS maximum_credit_limit
FROM customers;

-- Product Line Stock Analysis
SELECT productLine, COUNT(*) AS product_count
FROM products
WHERE quantityInStock > 5000
GROUP BY productLine
HAVING product_count > 10;

-- Product Line Pricing Analysis
SELECT productLine, MIN(buyPrice) AS minimum_price
FROM products
GROUP BY productLine
HAVING minimum_price > 5
ORDER BY minimum_price DESC
LIMIT 5 OFFSET 3;

-- INNER JOIN
SELECT pl.productLine, p.productName, p.buyPrice, p.MSRP
FROM productlines AS pl
INNER JOIN products AS p ON pl.productLine = p.productLine
ORDER BY pl.productLine, p.productName;

-- RIGHT JOIN
SELECT e.employeeNumber, e.firstName, e.lastName, e.jobTitle,
       e.officeCode, o.city, o.state, o.country
FROM offices AS o
RIGHT JOIN employees AS e ON o.officeCode = e.officeCode
ORDER BY e.officeCode, e.lastName;

-- CTE: Customers Above Average Credit
WITH average_credit AS (
    SELECT AVG(creditLimit) AS avg_credit_limit
    FROM customers
)
SELECT customerName, creditLimit
FROM customers
WHERE creditLimit > (SELECT avg_credit_limit FROM average_credit)
ORDER BY creditLimit DESC;

-- CTE: Office & Employee Analysis
WITH office_employees AS (
    SELECT employeeNumber, firstName, lastName, jobTitle, officeCode
    FROM employees
)
SELECT oe.employeeNumber, oe.firstName, oe.lastName, oe.jobTitle,
       oe.officeCode, o.city, o.country
FROM office_employees AS oe
INNER JOIN offices AS o ON oe.officeCode = o.officeCode
ORDER BY oe.officeCode, oe.lastName;

-- Subquery
SELECT customerNumber, customerName, country, creditLimit
FROM customers
WHERE creditLimit > (SELECT AVG(creditLimit) FROM customers)
ORDER BY creditLimit DESC;

-- Subquery: Employees in NYC or Paris
SELECT e.employeeNumber, e.firstName, e.lastName, e.jobTitle, e.officeCode
FROM employees AS e
WHERE e.officeCode IN (
    SELECT o.officeCode
    FROM offices AS o
    WHERE o.city IN ('NYC', 'Paris')
)
ORDER BY e.officeCode, e.lastName;

-- Derived Table
SELECT city
FROM (
    SELECT *
    FROM offices
    WHERE officeCode = 4
) AS office_data;

-- COALESCE & Nested Subquery
SELECT textDescription,
       COALESCE(htmlDescription, 'missing value') AS html_description
FROM productlines
WHERE productLine IN (
    SELECT productLine
    FROM products
    WHERE productName IN ('1952 Alpine Renault 1300', '1996 Moto Guzzi 1100i')
);

-- View
CREATE OR REPLACE VIEW amount_view AS
SELECT customerNumber,
       COUNT(*) AS payment_count,
       SUM(amount) AS total_payment_amount,
       AVG(amount) AS average_payment_amount
FROM payments
GROUP BY customerNumber;

SELECT * FROM amount_view
ORDER BY total_payment_amount DESC;

-- Stored Procedure
DROP PROCEDURE IF EXISTS employees_by_office;
DELIMITER $$
CREATE PROCEDURE employees_by_office(IN p_officeCode VARCHAR(10))
BEGIN
    SELECT employeeNumber, firstName, lastName, jobTitle, officeCode
    FROM employees
    WHERE officeCode = p_officeCode
    ORDER BY lastName, firstName;
END $$
DELIMITER ;

CALL employees_by_office('1');

-- User-Defined Function: Product Discount (10% demonstration rule)
DROP FUNCTION IF EXISTS product_discount;
DELIMITER $$
CREATE FUNCTION product_discount(price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN price * 0.10;
END $$
DELIMITER ;

SELECT productLine, quantityInStock, MSRP,
       product_discount(MSRP) AS discount_amount
FROM products;

-- User-Defined Function: Payment Discount (5% demonstration rule)
DROP FUNCTION IF EXISTS amount_disc;
DELIMITER $$
CREATE FUNCTION amount_disc(payment_amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN payment_amount * 0.05;
END $$
DELIMITER ;

SELECT customerNumber, amount,
       amount_disc(amount) AS discount_amount
FROM payments;

-- Top 10 Customers by Total Payments
SELECT c.customerNumber, c.customerName, c.country,
       SUM(p.amount) AS total_payments
FROM customers AS c
INNER JOIN payments AS p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName, c.country
ORDER BY total_payments DESC
LIMIT 10;

-- Revenue by Product Line
SELECT p.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM products AS p
INNER JOIN orderdetails AS od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY total_revenue DESC;

-- Top 10 Products by Revenue
SELECT p.productCode, p.productName, p.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM products AS p
INNER JOIN orderdetails AS od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.productLine
ORDER BY total_revenue DESC
LIMIT 10;

-- Sales Performance by Employee
SELECT e.employeeNumber, e.firstName, e.lastName,
       SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM employees AS e
INNER JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN orders AS o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
WHERE e.jobTitle = 'Sales Rep'
GROUP BY e.employeeNumber, e.firstName, e.lastName
ORDER BY total_sales DESC;

-- Order Status Distribution
SELECT status, COUNT(*) AS order_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2)
       AS percentage_of_orders
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- Top 10 Customers by Revenue
SELECT c.customerNumber, c.customerName, c.country,
       COUNT(DISTINCT o.orderNumber) AS total_orders,
       ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS total_revenue
FROM customers AS c
INNER JOIN orders AS o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName, c.country
ORDER BY total_revenue DESC
LIMIT 10;

-- Sales Performance by Country
SELECT c.country,
       COUNT(DISTINCT c.customerNumber) AS customer_count,
       COUNT(DISTINCT o.orderNumber) AS order_count,
       ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS total_revenue,
       ROUND(SUM(od.quantityOrdered * od.priceEach) /
             COUNT(DISTINCT o.orderNumber), 2) AS average_order_value
FROM customers AS c
INNER JOIN orders AS o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY total_revenue DESC;

-- Top 10 Orders by Order Value
SELECT o.orderNumber, o.orderDate, o.status,
       ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS order_value
FROM orders AS o
INNER JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber, o.orderDate, o.status
ORDER BY order_value DESC
LIMIT 10;
