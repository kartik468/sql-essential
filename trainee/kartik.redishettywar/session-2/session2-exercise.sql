-- 1.	Display contact details of all "non Active" users
SELECT TOP 100  vcFName, vcLName, Email, vcCityName, vcStateName, vcAddress, vcPhoneAreaCode, vcPhoneNumber, vcMobileNumber, vcPinCode
FROM ForumUsers WHERE bRegistrationActivated = 1

-- 2.	Display contact details of users from “Mumbai”
SELECT TOP 100 vcCityName, * 
FROM ForumUsers 
WHERE vcCityName = 'mumbai'

-- 3.	Display contact details or users from “Hyderabad” who have not given their address
SELECT TOP 100 vcCityName, vcAddress, * 
FROM ForumUsers 
WHERE vcCityName = 'Hyderabad'
AND (vcAddress IS NULL OR LTRIM(RTRIM(vcAddress)) = '')

-- 4.	Display contact details of users who are either from “Chennai” or have their Birthday on “1986-05-13”
SELECT TOP 100 dtBirthDate, CAST(dtBirthDate AS DATE), *
FROM ForumUsers A
WHERE vcCityName = 'Chennai'
AND CAST(dtBirthDate AS DATE) = '1986-05-13'

--5. Display contact details of users whose first names start with “K”
SELECT TOP 100 *
FROM ForumUsers WHERE vcFName like 'k%'

-- 6.	Display contact details of users whose first name does not start with “S”
SELECT TOP 100 *
FROM ForumUsers WHERE vcFName NOT like 's%'

-- 7.	Display contact details of users, arranged in ascending order of their age (in years)
SELECT TOP 100 GETUTCDATE(), dtBirthDate, DATEDIFF(YY, dtBirthDate, GETUTCDATE()) 'Age', *
FROM ForumUsers A
ORDER BY DATEDIFF(YY, dtBirthDate, GETUTCDATE())
-- ORDER BY A.dtBirthDate 

-- 8.	Display contact details of the 5 newest users
SELECT TOP 5 *
FROM ForumUsers ORDER BY UserId DESC


