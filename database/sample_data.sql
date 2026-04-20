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
