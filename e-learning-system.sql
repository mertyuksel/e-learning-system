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

GO
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3350, N'adamsylarx', N'4420d1918bbcf7686defdf9560bb5087d20076de5f77b7cb4c3b40bf46ec428b', N'itstatus@comcast.net', N'Adam', N'Sylar', N'male', CAST(N'1983-09-10T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3351, N'trychness', N'07dbb6e6832da0841dd79701200e4b179f1a94a7b3dd26f612817f3c03117434', N'trcyhines@hotmail.com', N'Tracey', N'Hines', N'female', CAST(N'1987-07-24T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3352, N'gilberttate456', N'11c150eb6c1b776f390be60a0a5933a2a2f8c0a0ce766ed92fea5bfd9313c8f6', N'gilbertate@gmail.com', N'Gilbert', N'Tate', N'male', CAST(N'1999-07-05T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3353, N'tmaek', N'2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824', N'tmaek@gmail.com
', N'Carol ', N'Walsh', N'female', CAST(N'1995-09-08T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3355, N'mcrawfor', N'58756879c05c68dfac9866712fad6a93f8146f337a69afe7dd238f3364946366', N'mcrawfor@comcast.net
', N'Bridget ', N'Mullins', N'male', CAST(N'1993-09-18T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3356, N'seanwrtn', N'c0e81794384491161f1777c232bc6bd9ec38f616560b120fda8e90f383853542', N'seanwrtn@outlook.com', N'Sean ', N'Wright', N'male', CAST(N'2001-04-13T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3359, N'hrldwatson', N'e4ba5cbd251c98e6cd1c23f126a3b81d8d8328abc95387229850952b3ef9f904', N'wikinerd@outlook.com
', N'Harold ', N'Watson', N'male', CAST(N'1981-07-12T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3360, N'twjmmyallen', N'5206b8b8a996cf5320cb12ca91c7b790fba9f030408efe83ebb83548dc3007bd', N'juliajimmy@live.com
', N'Jimmy ', N'Allen', N'male', CAST(N'1990-09-01T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3361, N'joshuawtsnnn', N'08eac03b80adc33dc7d8fbe44b7c7b05d3a2c511166bdb43fcb710b03ba919e7', N'scottlee@optonline.net
', N'Joshua ', N'Watson', N'male', CAST(N'1984-12-24T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3362, N'dashernesss', N'2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824', N'tddjhnsn@gmail.com', N'Todd ', N'Johnson', N'male', CAST(N'1999-06-18T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3365, N'teachyourselfcs12', N'a1e8a70b5ccab1dc2f56bbf7e99f064a6sdfa8e361a35751b9c483c88943d082', N'andreineagoie@outlook.com', N'Andrei', N'Neagoie', N'male', CAST(N'1997-05-18T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3367, N'jacintowong', N'asd8asdfeccafdgr2f56bbf7e99f064a6sdfa8e361a35751b9c483c889438964', N'jacintowong@gmail.com', N'Jacinto', N'Wong', N'male', CAST(N'1990-10-29T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3368, N'bradtrvsy', N'werr8a70b5ccafdgr2f56bbf7e99f064a6sdfa8e361a35751b9c483c889439875', N'bradtraversy@outlook.com', N'Brad', N'Traversy', N'male', CAST(N'1986-05-09T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3370, N'andrwmead', N'7894a70b5ccafdgr2f56bbf7e99f064a6sdfa8e361a35751b9c4845s6d7f8e12', N'andrew.mead@outlook.com', N'Andrew', N'Mead', N'male', CAST(N'1981-03-07T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3372, N'edwindiaz', N'aerty5b5ccafdgr2f56bbf7e99f064a6sdfa8e361a35751b9c4845s6d7124df', N'edwin_diaz@outlook.com', N'Edwin', N'Diaz', N'male', CAST(N'1982-07-15T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3373, N'robbin', N'serwe5b5ccafdgr2f56bbf7e99f064a6sdfa8e456456as4ds5a45asd5', N'rob.merril@gmail.com', N'Robb', N'Merril', N'male', CAST(N'1992-04-18T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3374, N'jckdase', N'aa6s5das9g5b5ccafdgr2f56bbf7e99f064a6sdfa8e456456as4ds5a45asd5', N'jckdase@gmail.com', N'Jack', N'Dase', N'male', CAST(N'1986-06-19T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3376, N'danielms', N'78a95das9g5b5ccafdgr2f56bbf7e99f064a6sdfa8e456456as4963261568', N'danielmsk@gmail.com', N'Daniel', N'Molly', N'male', CAST(N'1987-05-13T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3378, N'smthnwen', N'd1e8a70b5ccab1dc2f56bbf7e99f064a660c08e361a35751b9c483c88943d082
', N'smthnask@gmail.com', N'Samantha', N'Wendy', N'female', CAST(N'1998-03-13T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3379, N'sallywnd', N'a1e8a70b5ccadsac2f56bbsdawesf064a660c08e361a35751b9c483c88943d456', N'sallyruth@gmail.com', N'Sally', N'Ruth', N'female', CAST(N'1987-05-14T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3381, N'austin254', N'458596ab5ccab1dc2f56bbf7e789sad54a60c08e361a35751b9c483c8894125486', N'blakeaustin@gmail.com', N'Austin', N'Blake', N'male', CAST(N'1988-07-17T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3382, N'ChrisAllen', N'ada98a6ab5ccab1dc2f56bbf7e789sad54a60c08e361a3adasdsadas3c889414564ad8', N'chrisalan@gmail.com', N'Christian', N'Allen', N'male', CAST(N'1995-12-10T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3383, N'davidion', N'9a8sda98a6ab5ccab1dc2f54as6d54sa89sad54a60c08e361a3adasdsadas3c88asdasdsada', N'David.ian@hotmail.com', N'David', N'Ian', N'male', CAST(N'1986-10-31T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3384, N'ravidnor54', N'asdasdsda98a6ab5ccab1dc2adsadsa89sad54a60c08e361a3adas3c88asdc65da', N'ravinder.deol@hotmail.com', N'Ravinder', N'Deol', N'male', CAST(N'1982-07-14T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3385, N'brad785', N'afd2gf6ds6d5as4d65asd5a4s65d4sadsfd4f8d4f8sd1fh1gfdv51b', N'bradley.cs@gmail.com', N'Brad', N'Hussey', N'male', CAST(N'1985-02-01T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3386, N'austinbatch', N'a659efh2vcfdtr8e65sdfg59ec3bsf51f6ge9s4g5fdg6s', N'austin.batchelor@gmail.com', N'Austin', N'Batchelor', N'male', CAST(N'1980-05-01T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3388, N'tmsmrck', N'asda85454sd9efh2vcfdtr8e65sdfg59ec3bsf51f6ge9s4g5fdg6s', N'tomas.moravek@gmail.com', N'Tomas ', N'Moravek', N'male', CAST(N'1985-03-05T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3396, N'len456', N'598as565a6s4d8a97da8sasas54das8da635s4d', N'lensmith@gmail.com', N'Len', N'Smith', N'male', CAST(N'1982-05-14T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3397, N'flxhhrder', N'11a4a60b518bf24989d481468076e5d5982884626aed9faeb35b8576fcd223e1', N'felixharder@outlook.com', N'Felix', N'Harder', N'male', CAST(N'1999-04-01T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3398, N'jckwlsn', N'789a5sb518bf24989d481468076e5d5982884626aed9faeb35b8576fcd963as4', N'jackkwlson@gmail.com', N'Jack', N'Wilson', N'male', CAST(N'1998-06-05T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3399, N'hironakamura', N'aa8sd54a3s2d1sf56as1f65as1fsa5a4d8wa5', N'kevinhart@gmail.com', N'Kevin', N'Hart', N'male', CAST(N'1979-07-06T00:00:00.000' AS DateTime))
INSERT [eLearning].[Person] ([ID], [Username], [PasswordHash], [Email], [FirstName], [LastName], [Sex], [Birthdate]) VALUES (3400, N'markxx299', N's68q9d5a321c4d6a8r7a5s1a65', N'marksylar@gmail.com', N'Mark', N'Sylar', N'male', CAST(N'1999-07-05T00:00:00.000' AS DateTime))


GO
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4512, N'(+90)314 965 23 01', CAST(4.8 AS Decimal(2, 1)), 62548, 5, N'Hi, I am Sean! I have been identified as one of Udemys Top Instructors and all my premium courses have recently earned the best-selling status for outstanding performance and student satisfaction.', 3356)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4514, N'(+90)534 812 22 71', CAST(4.9 AS Decimal(2, 1)), 15000, 1, N'Andrei is the instructor of the highest rated Development courses on Udemy as well as one of the fastest growing.', 3365)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4515, N'(+90)532 782 12 17', CAST(4.8 AS Decimal(2, 1)), 250, 1, N'Jacinto is a Senior Developer with the Canadian Broadcasting Corporation with a diverse background, including 5 years experience as a teacher in Canada and South Korea.', 3367)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4518, N'(+90)535 489 96 96', CAST(4.0 AS Decimal(2, 1)), 1503, 1, N'Brad Traversy has been programming for around 12 years and teaching for almost 5 years.', 3368)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4519, N'(+90)535 848 92 45', CAST(4.5 AS Decimal(2, 1)), 4253, 4, N'Professionally, I am a Data Science management consultant with over five years of experience in finance, retail, transport and other industries.', 3376)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4520, N'(+90)524 879 96 65', CAST(4.9 AS Decimal(2, 1)), 25354, 6, N'Hi! I''m Samantha. I have a degree in Mathematics from Cambridge University and you might call me a bit of coding geek.', 3378)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4521, N'(+90)547 632 45 65', CAST(4.9 AS Decimal(2, 1)), 6789, 1, N'I am a qualified teacher and I have been teaching game design for over 6 years. I have been using Unity since 2013 and I have produced a series of courses showing people how to create games and animations using this game engine.', 3379)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4522, N'(+90)563 489 96 45', CAST(4.5 AS Decimal(2, 1)), 4562, 2, N'Hi.  I''m Austin Blake. I have the most comprehensive range of on-line courses based on emotional intelligence in business - not only on Udemy but anywhere on the internet.', 3381)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4524, N'(+90)564 548 98 63', CAST(4.9 AS Decimal(2, 1)), 6598, 1, N'Through working with students from many different schools, Mr. Steele has learned best practices for helping people understand accounting fast. ', 3383)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4525, N'(+90)546 879 85 21', CAST(4.5 AS Decimal(2, 1)), 500, 2, N'I was born in England and left school at 16. I founded a company which has reached over 100,000 people. ', 3384)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4526, N'(+90)556 874 54 78', CAST(4.6 AS Decimal(2, 1)), 1500, 1, N'A highly skilled professional, Brad Hussey is a passionate and experienced freelancing web designer, developer, blogger and digital entrepreneur.', 3385)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4527, N'(+90)555 658 43 25', CAST(4.8 AS Decimal(2, 1)), 3578, 1, N'Hi! I''m Austin. I''m a developer with a serious love for teaching.', 3386)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4528, N'(+90)534 798 45 65', CAST(4.4 AS Decimal(2, 1)), 7894, 2, N'I’m Tomas Moravek, award winning Prague based digital marketer, and I’m here on Udemy to help you to MASTER the strategies of SEO, Social Media & Digital Marketing. So, you can slash yours spend while supercharging your results.', 3388)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4529, N'(+90)536 648 85 96', CAST(4.4 AS Decimal(2, 1)), 10545, 3, N'For the past 20 odd years Len has run his own business, Copywriting On Demand and manages The-Writers-Guru.', 3396)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4530, N'(+90)530 879 96 45', CAST(4.9 AS Decimal(2, 1)), 12599, 1, N'I’m a certified coach and author. Over the years I''ve worked with and coached 20,000 students from all over the world.', 3397)
INSERT [eLearning].[Instructor] ([ID], [PhoneNumber], [InstructorRating], [StudentCount], [CourseCount], [InstructorDetails], [PersonID]) VALUES (4531, N'(+90)524 364 89 78', CAST(4.9 AS Decimal(2, 1)), 5469, 1, N'Jack is a CPT (certified personal trainer) with 10 years of experience in the health and fitness industry. He was formerly almost 50 pounds overweight, before choosing to pursue a healthier lifestyle transformed him.', 3398)


