use VendingMachineRentalDB;
go

create table Clients(
	ClientID int IDENTITY(1,1) NOT NULL,
	CompanyName nvarchar(1000) NULL,
	PhoneNumber varchar(15) NULL,
	Email nvarchar(1000) NULL,
	constraint ClientsPK primary key (ClientID)
);
GO

create table VendingMachines(
	MachineID int IDENTITY(1,1) not null,
	InventoryCount int not null,
	MonthlyLeasedPrice money not null,
	Capacity int null,
	VendingMachineType int null,
	constraint MachinesPK primary key (MachineID)
);
GO

create table Suppliers(
	SupplierID int IDENTITY(1,1) not null,
	SupplierName nvarchar(1000) null,
	SupplierEmail varchar(1000) null,
	SupplierPhoneNumber varchar(15) null,
	constraint SuppliersPK primary key (SupplierID)
);
GO

create table LeasedVendingMachines(
	LeaseID int IDENTITY(1,1) NOT NULL,
	ClientID int NOT NULL,
	MachineID int NOT NULL,
	StartDate date NOT NULL,
	EndDate date NULL,
	LeaseAmount money NOT NULL,
	LeaseStatus int NULL,
	QuantityLeased int not null,
	constraint LeasedPK primary key (LeaseID),
	constraint LeasedClientsFK FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
	constraint LeasedMachinesFK foreign key (MachineID) references VendingMachines(MachineID)
);
GO

create table Transactions(
	TransactionID int IDENTITY(1,1) NOT NULL,
	LeaseID int not null,
	PaymentAmount money not null,
	PaymentDate date null,
	constraint TransactionsPK PRIMARY KEY (TransactionID),
	constraint TransactionsLeasedFK foreign key (LeaseID) references LeasedVendingMachines(LeaseID)
);
GO


create table Orders(
	OrderID int identity(1,1) not null,
	SupplierID int not null,
	MachineID int not null,
	CostPrice money not null,
	PurchaseDate date not null,
	Quantity int not null,
	constraint OrdersPK primary key (OrderID),
	constraint SuppliersFK foreign key (SupplierID) references Suppliers(SupplierID),
	constraint OrdersVendingMachinesFK foreign key (MachineID) references VendingMachines(MachineID)
);
GO