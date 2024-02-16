CREATE VIEW ClientRentalsView AS
SELECT c.ClientID, c.CompanyName, c.ContactPerson, c.ContactPhoneNumber, c.Email,
       r.RentalID, r.StartDate, r.EndDate, r.LeaseStatus, r.QuantityLeased
FROM Clients c
LEFT JOIN Rentals r ON c.ClientID = r.ClientID;
