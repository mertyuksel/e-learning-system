USE master;
GO

CREATE DATABASE eLearningSystem;
GO

USE eLearningSystem;
GO

CREATE SCHEMA eLearning;
GO

CREATE LOGIN LMSManager 
WITH PASSWORD = 'itsastrongpassword';
GO

CREATE TABLE eLearning.Person(
	ID INT PRIMARY KEY NOT NULL,
	Username NVARCHAR(50) NOT NULL,
	PasswordHash NVARCHAR(255) NOT NULL,
	Email NVARCHAR(255) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Sex NVARCHAR(50),
	Birthdate DATETIME
);

CREATE TABLE eLearning.Instructor(
	ID INT PRIMARY KEY NOT NULL,
	PhoneNumber NVARCHAR(50),
	InstructorRating DECIMAL(2,1)
	CONSTRAINT InsRating CHECK (InstructorRating >= 0 AND InstructorRating <= 5),
	StudentCount INT,
	CourseCount INT, 
	InstructorDetails NVARCHAR(255),
	PersonID INT NOT NULL
);

CREATE TABLE eLearning.Administrator(
	ID INT PRIMARY KEY NOT NULL,
	PermissionTitle NVARCHAR(255) NOT NULL, 
	PersonID INT NOT NULL
);

CREATE TABLE eLearning.Learner(
	ID INT PRIMARY KEY NOT NULL,
	RegistrationDate DATETIME NOT NULL,
	LatestLogon DATETIME NOT NULL,
	PhoneNumber NVARCHAR(50),
	LearnerAddress NVARCHAR(255),
	LearnerDetails NVARCHAR(255),
	PersonID INT NOT NULL
);

CREATE TABLE eLearning.LearnerCourseEnrolment(
	ID INT PRIMARY KEY NOT NULL,
	EnrolmentDate DATETIME NOT NULL,
	CompletionDate DATETIME,
	LearnerID INT NOT NULL,
	CourseID  INT NOT NULL
);

CREATE TABLE eLearning.Orders(
	ID INT PRIMARY KEY NOT NULL,
	OrderDate DATETIME NOT NULL,
	Paid BIT NOT NULL,
    Quantity  INT NULL,
    UnitPrice DECIMAL(4, 2) NULL,
	LearnerID INT NOT NULL
);

CREATE TABLE eLearning.Payment(
	ID INT PRIMARY KEY NOT NULL,
	PaymentDate DATETIME NOT NULL,
	PaymentType NVARCHAR(50) NOT NULL,
	LearnerID INT NOT NULL
);

CREATE TABLE eLearning.Course(
	ID INT PRIMARY KEY NOT NULL,
	CourseName NVARCHAR(255) NOT NULL,
	CourseDescription NVARCHAR(255),
	CoursePrice DECIMAL(8,2) NOT NULL,
	CourseSubjectID INT NOT NULL,
	InstructorID INT NOT NULL
);

CREATE TABLE eLearning.CourseComment(
	ID INT PRIMARY KEY NOT NULL,
	CommentTitle NVARCHAR(255) NOT NULL,
	CommentText NVARCHAR(255),
	LearnerID INT NOT NULL, 
	CourseID INT NOT NULL
);

CREATE TABLE eLearning.CourseSubject(
	ID INT PRIMARY KEY NOT NULL,
	SubjectTitle NVARCHAR(255) NOT NULL,
    CategoryID INT NOT NULL
);

CREATE TABLE eLearning.CourseCategory(
	ID INT PRIMARY KEY NOT NULL,
	CategoryTitle NVARCHAR(255) NOT NULL
);

CREATE TABLE eLearning.Quiz(
	ID INT PRIMARY KEY NOT NULL,
	QuizName NVARCHAR(255),
	QuizPDF NVARCHAR(255),
	QuizDifficulty INT
	CONSTRAINT QDifficulty CHECK (QuizDifficulty >= 0 AND QuizDifficulty <= 3),
	CourseID INT NULL
);

CREATE TABLE eLearning.Feedback(
	ID INT PRIMARY KEY NOT NULL,
	QuizResult INT NOT NULL,
	CorrectAnswerCount INT,
	QuizID INT NOT NULL,
	LearnerID INT NOT NULL
);

CREATE TABLE eLearning.Worksheet(
	ID INT PRIMARY KEY NOT NULL,
	WorksheetName NVARCHAR(255),
	WorksheetPDF  NVARCHAR(255),
	CourseID INT NOT NULL
);


ALTER TABLE eLearning.Instructor
ADD FOREIGN KEY (PersonID) REFERENCES eLearning.Person(ID);

ALTER TABLE eLearning.Administrator
ADD FOREIGN KEY (PersonID) REFERENCES eLearning.Person(ID);

ALTER TABLE eLearning.Learner
ADD FOREIGN KEY (PersonID) REFERENCES eLearning.Person(ID);

ALTER TABLE eLearning.LearnerCourseEnrolment
ADD FOREIGN KEY (LearnerID) REFERENCES eLearning.Learner(ID);

ALTER TABLE eLearning.LearnerCourseEnrolment
ADD FOREIGN KEY (CourseID) REFERENCES eLearning.Course(ID);

ALTER TABLE eLearning.Orders
ADD FOREIGN KEY (LearnerID) REFERENCES eLearning.Learner(ID);

ALTER TABLE eLearning.Payment
ADD FOREIGN KEY (LearnerID) REFERENCES eLearning.Learner(ID);

ALTER TABLE eLearning.Course
ADD FOREIGN KEY (CourseSubjectID) REFERENCES eLearning.CourseSubject(ID);

ALTER TABLE eLearning.Course
ADD FOREIGN KEY (InstructorID) REFERENCES eLearning.Instructor(ID);

ALTER TABLE eLearning.CourseComment
ADD FOREIGN KEY (LearnerID) REFERENCES eLearning.Learner(ID);

ALTER TABLE eLearning.CourseComment
ADD FOREIGN KEY (CourseID) REFERENCES eLearning.Course(ID);

ALTER TABLE eLearning.Worksheet
ADD FOREIGN KEY (CourseID) REFERENCES eLearning.Course(ID);

ALTER TABLE eLearning.Quiz
ADD FOREIGN KEY (CourseID) REFERENCES eLearning.Course(ID);

ALTER TABLE eLearning.Feedback
ADD FOREIGN KEY (QuizID) REFERENCES eLearning.Quiz(ID);

ALTER TABLE eLearning.Feedback
ADD FOREIGN KEY (LearnerID) REFERENCES eLearning.Learner(ID);

ALTER TABLE eLearning.CourseSubject
ADD FOREIGN KEY (CategoryID) REFERENCES eLearning.CourseCategory(ID);