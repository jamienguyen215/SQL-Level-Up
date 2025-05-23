---AT THE LIBRARY 

---#1. Task 1 
--Find the number  of available copies of Dracula:
-- + Number of copies of Dracula --> Count how many Dracula copies
--+ Available --> ReturnedDate is NOT NULL
--  ==> Count how many dracula copies which have 'not null' returndates  

SELECT COUNT (BookID)
FROM Books
WHERE Title = 'Dracula';
  
SELECT * 
FROM Books
INNER JOIN Loans
ON Books.BookID=Loans.BookID
WHERE Books.Title='Dracula'
AND ReturnedDate NOT NULL; 
 

SELECT
(SELECT COUNT (BookID)FROM Books WHERE Title = 'Dracula')
- 
(SELECT COUNT (Books.BookID) as CopyCount 
FROM Books 
INNER JOIN Loans
ON Books.BookID=Loans.BookID
WHERE Books.Title='Dracula'
AND Loans.ReturnedDate IS NULL) 
As AvailableCopies;


--***ANOTHER WAY: 
SELECT COUNT(BookID) as CopiesAvailale, Title
FROM Books 
WHERE BookID NOT IN (SELECT BookID FROM Loans WHERE ReturnedDate IS NULL)
AND Title is 'Dracula'
GROUP BY Title;
	  
---#2. Task 2 
-- Add new copies of book


SELECT *
FROM Books
WHERE Title LIKE '%Dracula%' OR Title LIKE '%Gulliver''s Travels%'
ORDER BY Title ASC; 

INSERT INTO Books(Title,Author,Published,Barcode)
VALUES 
       ('Dracula','Bram Stoker',1897,4819277482),
	   ('Gulliver''s Travels into Several Remote Nations of the World','Jonathan Swift', 1729,4899254401);



---#3. Task 3 
--Check out boooks/loan books to Patrons 

SELECT * FROM Patrons
WHERE Email = 'jvaan@wisdompets.com';


INSERT INTO Loans (BookID, PatronID, LoanDate, DueDate)
VALUES 
      ((SELECT BookID FROM Books WHERE Barcode ='2855934983'),
	   (SELECT PatronID FROM Patrons WHERE Email = 'jvaan@wisdompets.com'),
	   '2022-08-25','2022-09-08'),
	   ((SELECT BookID FROM Books WHERE Barcode ='4043822646'),
	   (SELECT PatronID FROM Patrons WHERE Email = 'jvaan@wisdompets.com'),
	   '2022-08-25','2022-09-08');

SELECT * FROM Loans
ORDER BY LoanID DESC;	   
	   
	   
SELECT * FROM Loans
WHERE PatronID = (SELECT  PatronID FROM Patrons WHERE Email = 'jvaan@wisdompets.com');  


---#4. Task 4 
--Check for books due back 
--+ Loans Data: filter book due on July 13 2022 and ReturnedDate is NULL
--+ Books Data: information about those Books
--+ Patrons Data: information about those Patrons (emails)


SELECT Loans.DueDate,Books.Title,Patrons.FirstName,Patrons.LastName,Patrons.Email
FROM Loans 
INNER JOIN Books ON Loans.BookID = Books.BookID 
INNER JOIN Patrons ON Loans.PatronID = Patrons.PatronID
WHERE Loans.DueDate='2022-07-13'
AND Loans.ReturnedDate is NULL; 


---#5. Task 5
--Return Books to Library
--+Barcode --> From Books DATA 6435968624 - 5677520613 - 8730298424
--+Return Date --> From the Loans data --> update this Values ReturnedDate 2022-07-05
--These 2 data link to each other by the BookID 

 --use barcode --> filter what book ID --> use book ID to update values 

SELECT * FROM Loans 
WHERE BookID IN (SELECT BookID FROM Books WHERE Barcode IN (6435968624,5677520613,8730298424));
 
 
UPDATE Loans
SET ReturnedDate = '2022-07-05'
WHERE BookID IN (SELECT BookID FROM Books WHERE Barcode IN (6435968624,5677520613,8730298424))
AND ReturnedDate IS NULL;



SELECT *
FROM Loans 
WHERE ReturnedDate = '2022-07-05';

---#6. Task 6 
--Encourage patrons to check out Books
--Task: create a report showing the patrons who have checked out the fewest Books
--+Loans Data: Count how many times patrons check out books - group by patronID -> order by ASC
--+Patrons Data: get the patrons information like email, firstname 


SELECT Loans.PatronID,COUNT(Loans.LoanID)as CheckoutTimes, Patrons.FirstName,Patrons.Email
FROM Loans
INNER JOIN Patrons WHERE loans.PatronID=Patrons.PatronID
GROUP BY Loans.PatronID
ORDER BY CheckoutTimes ASC
LIMIT 15;   


---#7. Task 7
--Find books to feature for an event 
--List of books from 1890s (1890 to 1899) that are currently available.
--+ Books Data: Filter books Published from 1890 to 1899
--+ Loans Data: fiter those books has no null in ReturnedDate

--*** DO NOT USE THIS WAY
SELECT DISTINCT Books.BookID, Books.Title, Books.Author, Books.Published, Books.Barcode
FROM Books
INNER JOIN Loans ON Books.BookID=Loans.BookID
WHERE Books.Published BETWEEN 1890 AND 1899
AND Loans.ReturnedDate NOT NULL
EXCEPT
SELECT DISTINCT Books.BookID, Books.Title, Books.Author, Books.Published, Books.Barcode
FROM Books
INNER JOIN Loans ON Books.BookID=Loans.BookID
WHERE Books.Published BETWEEN 1890 AND 1899
AND Loans.ReturnedDate IS NULL
ORDER BY Books.BookID ASC; 

--===> This method has some litmit, For those book who never been borrowed, its ReturnedDate is NULL, but it is still available. 

SELECT BookID, Title, Author,Published,Barcode
FROM Books
WHERE Published BETWEEN 1890 AND 1899 
AND BookID NOT IN (Select BookID From Loans WHERE ReturnedDate IS NULL)
ORDER BY BookID ASC; 


--#8. Task 8 
--Book Statistics
--Task: 1/ How many books were published each year, count only one copy of each title, most books Published at the top of the list  
---2/ show five most popular books to check out 



SELECT Published, COUNT (DISTINCT Books.Title) as TitlesPublished, GROUP_CONCAT (DISTINCT Title)
FROM Books
GROUP BY Published
ORDER BY TitlesPublished DESC;



SELECT COUNT (Title) AS CheckoutTimes,Title
FROM (SELECT * FROM Loans INNER JOIN Books ON Loans.BookID = Books.BookID)
GROUP BY Title
ORDER BY CheckoutTimes DESC; 













