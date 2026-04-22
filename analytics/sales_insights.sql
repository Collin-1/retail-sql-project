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

