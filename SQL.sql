-- 1. Create Tablespace
--Create a tablespace called "COURSES" with one datafile of 50Mb, the name of the datafile should be: courses1.dbf

create tablespace COURSES datafile
'courses1.dbf' size 50M
EXTENT MANAGEMENT LOCAL 
SEGMENT SPACE MANAGEMENT AUTO;

-- 2. Create profile
-- Create a profile named "administrativo" with the following specifications: 
-- a) Idle time of 25 minutes 
-- b) Failed login attempts 4 
-- c) Onle one session per user

CREATE PROFILE administrativo LIMIT 
SESSIONS_PER_USER 1
IDLE_TIME 25
FAILED_LOGIN_ATTEMPTS 4;

--3. Create user
-- Create an user named with your github's username (In my case would be amartinezg) 
-- with only 30Mb of space on tablespace, the profile should be "administrativo"

create user AnaK111
identified by 123
default tablespace COURSES
quota 30M on COURSES
profile administrativo;

-- 4. Setting up user
--your user should be able to log in and have DBA privileges

GRANT CONNECT,DBA TO AnaK111;
grant connect, resource to AnaK111;

-- 5. Create 4 tables (LOG IN WITH YOUR USER!!!!!):

-- COURSES(id, name, code, date_start, date_end) 
-- STUDENTS(id, first_name, last_name, date_of_birth, city, address) 
-- ATTENDANCE(id, student_id, course_id, attendance_date)
-- ANSWERS(id, number_of_question, answer)


-- Types of columns:
-- int: id (all tables), attendance(student_id, course_id)  
-- varchar2(255): courses(name, code), students(first_name, last_name, city, address), answers(number_of_question, answer) 
-- date: courses(date_start, date_end), students(date_of_birth), attendance(attendance_date)

--Add these constraints:
--Primary keys for all tables
--Create a sequence with the name "answer_seq" starting in 500 with steps of 10 and associate it with answers table. (Do not use identity columns)
--Name of the courses MUST only accept 'Business and Computing', 'Computer Science', 'Chemistry', 'History' and 'Zoology'
--number_of_question column in answer table MUST only accept values 'QUESTION 1', 'QUESTION 2', 'QUESTION 3', 'QUESTION 4', 'QUESTION 5' (In uppercase)
--Foreign key in attendance table for students and courses.

create table COURSES(
Id int not null,
name varchar2(255) not null,
code varchar2(255) not null,
date_start date,
date_end date,
CONSTRAINT PK_COURSES_Id  PRIMARY KEY(Id),
CONSTRAINT CH_name CHECK (name IN ('Business and Computing', 'Computer Science', 'Chemistry', 'History', 'Zoology')));

create table STUDENTS (
Id int not null,
first_name varchar2(255) not null,
last_name varchar2(255) not null,
date_of_birth date,
city varchar2(255) not null,
address varchar2(255) not null,
CONSTRAINT PK_STUDENTS_Id PRIMARY KEY(Id));

create table ATTENDANCE (
Id int  not null,
student_id int,
course_id int,
attendance_date date,
CONSTRAINT PK_ATTENDANCE_Id PRIMARY KEY(Id),
CONSTRAINT FK_COURSES_Id FOREIGN KEY (course_id) REFERENCES COURSES(Id),
CONSTRAINT FK_STUDENTS_Id FOREIGN KEY (student_id) REFERENCES STUDENTS(Id));

create table ANSWERS (
Id int not null,
number_of_question varchar2(255) not null,
answer varchar2(255) not null,
CONSTRAINT PK_ANSWERS_Id  PRIMARY KEY(Id),
CONSTRAINT CH_number_of_question CHECK (number_of_question IN ('QUESTION 1', 'QUESTION 2', 'QUESTION 3', 'QUESTION 4', 'QUESTION 5')));

--6. Import data

-- Import data from files data/courses.csv, data/students.csv and data/attendance.csv

-- Be careful with the names of the headers on each CSV file and when you import the date the format of the date should be DD/MM/RR




