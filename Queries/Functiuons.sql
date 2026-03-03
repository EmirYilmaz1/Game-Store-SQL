CREATE FUNCTION fn_GetEmployeesBranch
(
	@BranchId INT
) RETURNS TABLE
AS
RETURN (
SELECT * FROM Employee WHERE  BranchId = @BranchId );
