-- 1.	Display details (Word, Meaning, Pronunciation, Usage) of all words

SELECT W.vcWord, W.vcWordMeaning, W.nvcPronunciation, WU.vcWordUsageSentence 
FROM tblWord W
LEFT JOIN tblWordUsages WU
	ON W.nWordID = WU.nWordID

-- 2.	Display words which are of type “noun”
DECLARE @nWordTypeId_noun INT = 1;
SELECT W.vcWord, WTM.*, WT.*
FROM tblWord W 
INNER JOIN tblWordTypeMapping WTM
	ON W.nWordID = WTM.nWordID
INNER JOIN tblWordTypeEnum WT
	ON WTM.nWordTypeID = WT.nWordTypeID
	AND WTM.nWordTypeID = @nWordTypeId_noun

-- 3.	Display words which have not been scheduled for SMS
SELECT W.*
FROM tblWord W
LEFT JOIN tblWordForSMS S
	ON W.nWordID = S.nWordID
WHERE S.nWordID IS NULL

-- 4.	Display contact details of users of partner “acme” (Partner Org ID = 1)
SELECT U.vcFirstName, U.vcLastName, U.*
FROM tblPartnerOrganizationUsers U
INNER JOIN tblPartnerOrganization P
	ON U.nPartnerOrgID = P.nPartnerOrgID
	AND P.nvcPartnerOrg = 'acme'

-- 5.	Display contact details of users which are not registered under any of the partners
SELECT TOP 10 FU.UserName, Email
--SELECT COUNT(*)
FROM ForumUsers FU
LEFT JOIN tblPartnerOrganizationUsers PU
	ON FU.UserID = PU.nUserID
WHERE PU.nUserID IS NULL

-- 6.	Display Name and size details of T-shirts from merchandises table which are available in black color
DECLARE @nvcMerchandiseType_Tshirts INT = 1,
	@tblMerchandiseColorEnum_Black INT = 4;

SELECT M.nvcMerchandiseName, MSE.nvcMerchandiseSize, MTE.nvcMerchandiseType, MCE.nvcMerchandiseColor
FROM tblMerchandise M
INNER JOIN tblMerchandiseAttributes MA 
	ON M.nMerchandiseID = MA.nMerchandiseID
	AND M.nMerchandiseTypeID = @nvcMerchandiseType_Tshirts
	AND MA.nMerchandiseColorID = @tblMerchandiseColorEnum_Black
INNER JOIN tblMerchandiseSizeEnum MSE
	ON MA.nMerchandiseSizeID = MSE.nMerchandiseSizeID
INNER JOIN tblMerchandiseTypeEnum MTE
	ON M.nMerchandiseTypeID = MTE.nMerchandiseTypeID
INNER JOIN tblMerchandiseColorEnum MCE
	ON MA.nMerchandiseColorID = MCE.nMerchandiseColorID

-- 7.	Display Name, type, color and size details of all merchandises to be displayed on User Points Reward Gallery (tblMerchandiseDisplayTypeEnum)

DECLARE @nvcMerchandiseDisplayType_Gallary INT = 2;
SELECT M.nvcMerchandiseName, MTE.nvcMerchandiseType, 
	MCE.nvcMerchandiseColor, MSE.nvcMerchandiseSize,
	MDTE.nvcMerchandiseDisplayType
FROM tblMerchandise M
INNER JOIN tblMerchandiseAttributes MA
	ON M.nMerchandiseID = MA.nMerchandiseID
INNER JOIN tblMerchandiseSizeEnum MSE
	ON MA.nMerchandiseSizeID = MSE.nMerchandiseSizeID
INNER JOIN tblMerchandiseColorEnum MCE
	ON MA.nMerchandiseColorID = MCE.nMerchandiseColorID
INNER JOIN tblMerchandiseDisplayTypeMapping MDTM
	ON MDTM.nMerchandiseID = M.nMerchandiseID
	AND MDTM.nMerchandiseDisplayTypeID = @nvcMerchandiseDisplayType_Gallary
INNER JOIN tblMerchandiseTypeEnum MTE
	ON M.nMerchandiseTypeID = MTE.nMerchandiseTypeID
INNER JOIN tblMerchandiseDisplayTypeEnum MDTE
	ON  MDTE.nMerchandiseDisplayTypeID = MDTM.nMerchandiseDisplayTypeID

-- 8.	Display contact details of all users of type Administrator
DECLARE @nUserTypeID_Adminstrators INT = 2;
SELECT FU.Email, FU.vcFName, FU.vcLName, UTE.vcUserType
FROM ForumUsers FU
INNER JOIN tblUserTypeUsers UTU
	ON FU.UserID = UTU.nUserID
	AND UTU.nUserTypeID = @nUserTypeID_Adminstrators
INNER JOIN tblUserTypeEnum UTE
	ON UTU.nUserTypeID = UTE.nUserTypeID
	
-- 9.	Display Merchandise Name, Size, Color and Quantity available for Black color T-shirts (MerchandiseType) and Red Color Backpacks (MerchandiseType)
DECLARE @nMerchandiseTypeID_Tshirt INT = 1,
	 @nMerchandiseTypeID_Backpack INT = 2,
	 @nMerchandiseColorID_Black INT = 4,
	 @nMerchandiseColorID_Red INT = 2

SELECT M.nvcMerchandiseName, MSE.nvcMerchandiseSize, MCE.nvcMerchandiseColor, MA.nAvailableQuantity, MTE.nvcMerchandiseType 
FROM tblMerchandise M
INNER JOIN tblMerchandiseAttributes MA 
	ON M.nMerchandiseID = MA.nMerchandiseID
LEFT JOIN tblMerchandiseSizeEnum MSE
	ON MA.nMerchandiseSizeID = MSE.nMerchandiseSizeID
INNER JOIN tblMerchandiseColorEnum MCE
	ON MA.nMerchandiseColorID = MCE.nMerchandiseColorID
INNER JOIN tblMerchandiseTypeEnum MTE
	ON M.nMerchandiseTypeID = MTE.nMerchandiseTypeID
WHERE (MTE.nMerchandiseTypeID = @nMerchandiseTypeID_Tshirt AND MCE.nMerchandiseColorID = @nMerchandiseColorID_Black) 
	OR (MTE.nMerchandiseTypeID = @nMerchandiseTypeID_Backpack AND MCE.nMerchandiseColorID = @nMerchandiseColorID_Red)
