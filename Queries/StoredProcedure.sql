-- FOR ADD DEVELOPER sp_AddDeveloper
-- FOR ADD Games sp_AddGame
-- FOR ADD GENRE  sp_AddGenre
-- FOR ADD GAMES GENRE sp_AddGamesGenre
-- FOR ADD BRANCH sp_AddBranch
-- FOR ADD EMPLOYEE sp_AddEmployee
-- FOR ADD CUSTOMER sp_Customer
-- FOR ADD STOCK sp_AddStock
-- FOR ADD ORDER sp_AddOrder
-- FOR ADD ORDERDETAIL sp_AddOrderDetail
USE GameStoreDB
GO
 CREATE PROC sp_AddDeveloper
 (
	@DeveloperName NVARCHAR(40)
 )AS
 INSERT INTO Developer(DeveloperName) VALUES(@DeveloperName)

GO

CREATE PROC sp_AddGame
(
	@Name NVARCHAR(50),
	@Description NVARCHAR(1000) = 'There is no description for this game...',
	@Price INT,
	@ReleaseDate DATE,
	@DeveloperId INT
)AS 
INSERT INTO Game(GameName,GameDescription,Price,ReleaseDate,DeveloperId) VALUES(@Name, @Description, @Price, @ReleaseDate, @DeveloperId)

GO 

CREATE PROC sp_AddGenre
(
	@GenreName NVARCHAR(100)
) AS
INSERT INTO Genre(GenreName) VALUES (@GenreName)

GO 

CREATE PROC sp_AddGamesGenre
(
	@ID1 INT,
	@ID2 INT
) AS
INSERT INTO Games_Genre VALUES(@ID1,@ID2)

GO

CREATE PROC sp_AddBranch
( 
	@StoreLocation NVARCHAR(40),
	@ManagerID INT
)AS
INSERT INTO Branch(StoreLocation,ManagerId) VALUES(@StoreLocation,@ManagerID)

GO

CREATE PROC sp_AddEmployee
(
	@EmployeeName NVARCHAR(40),
	@Age INT,
	@Salary MONEY,
	@Birthday DATE,
	@BranchId INT,
	@ManagerId INT
)AS
INSERT INTO Employee(EmployeeName, Age, Salary, Birthday,BranchId, ManagerId) VALUES(@EmployeeName,@Age,@Salary,@Birthday,@BranchId,@ManagerId)

GO

CREATE PROC sp_AddCustomer
(
	@CustomerName NVARCHAR(40),
	@Age INT,
	@Email NVARCHAR(45)
)AS
INSERT INTO Customer(CustomerName,Age,Email) VALUES(@CustomerName,@Age,@Email)

GO 

CREATE PROC sp_AddStock
(
	@BranchId INT ,
	@GameId INT ,
	@StockQuantity INT
)AS
IF EXISTS ( Select * FROM Stocks WHERE BranchId = @BranchId AND GameId = @GameId)
BEGIN
	UPDATE Stocks SET StockQuantity = (StockQuantity+@StockQuantity) WHERE BranchId = @BranchId AND GameId = @GameId 
END
ELSE
BEGIN 
	INSERT INTO  Stocks(BranchId,GameId,StockQuantity) VALUES(@BranchId,@GameId,@StockQuantity)
END

GO

CREATE PROC sp_AddOrder
(
	@OrderDate DATE,
	@BranchId INT,
	@CustomerId INT
) AS 
INSERT INTO Orders(OrderDate,BranchId,CustomerId) VALUES(@OrderDate,@BranchId,@CustomerId)

GO

CREATE PROC sp_OrderDetail
(
	@OrderId INT,
	@GameId INT,
	@Quantity INT,
	@UnitPrice MONEY
)AS
INSERT INTO OrderDetail(OrderId,GameId,Quantity,UnitPrice) VALUES(@OrderId,@GameId,@Quantity,@UnitPrice)