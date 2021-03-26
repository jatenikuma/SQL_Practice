-- 1 . Create a view to show all the books borrowed by the faculty in ‘Electrical Engineering’ department.
SELECT Borrower.Type , Books.Book_Title , Borrower.FName
FROM Books join Borrower on Books.ISBN_Code = Borrower.Book_Id
WHERE Borrower.Department_Name = 'Electrical Engineering' AND Borrower.Type = 'Faculty';

-- 2 . Show the average number of books borrowed by the graduate students in ‘Computer Science’ department.

SELECT AVG(result.count) AS Average_Number_Books
FROM 
(
	SELECT count(*) AS count
    FROM Borrower
    WHERE Department_Name = 'Computer Science' AND Type = 'Graduate'
) result;

-- 3 . Give the information of all the undergraduate students who have books overdue, and the fine they need to pay.
SELECT FNAME, LName , datediff(Borrower.Actual_Return_Date, Borrower.Borrowed_until) * Over_Due.Over_Due_Fee AS Amount_Due
FROM Borrower join Books b on Borrower.Book_Id = b.ISBN_Code , Over_Due  
WHERE  datediff(Borrower.Actual_Return_Date, Borrower.Borrowed_until) > 0
AND b.Category_id = Over_DUE.CategoryID AND Borrower.Type = 'Undergraduate';

-- 4 . Find the names of the library branches where all faculty members from ‘Computer Science’ have borrowed some book from.

SELECT Library_Branchs.Branch_Name
FROM Library_Branchs, Book_Copies , Borrower
WHERE Borrower.Department_Name = 'Computer Science' AND Borrower.Type = 'Graduate' 
AND Library_Branchs.Branch_Id = Book_Copies.BranchId
GROUP BY Library_Branchs.Branch_Name;

-- 5 . Get the titles of books that can be only borrowed from Branch B.

SELECT Book_Title
FROM Books join Book_Copies on Books.ISBN_Code = Book_Copies.ISBN_ID
WHERE Book_Copies.BranchId = 11 AND Book_Copies.Number_Copies = Books.No_Copies_Actual;

-- 6 . Show the students in ‘Finance’ department who renewed the current borrowed book.


-- 7 . Show all the new books that are not loaned out from Branch C. (Note that if all copies of a book are loaned out, then this book is loaned out.)

SELECT  Book_Copies.ISBN_ID , Books.Book_Title, Book_Copies.Remaining_Copies
FROM Books join Book_Copies on Books.ISBN_Code = Book_Copies.ISBN_ID
WHERE Books.Category_id = 9 -- 9 represents New books
AND Book_Copies.BranchId = 12 -- 12 represents Branch c
AND Book_Copies.Remaining_Copies > 0;

-- 8 . Find out the presses who have the maximum total numbers of book copies in Branch A, Branch B, and Branch C respectively.

SELECT  Publisher_Details.Publisher_Name, Library_Branchs.Branch_Name , Library_Branchs.Branch_Id  , 
count(Books.No_Copies_Actual)
FROM Books join Publisher_Details on Books.Publisher_Id = Publisher_Details.Publisher_Id, 
Library_Branchs join Book_Copies on Library_Branchs.Branch_Id = Book_Copies.BranchId
GROUP BY Book_Copies.BranchId , Books.Publisher_Id 
;






