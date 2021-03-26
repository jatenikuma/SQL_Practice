-- Creating the database if it does not exist
CREATE DATABASE IF NOT EXISTS Library_Managment;


-- Categories table to store the categories of books in the library. Referenced in books table
CREATE TABLE Categories
(
	Category_Id int NOT NULL,
    Category_Name varchar(50) NOT NULL,
    UNIQUE(Category_Name),
    PRIMARY KEY (Category_Id)
);

-- Library Branch table to store the branch information. Referenced in Book_Copies table
CREATE TABLE Library_Branchs
(
	Branch_Id int NOT NULL,
    Branch_Name varchar(200) NOT NULL,
    UNIQUE(Branch_Name),
    PRIMARY KEY (Branch_Id)
);

-- Publisher_Details table to store details about the publisher of the books. Referenced in the Books table
CREATE TABLE Publisher_Details
(
	Publisher_Id int NOT NULL,
    Publisher_Name varchar(100) NOT NULL,
    
    UNIQUE(Publisher_Name),
    PRIMARY KEY (Publisher_Id)
);


-- Books table - contains data about the book and also name of the author. Refernces the publisher and the categories id
CREATE TABLE Books
(  
    ISBN_Code int NOT NULL,  
    Book_Title varchar(150) NOT NULL,  
    Author_First_Name varchar(50) NOT NULL,  
    Author_Last_Name varchar(50),  
    Publisher_Id int NOT NULL,  
    No_Copies_Actual int,  
    No_Copies_Current int,  
    Category_id int NOT NULL,
    Published_Dated date NOT NULL,
    No_pages int,
    Number_of_words int NOT NULL,
    Price decimal(4,2),
    
    PRIMARY KEY (ISBN_Code),
    FOREIGN KEY (Category_id) REFERENCES Categories(Category_Id),
    FOREIGN KEY (Publisher_Id) REFERENCES Publisher_Details(Publisher_Id),
    UNIQUE(Book_Title)
);
 
-- Borrower table to store information about the borrower. A disjoint of student and faculty. Referenced in over_due table
CREATE TABLE Borrower
(
	Department_Name varchar(50) NOT NULL,
    FName varchar(50) NOT NULL,
    LName varchar(50) ,
    Gender varchar(1) NOT NULL,
    Book_Id int,
    Borrowed_From date NOT NULL,
    Borrowed_until date NOT NULL,
    Actual_Return_Date date NOT NULL,
    Email varchar(100) ,
    Borrower_id int NOT NULL,
    Type varchar(50),
    
    UNIQUE(Email),
    FOREIGN KEY (Book_Id) REFERENCES Books(ISBN_Code),
    PRIMARY KEY (Borrower_Id)
    
);

-- Over_Due to store overdues charged to a borrower
CREATE TABLE Over_DUE
(
	CategoryID int NOT NULL,
    Over_Due_Fee decimal(3,2) NOT NULL,
    
    FOREIGN KEY (CategoryID) REFERENCES Categories(Category_Id)
    
);

-- Book_Copies table to store the number of books present in each branch
CREATE TABLE Book_Copies
(
	ISBN_ID int NOT NULL,
    BranchId int NOT NULL,
    Number_Copies int NOT NULL,
    Remaining_Copies int NOT Null,
    
    FOREIGN KEY (ISBN_ID) REFERENCES Books(ISBN_Code),
    FOREIGN KEY (BranchId) REFERENCES Library_Branchs(Branch_Id)
);

INSERT INTO Publisher_Details (Publisher_Id , Publisher_Name)
VALUES
 (1 , 'HarperCollins'),
 (2 , 'Harcourt Inc'),
 (3 , 'Alfred A. Knopf'),
 (4 , 'Pantheon Books');
 
 INSERT INTO Categories (Category_Id , Category_name)
 VALUES (7 , 'English'),
		(8 , 'Foreign Language'),
		(9 , 'New');
        
