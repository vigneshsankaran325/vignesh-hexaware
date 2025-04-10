CREATE DATABASE SISDB;
use SISDB;
/*TASK 1*/
CREATE TABLE Students(
student_id INT PRIMARY KEY ,
first_name VARCHAR(200),
last_name VARCHAR(200),
date_of_birth DATE,
Email VARCHAR(200),
phone_no BIGINT);

CREATE TABLE Teachers(
teacher_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
Email VARCHAR(100));

CREATE TABLE Courses(
course_id INT PRIMARY KEY,
course_name VARCHAR(50),
credits VARCHAR(50),
teacher_id INT,
FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id));

CREATE TABLE Enrollments(
enrollment_id INT PRIMARY KEY,
student_id INT ,
course_id INT ,
enrollment_date DATE,
FOREIGN KEY(student_id) REFERENCES Students(student_id),
FOREIGN KEY(course_id) REFERENCES Courses(course_id));

CREATE TABLE Payments(
payment_id INT PRIMARY KEY,
student_id INT,
amount INT,
payment_date DATE,
FOREIGN KEY(student_id) REFERENCES Students(student_id),
);

INSERT INTO Students VALUES
(001,'Vignesh', 'Sankaran', '2002-04-10', 'vicky@gmail.com', 1234567890),
(002,'Shanthi', 'Nikethan', '2001-05-20', 'shanthi@gmail.com', 2345678901),
(003,'Harini', 'Sri', '2000-12-15', 'harini@gmail.com', 3456789012),
(004,'Gokul', 'Guna', '2003-03-18', 'gokul@gmail.com', 4567890123),
(005,'Athavan', 'Aravindhan', '2002-06-05', 'athavan@gmail.com', 5678901234),
(006,'Karthick', 'Netha', '2001-11-22', 'karthick@gmail.com', 6789012345),
(007,'Rajesh', 'Subramanium', '2000-08-30', 'rahul@gmail.com', 7890123456),
(008,'Rahul', 'Deeraj', '2002-09-14', 'raghul@gmail.com', 8901234567),
(009,'Reshma', 'Valli', '2001-02-11', 'reshma@gmail.com', 9012345678),
(010,'Janavee', 'Senthil', '2003-01-01', 'janavee@gmail.com', 0123456789);

INSERT INTO Teachers(teacher_id, first_name, last_name, email) VALUES
(1, 'Vijay', 'Rajendran', 'alan.@gmail.com'),
(2, 'Anitha', 'Mani', 'Anitha@gmail.com'),
(3, 'Kavya', 'Muthu', 'Kavya@gmail.com'),
(4, 'Revathi', 'Arumugam', 'Revathi@gmail.com'),
(5, 'Sudha', 'Balaji', 'Sudha@gmail.com'),
(6, 'Sangeetha', 'Kannan', 'Revathi@gmail.com'),
(7, 'Nandhini', 'Shankar', 'Nandhini@gmail.com'),
(8, 'Murugan', 'Gandhi', 'Murugan@gmail.com'),
(9, 'Senthil', 'Prakash', 'Senthil@gmail.com'),
(10, 'Meena', 'Sekar', 'Meena@gmail.com');

INSERT INTO Courses (course_id, course_name, credits, teacher_id) VALUES
(1, 'Mathematics', 4, 1),
(2, 'Computer Science', 3, 2),
(3, 'Physics', 4, 3),
(4, 'Philosophy', 2, NULL), 
(5, 'History', 2, 4),
(6, 'Biology', 4, NULL),
(7, 'Botany', 3, 4),
(8, 'Zoology', 3, 4),
(9, 'Chemistry', 3, 4),
(10, 'Psychology', 2, NULL);     

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 1, '2024-09-01'),
(2, 1, 2, '2024-09-01'),
(3, 2, 1, '2024-09-01'),
(4, 2, 3, '2024-09-01'),
(5, 3, 1, '2024-09-01'),
(6, 3, 2, '2024-09-01'),
(7, 4, 2, '2024-09-01'),
(8, 5, 3, '2024-09-01'),
(9, 6, 5, '2024-09-01'),
(10, 7, 5, '2024-09-01');

