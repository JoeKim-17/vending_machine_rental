USE VendingMachineRentalDB
GO

create procedure RentMachines
	@clientID int,
	@inventoryID int,
	@quantity int,
	@duration int
as
	--Ensure that the client can rent that many machines.
	declare @inventoryCount int
	select 
		@inventoryCount = InventoryCount
	from 
		Inventory
	where
		InventoryID = @inventoryID;

	if @inventoryCount < @quantity
	begin 
		set @quantity = @inventoryCount 
	end;

	-- Make a rental entry
	insert into Rentals
	(
		ClientID,
		StartDate,
		EndDate,
		LeaseStatus,
		QuantityLeased
	)	
	values 
		(@clientID, GETDATE(), DATEADD(MONTH, @duration, GETDATE()), 1, @quantity);

	--Get rentalID
	declare @renatalID int
	select 
		@renatalID = max(RentalID)
	from Rentals;

	--Get cost of vending machines
	declare @monthlyLeasedPrice money
	select 
		@monthlyLeasedPrice = MonthlyLeasedPrice
	from
		Inventory
	where
		InventoryID = @inventoryID;


	--Make an entry in the transactions table.
	insert into Transactions
	(
		RentalID,
		PaymentAmount,
		PaymentDate
	)
	values
		(@renatalID, @monthlyLeasedPrice * @quantity, GETDATE());

	-- Lease `x` machines
	declare @machineID int;
	declare @counter int = 0;
	declare unleasedMachineCursor cursor for 
		select 
			* 
		from 
			getUnleasedMachines(@inventoryID);

	open unleasedMachineCursor
	fetch next from unleasedMachineCursor into @machineID 

	while @@FETCH_STATUS = 0 and @counter < @quantity
	begin
		insert into LeasedVendingMachines
		(
			RentID,
			MachineID
		)
		values
			(@renatalID, @machineID);

		set @counter = @counter + 1;

		fetch next from unleasedMachineCursor into @machineID;
	end;

	close unleasedMachineCursor;
	deallocate unleasedMachineCursor;

	-- free `x` machines from the inventory
	update Inventory
	set 
		InventoryCount = InventoryCount - @quantity
	where 
		InventoryID = @inventoryID;
go;