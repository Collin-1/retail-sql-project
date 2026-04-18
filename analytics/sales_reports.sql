SELECT 
    ProductID,
    SUM(Quantity) AS TotalSold
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalSold DESC;