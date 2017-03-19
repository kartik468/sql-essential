/*This script can be used to convert ZeusCatLMS database to zeus sql trainig database by deleting unnecessary objects*/


'uspSelectUserAvailibility',
'udfRandBetween',
'udfParseString',
'vwRandom',
'uspGetError'

---- drop all user defined views
--Declare @viewName varchar(500) 
--Declare cur Cursor For Select [name] From sys.objects where type = 'v' and name <> 'vwRandom'
--Open cur 
--Fetch Next From cur Into @viewName 
--While @@fetch_status = 0 
--Begin 
-- Exec('drop view ' + @viewName) 
-- Fetch Next From cur Into @viewName 
--End
--Close cur 
--Deallocate cur 


---- drop all user defined triggers
--Declare @trgName varchar(500) 
--Declare cur Cursor For Select [name] From sys.objects where type = 'tr' 
--Open cur 
--Fetch Next From cur Into @trgName 
--While @@fetch_status = 0 
--Begin 
-- Exec('drop trigger ' + @trgName) 
-- Fetch Next From cur Into @trgName 
--End
--Close cur 
--Deallocate cur 


-- drop all user defined stored procedures
--Declare @procName varchar(500) 
--Declare cur Cursor For Select [name] From sys.objects where type = 'p' and name not in ('uspGetError','uspSelectUserAvailibility' )
--Open cur 
--Fetch Next From cur Into @procName 
--While @@fetch_status = 0 
--Begin 
--	 Exec('drop procedure ' + @procName) 
-- Fetch Next From cur Into @procName 
--End
--Close cur 
--Deallocate cur 



-- --drop all user defined functions
--Declare @funcName varchar(500) 
--Declare cur Cursor For Select [name] From sys.objects where type in ( 'FN', 'IF', 'TF' ) and name not in ('udfRandomBetween','udfParseString') 
--Open cur 
--Fetch Next From cur Into @funcName 
--While @@fetch_status = 0 
--Begin	
--	 Exec('drop function ' + @funcName) 
-- Fetch Next From cur Into @funcName 
--End
--Close cur 
--Deallocate cur 



--Declare @tableName varchar(500) 
--Declare cur Cursor For 
--Select [name] From sys.tables where name not in (
--'tblWord',
--'tblWordUsages',
--'tblWordTypeMapping',
--'tblWordTypeEnum',
--'ForumUsers',
--'tblPartnerOrganizationUsers',
--'tblPartnerOrganization',
--'tblMerchandise',
--'tblMerchandiseAttributes',
--'tblMerchandiseColorEnum',
--'tblMerchandiseDisplayTypeEnum',
--'tblMerchandiseDisplayTypeMapping',
--'tblMerchandiseSizeEnum',
--'tblMerchandiseTypeEnum',
--'tblUserTypeUsers',
--'tblQuiz',
--'tblQuizRound',
--'tblQuizRoundwiseScore',
--'tblEmployer',
--'tblEntranceTestTypeEnum',
--'tblUserEntranceTestsInterestedIn',
--'tblUserTypeEnum',
--'tblWordForSMS',
--'tblWordForSMSSchedule',
--'sysdiagrams'
--)
--Open cur 
--Fetch Next From cur Into @tableName 
--While @@fetch_status = 0 
--Begin 
--	 Exec('drop table ' + @tableName) 
-- Fetch Next From cur Into @tableName 
--End
--Close cur 
--Deallocate cur 