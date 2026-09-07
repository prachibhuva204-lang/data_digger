DROP DATABASE DataDigger;
CREATE DATABASE IF NOT EXISTS DataDigger;
USE DataDigger;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

INSERT INTO Customers (CustomerID, Name, Email, Address)
VALUES
(1, 'prachi', 'prachi@gmail.com', 'Ahmedabad'),
(2, 'Riya', 'riya@gmail.com', 'Surat'),
(3, 'Priya', 'priya@gmail.com', 'Vadodara'),
(4, 'Amit', 'amit@gmail.com', 'Rajkot'),
(5, 'Neha', 'neha@gmail.com', 'Gandhinagar');

SELECT * FROM Customers;

UPDATE Customers
SET Address = 'Mumbai'
WHERE CustomerID = 2;

SELECT * FROM Customers
WHERE Name = 'prachi';

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, CURDATE(), 2500.00),
(102, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 1200.00),
(103, 3, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 3500.00),
(104, 4, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 800.00),
(105, 1, DATE_SUB(CURDATE(), INTERVAL 40 DAY), 4500.00);

SELECT * FROM Orders
WHERE CustomerID = 1;

UPDATE Orders
SET TotalAmount = 3000.00
WHERE OrderID = 101;

SELECT * FROM Orders
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT
    MAX(TotalAmount) AS Highest_Order,
    MIN(TotalAmount) AS Lowest_Order,
    AVG(TotalAmount) AS Average_Order
FROM Orders;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Price, Stock)
VALUES
(201, 'Laptop', 55000.00, 10),
(202, 'Keyboard', 1200.00, 25),
(203, 'Mouse', 700.00, 0),
(204, 'Headphones', 2000.00, 15),
(205, 'Monitor', 15000.00, 8);

SELECT * FROM Products
ORDER BY Price DESC;

UPDATE Products
SET Price = 1300.00
WHERE ProductID = 202;

SELECT * FROM Products
WHERE Price BETWEEN 500 AND 2000;

SELECT
    MAX(Price) AS Most_Expensive,
    MIN(Price) AS Cheapest
FROM Products;

SELECT * FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);

SELECT * FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails
(OrderDetailID, OrderID, ProductID, Quantity, SubTotal)
VALUES
(1, 101, 201, 1, 55000.00),
(2, 101, 202, 2, 2400.00),
(3, 102, 203, 3, 2100.00),
(4, 103, 204, 2, 4000.00),
(5, 104, 205, 1, 15000.00);

SELECT * FROM OrderDetails
WHERE OrderID = 101;

SELECT SUM(SubTotal) AS Total_Revenue
FROM OrderDetails;

SELECT
    ProductID,
    SUM(Quantity) AS Total_Ordered
FROM OrderDetails
GROUP BY ProductID
ORDER BY Total_Ordered DESC
LIMIT 3;

SELECT
    ProductID,
    SUM(Quantity) AS Total_Sold
FROM OrderDetails
WHERE ProductID = 202
GROUP BY ProductID;

DELETE FROM Orders
WHERE OrderID = 105;

DELETE FROM Products
WHERE Stock = 0;

DELETE FROM Customers
WHERE CustomerID = 5;

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM OrderDetails;

