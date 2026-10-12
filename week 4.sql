DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

SET SQL_SAFE_UPDATES = 0;

CREATE TABLE customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    Registration_Date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE categories (
    Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    Category_Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT
);

CREATE TABLE products (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_Name VARCHAR(200) NOT NULL,
    Category_ID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    FOREIGN KEY (Category_ID) REFERENCES categories(Category_ID)
);

CREATE TABLE sellers (
    Seller_ID INT PRIMARY KEY AUTO_INCREMENT,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(255)
);

CREATE TABLE inventory (
    Inventory_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_ID INT NOT NULL,
    Seller_ID INT NOT NULL,
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    Stock_Status VARCHAR(20) DEFAULT 'Available' CHECK (Stock_Status IN ('Available', 'Out of Stock', 'Low Stock')),
    Last_Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES sellers(Seller_ID),
    UNIQUE KEY unique_product_seller (Product_ID, Seller_ID)
);

CREATE TABLE orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Order_Date DATE NOT NULL DEFAULT (CURRENT_DATE),
    Total_Amount DECIMAL(12,2) NOT NULL CHECK (Total_Amount >= 0),
    Order_Status VARCHAR(20) DEFAULT 'Pending' CHECK (Order_Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
);

CREATE TABLE order_details (
    Order_Detail_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
);

INSERT INTO customers (Customer_Name, Email, Phone, Address) VALUES
('Ajay', 'ajay@email.com', '9876543210', 'Ramanthurai, Kanyakumari District'),
('Lowell', 'lowell@email.com', '8765432109', 'Pillaiyarkovil, Kanyakumari District'),
('Noel', 'noel@email.com', '7654321098', 'Nagercoil, Kanyakumari District'),
('Ruben', 'ruben@email.com', '6543210987', 'Marathandam, Kanyakumari District'),
('Merjo', 'merjo@email.com', '5432109876', 'Keezhanputhenurai, Kanyakumari District'),
('Aulto', 'aulto@email.com', '4321098765', 'Pallam, Kanyakumari District'),
('Jefrin', 'jefrin@email.com', '3210987654', 'Kadiyapattanam, Kanyakumari District'),
('Jeni', 'jeni@email.com', '2109876543', 'Pattanam, Kanyakumari District'),
('Gowthem', 'gowthem@email.com', '1098765432', 'Eniyam, Kanyakumari District'),
('Sathish', 'sathish@email.com', '1987654321', 'Kumarkovil, Kanyakumari District');

INSERT INTO categories (Category_Name, Description) VALUES
('Electronics', 'Electronic devices, gadgets, and accessories'),
('Clothing', 'Apparel, fashion items, and accessories'),
('Books', 'Printed and digital books'),
('Home Appliances', 'Home and kitchen appliances'),
('Footwear', 'Shoes, sandals, and sports footwear'),
('Furniture', 'Home and office furniture'),
('Beauty', 'Cosmetics, skincare, and beauty products'),
('Sports', 'Sports equipment and accessories');

INSERT INTO products (Product_Name, Category_ID, Price, Stock_Quantity) VALUES
('Laptop', 1, 55000.00, 20),
('Smartphone', 1, 35000.00, 50),
('Headphones', 1, 2500.00, 100),
('T-Shirt', 2, 800.00, 150),
('Jeans', 2, 1500.00, 80),
('Jacket', 2, 3000.00, 40),
('Novel', 3, 500.00, 200),
('Textbook', 3, 1200.00, 60),
('Biography', 3, 750.00, 90),
('Refrigerator', 4, 45000.00, 15),
('Washing Machine', 4, 32000.00, 20),
('Microwave Oven', 4, 15000.00, 30),
('Sneakers', 5, 4500.00, 70),
('Sandals', 5, 1200.00, 100),
('Formal Shoes', 5, 3500.00, 45),
('Sofa Set', 6, 55000.00, 10),
('Dining Table', 6, 25000.00, 15),
('Study Chair', 6, 8500.00, 25),
('Lipstick', 7, 500.00, 200),
('Face Cream', 7, 800.00, 150),
('Shampoo', 7, 450.00, 180),
('Cricket Bat', 8, 3000.00, 40),
('Football', 8, 1500.00, 60),
('Tennis Racket', 8, 4500.00, 35);

