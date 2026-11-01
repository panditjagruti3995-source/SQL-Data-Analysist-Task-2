# SQL-Data-Analysist-Task-2
Student Management Database: Courses &amp; Enrollments Analysis

**Overview**

This project extends the Student Management Database built in Task 1 by adding two new tables, courses and enrollments. It then uses SQL joins, GROUP BY and aggregate functions to analyse student performance by course and to find insights such as the top students and the number of students who failed.

**Objectives**
Extend the existing database with courses and enrollments tables.
Model a one-to-many relationship: one student can enrol in many courses.
Practise JOIN, GROUP BY, AVG, COUNT, ORDER BY and LIMIT.
Think like a data analyst by turning raw records into insights.
Database Schema
Table	Columns	Notes
students	StudentID (PK), Name, Gender, Age, Grade, MathScore, ScienceScore, EnglishScore	From Task 1 (12 students)
courses	id (PK), name	4 courses
enrollments	student_id (FK), course_id (FK), grade	44 records, linking students to courses
students (1) ────< enrollments >──── (1) courses
 StudentID          student_id         id
                    course_id          name
                    grade

enrollments is the link table between students and courses.

**Sample Data**
Courses: Mathematics, Science, English, Computer Science.
Enrollments: each student's Math, Science and English grades come from the Task 1 scores. Computer Science grades for 8 students are added sample data, including two below 40 so that the failure query returns results.
Queries
#	Question	SQL concepts used
1	List all students enrolled in each course	JOIN (3 tables), ORDER BY
2	Find the average grade per course	JOIN, GROUP BY, AVG
3	Find the top 3 students overall	JOIN, GROUP BY, ORDER BY ... DESC, LIMIT
4	Count students who failed (grade < 40)	WHERE, COUNT(DISTINCT ...)
**Query examples**
sql
-- Average grade per course
SELECT c.name AS course_name,
       ROUND(AVG(e.grade), 2) AS avg_grade,
       COUNT(*) AS students_enrolled
FROM enrollments e
JOIN courses c ON e.course_id = c.id
GROUP BY c.name;

-- Top 3 students
SELECT s.Name AS student_name, ROUND(AVG(e.grade), 2) AS avg_grade
FROM enrollments e
JOIN students s ON e.student_id = s.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY avg_grade DESC
LIMIT 3;

-- Students who failed
SELECT COUNT(DISTINCT student_id) AS failed_students
FROM enrollments
WHERE grade < 40;

The full script, including table creation, inserts and all queries, is in task2_queries_student_data.sql.

Results
Analysis	Result
Average grade: Computer Science	69.88 (8 students)
Average grade: English	77.50 (12 students)
Average grade: Mathematics	76.92 (12 students)
Average grade: Science	76.42 (12 students)
Top 3 students	Ananya Iyer (94.00), Isha Kapoor (89.00), Aarav Sharma (88.75)
Students who failed (grade < 40)	2: Rahul Verma (35) and Karan Singh (38), both in Computer Science
Repository Structure
.
├── README.md
├── task2_queries_student_data.sql      # Schema, data and all queries
├── Student_Management_Data.xlsx        # Data and formula-based results in Excel
└── screenshots/                        # Screenshots of each query result
How to Run
Open MySQL, PostgreSQL or an online runner such as DB Fiddle.
Run Steps 1 to 5 of task2_queries_student_data.sql to create and fill the tables. Skip Step 1 if the students table already exists from Task 1.
Run each query (Steps 6 to 9) and check the output against the Results section.
Save a screenshot of each result in the screenshots/ folder.
Key Learnings
Designing table relationships with primary and foreign keys.
Joining three tables to combine student, course and grade data.
Using aggregate functions to summarise data per group.
Using COUNT(DISTINCT ...) so a student who fails several courses is counted once.
Turning query output into insights, such as the weakest course and the top performers.
Tools Used
MySQL / PostgreSQL
DB Fiddle (online SQL runner)
VS Code (for .sql files)
Microsoft Excel (data and formula-based verification)
