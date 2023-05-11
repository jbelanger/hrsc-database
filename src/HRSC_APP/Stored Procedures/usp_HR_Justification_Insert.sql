



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Justification_Insert]

    @StatusIDs		VARCHAR(MAX),
   	@Code			NVARCHAR(5), 
	@NameEn			NVARCHAR(250), 
	@NameFr			NVARCHAR(250), 
	@DescriptionEn	NVARCHAR(4000), 
	@DescriptionFr	VARCHAR(4000), 
    @EffectiveDate	DATETIME,
    @ExpiryDate		DATETIME,
    @User			NVARCHAR(60),
	@JustificationID BIGINT OUTPUT,
	@ReturnCode     BIGINT OUTPUT

WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_HR_JUSTIFICATION, REQ_STATUS_JUSTIFICATION   Insert
-- Admin screen
-- Oksana Zhukova 2013-01-31
------------------------------------------------------
-- Declare our variables
	DECLARE @Error INT, 
			@ID BIGINT,
			@CountFromStatus INT,
			@ExistingID INT,
			@CountMinID INT,
			@RequestStatusID INT
			
    DECLARE @TempStatus TABLE (ID INT IDENTITY(1,1), Item BIGINT)

  IF 
	  (SELECT COUNT(*) FROM HRSC.CD_HR_JUSTIFICATION 
					   WHERE HR_JUSTIFICATION_CODE =@Code OR HR_JUSTIFICATION_NAME_EN = @NameEn or 
							 HR_JUSTIFICATION_NAME_FR = @NameFr) = 0	   
	BEGIN
		 INSERT INTO HRSC.CD_HR_JUSTIFICATION
				   (HR_JUSTIFICATION_CODE,
					HR_JUSTIFICATION_NAME_EN,
					HR_JUSTIFICATION_NAME_FR,
					HR_JUSTIFICATION_DESC_EN,
					HR_JUSTIFICATION_DESC_FR,
					EFFECTIVE_DATE,
					EXPIRY_DATE,
					USER_CREATED,
					DATE_CREATED)
			 VALUES
				   (@Code,
					@NameEn,
					@NameFr,
					@DescriptionEn,
					@DescriptionFr,
					@EffectiveDate,
					@ExpiryDate,
					@User,
					GETDATE()
					)

		SELECT  @JustificationID = @@IDENTITY
			
		--begin transaction			  
		INSERT INTO @TempStatus (Item)
	   
		SELECT * FROM HRSC_App.Split (@StatusIDs, '|')
		--SELECT * FROM HRSC_App.Split ('2|5', '|')	

		SELECT @CountFromStatus =(SELECT COUNT(*) FROM @TempStatus)  
			
	--check if 	justification exist, set the expiry date of the status to today date
		SELECT @ExistingID =  REQ_STATUS_JUSTIFICATION_ID 
		                 FROM HRSC.REQ_STATUS_JUSTIFICATION 
		                 WHERE REQ_STATUS_JUSTIFICATION_ID = @JustificationID

		IF @ExistingID > 0 
			BEGIN		
				DECLARE cursorName CURSOR FOR						--DECLARE cursor
				SELECT Item FROM @TempStatus	
				OPEN cursorName										 --OPEN the cursor to begin data processing 

				FETCH NEXT FROM cursorName INTO @ID					--FETCH NEXT Assign the specific values from the cursor to the variables	
				WHILE @@FETCH_STATUS = 0							--WHILE Condition to BEGIN and continue data processing
				BEGIN		
					UPDATE HRSC.REQ_STATUS_JUSTIFICATION
					SET EXPIRY_DATE  = GETDATE(),
						USER_UPDATED = @User,
						DATE_UPDATED = GETDATE()
					 WHERE REQUEST_STATUS_ID = @ID
						   AND HR_JUSTIFICATION_ID = @JustificationID
						   AND EXPIRY_DATE IS NULL						     
				 FETCH NEXT FROM cursorName INTO @ID
	   
				END
				CLOSE cursorName									-- CLOSE the cursor
				DEALLOCATE cursorName								--DELLOCATE Destroys the cursor
				
			END

		--rollback transaction	
		--insert new with expiry date null---------------------------------------------------------			  			   
			IF @CountFromStatus != 0 AND @JustificationID != 0
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
  END	
     
   SET @JustificationID =@JustificationID

 -- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR
-- A Stored Proc always return 0 if no error.

IF @Error != 0
  SET @ReturnCode = @@ERROR
ELSE
  SET @ReturnCode = 0

  

