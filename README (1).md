# 📊 SQL Data Analysis & Advanced SQL

## 📌 Project Overview

This project focuses on analyzing a relational business database using SQL. The analysis uses the **ClassicModels** database to explore customers, employees, offices, products, product lines, orders, order details, and payments.

The project demonstrates SQL techniques ranging from basic data retrieval and filtering to advanced concepts such as aggregations, joins, Common Table Expressions (CTEs), subqueries, derived tables, views, stored procedures, user-defined functions, and triggers.

The goal is to use SQL to answer business-oriented questions and extract meaningful insights from structured relational data.

---

## 🎯 Project Objectives

- Explore and validate a relational business database
- Apply SQL filtering and aggregation techniques
- Analyze relationships between multiple database tables
- Use different types of SQL joins
- Apply CTEs, subqueries, and derived tables
- Create and use SQL views
- Implement stored procedures and user-defined functions
- Demonstrate trigger-based audit logging
- Perform customer, product, employee, order, payment, and country-level analysis
- Extract business-oriented insights from relational data

---

## 📊 Database Overview

The project uses the **ClassicModels** sample relational database.

The database contains eight interconnected tables:

| Table | Description |
|---|---|
| `customers` | Customer information, sales representatives, and credit limits |
| `employees` | Employee details, job titles, and office assignments |
| `offices` | Office locations and related information |
| `products` | Product details, inventory, purchase prices, and MSRP |
| `productlines` | Product categories and descriptions |
| `orders` | Order dates, status, shipping information, and customers |
| `orderdetails` | Products, quantities, and prices associated with orders |
| `payments` | Customer payment transactions and amounts |

The database uses primary and foreign-key relationships to connect the tables and support relational analysis.

---

## 🛠️ Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- Jupyter Notebook
- GitHub

### SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- LIMIT & OFFSET
- Aggregate Functions
- INNER JOIN
- RIGHT JOIN
- Common Table Expressions (CTEs)
- Subqueries
- Derived Tables
- COALESCE
- Views
- Stored Procedures
- User-Defined Functions
- Triggers

---

## 🔄 Project Workflow

1. Database and table validation
2. Data exploration and filtering
3. SQL operators and calculated fields
4. Aggregation and grouped analysis
5. SQL joins
6. Common Table Expressions
7. Subqueries and derived tables
8. Views
9. Stored procedures
10. User-defined functions
11. Triggers
12. Business-oriented analysis
13. Business insights and conclusions

---

## 🔎 Data Exploration & SQL Analysis

### Customer Data Filtering

Customers from NYC with a credit limit greater than 100,000 were identified using multiple filtering conditions.

### Employee Data Filtering

Sales Representatives assigned to office code 1 were identified using SQL filtering.

### SQL Aggregation Analysis

Customer credit-limit statistics were summarized using:

- COUNT
- AVG
- MIN
- MAX

### Product Line Stock Analysis

Product lines containing more than 10 products with inventory levels above 5,000 units were identified.

### Product Line Pricing Analysis

Minimum purchase prices were calculated for each product line and ranked using `ORDER BY`, `LIMIT`, and `OFFSET`.

---

## 🔗 SQL Joins

### INNER JOIN

Product and product-line information was combined using an `INNER JOIN`.

### RIGHT JOIN

Employee and office information was combined using a `RIGHT JOIN` based on `officeCode`.

These joins demonstrate how relational tables can be combined to create meaningful analytical datasets.

---

## 🧠 Advanced SQL Analysis

### Common Table Expressions (CTEs)

CTEs were used for:

- Identifying customers above the average credit limit
- Organizing employee and office analysis

### Subqueries

Subqueries were used for:

- Comparing customer credit limits against the overall average
- Identifying employees working in NYC or Paris offices

### Derived Tables

A derived table was used to create an intermediate result set for office-level analysis.

### COALESCE & Nested Subquery

`COALESCE()` was used to handle missing HTML descriptions while a nested subquery identified relevant product lines.

---

## 👁️ SQL View

A reusable view named `amount_view` was created to summarize customer payment activity.

The view calculates:

- Payment count
- Total payment amount
- Average payment amount

This demonstrates how views can simplify repeated reporting queries.

---

## ⚙️ Stored Procedure