GO
INSERT [eLearning].[Administrator] ([ID], [PermissionTitle], [PersonID]) VALUES (5063, N'All', 3351)
INSERT [eLearning].[Administrator] ([ID], [PermissionTitle], [PersonID]) VALUES (5065, N'View', 3353)
INSERT [eLearning].[Administrator] ([ID], [PermissionTitle], [PersonID]) VALUES (5066, N'All', 3359)


GO
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5060, CAST(N'2019-05-20T00:00:00.000' AS DateTime), CAST(N'2020-12-19T00:00:00.000' AS DateTime), N'(+90)534 665 12 77 ', NULL, NULL, 3370)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5063, CAST(N'2017-12-25T00:00:00.000' AS DateTime), CAST(N'2020-01-05T00:00:00.000' AS DateTime), N'(+90)532 272 56 91 ', NULL, NULL, 3372)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5065, CAST(N'2020-01-20T00:00:00.000' AS DateTime), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'(+90)548 362 94 42', NULL, NULL, 3373)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5066, CAST(N'2017-05-14T00:00:00.000' AS DateTime), CAST(N'2019-06-23T00:00:00.000' AS DateTime), N'(+90)565 789 44 12', NULL, NULL, 3374)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5068, CAST(N'2016-03-20T00:00:00.000' AS DateTime), CAST(N'2020-07-20T00:00:00.000' AS DateTime), N'(+90)598 415 89 74', NULL, NULL, 3352)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5070, CAST(N'2017-01-10T00:00:00.000' AS DateTime), CAST(N'2017-02-14T00:00:00.000' AS DateTime), N'(+90)535 489 96 96 ', NULL, NULL, 3355)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5072, CAST(N'2020-09-24T00:00:00.000' AS DateTime), CAST(N'2020-12-20T00:00:00.000' AS DateTime), N'(+90)525 789 85 45', NULL, NULL, 3360)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5074, CAST(N'2016-02-12T00:00:00.000' AS DateTime), CAST(N'2020-10-15T00:00:00.000' AS DateTime), N'(+90)542 459 66 56', NULL, NULL, 3361)
INSERT [eLearning].[Learner] ([ID], [RegistrationDate], [LatestLogon], [PhoneNumber], [LearnerAddress], [LearnerDetails], [PersonID]) VALUES (5075, CAST(N'2019-01-03T00:00:00.000' AS DateTime), CAST(N'2020-05-01T00:00:00.000' AS DateTime), N'(+90)589 779 56 74', NULL, NULL, 3362)


