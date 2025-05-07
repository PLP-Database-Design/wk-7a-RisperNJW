-- Question 1: Transforming to 1NF
CREATE TABLE ProductDetail (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100),
Products VARCHAR(255)
);

INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

CREATE TEMPORARY TABLE numbers (n INT);
INSERT INTO numbers (n) VALUES (1), (2), (3), (4), (5);

SELECT
pd.OrderID,
pd.CustomerName,
TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', n), ',', -1)) AS Product
FROM
ProductDetail pd
JOIN
numbers
ON
CHAR_LENGTH(pd.Products) - CHAR_LENGTH(REPLACE(pd.Products, ',', '')) >= n - 1;

-- Question 2: Transforming to 2NF
CREATE TABLE OrderDetails (
OrderID INT,
CustomerName VARCHAR(100),
Product VARCHAR(50),
Quantity INT
);

INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

CREATE TABLE OrderItems (
OrderID INT,
Product VARCHAR(50),
Quantity INT,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;