CREATE VIEW vw_AllStocks
AS
SELECT  g.GameName, SUM(s.StockQuantity) AS TotalStock FROM Stocks s INNER JOIN Game g ON s.GameId = g.GameId  GROUP BY g.GameName

GO 

CREATE VIEW vw_StoreStocks
AS
SELECT g.GameName , b.StoreLocation , s.StockQuantity FROM Game g INNER JOIN  Stocks s   ON  g.GameId = s.GameId INNER JOIN  Branch b  ON b.BranchId = s.BranchId

GO 

CREATE VIEW vw_StaffNumber
AS
SELECT   b.StoreLocation , COUNT(*) AS EmployeeNumber FROM Employee e INNER JOIN Branch b ON e.BranchId = b.BranchId GROUP BY b.StoreLocation

GO

CREATE VIEW vw_DeveloperOfTheGames
AS
SELECT d.DeveloperName, g.GameName, g.ReleaseDate FROM Developer d INNER JOIN Game g ON g.DeveloperId = d.DeveloperId

GO 

CREATE VIEW  vw_DevelopersTotalGame
AS
SELECT d.DeveloperName, COUNT(*) AS Games FROM Developer d INNER JOIN Game g ON d.DeveloperId = g.DeveloperId GROUP BY d.DeveloperName

GO
CREATE VIEW vw_ManagerOfStore
AS
SELECT e.EmployeeId ,e.EmployeeName AS ManagerName,b.StoreLocation FROM Employee e INNER JOIN Branch b ON e.EmployeeId = b.BranchId

GO
CREATE VIEW vw_TotalSales
AS
SELECT b.StoreLocation, COUNT(*) AS OrderCount FROM Orders o INNER JOIN Branch b ON o.BranchId = b.BranchId GROUP BY b.StoreLocation