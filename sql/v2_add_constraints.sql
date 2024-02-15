use VendingMachineRentalDB;
go
alter table Clients
	drop 
		constraint clients_check_email,
		constraint clients_uniq_email
;

alter table Inventory
	drop constraint machiens_leasedPrice_check,
	column MontlyLeasedPrice
;
go

alter table Clients
	alter column Email varchar(400);
;
go

alter table Inventory
	add MonthlyLeasedPrice money not null
;
go

alter table Clients
	add 
	constraint clients_check_email check(Email like '%@%.%' AND Email NOT LIKE '%@%@%'),
	constraint clients_uniq_email unique(Email);

alter table Manufacturers
	alter column ManufacturerEmail varchar(400);
;
go
ALTER TABLE Manufacturers
    ADD CONSTRAINT manufacturers_uniq_email UNIQUE(ManufacturerEmail),
	constraint manufacturers_uniq_name unique(ManufacturerName),
	CONSTRAINT manufacturers_check_email CHECK(ManufacturerEmail LIKE '%@%.%' AND ManufacturerEmail NOT LIKE '%@%@%'),
	constraint manufacturers_number_check check(ManufacturerPhoneNumber > 999999)


Alter table Inventory
	add constraint inventory_check check(InventoryCount > 0),
	constraint machines_leasedPrice_check check(MonthlyLeasedPrice > 0)
;

alter table Rentals
	add constraint start_before_end check(StartDate < EndDate),
	constraint positive_quantity check(QuantityLeased > 0)
;
go


alter table Transactions
	add constraint transactions_no_future_check check(PaymentDate <= getDate()),
	constraint transactions_some_value check(PaymentAmount != 0)
;


alter table Orders
	add constraint orders_cost_price_check check(CostPrice >= 0),
	constraint orders_nonzero_quantity check(Quantity > 0)
;