INSERT INTO sellers (Seller_Name, Email, Phone, Address) VALUES
('ABC Electronics', 'abc@electronics.com', '9876543210', '101, Electronics City, Bangalore'),
('TechWorld India', 'techworld@email.com', '8765432109', '45, Tech Park, Hyderabad'),
('Fashion Hub', 'fashion@hub.com', '7654321098', '789, Fashion Street, Mumbai'),
('BookNook Store', 'booknook@email.com', '6543210987', '234, Library Road, Delhi'),
('HomePlus Appliances', 'homeplus@email.com', '5432109876', '567, Home Town, Chennai'),
('ShoeMasters', 'shoemasters@email.com', '4321098765', '890, Footwear Lane, Pune'),
('Furniture World', 'furniture@world.com', '3210987654', '123, Furniture Market, Jaipur'),
('BeautyCare', 'beauty@care.com', '2109876543', '456, Beauty Street, Kolkata'),
('SportZone', 'sportzone@email.com', '1098765432', '789, Sports Complex, Ahmedabad'),
('MobileMasters', 'mobile@masters.com', '1987654321', '101, Mobile World, Noida');

INSERT INTO inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status) VALUES
(1, 1, 20, 'Available'),
(1, 2, 10, 'Available'),
(2, 1, 50, 'Available'),
(2, 10, 30, 'Available'),
(3, 1, 100, 'Available'),
(3, 2, 50, 'Available'),
(4, 3, 150, 'Available'),
(5, 3, 80, 'Available'),
(6, 3, 40, 'Available'),
(7, 4, 200, 'Available'),
(8, 4, 60, 'Available'),
(9, 4, 90, 'Available'),
(10, 5, 15, 'Available'),
(11, 5, 20, 'Available'),
(12, 5, 30, 'Available'),
(13, 6, 70, 'Available'),
(14, 6, 100, 'Available'),
(15, 6, 45, 'Available'),
(16, 7, 10, 'Available'),
(17, 7, 15, 'Available'),
(18, 7, 25, 'Available'),
(19, 8, 200, 'Available'),
(20, 8, 150, 'Available'),
(21, 8, 180, 'Available'),
(22, 9, 40, 'Available'),
(23, 9, 60, 'Available'),
(24, 9, 35, 'Available');

INSERT INTO orders (Customer_ID, Order_Date, Total_Amount, Order_Status) VALUES
(1, '2024-03-01', 57500.00, 'Delivered'),
(1, '2024-03-05', 1600.00, 'Delivered'),
(2, '2024-03-02', 36500.00, 'Shipped'),
(3, '2024-03-03', 3300.00, 'Delivered'),
(4, '2024-03-04', 5500.00, 'Pending'),
(5, '2024-03-06', 45000.00, 'Delivered'),
(6, '2024-03-07', 4700.00, 'Shipped'),
(7, '2024-03-08', 2000.00, 'Pending'),
(8, '2024-03-09', 6500.00, 'Delivered'),
(9, '2024-03-10', 1200.00, 'Delivered'),
(10, '2024-03-11', 2400.00, 'Shipped'),
(1, '2024-03-12', 32000.00, 'Pending'),
(2, '2024-03-13', 5800.00, 'Delivered'),
(3, '2024-03-14', 1000.00, 'Pending'),
(4, '2024-03-15', 15000.00, 'Shipped');

INSERT INTO order_details (Order_ID, Product_ID, Quantity, Price) VALUES
(1, 1, 1, 55000.00),
(1, 3, 1, 2500.00),
(2, 4, 2, 800.00),
(3, 2, 1, 35000.00),
(3, 7, 3, 500.00),
(4, 5, 1, 1500.00),
(4, 6, 1, 3000.00),
(5, 13, 1, 4500.00),
(5, 19, 2, 500.00),
(6, 10, 1, 45000.00),
(7, 22, 1, 3000.00),
(7, 8, 1, 1200.00),
(7, 19, 1, 500.00),
(8, 7, 4, 500.00),
(9, 14, 5, 1200.00),
(9, 19, 1, 500.00),
(10, 8, 1, 1200.00),
(11, 5, 1, 1500.00),
(11, 20, 1, 800.00),
(11, 21, 1, 450.00),
(12, 11, 1, 32000.00),
(13, 13, 1, 4500.00),
(13, 15, 1, 3500.00),
(14, 7, 2, 500.00),
(15, 12, 1, 15000.00);

