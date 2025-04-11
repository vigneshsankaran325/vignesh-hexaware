CREATE database ECom;
use ECom;

CREATE TABLE Customers(
Customer_id INT IDENTITY PRIMARY KEY,
First_name VARCHAR(60),
Last_name VARCHAR(60),
Email VARCHAR(150),
Address VARCHAR(100));

CREATE TABLE Products(
Product_id INT IDENTITY PRIMARY KEY,
Name VARCHAR(90),
Description VARCHAR(200),
Price DECIMAL(10,2),
StockQuantity INT);

CREATE TABLE Cart(
Cart_id INT IDENTITY PRIMARY KEY,
Customer_id INT,
Product_id INT,
Quantity INT
FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id),
FOREIGN KEY(Product_id) REFERENCES Products(Product_id));

CREATE TABLE Orders(
Order_id INT IDENTITY PRIMARY KEY,
Customer_id INT,
Order_date DATE,
Total_price DECIMAL(10,2),
FOREIGN KEY (Customer_id) REFERENCES Customers (Customer_id));

CREATE TABLE Order_items(
Order_item_id INT IDENTITY PRIMARY KEY,
Order_id INT,
Product_id INT,
Quantity INT,
ItemAmount DECIMAL(10,2),
FOREIGN KEY(Order_id) REFERENCES Orders(Order_id),
FOREIGN KEY (Product_id) REFERENCES Products(Product_id));

INSERT INTO Customers VALUES
('John','Doe','johndoe@example.com ','123 Main St, City '),
('Jane','Smith','janesmith@example.com ','456 Elm St, Town '),
('Robert','Johnson','robert@example.com ','789 Oak St, Village '),
('Sarah','Brown','sarah@example.com ','101 Pine St, Suburb'),
('David','Lee','david@example.com ','234 Cedar St, District '),
('Laura','Hall','laura@example.com ','567 Birch St, County '),
('Michael','Davis','michael@example.com ','890 Maple St, State '),
('Emma','Wilson','emma@example.com ','321 Redwood St, Country'),
('William','Taylor','william@example.com ','432 Spruce St, Province '),
('Olivia','Adams','olivia@example.com ','765 Fir St, Territory ');

INSERT INTO Products VALUES
('Laptop','High-Performance laptop',800.00,10),
('Smartphone','Latest smartphone',600.00,15),
('Tablet','Portable tablet',300.00,20),
('Headphones','Noice-cancelling',150.00,30),
('TV','4K Smart TV',900.00,5),
('Coffee Maker','Automatic coffee maker',50.00,25),
('Refrigerator','Energy-efficient',700.00,10),
('Microwave Oven','Countertop microwave oven',80.00,15),
('Blender','High-speed Blender',70.00,20),
('Vacuum Cleaner','Bagless vacuum cleaner',120.00,10);

ALTER TABLE Products ADD Category VARCHAR(100);

INSERT INTO Orders VALUES 
(1,'2023-01-05',1200.00),
(2,'2023-02-10',900.00),
(3,'2023-03-15',300.00),
(4,'2023-04-20',150.00),
(5,'2023-05-25',1800.00),
(6,'2024-05-12',400.00);

INSERT INTO Order_items VALUES
(1,1,2,1600.00),
(1,3,1,300.00),
(2,2,3,1800.00),
(3,5,2,1800.00),
(4,4,4,600.00),
(4,6,1,50.00),
(5,1,1,800.00),
(5,2,2,1200.00),
(6,10,2,240.00),
(6,9,3,210.00);

INSERT INTO Cart VALUES 
(1,1,2),
(1,3,1),
(2,2,3),
(3,4,4),
(3,5,2),
(4,6,1),
(5,1,1),
(6,10,2),
(6,9,3),
(7,7,2);

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_items;
SELECT * FROM Cart;

UPDATE Order_items
SET ItemAmount = oi.Quantity * p.Price
FROM Order_items oi
JOIN Products p ON oi.Product_id = p.Product_id;

UPDATE o
SET o.Total_price = oi_summary.total
FROM Orders o
JOIN (
    SELECT Order_id, SUM(ItemAmount) AS total
    FROM Order_items
    GROUP BY Order_id
) AS oi_summary ON o.Order_id = oi_summary.Order_id;


---1. Update refrigerator product price to 800.---

UPDATE Products SET Price=800.00 WHERE Name='Refrigerator';
SELECT * 
FROM Products;

--2. Remove all cart items for a specific customer. --

DELETE 
FROM Cart 
WHERE Customer_id=7;
SELECT * 
FROM Cart;

--3. Retrieve Products Priced Below $100. --

