CREATE FUNCTION GetLeasedMachinesByClientID
(
    @ClientID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT lvm.LeaseID, lvm.MachineID, vm.FKInventoryID, vm.FKOrderID
    FROM LeasedVendingMachines lvm
    INNER JOIN VendingMachines vm ON lvm.MachineID = vm.MachineID
    INNER JOIN Rentals r ON lvm.RentID = r.RentalID
    WHERE r.ClientID = @ClientID
);