A stored procedure named `employees_by_office` was created to retrieve employees based on an office-code parameter.

This demonstrates reusable and parameter-driven SQL logic.

---

## 🧮 User-Defined Functions

Two SQL functions were implemented as demonstration business rules:

### Product Discount

Calculates a 10% discount amount from a supplied product MSRP.

### Payment Discount

Calculates a 5% discount amount from a supplied payment amount.

These percentages are demonstration rules created for this project and do not represent actual ClassicModels business policies.

---

## 🔔 SQL Trigger

A salary-change logging trigger was implemented using a separate `sampledb` demonstration database.

The trigger automatically records:

- Employee ID
- Previous salary
- New salary
- Date of salary change

This demonstrates automated audit logging using database triggers.

The trigger demonstration is separate from the ClassicModels database because the ClassicModels `employees` table does not contain salary information.

---

## 💼 Business Analysis

### 💰 Top Customers by Total Payments

Customer payment activity was analyzed to identify customers with the highest recorded total payments.

### 💰 Revenue by Product Line

Product-line revenue was calculated using:

`quantityOrdered × priceEach`

This allows product categories to be compared based on recorded sales revenue.

### 🏆 Top 10 Products by Revenue

Products were ranked according to their recorded sales revenue.

### 👤 Sales Performance by Employee

Sales Representatives were compared based on the recorded revenue associated with their customers and orders.

### 📦 Order Status Analysis

Orders were analyzed by status to determine order counts and percentage distribution.

### 💵 Customer Revenue Analysis

Customer-level analysis included:

- Total orders
- Total revenue
- Average order value

### 🌍 Sales Performance by Country

Countries were compared using:

- Customer count
- Order count
- Total revenue
- Average order value

### 📦 Top Orders by Order Value

Individual orders were ranked based on calculated order value.

---

## 💡 Key Business Insights

The SQL analysis provides a structured view of business performance across customers, products, employees, orders, payments, and geographic markets.

The analysis can support:

- Customer segmentation
- High-value customer identification
- Product performance analysis
- Sales representative performance analysis
- Order monitoring
- Regional sales comparison
- Inventory planning
- Business reporting and KPI analysis

---

## ⚠️ Limitations

- The analysis is based on the available ClassicModels sample database.
- The dataset represents a sample business environment and may not reflect the complexity of a real-world production database.
- Revenue calculations are based on recorded order quantities and selling prices and do not include detailed cost or profit information.
- The custom discount functions use demonstration business rules and should not be interpreted as actual company pricing policies.
- The salary trigger demonstration uses a separate sample database because salary information is not available in the ClassicModels employee table.

---

## 🚀 Future Improvements

- Add advanced customer segmentation
- Analyze customer retention and repeat purchasing behavior
- Calculate profit margins if product cost data is available
- Build automated KPI dashboards using Power BI or Tableau
- Add time-based revenue and sales trend analysis
- Introduce more advanced stored procedures and database automation
- Integrate SQL analysis with Python for advanced analytics and visualization

---

## 📁 Project Files

```text
Project_4_SQL_Data_Analysis/
│
├── Project_4_SQL_Data_Analysis.ipynb
├── Project_4_SQL_Data_Analysis.sql
├── README.md
└── Database / Source Files
```

---

## 📝 Conclusion

This project demonstrates the use of SQL for analyzing a relational business database and extracting meaningful information from multiple interconnected tables.

The analysis progressed from basic filtering and aggregation to advanced SQL techniques including joins, Common Table Expressions, subqueries, derived tables, views, stored procedures, user-defined functions, and triggers.

Business-focused analysis was performed across customers, products, employees, orders, payments, and geographic markets.

The project demonstrates how SQL can transform structured database records into information that supports reporting, performance analysis, and data-driven decision-making.

---

## 🛠️ Skills Demonstrated

- SQL Data Analysis
- MySQL
- MySQL Workbench
- Data Filtering & Sorting
- Aggregate Functions
- GROUP BY & HAVING
- SQL Joins
- Common Table Expressions (CTEs)
- Subqueries
- Derived Tables
- COALESCE
- Views
- Stored Procedures
- User-Defined Functions
- Triggers
- Business KPI Analysis
- Customer & Revenue Analysis
- Product Performance Analysis
- Employee Sales Analysis
- Order Analysis