USE GameStoreDB;
GO

/* Developers */
EXEC sp_AddDeveloper 'Rockstar Games';
EXEC sp_AddDeveloper 'CD Projekt Red';
EXEC sp_AddDeveloper 'EA Sports';
GO

/* Genres */
EXEC sp_AddGenre 'Action';
EXEC sp_AddGenre 'RPG';
EXEC sp_AddGenre 'Sports';
GO

/* Branch (manager NULL baþta) */
INSERT INTO Branch (StoreLocation, ManagerId) VALUES ('Sheffield Central', NULL);
INSERT INTO Branch (StoreLocation, ManagerId) VALUES ('London Oxford St', NULL);
GO

/* Developer Id'leri al */
DECLARE @DevRockstar INT = (SELECT DeveloperId FROM Developer WHERE DeveloperName = 'Rockstar Games');
DECLARE @DevCDPR INT = (SELECT DeveloperId FROM Developer WHERE DeveloperName = 'CD Projekt Red');
DECLARE @DevEA INT = (SELECT DeveloperId FROM Developer WHERE DeveloperName = 'EA Sports');

/* Games */
EXEC sp_AddGame 'GTA V','Open world action game',39,'2013-09-17',@DevRockstar;
EXEC sp_AddGame 'Red Dead Redemption 2','Open world cowboy game',60,'2018-10-26',@DevRockstar;
EXEC sp_AddGame 'Cyberpunk 2077','Futuristic RPG',29,'2020-12-10',@DevCDPR;
EXEC sp_AddGame 'FIFA 24','Football simulation',49,'2023-09-29',@DevEA;
EXEC sp_AddGame 'FIFA 23','Football simulation',19,'2022-09-29',@DevEA;
EXEC sp_AddGame 'FIFA 22','Football simulation',9,'2021-09-29',@DevEA;

GO

/* Game Id'leri al */
DECLARE @GameGTA INT = (SELECT GameId FROM Game WHERE GameName = 'GTA V');
DECLARE @GameCP INT = (SELECT GameId FROM Game WHERE GameName = 'Cyberpunk 2077');
DECLARE @GameFIFA INT = (SELECT GameId FROM Game WHERE GameName = 'FIFA 24');

/* Genre Id'leri al */
DECLARE @GenreAction INT = (SELECT GenreId FROM Genre WHERE GenreName = 'Action');
DECLARE @GenreRPG INT = (SELECT GenreId FROM Genre WHERE GenreName = 'RPG');
DECLARE @GenreSports INT = (SELECT GenreId FROM Genre WHERE GenreName = 'Sports');


EXEC sp_AddGamesGenre @GameGTA, @GenreAction;
EXEC sp_AddGamesGenre @GameCP, @GenreRPG;
EXEC sp_AddGamesGenre @GameFIFA, @GenreSports;
GO


DECLARE @BranchSheffield INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'Sheffield Central');
DECLARE @BranchLondon INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'London Oxford St');

/* Employees */
EXEC sp_AddEmployee 'Jake Darkwood',29,3200,'1996-02-10',@BranchSheffield,NULL;
EXEC sp_AddEmployee 'Elif Kaya',33,3800,'1992-07-05',@BranchLondon,NULL;
EXEC sp_AddEmployee 'Nico Belli',20,2000,'1999-05-03',@BranchLondon,2;
EXEC sp_AddEmployee 'Steven Clever',20,2000,'1997-10-11',@BranchLondon,2;
EXEC sp_AddEmployee 'Kaya Ash',20,2000,'1993-12-20', @BranchSheffield,1;
EXEC sp_AddEmployee 'Adam Fisher',20,2000,'1980-07-08',@BranchSheffield,1;

GO

DECLARE @BranchSheffield INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'Sheffield Central');
DECLARE @BranchLondon INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'London Oxford St');

/* Manager set */
DECLARE @MgrSheffield INT = (SELECT EmployeeId FROM Employee WHERE EmployeeName = 'Jake Darkwood');
DECLARE @MgrLondon INT = (SELECT EmployeeId FROM Employee WHERE EmployeeName = 'Elif Kaya');

UPDATE Branch SET ManagerId = @MgrSheffield WHERE BranchId = @BranchSheffield;
UPDATE Branch SET ManagerId = @MgrLondon WHERE BranchId = @BranchLondon;

GO



/* Customers */
EXEC sp_AddCustomer 'Emir',22,'emir@test.com';
EXEC sp_AddCustomer 'Ro',24,'ro@test.com';
GO

/* Stock */

DECLARE @BranchSheffield INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'Sheffield Central');
DECLARE @BranchLondon INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'London Oxford St');

DECLARE @GameGTA INT = (SELECT GameId FROM Game WHERE GameName = 'GTA V');
DECLARE @GameCP INT = (SELECT GameId FROM Game WHERE GameName = 'Cyberpunk 2077');

DECLARE @GameFIFA INT = (SELECT GameId FROM Game WHERE GameName = 'FIFA 24');

EXEC sp_AddStock @BranchSheffield, @GameGTA, 10;
EXEC sp_AddStock @BranchSheffield, @GameFIFA, 6;
EXEC sp_AddStock @BranchLondon, @GameCP, 8;


GO

/* Order */

DECLARE @BranchSheffield INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'Sheffield Central');
DECLARE @BranchLondon INT = (SELECT BranchId FROM Branch WHERE StoreLocation = 'London Oxford St');

DECLARE @GameGTA INT = (SELECT GameId FROM Game WHERE GameName = 'GTA V');
DECLARE @GameCP INT = (SELECT GameId FROM Game WHERE GameName = 'Cyberpunk 2077');
DECLARE @GameFIFA INT = (SELECT GameId FROM Game WHERE GameName = 'FIFA 24');

DECLARE @CustEmir INT = (SELECT CustomerId FROM Customer WHERE CustomerName = 'Emir');

EXEC sp_AddOrder '2026-03-02', @BranchSheffield, @CustEmir;

DECLARE @LastOrderId INT = (SELECT MAX(OrderId) FROM Orders);

EXEC sp_OrderDetail @LastOrderId, @GameGTA, 1, 39;
EXEC sp_OrderDetail @LastOrderId, @GameFIFA, 2, 49;
GO