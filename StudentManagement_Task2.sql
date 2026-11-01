---SQL Data analysis internship Task 2---

---Project: Student Management Database---

Use studentmanagement;

SHOW TABLES;

Select * From students;

----1. Create the Courses Table----

Create table Courses (
ID int Primary Key Auto_increment,
Name Varchar(50) NOT NULL);

INSERT INTO Courses (name)
VALUES
    ('Mathematics'),
    ('Science'),
    ('English'),
    ('Computer Science');
    
SELECT * FROM Courses;

----2. Create the Enrollments Table----

Create Table Enrollments (
   student_id int not null,
   course_id int not null,
   grade decimal (5,2) not null,
   FOREIGN KEY (student_id) REFERENCES Students(StudentID),
FOREIGN KEY (course_id) REFERENCES Courses(id)
);

DESCRIBE Enrollments;


INSERT INTO Enrollments (student_id, course_id, grade)
VALUES
    (1, 1, 92),
    (1, 2, 85),
    (2, 1, 78),
    (2, 3, 88),
    (3, 1, 95),
    (3, 2, 93),
    (3, 4, 98),
    (4, 1, 35),
    (4, 3, 72),
    (5, 2, 79),
    (5, 4, 84),
    (6, 1, 89),
    (6, 2, 94),
    (7, 1, 38),
    (7, 3, 64),
    (8, 2, 80),
    (8, 4, 87),
    (9, 1, 98),
    (9, 2, 96),
    (10, 3, 39);
    
SELECT * FROM Enrollments;

SELECT COUNT(*) AS TotalEnrollments
FROM Enrollments;

----Query 1. List all students enroll in each course----

SELECT 
   s.StudentID,
   s.name as StudentName,
   c.name as CourseName,
   e.Grade as Score
FROM Enrollments e
Inner Join students s
    ON e.student_id = s.StudentID
Inner Join Courses c
    ON e.course_id = c.id
ORDER BY c.name, s.name;

----Query 2. Find average grade per score----

SELECT
    c.id,
    c.name AS CourseName,
    ROUND(AVG(e.grade), 2) AS AverageGrade
FROM Courses c
INNER JOIN Enrollments e
    ON c.id = e.course_id
GROUP BY c.id, c.name
ORDER BY AverageGrade DESC;

----Query 3. Find TOP 3 Students overall---

SELECT
    s.StudentID,
    s.Name AS StudentName,
    COUNT(e.course_id) AS CoursesEnrolled,
    ROUND(AVG(e.grade), 2) AS AverageGrade,
    SUM(e.grade) AS TotalScore
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.student_id
GROUP BY s.StudentID, s.Name
ORDER BY AverageGrade DESC, TotalScore DESC
LIMIT 3;

----Query 4. Count Students who failed (Grdae < 40)

SELECT
    c.name AS CourseName,
    COUNT(*) AS FailedEnrollments
FROM Enrollments e
INNER JOIN Courses c
    ON e.course_id = c.id
WHERE e.grade < 40
GROUP BY c.id, c.name
ORDER BY FailedEnrollments DESC;

SELECT COUNT(DISTINCT student_id) AS StudentsWhoFailed
FROM Enrollments
WHERE grade < 40;