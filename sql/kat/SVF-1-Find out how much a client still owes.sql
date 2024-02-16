USE VendingMachineRentalDB;
GO

create function [dbo].[getRentDueForRental]
(
	@rentalID int
)
returns money
as
begin
	-- get total paid
	declare @totalPaid money;
	select 
		@totalPaid  = sum(PaymentAmount)
	from 
		Transactions
	where 
		RentalID = @rentalID;

	-- get lease price of machine
	declare @leasePrice money;
	select 
		@leasePrice = 
		(
		select 
			top 1 i.MonthlyLeasedPrice
		from 
			Rentals r
			inner join LeasedVendingMachines l on r.RentalID = l.RentID
			inner join VendingMachines v on v.MachineID = l.MachineID
			inner join Inventory i on i.InventoryID= v.InventoryID
		where 
			r.RentalID = @rentalID
		);

	-- get quantity leased
	declare @quantityLeased money;
	select 
		@quantityLeased = QuantityLeased
	from 
		Rentals
	where 
		RentalID = @rentalID;

	-- get the duration of the rental
	declare @duration int
	select 
		@duration = DATEDIFF(Month, StartDate, EndDate)
	from 
		Rentals
	where 
		RentalID = @rentalID;

	return @duration * @quantityLeased * @leasePrice - @totalPaid
end;