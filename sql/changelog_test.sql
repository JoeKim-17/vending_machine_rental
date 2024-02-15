create table testTable(
	ID int identity(1,1) not null,
	personName nvarchar(400) null,
	personSurname nvarchar(400) not null,
	cost money null,
	constraint testPK primary key (ID)
);