INSERT INTO Payments (payment_id, student_id, amount, payment_date) VALUES
(1, 1, 500, '2024-09-15'),
(2, 1, 250, '2024-10-15'),
(3, 2, 700, '2024-09-10'),
(4, 9, 300, '2024-09-12'),
(5, 9, 300, '2024-10-12'),
(6, 4, 600, '2024-09-20'),
(7, 5, 550, '2024-09-25'),
(8, 6, 700, '2024-09-28'),
(9, 6, 700, '2024-09-28'),
(10, 8, 400, '2024-10-01');

/*TASK 2*/
/*1. Write an SQL query to insert a new student into the "Students" table with the following details: */
INSERT INTO Students VALUES (011,'John','Doe','1995-08-15','john.doe@example.com',1234567890);
SELECT * FROM Students;

/*2. Write an SQL query to enroll a student in a course. Choose an existing student and course and 
insert a record into the "Enrollments" table with the enrollment date. */

INSERT INTO Enrollments VALUES (11, 7, 8, '2024-10-01')
SELECT * FROM Enrollments;

/*3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and 
modify their email address. */

UPDATE Teachers SET Email='Murugan,Gandhi@gmail.com' WHERE last_name='Gandhi';
SELECT * FROM Teachers;

/*4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select 
an enrollment record based on the student and course.*/

DELETE FROM Enrollments WHERE student_id=1 AND course_id=2;
SELECT * FROM Enrollments;

/*5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and 
teacher from the respective tables.*/
UPDATE Courses SET teacher_id=8 WHERE course_id=10;
SELECT * FROM Courses;

/*6. Delete a specific student from the "Students" table and remove all their enrollment records 
from the "Enrollments" table. Be sure to maintain referential integrity.*/

DELETE FROM Enrollments WHERE student_id=6;
DELETE FROM Payments WHERE student_id=6;
DELETE FROM Students WHERE student_id=6;
SELECT * FROM Students;
SELECT * FROM Enrollments;
SELECT * FROM Payments;

/*7. Update the payment amount for a specific payment record in the "Payments" table. Choose any 
payment record and modify the payment amount. */

UPDATE Payments SET amount=450 WHERE payment_id=2;
SELECT * FROM Payments;

/*TASK 3*/
/*1. Write an SQL query to calculate the total payments made by a specific student. You will need to 
join the "Payments" table with the "Students" table based on the student's ID.*/

SELECT (s.first_name+' '+s.last_name)AS Student_name,SUM(p.amount) AS Total_payments 
FROM Students s 
JOIN Payments p ON s.student_id=p.student_id 
WHERE s.student_id = 1 
GROUP BY (s.first_name+' '+s.last_name);

/*2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each 
course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.*/

SELECT c.course_name, COUNT(e.student_id) AS 'No. of Students'
FROM Courses c 
LEFT JOIN Enrollments e ON c.course_id=e.course_id
GROUP BY course_name;

/*3. Write an SQL query to find the names of students who have not enrolled in any course. Use a 
LEFT JOIN between the "Students" table and the "Enrollments" table to identify students 
without enrollments. */

SELECT CONCAT(first_name,' ',last_name) AS Student_name FROM Students s 
LEFT JOIN Enrollments e ON s.student_id=e.student_id
WHERE enrollment_id IS NULL;

/*4. Write an SQL query to retrieve the first name, last name of students, and the names of the 
courses they are enrolled in. Use JOIN operations between the "Students" table and the 
"Enrollments" and "Courses" tables. */