INSERT INTO Books 
(ISBN_Code , Book_Title , Author_First_Name , Author_Last_Name , Publisher_Id , No_Copies_Actual,  No_Copies_Current, Category_id , Published_Date, No_pages, Number_of_words, Price)
VALUES 
	  -- English books
	   (0061124958 , "Charlotte's Web" , "Elwyn" , "White" , 1 , 20 , 12 , 7 , '2012-04-12' , 192 , 100000 , 50.00) ,
	   (0694003611 , "Goodnight Moon Board Book" , "Margaret" , "Brown" , 1 , 30 , 20 , 7 , '2007-01-23' , 34, 10000 , 10.00),
	   (0060935464 , "To Kill a Mockingbird" , "Harper" , "Lee" , 1 , 12 , 3 , 7 , '2007-07-05' , 336, 10000 , 15.00), 
	   (0061135465 , "The Complete Grimm's Fairy Tales" , "Jacob" , "Grimm" , 4 , 32 , 30 , 7 , '2017-07-15' , 236, 90000 , 11.00), 
       
       -- Foreign books
       (0060935422 , "The Little Prince" , "Antoine" , "de Saint-Exupéry" , 2 , 15 , 3 , 8 , '2000-06-29' , 93, 15000 , 7.00),
	   (0679760806 , "The Master and Margarita" , "Mikhail" , "Bulgakov" , 2 , 10 , 9 , 8 , '1996-03-02' , 335, 120000 , 17.00),
	   (0679721806 , "The Man Without Qualities" , "Robert" , "Musil" , 3 , 122 , 109 , 8 , '1986-08-22' , 380, 125000 , 27.00),
	   (0679721116 , "The Brothers Karamazov" , "Fyodor" , "Dostoyevsky" , 3 , 2 , 2 , 8 , '2000-12-22' , 480, 155000 , 37.00),
       
        -- New books
       (0067775422 , "The Woman in the Dunes" , "Kobo" , "Abe" , 2 , 15 , 3 , 9 , '2010-09-29' , 193, 120000 , 23.00),
	   (0678880806 , "The Odyssey" , "Mikhail" , "Bulgakov" , 2 , 10 , 9 , 9 , '1976-03-22' , 535, 170000 , 27.00),
	   (0679991806 , "The Story of a Murderer" , "Patrick" , "Woods" , 4 , 12 , 9 , 9 , '1986-08-22' , 380, 125000 , 57.00),
	   (0679661216 , "Selected Stories and Other Writings" , "Jorge" , "Borges" , 3 , 20 , 2 , 9 , '2011-11-11' , 1480, 1505000 , 79.00)
       ;
       

-- Insert into Borrower

