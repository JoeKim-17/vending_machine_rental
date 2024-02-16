CREATE FUNCTION CalculateTotalPaymentByRentalID
(
    @RentalID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalPayment DECIMAL(10, 2);

    SELECT @TotalPayment = SUM(t.PaymentAmount)
    FROM Transactions t
    WHERE t.RentalID = @RentalID;

    RETURN @TotalPayment;
END;
