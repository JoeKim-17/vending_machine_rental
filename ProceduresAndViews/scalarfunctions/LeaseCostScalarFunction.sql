CREATE FUNCTION CalculateLeaseCost
(
    @LeaseID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalCost DECIMAL(10, 2);

    SELECT @TotalCost = SUM(i.MonthlyLeasedPrice)
    FROM LeasedVendingMachines lvm
    INNER JOIN VendingMachines vm ON lvm.MachineID = vm.MachineID
    INNER JOIN Inventory i ON vm.InventoryID = i.InventoryID
    WHERE lvm.LeaseID = @LeaseID;

    RETURN @TotalCost;
END;
