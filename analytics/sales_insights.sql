-- 1. Top 5 Customers by Total Spending
-- CTEs + business insight

WITH CustomerSpending AS (
    SELECT 
       c.CustomerID,
       c.FirstName + ' ' + c.LastName AS CustomerName,
       SUM(od.Quantity * od.UnitPrice) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.Status = 'Completed'
    GROUP BY c.CustomerID, c.FirstName, c.LastName
)
SELECT TOP 5 *
FROM CustomerSpending
ORDER BY TotalSpent DESC;

-- 2. Monthly Revenue Trend
-- time-based analysis

SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS Month,
    SUM(od.Quantity * od.UnitPrice) AS Revenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.Status = 'Completed'
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY Month;


-- 3. Best-Selling Products (Ranked)

SELECT 
    p.ProductName,
    SUM(od.Quantity) AS TotalSold,
    RANK() OVER (ORDER BY SUM(od.Quantity) DESC) AS SalesRank
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;


-- 4. Customer Lifetime Value (CLV)

SELECT 
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * od.UnitPrice) AS LifetimeValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.Status = 'Completed'
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY LifetimeValue DESC;


-- 5. Average Order Value (AOV)

SELECT 
    AVG(OrderTotal) AS AvgOrderValue
FROM (
    SELECT 
        o.OrderID,
        SUM(od.Quantity * od.UnitPrice) AS OrderTotal
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.Status = 'Completed'
    GROUP BY o.OrderID
) AS OrderTotals;

-- 6. Low Stock Alert (Inventory Insight)

SELECT
    ProductName,
    Stock
FROM Products
WHERE Stock < 10
ORDER BY Stock ASC;

-- 7. Revenue Contribution by Product (%)
-- multi-CTE + percentage analytics

WITH ProductRevenue AS (
    SELECT
        p.ProductName,
        SUM(od.Quantity * od.UnitPrice) AS Revenue
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.ProductName
),
TotalRevenue AS (
    SELECT SUM(Revenue) AS Total FROM ProductRevenue
)
SELECT
    pr.ProductName,
    pr.Revenue,
    (pr.Revenue * 100.0 / tr.Total) AS RevenuePercentage
FROM ProductRevenue pr, TotalRevenue tr
ORDER BY RevenuePercentage DESC;


-- 8. Most Loyal Customers (Repeat Buyers)
SELECT
    c.FirstName + ' ' + c.LastName AS CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING COUNT(o.OrderID) > 1
ORDER BY OrderCount DESC;


-- 9. Running Total of Sales Over Time
SELECT
    o.OrderDate,
    SUM(od.Quantity * od.UnitPrice) AS DailyRevenue,
    SUM(SUM(od.Quantity * od.UnitPrice)) OVER (ORDER BY o.OrderDate) AS RunningTotal
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.Status = 'Completed'
GROUP BY o.OrderDate
ORDER BY o.OrderDate;

-- 10. Top Product Per Category

WITH ProductSales AS (
    SELECT
        c.CategoryName,
        p.ProductName,
        SUM(od.Quantity) AS TotalSold,
        RANK() OVER (PARTITION BY c.CategoryName ORDER BY SUM(od.Quantity) DESC) AS RankInCategory
    FROM Products p
    JOIN Categories c ON p.CategoryID = c.CategoryID
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY c.CategoryName, p.ProductName
)
SELECT *
FROM ProductSales
WHERE RankInCategory = 1;
