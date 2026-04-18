CREATE PROCEDURE PlaceOrder
    @CustomerID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    INSERT INTO Orders (CustomerID, OrderDate)
    VALUES (@CustomerID, GETDATE());
END;