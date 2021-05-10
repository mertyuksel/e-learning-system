
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

