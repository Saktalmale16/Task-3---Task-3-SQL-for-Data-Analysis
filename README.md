# Task-3-SQL-for-Data-Analysis
📦 E-commerce Database Analysis (SQL)

This project explores an ecommerce_db using structured SQL queries for data exploration, transformation, and optimization. It covers everything from basic filtering to performance tuning with indexes.
___
 
🧾 a) Basic SELECT / WHERE / ORDER BY / GROUP BY

Retrieved all records sorted by invoice date for chronological analysis.

Filtered dataset by country to analyze country-specific sales (e.g., United Kingdom).

Aggregated total quantity sold per product to identify top-performing items.

Summarized total revenue generated per country to determine top markets.

___

🔗 b) JOINS

Created a Customers dimension table to separate customer details.

Used an INNER JOIN to combine sales data with customer information for enriched reporting.

Implemented a LEFT JOIN to list all customers along with any matching sales, including those with no transactions.

Performed a self-join to find product pairs frequently bought together, useful for market basket analysis.

___

🔍 c) Subqueries

Identified customers who spent more than £1,000 using aggregate filtering in a HAVING clause.

Detected products that were never sold by comparing against a list of sold items with positive quantities.
___

📊 d) Aggregate Functions

Calculated the average order value by summing invoice totals and finding their average.

Counted the number of distinct invoices per customer to analyze buying frequency.
___

👁️ e) Creating Views

Created a reusable monthly sales summary view, including total quantity sold and revenue per month.

Queried the view to analyze sales trends over time efficiently.

___

🚀 f) Optimizing with Indexes

Added indexes to frequently used columns (CustomerID, InvoiceDate, StockCode) to improve query performance, especially on filtering and joining operations.

___

