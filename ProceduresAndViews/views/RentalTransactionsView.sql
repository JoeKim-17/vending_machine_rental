CREATE VIEW RentalTransactionsView AS
SELECT r.RentalID, r.StartDate, r.EndDate, r.LeaseStatus, r.QuantityLeased,
       t.TransactionID, t.PaymentAmount, t.PaymentDate
FROM Rentals r
LEFT JOIN Transactions t ON r.RentalID = t.RentalID;
