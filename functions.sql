

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