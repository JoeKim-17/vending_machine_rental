use VendingMachineRentalDB;
go

create view viewClientRentals
as
select	
	c.ClientID,
	c.CompanyName,
	r.RentalID,
	DATEDIFF(MONTH, GETDATE(), r.EndDate) as [Months Left],
	dbo.getRentDueForRental(r.RentalID) as [Rental Due]
from 
	Clients c
	inner join Rentals r on c.ClientID = r.ClientID
	inner join Transactions t on r.RentalID = t.RentalID