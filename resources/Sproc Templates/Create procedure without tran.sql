/*=============================================
Author:		
Create date: 
Description:	
=============================================*/
CREATE PROCEDURE [dbo].[StoredProcedureName]
(
	@Param1 UNIQUEIDENTIFIER = NULL
	, @Param2 INT
	, @Param3 INT
)
AS							
BEGIN
	SET NOCOUNT ON;
	/*******************************************************************************************************/		
	/*begin declaration section */	
	DECLARE	@Error INT
			, @ErrorMessage NVARCHAR(4000)
			, @IsCustomError BIT
			, @TodaysDate DATETIME
			, @Id UNIQUEIDENTIFIER
	
	
	DECLARE @TemporaryTable TABLE
	(
		Column1 NVARCHAR(400)
		, Column2 BIT DEFAULT(0)		
	)	
	/*end declaration section*/
	/*******************************************************************************************************/
	
	/*******************************************************************************************************/		
	/*begin processing section */			
	BEGIN TRY
	
		SELECT @TodaysDate = GETUTCDATE()
		
		INSERT INTO @TemporaryTable
			(Column1)
		SELECT SomeColumn
		FROM SomeTable
		WHERE SomeOtherColumn = 'SomeValue'
			
				
		IF EXISTS(SELECT Column1 FROM @Table1 WHERE Column1 = 1) 
		BEGIN			
			SELECT @IsCustomError = 1, @Error = 132, @ErrorMessage = 'Some message'		
			GOTO ErrorHandler 
		END			
	/*end processing section */
	/*******************************************************************************************************/		
	
	/*******************************************************************************************************/		
	/*begin result section */
		/*1)*/
		SELECT 0 AS 'success', @Param1 AS 'Id'
			
		/*2)*/
		SELECT Column1, Column2, Column1 + Column2 AS 'SomeAlias'

	
 		RETURN
	/*end result section */
	/*******************************************************************************************************/	
	/*******************************************************************************************************/		
	/*begin error handler section */		  
	END TRY  
	BEGIN CATCH  
	  SELECT @error = @@ERROR, @errorMessage = ERROR_MESSAGE()  
	  GOTO ErrorHandler  
	END CATCH   
	ErrorHandler:
		EXEC [GetError]
			@ErrorNum = @Error, /*INT*/
			@IsCustomError = @IsCustomError, /*BIT*/
			@ErrorMessage = @ErrorMessage				
			
		RETURN
	/*end error handler section */
	/*******************************************************************************************************/			
END


/*
EXEC StoredProcedureName
	@Param1 = null
	,@Param1 = 'SoemValue'
	,@Param2 = 'SomeValue
*/