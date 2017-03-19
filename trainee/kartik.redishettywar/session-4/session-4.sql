-- 1.	Using CASE statement write a simple query to print 3 letter form of current month (e.g. Jan, Feb etc.)

SELECT 
	CASE MONTH(GETUTCDATE()) 
		WHEN 1 THEN 'JAN'
		WHEN 2 THEN 'FEB'
		WHEN 3 THEN 'MAR'
		WHEN 4 THEN 'APR'
		WHEN 5 THEN 'MAY'
		WHEN 6 THEN 'JUN'
		WHEN 7 THEN 'JLY'
		WHEN 8 THEN 'AUG'
		WHEN 9 THEN 'SPT'
		WHEN 10 THEN 'OCT'
		WHEN 11 THEN 'NOV'
		WHEN 12 THEN 'DEC'
	END


-- 2.	Display contact details and registration date [in format: dd/mm/yyyy] of all paid users
SELECT Email, CONVERT(NVARCHAR(20), RegistrationDate, 103) RegistrationDate
FROM ForumUsers 
WHERE bPaidUser = 1

-- 3.	Write a query to display today’s date in form 13th Dec 2010
DECLARE @tDate NVARCHAR(10),
@prefix NVARCHAR(10),
@rem NVARCHAR(20);

SET @tDate = CAST(DATEPART(dd, GETUTCDATE()) as NVARCHAR(10));

SELECT @prefix = CASE 
	WHEN @tDate in (1, 21, 31) then 'st'
	WHEN @tDate in (2, 22) then 'nd'
	WHEN @tDate in (3, 23) then 'rd' else 'th'
END;

SET @rem = SUBSTRING(CONVERT(NVARCHAR(20), GETUTCDATE(), 106), 3, 9);

SELECT @tDate + @prefix + @rem

--SELECT TOP 1000 RegistrationDate, FORMAT(RegistrationDate,'d'
--+IIF(DAY(RegistrationDate) IN (1,21,31),'''st'''
--,IIF(DAY(RegistrationDate) IN (2,22),'''nd'''
--,IIF(DAY(RegistrationDate) IN (3,23),'''rd''','''th''')))
--+' MMM yyyy') As [Formatted Date]
--FROM ForumUsers


-- 4.	Display names of all paid users in the form FirstName<space>InitialOfLastName<dot>

SELECT TOP 100 vcFName + ' '+ UPPER(SUBSTRING(vcLName, 1, 1)) + '.' 
FROM ForumUsers 
WHERE bPaidUser = 1


