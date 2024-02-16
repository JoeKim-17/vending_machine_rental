use VendingMachineRentalDB;
go

delete from LeasedVendingMachines;
delete from Transactions;
delete from Rentals;
delete from VendingMachines;
delete from Inventory;
delete from Orders;
delete from Clients;
delete from Manufacturers;
go

--create Cleints
insert into	Clients (
	CompanyName,
	ContactPerson,
	ContactPhoneNumber,
	Email
)
values
	('Rosebank', 'Moshe Franklin', '545199785', 'Moshe.Franklin@gmail.com'),
	('Sandton City', 'Mohammad Clements', '867920243', 'Mohammad.Clements@gmail.com'),
	('Mall of Africa', 'Elisa Mills', '465008465', 'Elisa.Mills@gmail.com'),
	('Mall of the South', 'Tabitha Acosta', '203853118', 'Tabitha.Acosta@gmail.com'),
	('Centurion Mall', 'Kallum Fulton', '360975981', 'Kallum.Fulton@gmail.com');
go

--create Manufacturers
insert into Manufacturers
(
	ManufacturerName,
	ManufacturerPhoneNumber,
	ManufacturerEmail
)
values
	('Bryn Hurst', '280233663', 'Bryn.Hurst@gmail.com'),
	('Layla Gamble', '337725154', 'Layla.Gamble@gmail.com'),
	('Mattie Berger', '738012480', 'Mattie.Berger@gmail.com'),
	('Aled Lane', '242207723', 'Aled.Lane@gmail.com'),
	('Caroline Coffey', '027125817', 'Caroline.Coffey@gmail.com');
go


-- get min ClientID
declare @minClientID int
select 
	@minClientID  = min(ClientID)
from 
	Clients;

-- get min ManufacturerID
declare @minManufacturerID int
select 
	@minManufacturerID = min(ManufacturerID)
from 
	Manufacturers;


exec OrderStock
	@manufacturerID = @minManufacturerID,
	@costPrice = 10000,
	@quantity = 10;

set @minManufacturerID = @minManufacturerID + 1
exec OrderStock
	@manufacturerID = @minManufacturerID,
	@costPrice = 20000,
	@quantity = 10;

set @minManufacturerID = @minManufacturerID + 1
exec OrderStock
	@manufacturerID = @minManufacturerID,
	@costPrice = 50000,
	@quantity = 10;

set @minManufacturerID = @minManufacturerID + 1
exec OrderStock
	@manufacturerID = @minManufacturerID,
	@costPrice = 100000,
	@quantity = 10;

set @minManufacturerID = @minManufacturerID + 1
exec OrderStock
	@manufacturerID = @minManufacturerID,
	@costPrice = 200000,
	@quantity = 1;


-- get min InventoryID
declare @minInventoryID int
select 
	@minInventoryID = min(InventoryID)
from 
	Inventory;

exec RentMachines
	@clientID = @minClientID,
	@inventoryID = @minInventoryID,
	@quantity = 5,
	@duration = 5;

set @minInventoryID = @minInventoryID + 1
set @minClientID = @minClientID + 1
exec RentMachines
	@clientID = @minClientID,
	@inventoryID = @minInventoryID,
	@quantity = 5,
	@duration = 7;

set @minInventoryID = @minInventoryID + 1
set @minClientID = @minClientID + 1
exec RentMachines
	@clientID = @minClientID,
	@inventoryID = @minInventoryID,
	@quantity = 5,
	@duration = 10;

set @minInventoryID = @minInventoryID + 1
set @minClientID = @minClientID + 1
exec RentMachines
	@clientID = @minClientID,
	@inventoryID = @minInventoryID,
	@quantity = 5,
	@duration = 24;

set @minInventoryID = @minInventoryID + 1
set @minClientID = @minClientID + 1
exec RentMachines
	@clientID = @minClientID,
	@inventoryID = @minInventoryID,
	@quantity = 1,
	@duration = 36;
