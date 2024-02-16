CREATE PROCEDURE GetRentalDetailsByRentalID
    @RentalID INT
AS
BEGIN
    SELECT r.RentalID, r.StartDate, r.EndDate, r.LeaseStatus, r.QuantityLeased,
           c.ClientID, c.CompanyName, c.ContactPerson, c.ContactPhoneNumber, c.Email
    FROM Rentals r
    INNER JOIN Clients c ON r.ClientID = c.ClientID
    WHERE r.RentalID = @RentalID;
END;