SELECT first_name,last_name,course_name	
FROM Students s
JOIN Enrollments e ON s.student_id=e.student_id
JOIN Courses c ON e.course_id=c.course_id
WHERE enrollment_id IS NOT NULL;
--5--
SELECT CONCAT(first_name,' ',last_name) AS Teacher_name, course_name
FROM Teachers t 
LEFT JOIN Courses c ON T.teacher_id=c.teacher_id;
--6--
SELECT CONCAT(first_name,' ',last_name) AS Student_name, enrollment_date 
FROM Students s 
JOIN Enrollments e ON s.student_id=e.student_id
JOIN Courses c ON e.course_id=c.course_id
WHERE e.course_id=1;
--7--
SELECT CONCAT(first_name,' ',last_name) AS Student_name 
FROM Students s 
LEFT JOIN Payments p ON s.student_id=p.student_id
WHERE p.payment_id IS NULL;
--8--
SELECT c.course_name
FROM Courses c 
LEFT JOIN Enrollments e ON c.course_id=e.course_id
WHERE e.enrollment_id IS NULL;
--9--
SELECT s.student_id , CONCAT(first_name,last_name) AS Student_name,COUNT(e.course_id) AS 'No. of courses'
FROM Students s
JOIN Enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id,CONCAT(first_name,last_name)
HAVING COUNT(e.course_id)>1
ORDER BY s.student_id;
--10--
SELECT CONCAT(first_name,' ',last_name) AS Teacher_name
FROM Teachers t 
LEFT JOIN Courses c ON T.teacher_id=c.teacher_id
WHERE c.course_id IS NULL;

/*TASK 4*/
--1--
SELECT  course_id,AVG(student_count) AS avg_students_per_course
FROM (
    SELECT course_id, COUNT(student_id) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS coursestats 
GROUP BY course_id;;

SELECT AVG(student_count) AS avg_students_per_course
FROM (
    SELECT course_id, COUNT(student_id) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS avg;

--2--
SELECT p.student_id,CONCAT(first_name,' ',last_name)AS std_name, p.amount
FROM Payments p
JOIN Students s ON p.student_id= s.student_id
WHERE amount = (SELECT MAX (amount) FROM Payments);
--3--
SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) = (
    SELECT MAX(course_enrollments)
    FROM (
        SELECT COUNT(student_id) AS course_enrollments
        FROM Enrollments
        GROUP BY course_id
    ) AS max
);


--4--
SELECT t.first_name, t.last_name, (
    SELECT SUM(p.amount)
    FROM Payments p
    WHERE p.student_id IN (
        SELECT e.student_id
        FROM Enrollments e
        JOIN Courses c ON e.course_id = c.course_id
        WHERE c.teacher_id = t.teacher_id
    )
) AS total_payments
FROM Teachers t;

--5--
SELECT s.first_name, s.last_name
FROM Students s
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM Courses c
    WHERE c.course_id NOT IN (
        SELECT e.course_id
        FROM Enrollments e
        WHERE e.student_id = s.student_id
    )
);

--6--
SELECT first_name, last_name FROM Teachers
WHERE teacher_id NOT IN (
    SELECT teacher_id FROM Courses
    WHERE teacher_id IS NOT NULL
);

--7--
SELECT AVG(age) AS average_age
FROM (
    SELECT DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age
    FROM Students
) AS sub;
--8--
SELECT course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM Enrollments
);
--9--
SELECT CONCAT(s.first_name,' ', s.last_name) AS Std_name, c.course_name, 
(
    SELECT SUM(p.amount)
    FROM Payments p
    WHERE p.student_id = s.student_id
) AS total_payment
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.first_name, s.last_name, c.course_name;

--10--
SELECT CONCAT(s.first_name,' ', s.last_name) AS Std_name
FROM Students s
WHERE (
    SELECT COUNT(p.payment_id)
    FROM Payments p
    WHERE p.student_id = s.student_id
) > 1;
--11--
SELECT CONCAT(s.first_name,' ', s.last_name) AS Std_name, SUM(p.amount) AS total_payments
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.first_name,s.last_name;
--12--
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
--13--
SELECT AVG(student_total) AS avg_payment_per_student
FROM (
    SELECT SUM(p.amount) AS student_total
    FROM Payments p
    GROUP BY p.student_id
) AS std_date;


