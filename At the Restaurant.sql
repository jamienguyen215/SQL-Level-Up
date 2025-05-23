
---***1/ CREATE_TABLE; DELETE_TABLE; DISPLAY_TABLE 
CREATE TABLE AnniversaryAttendees (
CustomerID INTEGER,
PartySize INTEGER);

DROP TABLE CustomersResponses;

SELECT Name,Price,Type FROM Dishes
ORDER BY Price ASC;

SELECT Name,Price,Type FROM Dishes 
WHERE Type IN ('Appetizer','Beverage')
ORDER BY Type ASC, Price ASC;

SELECT Name, Price, Type FROM Dishes
WHERE Type NOT IN ('Beverage')
ORDER BY Type ASC,Price ASC;

SELECT Name, Price, Type FROM Dishes
WHERE Type !='Beverage'
ORDER BY Type ASC, Price ASC;


SELECT Name, Price, Type FROM Dishes
WHERE Type ='Beverage' OR Type = 'Appetizer'
ORDER BY Type ASC, Price ASC;

INSERT INTO Customers (FirstName,LastName,Email,Address,City,State,Phone,Birthday)
VALUES ('Tram','Nguyen','tram.nguyen@bekaert.com','2002 Reserve Pkwy','McDonough','GA','4045020832','1998-05-21');

SELECT * FROM Customers ORDER BY CustomerID DESC;

UPDATE Customers 
SET Address='74 Pine St.',
    City = 'New York',
	State = 'NY'
WHERE FirstName = 'Taylor' AND LastName ='Jenkins';

SELECT * FROM Customers 
WHERE FirstName = 'Taylor' AND LastName = 'Jenkins';

SELECT * FROM Customers
WHERE FirstName = 'Norby';

SELECT * FROM Reservations 
WHERE CustomerID = 64;

DELETE FROM Reservations
WHERE ReservationID = 2000; 

SELECT Customers.FirstName, Reservations.ReservationID, Reservations.Date, Customers.CustomerID 
FROM Customers
INNER JOIN Reservations 
ON Customers.CustomerID=Reservations.CustomerID
WHERE Customers.FirstName='Norby';

SELECT * FROM Reservations 
INNER JOIN Customers 
ON Reservations.CustomerID = Customers.CustomerID
WHERE Customers.FirstName='Norby'
AND Reservations.Date > '2021-01-11'; 

SELECT * FROM Reservations 
INNER JOIN Customers 
ON Reservations.CustomerID=Customers.CustomerID
ORDER BY CustomerID ASC; 

DELETE FROM Reservations 
WHERE CustomerID = 1;

SELECT * FROM Reservations
ORDER BY CustomerID ASC;

SELECT * FROM Reservations
INNER JOIN Customers
ON Reservations.CustomerID = Customers.CustomerID
ORDER BY CustomerID ASC;


SELECT * FROM Reservations
RIGHT JOIN Customers
ON Reservations.CustomerID=Customers.CustomerID
ORDER BY CustomerID ASC;

SELECT * FROM Customers
LEFT JOIN Reservations
ON Reservations.CustomerID=Customers.CustomerID
ORDER BY CustomerID ASC;


INSERT INTO AnniversaryAttendees (CustomerID,PartySize)
VALUES ((SELECT CustomerID FROM Customers WHERE Email = 'atapley2j@kinetecoinc.com'),4);

SELECT * FROM AnniversaryAttendees	


SELECT * FROM Reservations 
INNER JOIN Customers 
ON Reservations.CustomerID=Customers.CustomerID
WHERE Customers.LastName LIKE 'ste%' 
AND Reservations.PartySize=4 
AND Reservations.Date>'2022-06-14';


SELECT * FROM Customers
WHERE FirstName='SAM';


INSERT INTO Customers (FirstName,LastName,Email,Phone)
VALUES('SAM','McAdams','smac@kinetecoin','(555-555-1212');	

INSERT INTO Reservations (CustomerID,Date,PartySize)
VALUES ((SELECT CustomerID FROM Customers 
         WHERE FirstName='SAM'), '2022-08-12 18:00:00','5');

SELECT * FROM Reservations
WHERE Date > '2022-08-12';


SELECT * FROM Customers
WHERE FirstName = 'Loretta';


INSERT INTO Orders (CustomerID,OrderDate)
VALUES ((SELECT CustomerID FROM Customers
         WHERE FirstName='Loretta'),
		 '2022-09-20 14:00:00');


SELECT * FROM Orders 
Where OrderDate='2022-09-20 14:00:00';




INSERT INTO OrdersDishes (OrderID,DishID)
VALUES
((SELECT OrderID FROM Orders WHERE OrderDate = '2022-09-20 14:00:00'),
(SELECT DishID FROM Dishes WHERE Name = 'House Salad')),
((SELECT OrderID FROM Orders WHERE OrderDate = '2022-09-20 14:00:00'),
(SELECT DishID FROM Dishes WHERE Name = 'Mini Cheeseburgers')),
((SELECT OrderID FROM Orders WHERE OrderDate = '2022-09-20 14:00:00'),
(SELECT DishID FROM Dishes WHERE Name = 'Tropical Blue Smoothie'));

SELECT * FROM OrdersDishes
Where OrderID=1001

SELECT * 
FROM Dishes 
JOIN OrdersDishes ON Dishes.DishID=OrdersDishes.DishID
WHERE OrdersDishes.OrderID=1001; 

DELETE FROM OrdersDishes
WHERE OrderID=1001;

SELECT SUM(Price) FROM Dishes 
WHERE DishID IN (7,4,20);


SELECT SUM(Price)
FROM Dishes 
JOIN OrdersDishes ON Dishes.DishID=OrdersDishes.DishID
WHERE OrdersDishes.OrderID=1001;

---### Track_favorite_dish - UPDATE values 
 
 SELECT * 
 FROM Customers
 WHERE LastName = 'Goldwater';
 
UPDATE Customers 
SET FavoriteDish = (SELECT DishID FROM Dishes WHERE NAME = 'Quinoa Salmon Salad')
WHERE LastName = 'Goldwater';
 
 SELECT *
 FROM Customers 
 INNER JOIN Dishes 
 ON Customers.FavoriteDish=Dishes.DishID
 WHERE Customers.FirstName='Cleo'
 AND Customers.LastName='Goldwater'; 
 
 
--- ###Report_of_top_customers 
 --Who has placed the most orders? 
 
 SELECT * 
 FROM Orders
 INNER JOIN Customers 
 WHERE Orders.CustomerID=Customers.CustomerID
 ORDER BY CustomerID ASC;
 

 
SELECT CustomerID,FirstName,LastName,Email,COUNT(OrderID) as OrderCount
FROM (SELECT * FROM Orders
      INNER JOIN Customers 
      WHERE Orders.CustomerID=Customers.CustomerID)
GROUP BY CustomerID 
HAVING OrderCount > 14
ORDER BY OrderCount DESC
LIMIT 15;	  

SELECT Customers.FirstName,Customers.LastName,Customers.Email, COUNT(Orders.OrderID) as OrderCount
FROM Customers 
INNER JOIN Orders 
WHERE Customers.CustomerID=Orders.CustomerID
GROUP BY Orders.CustomerID
HAVING OrderCount > 14
ORDER BY OrderCount DESC
LIMIT 15;











