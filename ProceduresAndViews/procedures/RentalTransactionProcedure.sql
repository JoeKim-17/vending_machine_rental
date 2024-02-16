CREATE PROCEDURE GetTransactionsByRentalID
    @RentalID INT
AS
BEGIN
    SELECT t.TransactionID, t.PaymentAmount, t.PaymentDate
    FROM Transactions t
    WHERE t.RentalID = @RentalID;
END;
