CREATE TRIGGER trg_UpdateStock
ON OrderDetails
AFTER INSERT
AS
BEGIN
    UPDATE Products
    SET Stock = Stock - i.Quantity
    FROM inserted i
    WHERE Products.ProductID = i.ProductID;
END;