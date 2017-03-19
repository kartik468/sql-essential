-- 1.	Script to print all leap years between year 1900 and 2000
DECLARE @start_year INT = 1900,
	 @end_year INT = 2000

BEGIN
	WHILE (@start_year <= @end_year)
	BEGIN
		IF (DAY(EOMONTH(DATEFROMPARTS(@start_year, 2, 1))) = 29)
		BEGIN
			PRINT @start_year
		END
		
		SET @start_year = @start_year + 1;
	END
END


-- 2.	Script to execute stored procedure uspSelectUserAvailibility to check if username “testfunda” or email “contact@testfunda.com” exists in database

EXEC dbo.uspSelectUserAvailibility 
	@nvcUserName = 'testfunda', 
	@nvcEmail = 'contact@testfunda.com';


-- 3.	Script to get Random Number between 1 to 100 using function udfRandomBetween

SELECT dbo.udfRandomBetween(1, 100)

-- 4.	Script to parse the string “19,45,64,85” into a table using function udfParseString

SELECT vcData, nId 
FROM dbo.udfParseString(',', '19,45,64,85')