GO
INSERT [eLearning].[Payment] ([ID], [PaymentDate], [PaymentType], [LearnerID]) VALUES (7605, CAST(N'2020-10-05T00:00:00.000' AS DateTime), N'Debit Card', 5060)
INSERT [eLearning].[Payment] ([ID], [PaymentDate], [PaymentType], [LearnerID]) VALUES (7606, CAST(N'2020-10-01T00:00:00.000' AS DateTime), N'Credit Card', 5063)
INSERT [eLearning].[Payment] ([ID], [PaymentDate], [PaymentType], [LearnerID]) VALUES (7607, CAST(N'2020-09-25T00:00:00.000' AS DateTime), N'Credit Card', 5065)
INSERT [eLearning].[Payment] ([ID], [PaymentDate], [PaymentType], [LearnerID]) VALUES (7608, CAST(N'2020-08-20T00:00:00.000' AS DateTime), N'Credit Card', 5066)
INSERT [eLearning].[Payment] ([ID], [PaymentDate], [PaymentType], [LearnerID]) VALUES (7609, CAST(N'2020-07-05T00:00:00.000' AS DateTime), N'Debit Card', 5060)
INSERT [eLearning].[Payment] ([ID], [PaymentDate], [PaymentType], [LearnerID]) VALUES (7610, CAST(N'2020-05-04T00:00:00.000' AS DateTime), N'Debit Card', 5068)
INSERT [eLearning].[Payment] ([ID], [PaymentDate], [PaymentType], [LearnerID]) VALUES (7614, CAST(N'2020-04-02T00:00:00.000' AS DateTime), N'Credit Card', 5063)


GO
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6451, CAST(N'2020-10-05T00:00:00.000' AS DateTime), 1, 1, CAST(35.00 AS Decimal(4, 2)) ,5060)
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6454, CAST(N'2020-10-01T00:00:00.000' AS DateTime), 1, 2, CAST(35.00 AS Decimal(4, 2)) ,5063)
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6456, CAST(N'2020-09-25T00:00:00.000' AS DateTime), 1, 1, CAST(35.00 AS Decimal(4, 2)) ,5065)
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6458, CAST(N'2020-08-20T00:00:00.000' AS DateTime), 1, 1, CAST(35.00 AS Decimal(4, 2)) ,5066)
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6459, CAST(N'2020-07-05T00:00:00.000' AS DateTime), 1, 4, CAST(35.00 AS Decimal(4, 2)) ,5060)
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6460, CAST(N'2020-05-04T00:00:00.000' AS DateTime), 1, 2, CAST(35.00 AS Decimal(4, 2)) ,5068)
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6461, CAST(N'2020-04-03T00:00:00.000' AS DateTime), 0, 2, CAST(35.00 AS Decimal(4, 2)) ,5070)
INSERT [eLearning].[Orders] ([ID], [OrderDate], [Paid], [Quantity], [UnitPrice], [LearnerID]) VALUES (6463, CAST(N'2020-04-02T00:00:00.000' AS DateTime), 1, 2, CAST(35.00 AS Decimal(4, 2)) ,5063)


GO
INSERT [eLearning].[CourseCategory] ([ID], [CategoryTitle]) VALUES (9315, N'Development')
INSERT [eLearning].[CourseCategory] ([ID], [CategoryTitle]) VALUES (9316, N'Business')
INSERT [eLearning].[CourseCategory] ([ID], [CategoryTitle]) VALUES (9317, N'Finance & Accounting')
INSERT [eLearning].[CourseCategory] ([ID], [CategoryTitle]) VALUES (9318, N'Design')
INSERT [eLearning].[CourseCategory] ([ID], [CategoryTitle]) VALUES (9319, N'Marketing')
INSERT [eLearning].[CourseCategory] ([ID], [CategoryTitle]) VALUES (9320, N'Music')
INSERT [eLearning].[CourseCategory] ([ID], [CategoryTitle]) VALUES (9321, N'Health & Fitness')


GO
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8881, N'Web Development', 9315)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8882, N'Data Science', 9315)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8883, N'Mobile Development', 9315)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8884, N'Game Development', 9315)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8885, N'Software Testing', 9315)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8886, N'Entrepreneurship', 9316)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8887, N'Project Management', 9316)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8888, N'Human Resources', 9316)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8892, N'Accounting', 9317)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8893, N'Taxes', 9317)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8895, N'Investing', 9317)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8896, N'Web Design', 9318)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8897, N'Game Design', 9318)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8903, N'Advertising', 9319)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8904, N'Content Marketing', 9319)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8907, N'Fitness', 9321)
INSERT [eLearning].[CourseSubject] ([ID], [SubjectTitle], [CategoryID]) VALUES (8909, N'Dieting', 9321)


GO
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9007, N'The Web Development Bootcamp', N'Hi! Welcome to the brand new version of The Web Developer Bootcamp, Udemy''s most popular web development course.  This course was just completely overhauled to prepare students for the 2021 job market, with over 60 hours of brand new content. ', CAST(35.00 AS Decimal(8, 2)), 8881, 4512)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9010, N'Data Science and Machine Learning Bootcamp', N'This comprehensive course will be your guide to learning how to use the power of Python to analyze data, create beautiful visualizations, and use powerful machine learning algorithms!', CAST(35.00 AS Decimal(8, 2)), 8882, 4519)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9011, N'Make a horror survival game in Unity
', N'Do you want to create a professional looking horror survival game in Unity? Well you''ve found the right course. This is aimed at anybody who loves game design and wants to make awesome games.', CAST(35.00 AS Decimal(8, 2)), 8883, 4520)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9013, N'Selenium WebDriver with Java -Basics to Advanced+Frameworks
', N'On course completion You will be Mastered in Selenium Automation Testing and implementing Successfully in your work place or you will land on High Paying Job 

', CAST(35.00 AS Decimal(8, 2)), 8885, 4521)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9014, N'The Complete Business Plan Course ', N'Welcome to the Complete Business Plan Course, which will help you make an incredible business plan from scratch.', CAST(35.00 AS Decimal(8, 2)), 8886, 4518)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9015, N'PMP Exam Prep Seminar - Pass the PMP on Your First Attempt
', N'Join the thousands of others who''ve completed this top-rated course and passed their PMP exam. You can do this!', CAST(35.00 AS Decimal(8, 2)), 8887, 4515)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9016, N'Conflict Management with Emotional Intelligence
', N'Conflict and disagreements are a natural part of everyday life as there is not enough of what everyone wants to go around.  Conflict occurs over money, goods, services, power, possessions, time, and much more.

', CAST(35.00 AS Decimal(8, 2)), 8888, 4514)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9017, N'Introduction to Finance, Accounting, Modeling and Valuation
', N'After taking this course you will understand how to create, analyze and forecast an income statement, balance sheet and cash flow statement. ', CAST(35.00 AS Decimal(8, 2)), 8892, 4522)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9019, N'Tax Preparation and Law 2021, 2020, 2019 & 2018 - Income Tax
', N'We will discuss the concept of filing status and dependents and how they affect the tax formula.