UPDATE orders SET Order_Status = 'Shipped' WHERE Order_ID = 5;
UPDATE orders SET Order_Status = 'Delivered' WHERE Order_ID = 3;
UPDATE orders SET Order_Status = 'Cancelled' WHERE Order_ID = 14;

UPDATE order_details SET Quantity = 3 WHERE Order_Detail_ID = 3;
UPDATE order_details SET Quantity = 2, Price = 750.00 WHERE Order_Detail_ID = 5;

UPDATE orders 
SET Order_Status = 'Delivered' 
WHERE Order_ID = 13 AND Order_Status = 'Shipped';

DELETE FROM order_details WHERE Order_ID = 14;
DELETE FROM orders WHERE Order_ID = 14;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM customers;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM sellers;
SELECT * FROM inventory;
SELECT * FROM orders;
SELECT * FROM order_details;

SELECT 
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status
FROM customers c
INNER JOIN orders o ON c.Customer_ID = o.Customer_ID
ORDER BY c.Customer_Name, o.Order_Date DESC;

SELECT 
    p.Product_ID,
    p.Product_Name,
    COUNT(od.Order_ID) AS Times_Ordered,
    SUM(od.Quantity) AS Total_Quantity_Sold,
    SUM(od.Quantity * od.Price) AS Total_Revenue
FROM products p
INNER JOIN order_details od ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID
ORDER BY Total_Quantity_Sold DESC;

SELECT 
    c.Customer_ID,
    c.Customer_Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Spending,
    ROUND(AVG(o.Total_Amount), 2) AS Avg_Order_Value
FROM customers c
INNER JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID
ORDER BY Total_Spending DESC;

SELECT 
    SUM(Total_Amount) AS Total_Sales,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(AVG(Total_Amount), 2) AS Average_Order_Value
FROM orders
WHERE Order_Status != 'Cancelled';

SELECT 
    Order_Status,
    COUNT(*) AS Order_Count,
    SUM(Total_Amount) AS Total_Amount
FROM orders
GROUP BY Order_Status;

SELECT 
    o.Order_ID,
    c.Customer_Name,
    o.Order_Date,
    p.Product_Name,
    od.Quantity,
    od.Price,
    (od.Quantity * od.Price) AS Line_Total,
    o.Order_Status
FROM orders o
INNER JOIN customers c ON o.Customer_ID = c.Customer_ID
INNER JOIN order_details od ON o.Order_ID = od.Order_ID
INNER JOIN products p ON od.Product_ID = p.Product_ID
ORDER BY o.Order_ID, p.Product_Name;

SELECT 
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Order_Status,
    GROUP_CONCAT(
        CONCAT(p.Product_Name, ' (', od.Quantity, ' x ', od.Price, ')') 
        SEPARATOR ', '
    ) AS Products_Ordered,
    o.Total_Amount
FROM customers c
INNER JOIN orders o ON c.Customer_ID = o.Customer_ID
INNER JOIN order_details od ON o.Order_ID = od.Order_ID
INNER JOIN products p ON od.Product_ID = p.Product_ID
GROUP BY o.Order_ID
ORDER BY c.Customer_Name, o.Order_Date;

SELECT 
    c.Category_Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(od.Quantity) AS Total_Quantity_Sold,
    SUM(od.Quantity * od.Price) AS Total_Revenue
FROM categories c
INNER JOIN products p ON c.Category_ID = p.Category_ID
INNER JOIN order_details od ON p.Product_ID = od.Product_ID
INNER JOIN orders o ON od.Order_ID = o.Order_ID
WHERE o.Order_Status != 'Cancelled'
GROUP BY c.Category_ID
ORDER BY Total_Revenue DESC;