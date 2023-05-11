



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Justification_Update]

    @JustificationID BIGINT,
    @StatusIDs		VARCHAR(MAX),
   	@Code			NVARCHAR(5), 
	@NameEn			NVARCHAR(250), 
	@NameFr			NVARCHAR(250), 
	@DescriptionEn	NVARCHAR(4000), 
	@DescriptionFr	VARCHAR(4000), 
    @EffectiveDate	DATETIME,
    @ExpiryDate		DATETIME,
    --@Active BIT,
    @User			NVARCHAR(60),
	@ReturnCode     BIGINT OUTPUT
		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_Justification_Update
-- UPDATE an existing CD_HR_JUSTIFICATION and REQ_STATUS_JUSTIFICATION
-- Oksana Zhukova 2013-01-31
------------------------------------------------------
-- Declare our variables
DECLARE @Error INT, 
		@ID BIGINT, 
		@CountFromStatus  INT, 
		@ExistingID INT,
		@CountMinID INT,
		@RequestStatusID INT

DECLARE @TempStatus TABLE (ID INT IDENTITY(1,1), Item BIGINT)
    
	 UPDATE HRSC.CD_HR_JUSTIFICATION
	   SET HR_JUSTIFICATION_CODE = @Code,
		   HR_JUSTIFICATION_NAME_EN = @NameEn,
		   HR_JUSTIFICATION_NAME_FR = @NameFr,
		   HR_JUSTIFICATION_DESC_EN = @DescriptionEn,
		   HR_JUSTIFICATION_DESC_FR = @DescriptionFr,
		   EFFECTIVE_DATE = @EffectiveDate,
		   EXPIRY_DATE = @ExpiryDate,
		   USER_UPDATED = @User,
		   DATE_UPDATED = GETDATE()
	 WHERE HR_JUSTIFICATION_ID =  @JustificationID
	 
  --begin transaction			  
	INSERT INTO @TempStatus (Item)
	
	SELECT * FROM HRSC_App.Split (@StatusIDs, '|')
	--SELECT * FROM HRSC_App.Split ('|1|2|5|6|', '|')	
	
	--check if 	justification exist, set the expiry date of the status to today date--check if 	guide/procedure exist and update expiry date set getdate----
	SELECT @CountFromStatus  = (SELECT COUNT(*) FROM @TempStatus)    
 
	SELECT @ExistingID =  HR_JUSTIFICATION_ID 
		                 FROM HRSC.REQ_STATUS_JUSTIFICATION 
		                 WHERE  HR_JUSTIFICATION_ID  = @JustificationID
	
	IF @ExistingID > 0 AND @CountFromStatus > 0
		BEGIN		
			DECLARE cursorName CURSOR FOR	     --DECLARE cursor
			SELECT Item FROM @TempStatus	
			
			OPEN cursorName					     --OPEN the cursor to begin data processing 

			FETCH NEXT FROM cursorName		     --FETCH NEXT Assign the specific values from the cursor to the variables	
			INTO @ID		
			WHILE @@FETCH_STATUS = 0		     --WHILE Condition to BEGIN and continue data processing 
			BEGIN
			
			   UPDATE HRSC.REQ_STATUS_JUSTIFICATION
				SET EXPIRY_DATE  = GETDATE(),
					USER_UPDATED = @User,
					DATE_UPDATED = GETDATE()
				WHERE HR_JUSTIFICATION_ID =@JustificationID
					  AND EXPIRY_DATE IS NULL	
					  
				UPDATE HRSC.REQ_STATUS_JUSTIFICATION
				SET EXPIRY_DATE  = GETDATE(),
					USER_UPDATED = @User,
					DATE_UPDATED = GETDATE()
				WHERE REQUEST_STATUS_ID = @ID
					  AND HR_JUSTIFICATION_ID = @JustificationID
					  AND EXPIRY_DATE IS NULL	

					  				
			   FETCH NEXT FROM cursorName 
			   INTO @ID
			END
			CLOSE cursorName					-- CLOSE the cursor
			DEALLOCATE cursorName				--DELLOCATE Destroys the cursor
					
		END
		
	ELSE IF @ExistingID > 0 AND @CountFromStatus = 0
		BEGIN
		UPDATE HRSC.REQ_STATUS_JUSTIFICATION
			SET EXPIRY_DATE  = GETDATE(),
				USER_UPDATED = @User,
				DATE_UPDATED = GETDATE()
			WHERE HR_JUSTIFICATION_ID = @JustificationID
				  AND EXPIRY_DATE IS NULL					
		END
		
	--insert new with expiry date null------		  			   
	IF  @CountFromStatus > 0  
		BEGIN
			SELECT @CountMinID  = (SELECT MIN(ID) FROM @TempStatus)  
			
			   WHILE @CountMinID <= (SELECT MAX(ID) FROM @TempStatus) 
				   BEGIN
					  SELECT @RequestStatusID = Item FROM @TempStatus WHERE ID = @CountMinID
					 INSERT INTO HRSC.REQ_STATUS_JUSTIFICATION
								   (HR_JUSTIFICATION_ID,
									REQUEST_STATUS_ID,
									EXPIRY_DATE,
									USER_CREATED,
									DATE_CREATED)
							 VALUES
								   (@JustificationID,
									@RequestStatusID,
									Null,
									@User,
									GETDATE())		  
				   SET @CountMinID = @CountMinID + 1
				   END
		END

 -- Move it to our local variable, and check for an error condition
	SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  SET @ReturnCode = @@ERROR
ELSE
  SET @ReturnCode = 0
