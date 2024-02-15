use VendingMachineRentalDB;
go

create table Clients(
	ClientID int IDENTITY(1,1) NOT NULL,
	CompanyName nvarchar(1000) NULL,
	ContactPerson nvarchar(1000) NULL,
	ContactPhoneNumber varchar(15) NULL,
	Email nvarchar(1000) NULL,
	constraint ClientsPK primary key (ClientID)
);
GO

create table Manufacturers(
	ManufacturerID int IDENTITY(1,1) not null,
	ManufacturerName nvarchar(1000) null,
	ManufacturerEmail nvarchar(1000) null,
	ManufacturerPhoneNumber varchar(15) null,
	constraint ManufacturerPK primary key (ManufacturerID)
);
GO

create table Orders(
	OrderID int identity(1,1) not null,
	ManufacturerID int not null,
	CostPrice money not null,
	PurchaseDate date not null,
	Quantity int not null,
	constraint OrdersPK primary key (OrderID),
	constraint ManufacturerFK foreign key (ManufacturerID) references Manufacturers(ManufacturerID)
);
GO
create table Inventory(
	InventoryID int identity(1,1) not null,
	InventoryCount int not null,
	MontlyLeasedPrice money null
	constraint InventoryPK primary key (InventoryID)
);
go

create table VendingMachines(
	MachineID int IDENTITY(1,1) not null,
	InventoryID int,
	OrderID int,
	constraint MachinesPK primary key (MachineID),
	constraint InventoryMachinesFK foreign key (InventoryID) references Inventory(InventoryID),
	constraint OrdersFK foreign key (OrderID) references Orders(OrderID)
);
GO

create table Rentals(
	RentalID int IDENTITY(1,1) NOT NULL,
	ClientID int NOT NULL,
	StartDate date NOT NULL,
	EndDate date NULL,
	LeaseStatus int NULL,
	QuantityLeased int not null,
	constraint RentalPK primary key (RentalID),
	constraint LeasedClientsFK FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);
GO

create table LeasedVendingMachiens(
	LeaseID int IDENTITY(1,1) NOT NULL,
	RentID int,
	MachineID int,
	constraint LeasedPK primary key (LeaseID),
	constraint Leased_RentFK foreign key (RentID) references Rentals(RentalID),
	constraint Leased_MachinedFK foreign key (MachineID) references VendingMachines(MachineID)
);

create table Transactions(
	TransactionID int IDENTITY(1,1) NOT NULL,
	RentalID int not null,
	PaymentAmount money not null,
	PaymentDate date null,
	constraint TransactionsPK PRIMARY KEY (TransactionID),
	constraint Transactions_RentFK foreign key (RentalID) references Rentals(RentalID)
);
GO

