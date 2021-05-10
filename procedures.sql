

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
