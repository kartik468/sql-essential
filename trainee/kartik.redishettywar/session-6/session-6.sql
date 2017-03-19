-- 1.	INSERT a row for “Training User” in table tblUserTypeEnum

--select * from tblUserTypeEnum_kartikredishettywar
-- DBCC CHECKIDENT('tblUserTypeEnum_kartikredishettywar', RESEED, 12)
BEGIN TRAN	
	INSERT INTO tblUserTypeEnum_kartikredishettywar
	(vcUserType, vcUserTypeDesc, dtCreatedOn, dtModifiedOn, bZeusInternalWalkin, GUID)
	VALUES('Custom user', 'Custom type', GETUTCDATE(), GETUTCDATE(), 0, NEWID());

	SELECT * from tblUserTypeEnum_kartikredishettywar order by nUserTypeID desc
COMMIT TRAN

-- 2.	UPDATE column vcUserType to “SQL Training Users” of the row inserted with the above query (1.)
BEGIN TRAN	
	UPDATE tblUserTypeEnum_kartikredishettywar
	SET vcUserType = 'SQL Training Users'
	WHERE nUserTypeID = 16;

	SELECT * from tblUserTypeEnum_kartikredishettywar order by nUserTypeID desc
COMMIT TRAN

-- 3.	DELETE the row inserted with the above query (1.)
BEGIN TRAN	
	DELETE FROM tblUserTypeEnum_kartikredishettywar
	WHERE nUserTypeID = 16;
COMMIT TRAN

-- 4.	Replace without using sub-query, all occurrences of “<br/>” with “ “(space), from the Usage statements of the words which are scheduled for SMS word service for the future dates
BEGIN TRAN		
	UPDATE WU
	SET WU.vcWordUsageSentence = REPLACE(vcWordUsageSentence, '<br/>', ' ')	
	FROM tblWordUsages_kartikredishettywar WU
	INNER JOIN tblWordForSMSSchedule_kartikredishettywar WSS
		ON WU.nWordID = WSS.nWordID
	WHERE WSS.dtScheduleDate > GETUTCDATE()
	AND WU.vcWordUsageSentence LIKE '%<br/>%'
ROLLBACK TRAN

-- 5.	Delete without using sub-query, the schedule for SMS word service, for the future dates, of the words for which the length of the usage statement is more than 30 characters
BEGIN TRAN	
	DELETE WFSS
	--select WSS.vcWordUsageSentence, LEN(WSS.vcWordUsageSentence)
	FROM tblWordForSMSSchedule_kartikredishettywar WFSS
	INNER JOIN tblWordUsages_kartikredishettywar WSS
		ON WFSS.nWordID = WSS.nWordID
	WHERE LEN(WSS.vcWordUsageSentence) > 30
ROLLBACK TRAN
--order by LEN(WSS.vcWordUsageSentence)