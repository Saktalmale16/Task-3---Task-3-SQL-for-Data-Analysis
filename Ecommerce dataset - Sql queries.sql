use ecommerce_db ;

# a) Basic SELECT / WHERE / ORDER BY / GROUP BY
# 1) All records, ordered by date

SELECT *
FROM data
ORDER BY InvoiceDate;

# 2) Filter to a specific country (e.g. “United Kingdom”)
 
SELECT *
FROM data
WHERE Country = 'United Kingdom'
ORDER BY InvoiceDate;

# 3) Total quantity sold per product

SELECT Country,
SUM(Quantity * UnitPrice) AS total_revenue
FROM data
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;


# 4) Total revenue per country

SELECT Country,
SUM(Quantity * UnitPrice) AS total_revenue
FROM data
GROUP BY Country
ORDER BY total_revenue DESC;

# b) JOINS
# 1) Create a Customers dimension

CREATE TABLE Customers AS
SELECT DISTINCT CustomerID, Country
FROM data;

# 2) INNER JOIN: sales with customer country

SELECT d.InvoiceNo,
       d.StockCode,
       d.Description,
       d.Quantity,
       d.UnitPrice,
       c.Country
FROM data AS d
INNER JOIN Customers AS c
  ON d.CustomerID = c.CustomerID;

# 3) LEFT JOIN: all customers and any sales

SELECT c.CustomerID,
       c.Country,
       d.InvoiceNo,
       d.Quantity
FROM Customers AS c
LEFT JOIN data AS d
  ON c.CustomerID = d.CustomerID;
  
# 4) Self JOIN: products bought together

SELECT a.StockCode AS product_a,
       b.StockCode AS product_b,
       COUNT(*) AS times_bought_together
FROM data AS a
JOIN data AS b
  ON a.InvoiceNo = b.InvoiceNo
 AND a.StockCode < b.StockCode
GROUP BY product_a, product_b
ORDER BY times_bought_together DESC
LIMIT 20;

# c) Subqueries
# 1) Customers who’ve spent over £1,000

SELECT CustomerID,
SUM(Quantity * UnitPrice) AS total_spent
FROM data
GROUP BY CustomerID
HAVING total_spent > 1000;

# 2) Products never sold

SELECT DISTINCT StockCode, Description
FROM data
WHERE StockCode NOT IN (
  SELECT StockCode
  FROM data
  WHERE Quantity > 0
);

# d) Aggregate Functions
# 1)Average order value

SELECT AVG(invoice_total) AS avg_order_value
FROM (SELECT InvoiceNo, 
SUM(Quantity * UnitPrice) 
AS invoice_total
FROM data GROUP BY InvoiceNo)
AS invoice_totals;

# 2) Count of invoices per customer

SELECT CustomerID,
COUNT(DISTINCT InvoiceNo) AS invoice_count
FROM data
GROUP BY CustomerID;

# e) Creating Views
# 1) Monthly sales summary view

CREATE VIEW MonthlySalesSummary AS
SELECT YEAR(InvoiceDate)  AS sales_year,
       MONTH(InvoiceDate) AS sales_month,
       SUM(Quantity) AS total_qty,
       SUM(Quantity * UnitPrice) AS total_rev
FROM data
GROUP BY sales_year, sales_month;

# 2) Query the view

SELECT *
FROM MonthlySalesSummary
ORDER BY sales_year, sales_month;


# f) Optimizing with Indexes

CREATE INDEX idx_customerid
  ON `data` (`CustomerID`);

CREATE INDEX idx_invoicedate
  ON `data` (`InvoiceDate`);

CREATE INDEX idx_stockcode
  ON `data` (`StockCode`);












