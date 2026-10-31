create table TempInstructor(
 TempID int ,
 TempName VARCHAR(50),
 JoinedDate DATE)
 select* from TempInstructor

 --------------------------

 create table Department(
 DepartmentID int primary key ,
 DepartmentName VARCHAR(100) not null unique)
 select* from Department

-----------------------
 create table Student(
 StudentID int primary key,
 FullName VARCHAR(100) NOT NULL,
 Email VARCHAR(100) UNIQUE,
 GPA DECIMAL(3,2),
 DepID INT foreign key references Department(DepartmentID) )

 select* from Student
 -----------------

 create table  StudentProfile(
 ProfileID INT primary key,
 StuID INT foreign key references Student(StudentID),
 Address VARCHAR(200),
 EmergencyPhone VARCHAR(20))
 select* from StudentProfile

--------------------

create table Course(
CourseID INT primary key, 
CourseName VARCHAR(100) NOT NULL,
Credits INT,
 DepID INT foreign key references Department(DepartmentID))

select* from Course

--------------------------

 create table StudentCourse(
 StuID INT foreign key references Student(StudentID),
 CouID INT foreign key references Course(CourseID),
 EnrollmentDate DATE DEFAULT GETDATE(),
 PRIMARY KEY (StuID, CouID))

 select* from StudentCourse

------------------------------
alter table Student add Age int 
drop table TempInstructor

---------------------------
insert into Department values (1, 'Computer Science'), (2, 'Software Engineering'), (3, 'Business Administration')
insert into Student values 
(101, 'Ali Smadi' , 'ali@coursehub.com', 3.80 , 1 , 22),
(102  , 'Omar Ahmad',  'omar@coursehub.com' , 2.90, 1 , 21),
(103 , 'Laila Hassan' ,'laila@coursehub.com', 3.50 , 2 , 23),
(104 , 'Tariq Zaid' ,'tariq@coursehub.com', 2.10 , 3 ,20)
----------------------
insert into StudentProfile values (1, 101, 'Amman, Jordan', '0791111111'), 
(2, 102, 'Irbid, Jordan', '0792222222'), (3, 103, 'Zarqa, Jordan', '0793333333')

----------------------

insert into Course values (201, 'Database Systems', 3, 1), (202, 'Web Development', 3, 1),
(203, 'Software Architecture', 3, 2)

-----------------------

INSERT INTO StudentCourse (StuID, CouID)
VALUES (101, 201),(101, 202),(102, 201),(103, 203)

-----------------------

update Student set GPA=2.50 where StudentID = 104
delete from Student where StudentID=104

-----------------------

select Student.FullName,Student.GPA,Department.DepartmentName from Student inner
join Department on Student.DepID= Department.DepartmentID

-------------------

SELECT Department.DepartmentName,Student.FullName
FROM Department LEFT JOIN Student
oN Department.DepartmentID = Student.DepID;

----------------------

select Student.FullName,StudentProfile.Address,StudentProfile.EmergencyPhone
from student inner join StudentProfile on
Student.StudentID=StudentProfile.StuID

---------------------

SELECT Student.FullName,Course.CourseName,StudentCourse.EnrollmentDate
FROM Student INNER JOIN StudentCourse ON Student.StudentID = StudentCourse.StuID
INNER JOIN Course ON StudentCourse.CouID = Course.CourseID;

----------------------

select count(StudentID) as TotalStudents FROM Student
select avg(gpa) as AverageGPA  FROM Student
select max(gpa) as AverageGPA  FROM Student
select min(gpa) as AverageGPA  FROM Student

--------------------------

select avg(Student.gpa)as averageGPA ,count(Student.StudentID) as totalStudent FROM Student inner join
Department on Student.DepID=Department.DepartmentID group by DepartmentID

-------------------

select avg(Student.gpa)as averageGPA ,Department.DepartmentID  FROM Student inner join
Department on Student.DepID=Department.DepartmentID group by DepartmentID
having avg (gpa)>3.00

-------------------

select DepID,count(StudentID) as TotalStudent from Student where GPA >= 2.50 group by 
DepID having count(StudentID)>1

------------------

CREATE NONCLUSTERED INDEX IX_Students_Email ON Student(Email)

------------------

select avg(gpa) from Student
select * from Student where gpa>(select avg(gpa) from Student)

-------------------

create view vw_StudentAcademicDetails AS

select Student.StudentID,Student.FullName,Student.GPA, Department.DepartmentName from Student inner
join Department on Student.DepID= Department.DepartmentID

select * from vw_StudentAcademicDetails

---------------------

create Procedure sp_GetStudentsByDepartment
@DeptID INT as begin select * from student where Student.DepID=@DeptID end
EXEC sp_GetStudentsByDepartment @DeptID = 1


 