', CAST(35.00 AS Decimal(8, 2)), 8893, 4524)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9021, N'Bitcoin Investing: The Complete Buy & Hold Strategy
', N'Bitcoin Investing: The Complete Buy & Hold Strategy, is the most comprehensive Bitcoin investing course you’ll find on the internet.', CAST(35.00 AS Decimal(8, 2)), 8895, 4525)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9022, N'WordPress Theme Development with Bootstrap
', N'Whether you''re a freelance designer, entrepreneur, employee for a company, code hobbyist, or looking for a new career — this course gives you an immensely valuable skill that will enable you to either:

', CAST(35.00 AS Decimal(8, 2)), 8896, 4526)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9024, N'Photorealistic Digital Painting From Beginner To Advanced.
', N'Do you want to learn how to digitally paint images for games and film like an industry pro? Or maybe you’re wanting to branch out and try a new painting style? In any case you’ve come to the right place.', CAST(35.00 AS Decimal(8, 2)), 8897, 4527)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9027, N'The Complete Facebook Traffic Ads', N'Hi, it''s Ing. Tomas Moravek, Internet Efficiency Award Winner and Digital Strategist with my brand new course, your COMPLETE MASTERY GUIDE TO FACEBOOK CPC TRAFFIC ADS.', CAST(35.00 AS Decimal(8, 2)), 8903, 4528)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9035, N'Copywriting - Become a Freelance Copywriter, your own boss
', N'Just imagine, earning your living - a good living - without the hassle of commuting. Be your own boss. All you really need is a PC or Mac and a broadband connection - plus a desire to write and a bit of flair.  ', CAST(35.00 AS Decimal(8, 2)), 8904, 4529)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9036, N'Complete Fitness Trainer Certification: Beginner To Advanced
', N'Hi, I''m Felix Harder fitness coach and certified nutritionist. My "Complete Fitness Trainer Certification" is designed for anyone who wants to coach others about fitness training - be it cardio, strength training or flexibility.

', CAST(35.00 AS Decimal(8, 2)), 8907, 4530)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9037, N'The Fastest Way to Lose Belly Fat
', N'Exercise and eating right can save you tens or HUNDREDS of thousands of dollars of the years on doctors appointments, physical therapists, medications, and even surgeries.

', CAST(35.00 AS Decimal(8, 2)), 8909, 4531)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9046, N'Angular - The Complete Guide ', N'Angular 11 simply is the latest version of Angular 2, you will learn this amazing framework from the ground up in this course!