SELECT * 
FROM Products 
WHERE Price<100.00;

--4. Find Products with Stock Quantity Greater Than 5. --

SELECT * 
FROM Products 
WHERE StockQuantity>5;

--5. Retrieve Orders with Total Amount Between $500 and $1000. --

SELECT * 
FROM Orders 
WHERE Total_price BETWEEN 500 AND 1000;

--6. Find Products which name end with letter ‘r’. --

SELECT * 
FROM Products
WHERE Name like '%r';

--7. Retrieve Cart Items for Customer 5. --

SELECT * 
FROM Cart 
WHERE Customer_id=5;

--8. Find Customers Who Placed Orders in 2023. --

SELECT C.* 
FROM Customers c
JOIN Orders o ON c.Customer_id=o.Customer_id
WHERE YEAR(o.Order_date) = '2023';

--9. Determine the Minimum Stock Quantity for Each Product Category. --

SELECT Category,MIN(StockQuantity)AS 'Minimum Stock Quantity' 
FROM Products 
GROUP BY Category 
ORDER BY Category;

--10. Calculate the Total Amount Spent by Each Customer.--

SELECT c.customer_id, CONCAT(First_name,Last_name) AS Customer_Name,SUM(total_price) AS total_spent
FROM Customers c
LEFT JOIN Orders o ON o.Customer_id=c.Customer_id
GROUP BY c.customer_id,First_name,Last_name
ORDER BY c.customer_id,First_name,Last_name;

--11. Find the Average Order Amount for Each Customer. --

SELECT o.customer_id, CONCAT(First_name,Last_name) AS Customer_Name,AVG(total_price) AS Average_amount
FROM orders o
JOIN Customers c ON o.Customer_id=c.Customer_id
GROUP BY o.customer_id,First_name,Last_name;

SELECT AVG(total_price) AS Average_amount
FROM orders;

--12. Count the Number of Orders Placed by Each Customer. --

SELECT o.customer_id, CONCAT(First_name,Last_name) AS Customer_Name,COUNT(oi.Order_item_id) AS Number_of_Orders 
FROM Customers c
JOIN Orders o ON c.Customer_id=o.Customer_id
JOIN Order_items oi ON o.Order_id=oi.Order_id
WHERE oi.Order_id=o.Order_id
GROUP BY o.customer_id,First_name,Last_name;

---13. Find the Maximum Order Amount for Each Customer. --
SELECT c.customer_id, CONCAT(First_name,Last_name) AS Customer_Name,MAX(o.Total_price) AS Maximum_Order_Amount
FROM Customers c 
LEFT JOIN Orders o ON c.Customer_id=o.Customer_id
GROUP BY c.customer_id,First_name,Last_name;

--14. Get Customers Who Placed Orders Totaling Over $1000. --

SELECT o.customer_id, CONCAT(First_name,Last_name) AS Customer_Name,total_price
FROM orders o
JOIN Customers c ON o.Customer_id=c.Customer_id
WHERE Total_price>1000;

--15. Subquery to Find Products Not in the Cart. --

SELECT *
FROM Products
WHERE Product_id NOT IN (
    SELECT DISTINCT Product_id FROM Cart
);

--16. Subquery to Find Customers Who Haven't Placed Orders. --

SELECT  c.customer_id, CONCAT(First_name,Last_name) AS Customer_Name
FROM Customers c 
WHERE Customer_id NOT IN (
						SELECT DISTINCT customer_id 
						FROM Orders);

--17. Subquery to Calculate the Percentage of Total Revenue for a Product. --

SELECT 
    p.product_id,
    p.name,
    SUM(oi.itemAmount) AS revenue,(SELECT SUM(itemAmount) FROM Order_items)AS TOTAL_REVENUE,
    (SUM(oi.itemAmount) * 100.0) / (
        SELECT SUM(itemAmount) FROM Order_items
    ) AS revenue_percentage
FROM Products p
JOIN Order_items oi ON p.Product_id = oi.Product_id
GROUP BY p.Product_id, p.Name
ORDER BY revenue_percentage DESC;


--18. Subquery to Find Products with Low Stock. --
DECLARE @stk_parameter INT=10
SELECT * 
FROM Products 
WHERE Product_id IN (
					SELECT Product_id 
					FROM Products 
					WHERE StockQuantity < @stk_parameter);

--19. Subquery to Find Customers Who Placed High-Value Orders. --
DECLARE @High_Value DECIMAL(10,2)=1500.00
SELECT * 
FROM Customers 
WHERE Customer_id IN (
					SELECT Customer_id 
					FROM Orders 
					WHERE Total_price > @High_Value);

