use VendingMachineRentalDB;
go
select * from Inventory i
inner join VendingMachines v on v.InventoryID = i.InventoryID
inner join Orders o on o.OrderID = v.OrderID
inner join Manufacturers m on o.ManufacturerID = m.ManufacturerID;

select * from Inventory;
select * from Manufacturers;
select * from  Clients;
select * from Orders;
select * from LeasedVendingMachiens;
select * from VendingMachines;
select * from Transactions;
select * from Rentals;