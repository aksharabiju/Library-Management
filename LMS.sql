CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch (Branch_no INT PRIMARY KEY,Manager_id INT,Branch_address VARCHAR(100),Contact_no INT);
INSERT INTO Branch VALUES
(1, 34, '32 Corner Road, New York, NY 10012', 12345),
(2, 23, '491 3rd Street, New York, NY 10014', 3456),
(3, 12, '40 State Street, Saline, MI 48176', 456),
(4, 10, '101 South University, Ann Arbor, MI 48104', 456789);
SELECT * FROM Branch;


CREATE TABLE Employee ( Emp_id INT PRIMARY KEY, Emp_name VARCHAR(20), Position VARCHAR(20), Salary INT, Branch_no INT REFERENCES Branch(Branch_no));
INSERT INTO Employee VALUES
(101, 'Akshara', 'Manager', 80000, 1),
(102, 'Ajith', 'Sales Associate', 50000, 2),
(103, 'Anija', 'Clerk', 40000, 3),
(104, 'Avani', 'Accountant', 60000, 4),
(105,'Susheel','Clerk',70000,4),
(106,'Sachin','Manager',40000,4),
(107,'Ammu','Sales',25000,4),
(108,'Raveena','Pune',20000,4),
(109,'Anju','Cashier',23000,4),
(110,'Biju','Clerk',70000,1),
(111,'Madhu','Clerk',70000,2)
;
SELECT * FROM Employee;


CREATE TABLE Customer (Customer_id INT PRIMARY KEY,Customer_name VARCHAR(50),Customer_address VARCHAR(50),Reg_date DATE);
INSERT INTO Customer VALUES
(7, 'Sandra', '123 Main Street, Cityville', '2024-01-12'),
(8, 'Lalitha', '456 Oak Avenue, Townsville', '2024-01-15'),
(9, 'Vinisha', '789 Pine Road, Villagetown', '2024-01-18'),
(10, 'Manju', '789 Apple Road, Villagetown', '2020-01-20'),
(11, 'Malu', '789 Ruby Road, Villagetown', '2019-01-27');
SELECT * FROM Customer;


CREATE TABLE IssueStatus ( Issue_id INT PRIMARY KEY, Issued_cust INT REFERENCES Customer(Customer_id),Issued_book_name VARCHAR(50),Issue_date DATE, Isbn_book BIGINT );
INSERT INTO IssueStatus VALUES
(1, 7, 'X-Men: God Loves, Man Kills', '2024-02-01', 9788654552277),
(2, 8, 'V for Vendetta', '2024-02-05', 6901142585540),
(3, 9, 'The Great Gatsby', '2023-06-10', 8653491200700);
SELECT * FROM IssueStatus;


CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY, Return_cust VARCHAR(50),Return_book_name VARCHAR(50),Return_date DATE, Isbn_book2 BIGINT);
INSERT INTO ReturnStatus VALUES
(1, 'Sandra', 'X-Men: God Loves, Man Kills', '2024-02-15', 9788654552277),
(2, 'Lalitha', 'V for Vendetta', '2024-02-20', 6901142585540),
(3, 'Vinisha', 'The Great Gatsby', '2024-02-25', 8653491200700);
SELECT * FROM ReturnStatus;


CREATE TABLE Books(ISBN BIGINT PRIMARY KEY,Book_title VARCHAR(100),Category VARCHAR(50),Rental_Price DECIMAL(10,2),Status BOOLEAN,Author VARCHAR(50),Publisher VARCHAR(50));
INSERT INTO Books VALUES
(9788654552277, 'X-Men: God Loves, Man Kills', 'Comics', 98.00, FALSE, 'Chris', 'Viking'),
(964161484100, 'Mike Tyson: Undisputed Truth', 'Sports', 654.00, FALSE, 'Larry Sloman', 'Bloomsbury'),
(6901142585540, 'V for Vendetta', 'Comics', 600.00, TRUE, 'Alan Moore', 'Chilton Books'),
(9094996245442, 'When Breath Becomes Air', 'Medical', 500.00, TRUE, 'Paul Kalanithi', 'Pan Books'),
(8653491200700, 'The Great Gatsby', 'Fiction', 432.00, TRUE, 'F. Scott Fitzgerald', 'W.W. Norton'),
(2345697869708,'The Communist Manifesto','History',235.00,TRUE,'Karl Marx','DC BOOKS');
SELECT * FROM Books;



#1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title,Category,Rental_Price FROM Books;


#2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;


#3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT  IssueStatus.Issued_book_name, Customer.Customer_name FROM IssueStatus JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_id;


#4. Display the total count of books in each category.
SELECT Category,COUNT(*) AS Total_Books_Count FROM Books GROUP BY Category;


#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Emp_name,Position FROM Employee WHERE Salary>50000;


#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT C.Customer_name FROM Customer C LEFT JOIN IssueStatus I ON C.Customer_id = I.Issued_cust WHERE C.Reg_date < '2022-01-01' AND I.Issued_cust IS NULL;


#7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees_Count FROM Employee GROUP BY Branch_no;


#8. Display the names of customers who have issued books in the month of June 2023.
SELECT C.Customer_name FROM Customer C JOIN IssueStatus I ON C.Customer_id = I.Issued_cust WHERE MONTH(I.Issue_date)=6 AND YEAR(I.Issue_date)=2023;


#9.Retrieve book_title from book table containing history.
SELECT Book_title FROM Books WHERE Category='History';


#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no,COUNT(*) AS Total_Employees_Count FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

