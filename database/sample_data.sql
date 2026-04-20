-- CATEGORIES
INSERT INTO Categories (CategoryName) VALUES
('Electronics'),
('Clothing'),
('Home & Kitchen'),
('Books');

-- CUSTOMERS
INSERT INTO Customers (FirstName, LastName, Email, Phone) VALUES
('John', 'Doe', 'john.doe@email.com', '0712345678'),
('Sarah', 'Smith', 'sarah.smith@email.com', '0723456789'),
('Michael', 'Brown', 'michael.brown@email.com', '0734567890'),
('Emily', 'Davis', 'emily.davis@email.com', '0745678901'),
('David', 'Wilson', 'david.wilson@email.com', '0756789012');

-- SUPPLIERS
INSERT INTO Suppliers (SupplierName, ContactName, Phone, Email) VALUES
('Tech Distributors Ltd', 'Alice Johnson', '0111234567', 'alice@techdist.com'),
('Fashion Wholesale Co', 'Bob Lee', '0112345678', 'bob@fashionwholesale.com'),
('Home Goods Supply', 'Carol White', '0113456789', 'carol@homegoods.com');

-- PRODUCTS
INSERT INTO Products (ProductName, CategoryID, Price, Stock) VALUES
('Laptop', 1, 15000.00, 10),
('Smartphone', 1, 8000.00, 20),
('T-Shirt', 2, 200.00, 50),
('Jeans', 2, 500.00, 30),
('Blender', 3, 1200.00, 15),
('Cookware Set', 3, 2500.00, 8),
('Novel Book', 4, 150.00, 40);

-- PRODUCT SUPPLIERS
INSERT INTO ProductSuppliers (ProductID, SupplierID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 3);