', CAST(35.00 AS Decimal(8, 2)), 8881, 4512)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9047, N'Build Responsive Real World Websites with HTML5 and CSS3
', N'The easiest way to learn modern web design, HTML5 and CSS3 step-by-step from scratch. Design AND code a huge project.
', CAST(35.00 AS Decimal(8, 2)), 8881, 4512)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9048, N'JavaScript: Understanding the Weird Parts
', N'An advanced JavaScript course for everyone! Scope, closures, prototypes, ''this'', build your own framework, and more.
', CAST(35.00 AS Decimal(8, 2)), 8881, 4512)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9049, N'The Complete ASP.NET MVC 5 Course
', N'Learn to build fast and secure web applications with ASP.NET MVC 5 - The most popular course with 40,000+ students!
', CAST(35.00 AS Decimal(8, 2)), 8881, 4512)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9050, N'iOS & Swift - The Complete iOS App Development Bootcamp
', N'From Beginner to iOS App Developer with Just One Course! Fully Updated with a Comprehensive Module Dedicated to SwiftUI!
', CAST(35.00 AS Decimal(8, 2)), 8883, 4520)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9051, N'The Complete Android N Developer Course
', N'Learn Android App Development with Android 7 Nougat by building real apps including Uber, Whatsapp and Instagram!
', CAST(35.00 AS Decimal(8, 2)), 8883, 4520)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9052, N'Ionic - Build iOS, Android & Web Apps with Ionic & Angular
', N'Build Native iOS & Android as well as Progressive Web Apps with Angular, Capacitor and the Ionic Framework (Ionic 4+).
', CAST(35.00 AS Decimal(8, 2)), 8883, 4520)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9053, N'The Complete iOS 10 & Swift 3 Developer Course
', N'Learn iOS App Development by building 21 iOS apps using Swift 3 & Xcode 8. Includes free web hosting, assets & ebook.
', CAST(35.00 AS Decimal(8, 2)), 8883, 4520)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9054, N'iOS 9 and Swift 2: From Beginner to Paid Professional™
', N'The BEST online iOS 9 Swift 2 course online. Lets learn iOS 9 & Swift 2
', CAST(35.00 AS Decimal(8, 2)), 8883, 4520)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9056, N'Machine Learning A-Z™: Hands-On Python & R In Data Science
', N'Learn to create Machine Learning Algorithms in Python and R from two Data Science experts. Code templates included.
', CAST(35.00 AS Decimal(8, 2)), 8882, 4519)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9057, N'Deep Learning A-Z™: Hands-On Artificial Neural Networks
', N'Learn to create Deep Learning Algorithms in Python from two Machine Learning & Data Science experts. Templates included.
', CAST(35.00 AS Decimal(8, 2)), 8882, 4519)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9058, N'R Programming A-Z™: R For Data Science With Real Exercises!
', N'Learn Programming In R And R Studio. Data Analytics, Data Science, Statistical Analysis, Packages, Functions, GGPlot2
', CAST(35.00 AS Decimal(8, 2)), 8882, 4519)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9059, N'Accounting: From Beginner to Advanced!
', N'Learn accounting like never before. Learn easy and fast. Easy to understand Accounting. #1 accounting course online.
', CAST(35.00 AS Decimal(8, 2)), 8892, 4522)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9061, N'2020 New Google Ads (AdWords) Course - From Beginner to PRO
', N'Updated December 2020: Google Ads (AdWords) Step-by-Step Course to help you Succeed with Search, Display & Remarketing.
', CAST(35.00 AS Decimal(8, 2)), 8903, 4528)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9062, N'Content Marketing Masterclass: Create Content That Sells
', N'Master content marketing to grow your business: content creation, promotion, copywriting, SEO, email marketing, & more!
', CAST(35.00 AS Decimal(8, 2)), 8904, 4529)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9063, N'Viral Blogging 101: Blogging & Content Writing Masterclass
', N'Step-by-step blogging & content writing guide. Go from blank page to viral blog post. Become a blogging & writing pro.
', CAST(35.00 AS Decimal(8, 2)), 8904, 4529)
INSERT [eLearning].[Course] ([ID], [CourseName], [CourseDescription], [CoursePrice], [CourseSubjectID], [InstructorID]) VALUES (9066, N'Investing In Stocks The Complete Course! (11 Hour)
', N'Master Investing in the Stock Market with Stocks, Mutual Funds, ETF, from a Top Instructor & Millionaire Stock Portfolio
', CAST(35.00 AS Decimal(8, 2)), 8895, 4525)

GO
INSERT [eLearning].[LearnerCourseEnrolment] ([ID], [EnrolmentDate], [CompletionDate], [LearnerID], [CourseID]) VALUES (15000, CAST(N'2020-10-05T00:00:00.000' AS DateTime), CAST(N'2020-12-01T00:00:00.000' AS DateTime), 5060, 9007)
INSERT [eLearning].[LearnerCourseEnrolment] ([ID], [EnrolmentDate], [CompletionDate], [LearnerID], [CourseID]) VALUES (15001, CAST(N'2020-10-01T00:00:00.000' AS DateTime), CAST(N'2020-11-02T00:00:00.000' AS DateTime), 5063, 9010)
INSERT [eLearning].[LearnerCourseEnrolment] ([ID], [EnrolmentDate], [CompletionDate], [LearnerID], [CourseID]) VALUES (15002, CAST(N'2020-09-25T00:00:00.000' AS DateTime), NULL, 5065, 9011)
INSERT [eLearning].[LearnerCourseEnrolment] ([ID], [EnrolmentDate], [CompletionDate], [LearnerID], [CourseID]) VALUES (15003, CAST(N'2020-09-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T00:00:00.000' AS DateTime), 5066, 9013)
INSERT [eLearning].[LearnerCourseEnrolment] ([ID], [EnrolmentDate], [CompletionDate], [LearnerID], [CourseID]) VALUES (15004, CAST(N'2020-07-05T00:00:00.000' AS DateTime), CAST(N'2020-12-20T00:00:00.000' AS DateTime), 5060, 9014)
INSERT [eLearning].[LearnerCourseEnrolment] ([ID], [EnrolmentDate], [CompletionDate], [LearnerID], [CourseID]) VALUES (15005, CAST(N'2020-05-04T00:00:00.000' AS DateTime), NULL, 5068, 9015)
INSERT [eLearning].[LearnerCourseEnrolment] ([ID], [EnrolmentDate], [CompletionDate], [LearnerID], [CourseID]) VALUES (15006, CAST(N'2020-04-02T00:00:00.000' AS DateTime), NULL, 5063, 9016)


GO
INSERT [eLearning].[CourseComment] ([ID], [CommentTitle], [CommentText], [LearnerID], [CourseID]) VALUES (20120, N'Perfect course!!', N'It was so challenging and full of knowledge! I have learned a lot from this course. Colt is the best instructor, respect! He explains everything that way so you get it instantly.', 5060, 9007)
INSERT [eLearning].[CourseComment] ([ID], [CommentTitle], [CommentText], [LearnerID], [CourseID]) VALUES (20121, N'Challenging course', N'This is an amazing course for the beginners who want to understand about everything in machine learning. ', 5063, 9010)
INSERT [eLearning].[CourseComment] ([ID], [CommentTitle], [CommentText], [LearnerID], [CourseID]) VALUES (20122, N'Took me 8 weeks', N'I wanted to make a video game, because it''s practically all my kiddos play or talk about and I thought it''d be a fun way to understand their world.', 5065, 9011)
INSERT [eLearning].[CourseComment] ([ID], [CommentTitle], [CommentText], [LearnerID], [CourseID]) VALUES (20123, N'Very helpful', N'I have successfully finished the course, i would like to extend my gratitude for Mr.Rahul for providing this course with a neat explanation on real time scenarios also the course was well structured without missing any concept with a good presentation.', 5066, 9013)
INSERT [eLearning].[CourseComment] ([ID], [CommentTitle], [CommentText], [LearnerID], [CourseID]) VALUES (20124, N'Not enough', N'I am sorry i could not endure going through the entire lesson. It is so stressful listening to it', 5060, 9014)
INSERT [eLearning].[CourseComment] ([ID], [CommentTitle], [CommentText], [LearnerID], [CourseID]) VALUES (20125, N'Recommend you', N'I like the course and it cleared many things as I did the exercises.', 5068, 9015)
INSERT [eLearning].[CourseComment] ([ID], [CommentTitle], [CommentText], [LearnerID], [CourseID]) VALUES (20126, N'Insightful', N'I found this to be an insightful and easy to follow process. I have a much better understanding of my own personality and how I interact with conflict, as well as, understanding how to better adapt in the workplace when conflict is present.', 5063, 9016)


GO
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15000, N'The Web Development Bootcamp Worksheet', N'TWDBworksheet.pdf', 9007)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15001, N'Data Science and Machine Learning Bootcamp', N'datasciencecourse.pdf', 9010)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15002, N'Make a horror survival game in Unity
', N'createunitygame.pdf', 9011)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15003, N'Selenium WebDriver with Java -Basics to Advanced+Frameworks
', N'selenium.pdf', 9013)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15004, N'The Complete Business Plan Course ', N'businesscourse.pdf', 9014)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15005, N'PMP Exam Prep Seminar - Pass the PMP on Your First Attempt
', N'examprep.pdf', 9015)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15006, N'Conflict Management with Emotional Intelligence
', N'conflictmanagement.pdf', 9016)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15007, N'Introduction to Finance, Accounting, Modeling and Valuation
', N'introtofinance.pdf', 9017)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15008, N'Tax Preparation and Law 2021, 2020, 2019 & 2018 - Income Tax
', N'taxprep.pdf', 9019)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15009, N'Bitcoin Investing: The Complete Buy & Hold Strategy
', N'bitcoininvesting.pdf', 9021)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15010, N'WordPress Theme Development with Bootstrap
', N'wordpresstheme.pdf', 9022)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15011, N'Photorealistic Digital Painting From Beginner To Advanced.
', N'photorealisticdigital.pdf', 9024)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15012, N'The Complete Facebook Traffic Ads', N'facebooktraficads.pdf', 9027)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15013, N'Copywriting - Become a Freelance Copywriter, your own boss
', N'copywritingcourse.pdf', 9035)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15014, N'Complete Fitness Trainer Certification: Beginner To Advanced
', N'completefitness.pdf', 9036)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15015, N'The Fastest Way to Lose Belly Fat
', N'fastestwaytoloseweight.pdf', 9037)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15016, N'Angular - The Complete Guide ', N'angularcompletecourse.pdfq', 9046)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15017, N'Build Responsive Real World Websites with HTML5 and CSS3
', N'responsivewebsites.pdf', 9047)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15018, N'JavaScript: Understanding the Weird Parts
', N'jsunderstandtheweirdparts.pdf', 9048)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15019, N'The Complete ASP.NET MVC 5 Course
', N'completeasp.pdf', 9049)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15020, N'iOS & Swift - The Complete iOS App Development Bootcamp
', N'iosswiftcompletecourse.pdf', 9050)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15021, N'The Complete Android N Developer Course
', N'completeandroiddevelopment.pdf', 9051)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15022, N'Ionic - Build iOS, Android & Web Apps with Ionic & Angular
', N'ionicbuildios.pdf', 9052)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15023, N'The Complete iOS 10 & Swift 3 Developer Course
', N'comleteios.pdf', 9053)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15024, N'iOS 9 and Swift 2: From Beginner to Paid Professional™
', N'ios9.pdf', 9054)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15025, N'Machine Learning A-Z™: Hands-On Python & R In Data Science
', N'machinelearning.pdf', 9056)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15026, N'Deep Learning A-Z™: Hands-On Artificial Neural Networks
', N'deeplearning.pdf', 9057)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15027, N'R Programming A-Z™: R For Data Science With Real Exercises!
', N'rprogramming.pdf', 9058)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15028, N'Accounting: From Beginner to Advanced!
', N'accountingbeginnertoadvanced.pdf', 9059)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15029, N'2020 New Google Ads (AdWords) Course - From Beginner to PRO
', N'googleadvertisement.pdf', 9061)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15030, N'Content Marketing Masterclass: Create Content That Sells
', N'contentmarketing.pdf', 9062)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15031, N'Viral Blogging 101: Blogging & Content Writing Masterclass
', N'viralblogging.pdf', 9063)
INSERT [eLearning].[Worksheet] ([ID], [WorksheetName], [WorksheetPDF], [CourseID]) VALUES (15032, N'Investing In Stocks The Complete Course! (11 Hour)
', N'investinginstocs.pdf', 9066)


GO
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10252, N'The Web Development Bootcamp Quiz ', N'twdb_quiz.pdf', 3, 9007)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10253, N'Data Science and Machine Learning Bootcamp', N'datascience_quiz.pdf', 3, 9010)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10254, N'Make a horror survival game in Unity
', N'unitygame_quiz.pdf', 1, 9011)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10255, N'Selenium WebDriver with Java -Basics to Advanced+Frameworks
', N'seleniumcourse_quiz.pdf', 3, 9013)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10256, N'The Complete Business Plan Course ', N'competebusiness_quiz.pdf', 2, 9014)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10257, N'PMP Exam Prep Seminar - Pass the PMP on Your First Attempt
', N'pmpexam.pdf', 2, 9015)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10258, N'Conflict Management with Emotional Intelligence
', N'conflictmanagement.pdf', 3, 9016)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10259, N'Introduction to Finance, Accounting, Modeling and Valuation
', N'introtofinance_quiz.pdf', 2, 9017)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10260, N'Tax Preparation and Law 2021, 2020, 2019 & 2018 - Income Tax
', N'taxprep_quiz.pdf', 2, 9019)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10261, N'Bitcoin Investing: The Complete Buy & Hold Strategy
', N'bitcoincourse_quiz.pdf', 3, 9021)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10262, N'WordPress Theme Development with Bootstrap
', N'wordpresscourse_quiz.pdf', 2, 9022)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10263, N'Photorealistic Digital Painting From Beginner To Advanced.
', N'photorealisticcourse_quiz.pdf', 3, 9024)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10264, N'The Complete Facebook Traffic Ads', N'facebooktrafficads_quiz.pdf', 2, 9027)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10265, N'Copywriting - Become a Freelance Copywriter, your own boss
', N'copywriting_quiz.pdf', 3, 9035)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10266, N'Complete Fitness Trainer Certification: Beginner To Advanced
', N'completefitnesstrainer_quiz.pdf', 2, 9036)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10267, N'The Fastest Way to Lose Belly Fat
', N'losebellyfat_quiz.pdf', 2, 9037)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10268, N'Angular - The Complete Guide ', N'angularcourse_quiz.pdf', 2, 9046)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10269, N'Build Responsive Real World Websites with HTML5 and CSS3
', N'responsivewebsite_quiz.pdf', 3, 9047)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10270, N'JavaScript: Understanding the Weird Parts
', N'javascriptcourse_quiz.pdf', 1, 9048)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10271, N'The Complete ASP.NET MVC 5 Course
', N'completeasp_quiz.pdf', 2, 9049)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10272, N'iOS & Swift - The Complete iOS App Development Bootcamp
', N'iosandswift_quiz.pdf', 2, 9050)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10273, N'The Complete Android N Developer Course
', N'androidndevelopercourse_quiz.pdf', 2, 9051)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10274, N'Ionic - Build iOS, Android & Web Apps with Ionic & Angular
', N'ionic_quiz.pdf', 3, 9052)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10275, N'The Complete iOS 10 & Swift 3 Developer Course
', N'ios10_quiz.pdf', 2, 9053)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10276, N'iOS 9 and Swift 2: From Beginner to Paid Professional™
', N'ios9andswift_quiz.pdf', 2, 9054)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10277, N'Machine Learning A-Z™: Hands-On Python & R In Data Science
', N'machinelearning_quiz.pdf', 2, 9056)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10278, N'Deep Learning A-Z™: Hands-On Artificial Neural Networks
', N'deeplearning_quiz.pdf', 2, 9057)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10279, N'R Programming A-Z™: R For Data Science With Real Exercises!
', N'rprogramming_quiz.pdf', 3, 9058)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10280, N'Accounting: From Beginner to Advanced!
', N'accounting_quiz.pdf', 2, 9059)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10281, N'2020 New Google Ads (AdWords) Course - From Beginner to PRO
', N'googleadwords_quiz.pdf', 2, 9061)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10282, N'Content Marketing Masterclass: Create Content That Sells
', N'contentmarketing_quiz.pdf', 3, 9062)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10283, N'Viral Blogging 101: Blogging & Content Writing Masterclass
', N'viralblogging_quiz.pdf', 2, 9063)
INSERT [eLearning].[Quiz] ([ID], [QuizName], [QuizPDF], [QuizDifficulty], [CourseID]) VALUES (10284, N'Investing In Stocks The Complete Course! (11 Hour)
', N'investinginstocks_quiz.pdf', 3, 9066)

GO
INSERT [eLearning].[Feedback] ([ID], [QuizResult], [CorrectAnswerCount], [QuizID], [LearnerID]) VALUES (3012, 100, 10, 10252, 5060)
INSERT [eLearning].[Feedback] ([ID], [QuizResult], [CorrectAnswerCount], [QuizID], [LearnerID]) VALUES (3013, 50, 5, 10253, 5063)
INSERT [eLearning].[Feedback] ([ID], [QuizResult], [CorrectAnswerCount], [QuizID], [LearnerID]) VALUES (3014, 100, 10, 10255, 5066)
INSERT [eLearning].[Feedback] ([ID], [QuizResult], [CorrectAnswerCount], [QuizID], [LearnerID]) VALUES (3015, 70, 7, 10256, 5060)
GO


-- view 1  print quiz details that has 2 degree of difficulty.
CREATE VIEW eLearning.twoDegreeDiffQuizDetails 
AS
SELECT ID,QuizName,QuizDifficulty
FROM eLearning.Quiz
WHERE QuizDifficulty = 2

-- for testing purposes  
-- SELECT * FROM eLearning.twoDegreeDiffQuizDetails;


-- view 2 receive learner details from the person table 
CREATE VIEW eLearning.vLearnerDetails
AS
SELECT  FirstName,LastName,Sex,Birthdate
FROM eLearning.Person
INNER JOIN eLearning.Learner
ON eLearning.Person.ID = eLearning.Learner.PersonID

-- for testing purposes  
-- SELECT * FROM eLearning.vLearnerDetails;


-- view 3 receive instructor details from the person table 
CREATE VIEW eLearning.vInstructorDetails
AS
SELECT  FirstName,LastName,Sex,Birthdate
FROM eLearning.Person
INNER JOIN eLearning.Instructor
ON eLearning.Person.ID = eLearning.Instructor.PersonID

-- for testing purposes  
-- SELECT * FROM eLearning.vInstructorDetails;


-- view 4 print instructors' details who have more than 1000 student. 
CREATE VIEW eLearning.vInstructorStudentCountDetails
AS
SELECT FirstName, LastName, Sex, Birthdate 
FROM eLearning.Person
WHERE ID IN 
(SELECT PersonID
FROM eLearning.Instructor
WHERE StudentCount > 1000);

-- for testing purposes  
-- SELECT * FROM eLearning.vInstructorStudentCountDetails;


-- view 5 print instructors details whose ratings are greater than or equal to 4.8.
CREATE VIEW eLearning.vInstructorRatingDetails
AS
SELECT FirstName, LastName, Sex, Birthdate 
FROM eLearning.Person
WHERE ID IN 
(SELECT PersonID
FROM eLearning.Instructor
WHERE InstructorRating >= 4.8);

-- for testing purposes  
-- SELECT * FROM eLearning.vInstructorRatingDetails;


-- view 5 print instructors details whose course count are smaller than or equal to 2.
CREATE VIEW eLearning.vInstructorsThatHaveMoreThan2Course
AS
SELECT FirstName, LastName, Sex, Birthdate 
FROM eLearning.Person
WHERE ID IN 
(SELECT PersonID
FROM eLearning.Instructor
WHERE CourseCount <= 2);

-- for testing purposes  
-- SELECT * FROM eLearning.vInstructorsThatHaveMoreThan2Course;

-- view 6 
CREATE VIEW eLearning.vSubjectsOfTheDevelopmentCategory
AS
SELECT  ID,SubjectTitle
FROM eLearning.CourseSubject
WHERE CategoryID IN 
(SELECT ID
FROM eLearning.CourseCategory
WHERE ID = 9315);

-- for testing purposes  
--SELECT * FROM eLearning.vSubjectsOfTheDevelopmentCategory;


-- view 7 print latest logon of the learners who bought at least one course before. 
CREATE VIEW eLearning.vLatestLogonOfTheLearner
AS
SELECT  ID,LatestLogon
FROM eLearning.Learner
WHERE ID IN 
(SELECT LearnerID
FROM eLearning.Payment);

-- for testing purposes  
-- SELECT * FROM eLearning.vLatestLogonOfTheLearner;


-- view 8 print personal details of the learners who get at least one feedback. 
CREATE VIEW eLearning.vDetailsOfLearnersWhoHaveFeedbacks
AS
SELECT  FirstName,LastName,Sex,Birthdate
FROM eLearning.Person
INNER JOIN eLearning.Learner
ON eLearning.Person.ID = eLearning.Learner.PersonID
INNER JOIN eLearning.Feedback
ON eLearning.Feedback.LearnerID = eLearning.Learner.ID

-- test tool 
-- SELECT * FROM eLearning.vDetailsOfLearnersWhoHaveFeedbacks;




-- view 9 print courses that have a quiz whose difficulty is 3 
CREATE VIEW eLearning.vCoursesThatHaveQuizDifficulty3
AS
SELECT  CourseName, CourseDescription, CoursePrice
FROM eLearning.Course
INNER JOIN eLearning.Quiz
ON eLearning.Course.ID = eLearning.Quiz.CourseID
WHERE QuizDifficulty = 3

-- for testing purposes  
-- SELECT * FROM eLearning.vCoursesThatHaveQuizDifficulty3;




--- view 10 return category title of 'The Web Development Bootcamp'
CREATE VIEW eLearning.vCategoryTitleOfTheSpecificCourse
AS
SELECT ID, CategoryTitle
FROM eLearning.CourseCategory
WHERE ID =
(SELECT CategoryID
FROM eLearning.CourseSubject
WHERE ID =
(SELECT CourseSubjectID
FROM eLearning.Course
WHERE CourseName = 'The Web Development Bootcamp'))

-- for testing purposes  
-- SELECT * FROM eLearning.vCategoryTitleOfTheSpecificCourse;



-- procedure 1 
CREATE PROCEDURE eLearning.showCourseBySubject (@id as INT)
AS
SELECT ID, CourseName, CourseDescription, CoursePrice, CourseSubjectID, InstructorID
FROM  eLearning.Course
WHERE CourseSubjectID = @id

-- for testing purposes  
/*
GO
EXEC eLearning.showCourseBySubject  @id = '8881';
GO
*/


-- procedure 2 
CREATE PROCEDURE eLearning.showPaymentDetailsByPaymentType (@paymentType as NVARCHAR(255))
AS
SELECT ID, PaymentDate, LearnerID
FROM  eLearning.Payment
WHERE PaymentType = @paymentType

-- for testing purposes  
/*
GO
EXEC  eLearning.showPaymentDetailsByPaymentType  @paymentType = 'Debit Card';
GO
*/


-- procedure 3
CREATE PROCEDURE eLearning.showWorksheetDetailsByCourseID (@CourseID as INT)
AS
SELECT ID, WorksheetName, WorksheetPDF
FROM  eLearning.Worksheet
WHERE CourseID = @CourseID

-- for testing purposes  
/*
GO
EXEC  eLearning.showWorksheetDetailsByCourseID  @CourseID = 9010;
GO
*/



-- procedure 4 
CREATE PROCEDURE eLearning.showSuccesfullOrders (@Paid as BIT)
AS
SELECT ID, OrderDate, Paid, Quantity, UnitPrice, LearnerID
FROM  eLearning.Orders
WHERE Paid = @Paid

-- for testing purposes  
/*
GO
EXEC  eLearning.showSuccesfullOrders  @Paid = True;
GO
*/


-- procedure 5 
CREATE PROCEDURE eLearning.showCourseCommentsByCourseID (@CourseID as INT)
AS
SELECT ID, CommentTitle, CommentText, LearnerID
FROM  eLearning.CourseComment
WHERE CourseID = @CourseID

-- for testing purposes  
/*
GO
EXEC  eLearning.showCourseCommentsByCourseID  @CourseID = 9011;
GO
*/




-- procedure 6
CREATE PROCEDURE eLearning.showFeedbackDetailsByLearnerID (@LearnerID as INT)
AS
SELECT  ID, QuizResult, CorrectAnswerCount, QuizID, LearnerID 
FROM eLearning.Feedback
WHERE LearnerID = @LearnerID

-- for testing purposes  
/*
GO
EXEC  eLearning.showFeedbackDetailsByLearnerID  @LearnerID = 5063;
GO
*/


-- procedure 7
CREATE PROCEDURE eLearning.showOrdersAfterASpecificDate (@Order as DATETIME)
AS
SELECT  ID, OrderDate, Paid, Quantity, UnitPrice, LearnerID 
FROM eLearning.Orders
WHERE OrderDate <= @Order 

-- for testing purposes  
/*
GO
EXEC  eLearning.showOrdersAfterASpecificDate  @Order = '2020-05-20';
GO
*/


-- procedure 8
CREATE PROCEDURE eLearning.showCourseCommentsByLearnerID (@LearnerID as INT)
AS
SELECT ID, CommentTitle, CommentText, LearnerID
FROM  eLearning.CourseComment
WHERE LearnerID = @LearnerID

-- for testing purposes  
/*
GO
EXEC  eLearning.showCourseCommentsByLearnerID  @LearnerID = 5060;
GO
*/


-- procedure 9
CREATE PROCEDURE eLearning.getOrdersByPriceAmount (@UnitPrice as INT)
AS
SELECT ID, OrderDate, Paid, Quantity, UnitPrice, LearnerID
FROM  eLearning.Orders
WHERE UnitPrice = @UnitPrice


-- for testing purposes  
/*
GO
EXEC  eLearning.getOrdersByPriceAmount  @UnitPrice = 70;
GO
*/



-- Trigger 1 
GO
CREATE TRIGGER  eLearning.DeleteCourseCategory
ON eLearning.CourseCategory
INSTEAD OF DELETE
AS	
	PRINT 'CANNOT DELETE ANY COURSE CATEGORY';
GO

-- for testing purposes  
/*
DELETE eLearning.CourseCategory
WHERE ID = 9315;
*/


-- Trigger 2  
CREATE TRIGGER  eLearning.AddNewLearner
ON eLearning.Learner
INSTEAD OF INSERT
AS	
	DECLARE  @ID AS INT;
	DECLARE  @RegistrationDate AS DATETIME;
	DECLARE  @LatestLogon AS DATETIME;
	DECLARE  @PhoneNumber AS NVARCHAR(255);
	DECLARE  @LearnerAddress AS NVARCHAR(255);
	DECLARE  @LearnerDetails AS NVARCHAR(255);
	DECLARE  @PersonID AS INT;

	SET @ID = (SELECT ID FROM inserted)
	SET @RegistrationDate = (SELECT RegistrationDate FROM inserted)
	SET @LatestLogon = (SELECT LatestLogon FROM inserted)
	SET @PhoneNumber = (SELECT PhoneNumber FROM inserted)
	SET @LearnerAddress = (SELECT LearnerAddress FROM inserted)	
	SET @LearnerDetails = (SELECT LearnerDetails FROM inserted)	
	SET @PersonID = (SELECT PersonID FROM inserted)

	IF(@PersonID IN (SELECT ID FROM eLearning.Person))
	BEGIN
		INSERT INTO eLearning.Learner (ID,RegistrationDate,LatestLogon,PhoneNumber,LearnerAddress,LearnerDetails,PersonID)
		VALUES(@ID, @RegistrationDate, @LatestLogon, @PhoneNumber, @LearnerAddress, @LearnerDetails, @PersonID)
	END
	ELSE
	BEGIN
	PRINT 'THERE IS NO PERSON WITH THIS ID = ' + cast(@PersonID as varchar(255));
	END
GO


-- for testing purposes  
/*
INSERT INTO eLearning.Learner (ID,RegistrationDate,LatestLogon,PhoneNumber,LearnerAddress,LearnerDetails,PersonID)
VALUES(5076, '2016-02-12 00:00:00.000', '2020-10-15 00:00:00.000', '(+90)525 789 88 85', NULL, NULL, 3399)
*/


-- Trigger 3   
CREATE TRIGGER  eLearning.AddLearnerInfo
ON eLearning.Learner
AFTER INSERT
AS	

	DECLARE  @PersonID AS INT;
	SET @PersonID = (SELECT PersonID FROM inserted)

	DECLARE @Fname AS NVARCHAR(255);
	DECLARE @Lname AS NVARCHAR(255);
	SET @Fname = (SELECT FirstName FROM eLearning.Person WHERE ID = @PersonID)
	SET @Lname = (SELECT LastName FROM eLearning.Person WHERE ID = @PersonID)

	PRINT 'PERSON NAMED ' + @Fname + ' ' + @Lname + ' WITH ID = ' + cast(@PersonID as varchar(255)) + ' WAS ADDED AS A LEARNER';

GO

-- for testing purposes  
/*
INSERT INTO eLearning.Learner (ID,RegistrationDate,LatestLogon,PhoneNumber,LearnerAddress,LearnerDetails,PersonID)
VALUES(5076, '2020-12-29 00:00:00.000', '2020-01-20 00:00:00.000', '(+90)535 489 96 96', NULL, NULL, 3399);
*/


-- Trigger 4
CREATE TRIGGER  eLearning.DeleteInstructor
ON eLearning.Instructor
AFTER DELETE
AS	

	DECLARE  @InsID AS INT;
	SET @InsID = (SELECT ID FROM deleted)

	DECLARE  @PersonID AS INT;
	SET @PersonID = (SELECT PersonID FROM deleted)

	DECLARE @Fname AS NVARCHAR(255);
	DECLARE @Lname AS NVARCHAR(255);
	SET @Fname = (SELECT FirstName FROM eLearning.Person WHERE ID =  @PersonID)
	SET @Lname = (SELECT LastName FROM eLearning.Person WHERE ID =  @PersonID)

	PRINT 'INSTRUCTOR NAMED ' + @Fname +' '+ @Lname + ' WITH ID = ' + cast(@PersonID as varchar(255)) + ' WAS DELETED SUCCESSFULLY';
GO


-- for testing purposes  
/*
INSERT INTO eLearning.Instructor (ID,PhoneNumber,InstructorRating,StudentCount,CourseCount,InstructorDetails,PersonID)
VALUES(4532, '(+90)525 963 85 45', 4.9,100, 1, 'Hi, its Mark. Im the founder of SMAcademy ', 3400);

DELETE eLearning.Instructor
WHERE ID = 4532;
*/


-- Trigger 5 
CREATE TRIGGER  eLearning.DeleteLearnerAndItsPayment
ON eLearning.Learner
INSTEAD OF DELETE
AS	
	DECLARE  @ID AS INT;
	DECLARE  @PersonID AS INT;

	SET @ID = (SELECT ID FROM deleted)
	SET @PersonID = (SELECT PersonID FROM deleted)
	
	IF((@ID IN (SELECT ID FROM eLearning.Learner)) AND (@PersonID IN (SELECT @PersonID FROM eLearning.Payment)))
		BEGIN
			DELETE eLearning.Payment
			WHERE LearnerID = @ID;
			PRINT 'LEARNERS PAYMENT HISTORY ' + cast(@ID as varchar(255)) + ' WAS DELETED SUCCESSFULLY';

			DELETE eLearning.Learner
			WHERE ID = @ID;
			PRINT 'LEARNER ' + cast(@ID as varchar(255)) + ' WAS DELETED SUCCESSFULLY';
		END
	ELSE
		BEGIN
				PRINT 'THERE IS NO LEARNER WITH THIS ID';
		END
GO


-- for testing purposes  
/*
INSERT INTO eLearning.Learner (ID,RegistrationDate,LatestLogon,PhoneNumber,LearnerAddress,LearnerDetails,PersonID)
VALUES(5076, '2020-12-29 00:00:00.000', '2020-01-20 00:00:00.000', '(+90)535 489 96 96', NULL, NULL, 3399);

INSERT INTO eLearning.Payment (ID,PaymentDate,PaymentType,LearnerID)
VALUES(7615, '2020-12-29 00:00:00.000', 'Credit Card', 5076);

DELETE eLearning.Learner
WHERE ID = 5076;
*/



-- function 1  
CREATE FUNCTION eLearning.IsThePersonLearner (@PersonID INT)
RETURNS NVARCHAR(255)
AS	
BEGIN
	IF(@PersonID IN (SELECT PersonID FROM eLearning.Learner))
		BEGIN
			RETURN 'A LEARNER';
		END
	RETURN 'NOT A LEARNER';	
END

-- for testing purposes 
-- PRINT  eLearning.IsThePersonLearner(3399);


-- function 2 
CREATE FUNCTION eLearning.LearnersPaymentHistory (@LearnerID INT)
RETURNS TABLE
AS	
RETURN 
(
	SELECT ID, PaymentDate, PaymentType 
	FROM eLearning.Payment 
	WHERE @LearnerID = LearnerID 
)

-- for testing purposes 
-- SELECT * FROM eLearning.LearnersPaymentHistory(5060);


-- function 3 
CREATE FUNCTION eLearning.NumberOfCoursesSoldToThisLearner (@LearnerID INT)
RETURNS REAL  
AS	
BEGIN
RETURN (SELECT SUM(Quantity) AS TotalCount FROM eLearning.Orders WHERE LearnerID = @LearnerID)
END 

-- for testing purposes 
-- PRINT eLearning.NumberOfCoursesSoldToThisLearner(5063);