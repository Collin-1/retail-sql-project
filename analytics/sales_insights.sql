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

