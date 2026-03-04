CREATE FUNCTION fn_GetEmployeesBranch
(
	@BranchId INT
) RETURNS TABLE
AS
RETURN (
SELECT * FROM Employee WHERE  BranchId = @BranchId );

GO

CREATE FUNCTION fn_GetStockNumber (@GameId INT) 
RETURNS INT
AS
BEGIN
DECLARE @StockNumber INT
SELECT @StockNumber = SUM(StockQuantity)  FROM Stocks WHERE  GameId = @GameId ;
	RETURN @StockNumber
END