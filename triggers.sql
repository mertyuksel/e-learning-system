
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
