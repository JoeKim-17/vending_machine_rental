CREATE FUNCTION GetOrdersByManufacturerID
(
    @ManufacturerID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT o.OrderID, o.CostPrice, o.PurchaseDate, o.Quantity
    FROM Orders o
    WHERE o.ManufacturerID = @ManufacturerID
);
