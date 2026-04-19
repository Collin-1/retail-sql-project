-- CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- CATEGORIES
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

-- PRODUCTS
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)

-- SUPPLIERS
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

-- PRODUCT SUPPLIERS (Many-to-Many)
CREATE TABLE ProductSuppliers (
    ProductID INT,
    SupplierID INT,

    PRIMARY KEY (ProductID, SupplierID),

    CONSTRAINT FK_PS_Product
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID),

    CONSTRAINT FK_PS_Supplier
        FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
