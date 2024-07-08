CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    JoinDate DATE
);

INSERT INTO Customers (CustomerID, CustomerName, JoinDate) VALUES
(101, 'Alice', '2023-01-15'),
(102, 'Bob', '2023-02-20'),
(103, 'Charlie', '2023-03-25'),
(104, 'David', '2023-04-30'),
(105, 'Eve', '2023-05-05'),
(106, 'Frank', '2023-06-10'),
(107, 'Grace', '2023-07-15'),
(108, 'Hank', '2023-08-20'),
(109, 'Ivy', '2023-09-25'),
(110, 'Jack', '2023-10-30');


CREATE TABLE Sales (
    TransactionID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    TransactionDate DATE
);

INSERT INTO Sales (TransactionID, CustomerID, ProductID, Quantity, Price, TransactionDate) VALUES
(1, 101, 1, 2, 50.00, '2023-06-01'),
(2, 102, 2, 1, 100.00, '2023-06-02'),
(3, 103, 1, 3, 50.00, '2023-06-03'),
(4, 104, 3, 5, 20.00, '2023-06-05'),
(5, 105, 2, 2, 100.00, '2023-06-10'),
(6, 106, 1, 1, 50.00, '2023-06-15'),
(7, 107, 3, 4, 20.00, '2023-06-20'),
(8, 108, 2, 1, 100.00, '2023-06-25'),
(9, 109, 1, 2, 50.00, '2023-07-01'),
(10, 110, 3, 3, 20.00, '2023-07-05');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100)
);

INSERT INTO Products (ProductID, ProductName) VALUES
(1, 'Product A'),
(2, 'Product B'),
(3, 'Product C');


SELECT *
FROM customers

SELECT *
FROM sales

SELECT *
FROM products

-- Problem 1: Sales Analysis
SELECT ProductID, SUM(Quantity * Price) AS TotalSalesAmount
FROM Sales
WHERE TransactionDate BETWEEN '2023-06-01' AND '2023-06-30'
GROUP BY ProductID;

--Problem 2: Customer Purchase Frequency
SELECT c.customername, SUM(quantity)
FROM sales s
INNER JOIN customers AS c 
ON c.customerid = s.customerid
WHERE s.transactiondate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY c.customername;

--Problem 3: Monthly Sales Trend
SELECT EXTRACT(MONTH FROM transactiondate) AS month, SUM(quantity * price) AS tot_sale
FROM sales
WHERE EXTRACT(YEAR FROM transactiondate) = 2023
GROUP BY EXTRACT(MONTH FROM transactiondate);


--Problem 4: Top Customers by Sales
SELECT c.customername, sum(quantity*price) as sales_per_customer
FROM sales s
INNER JOIN customers as c 
ON c.customerid = s.customerid 
WHERE EXTRACT(YEAR FROM s.transactiondate) = 2023
GROUP BY c.customerid
ORDER BY sales_per_customer DESC
LIMIT 5