INSERT INTO Borrower (Department_Name, FName, LName, Gender, Book_Id, Borrowed_From, Borrowed_until, Actual_Return_Date, Email, Borrower_id, Type)
VALUES
	('Computer Science' , 'Charlotte' , 'Oliver' , 'F' , '0061124958' , '2020-01-01' , '2020-02-23', '2020-02-27', 'CharlotteOliver@gmail.com' , 1, 'Graduate'),
	('Computer Science' , 'Liam' , 'Khan' , 'M' , '0694003611' , '2020-03-02' , '2020-05-23', '2020-05-27', 'LiamKhan@gmail.com' , 2, 'Undergraduate'),
	('Computer Science' , 'Aurora' , 'Gabriel' , 'F' , '0060935464' , '2020-10-11' , '2020-12-23', '2020-12-12', 'AuroraGabriel@gmail.com' , 3, 'Undergraduate'),
	('Computer Science' , 'Ava' , 'Henry' , 'F' , '0061135465' , '2020-08-01' , '2020-09-23', '2020-09-22', 'AvaHenry@gmail.com' , 4, 'Graduate'),
    ('Electrical Engineering' , 'Jackson' , 'Declan' , 'M' , '0679721806' , '2020-08-22' , '2020-09-22', '2020-09-11', 'JacksonDeclan@gmail.com' , 5, 'Undergraduate'),
    ('Electrical Engineering' , 'Caleb' , 'Owen' , 'M' , '0060935422' , '2020-08-06' , '2020-08-24', '2020-08-27', 'CalebOwen@gmail.com' , 6, 'Staff'),
    ('Electrical Engineering' , 'Aiden' , 'Theodore' , 'M' , '0679721116' , '2020-09-16' , '2020-10-16', '2020-10-15', 'AidenTheodore@gmail.com' , 7, 'Graduate'),
    ('Mechanical Engineering' , 'Milo' , 'Lucas' , 'M' , '0679760806' , '2020-11-16' , '2020-11-23', '2020-11-27', 'MiloLucas@gmail.com' , 8, 'Undergraduate'),
    ('Mechanical Engineering' , 'Hudson' , 'Felix' , 'M' , '0679721806' , '2020-05-10' , '2020-05-30', '2020-05-27', 'HudsonFelix@gmail.com' , 9, 'Staff'),
    ('Mechanical Engineering' , 'Lionel' , 'Messi' , 'M' , '0067775422' , '2020-10-12' , '2020-11-27', '2020-11-26', 'LionelMessi@gmail.com' , 10, 'Faculty'),
    ('Civil Engineering' , 'Sara' , 'Thomas' , 'F' , '0679661216' , '2020-01-01' , '2020-06-23', '2020-06-27', 'SaraThomas@gmail.com' , 11, 'Graduate'),
    ('Civil Engineering' , 'Mindy' , 'Jefferson' , 'F' , '0061124958' , '2020-07-12' , '2020-08-23', '2020-08-22', 'MindyJefferson@gmail.com' , 12, 'Undergraduate'),
    ('Civil Engineering' , 'Dwight' , 'Schrute' , 'M' , '0694003611' , '2020-02-01' , '2020-02-10', '2020-02-14', 'DwightSchrute@gmail.com' , 13, 'Graduate'),
    ('Civil Engineering' , 'Jim' , 'Halpert' , 'M' , '0679760806' , '2020-11-01' , '2020-12-03', '2020-12-17', 'JimHalpert@gmail.com' , 14, 'Undergraduate'),
    ('Mathematics' , 'Micheal' , 'Scott' , 'M' , '0061135465' , '2020-01-19' , '2020-02-23', '2020-02-24', 'MichealScott@gmail.com' , 15, 'Faculty'),
    ('Mathematics' , 'Andy' , 'Bernard' , 'M' , '0067775422' , '2020-01-10' , '2020-02-15', '2020-02-14', 'AndyBernard@gmail.com' , 16, 'Graduate'),
    ('Social Science' , 'Darnyel' , 'Dida' , 'M' , '0678880806' , '2020-09-11' , '2020-12-23', '2020-12-10', 'DarnyelDida@gmail.com' , 17, 'Undergraduate'),
    ('Mathematicse' , 'Pam' , 'Bessely' , 'F' , '0679991806' , '2020-03-01' , '2020-04-23', '2020-04-27', 'PamBessely@gmail.com' , 18, 'Undergraduate'),
    ('Social Science' , 'Angela' , 'Elliot' , 'F' , '0679661216' , '2020-01-21' , '2020-02-23', '2020-03-27', 'AngelaElliot@gmail.com' , 19, 'Undergraduate'),
    ('Electrical Engineering' , 'Toby' , 'Flenderson' , 'M' , '0067775422' , '2020-08-22' , '2020-09-22', '2020-09-30', 'TobyFlenderson@gmail.com' , 20, 'Faculty');
    
    

SELECT ISBN_Code , No_Copies_Actual , No_Copies_Current FROM Books;
-- Insert into Library_Branchs

INSERT INTO Library_Branchs (Branch_Id, Branch_Name)
VALUES (10 , 'Business and Management'),
	   (11 , 'Science and Technology'),
	   (12 , 'Law, Arts and Literature');
       
-- Insert into Book_Copies

INSERT INTO Book_Copies (ISBN_ID , BranchId , Number_Copies , Remaining_Copies)
VALUES 
(60935422 , 10 , 10 , 1),
(60935422 , 11 , 5 , 2),
(60935464 , 12 , 8 , 1),
(60935464 , 10 , 4 , 2),
(61124958 , 11, 17 , 12),
(61124958 , 12, 3 , 0),
(61135465 , 11, 15 , 15),
(61135465 , 10, 10 , 10),
(61135465 , 12, 7 , 5),
(67775422 , 10, 15 , 3),
(678880806 , 12 , 10 , 9),
(679661216 , 11 , 20 , 2),
(679721116 , 12, 1 , 1 ),
(679721116 , 11, 1 , 1),
(679721806 , 10 , 32 , 25),
(679721806 , 11, 40, 35),
(679721806 , 12, 50 , 49 ),
(679760806 , 10 , 5 , 4),
(679760806 , 11, 5 , 5),
(679991806 , 12 , 12 , 9),
(694003611 , 10 , 10 , 10),
(694003611 , 11 , 10 , 10),
(694003611 , 11 , 10 , 0);

-- Insert into Over_Due
INSERT INTO Over_DUE ( CategoryID , Over_Due_Fee)
VALUES (7 , 0.20),
	   (8 , 0.50 ),
	   (9 , 0.50);
       











