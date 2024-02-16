USE VendingMachineRentalDB
GO

create procedure OrderStock
	@manufacturerID int, 
	@costPrice money,
	@quantity int
as
	-- Create Order first
	insert into Orders
	(
		ManufacturerID,
		CostPrice,
		PurchaseDate,
		Quantity
	)
	values
		(@manufacturerID, @costPrice, GETDATE(), @quantity)

	-- Getting most recent order
	declare @orderID int
	select 
		@orderID = max(OrderID) 
	from Orders;

	-- get InventoryID if it exists, else, add a new entry

	-- Try to get already existing InventoryID 
	declare @inventoryID int;

	set @inventoryID = 
	(select 
		top 1 i.InventoryID
	from 
		Inventory i
		inner join VendingMachines v on v.InventoryID = i.InventoryID
		inner join Orders o on o.OrderID = v.OrderID
		inner join Manufacturers m on o.ManufacturerID = m.ManufacturerID
	where
		m.ManufacturerID = @manufacturerID
	)
	
	-- Doesnt exist, so create it manually
	if @inventoryID is null 
	begin
		insert into Inventory
		(
			InventoryCount,
			MonthlyLeasedPrice
		)
		values
			(@quantity, ((@costPrice / @quantity) / 12));

		select @inventoryID = max(InventoryID) from Inventory
	end
	else
	begin
		update Inventory
		set InventoryCount = InventoryCount + @quantity;
	end;

	-- Insert stock into VendingMachines table
	declare @counter int = 0
	while @counter < @quantity
	begin
		insert into VendingMachines
		(
			InventoryID,
			OrderID
		)
		values 
			(@inventoryID, @orderID);

		set @counter = @counter + 1;
	end;
go