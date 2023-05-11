



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Change_Category_SubCategory] 
	@pRequestID bigint,
	@pOldCategoryID bigint, @pOldSubCategoryID bigint, 
	@pNewCategoryID bigint, @pNewSubCategoryID bigint, 
	@pUser nvarchar(30), @pReturnCode bigint OUTPUT

WITH EXEC AS CALLER
AS

------------------------------------------------------
-- usp_REQUEST_Change_Category_SubCategory
-- Update an existing HR Request in DB 
-- Michel Tardif
-- 2017-03-23
------------------------------------------------------
-- Declare our variables
declare @vStatusID bigint;
declare @vError bigint;
declare @InterventionID bigint;
DECLARE @intReturnCode Integer;


-- Get the status ID for the NEW status
select @vStatusID =  REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE = 'NOACT';

DECLARE objIntervention CURSOR FOR
       SELECT hr_request_intervention_id 
       FROM HRSC.HR_REQUEST_INTERVENTION 
       WHERE [HR_REQUEST_ID] = @pRequestID AND
 			[REQUEST_CATEGORY_ID] = @pOldCategoryID AND
			[REQUEST_SUB_CATEGORY_ID] = @pOldSubCategoryID;

OPEN objIntervention
    FETCH NEXT FROM objIntervention 
    INTO @InterventionID
    WHILE @@FETCH_STATUS = 0
	  BEGIN
		  INSERT INTO HRSC.HR_REQUEST_STATUS
				( REQUEST_INTERVENTION_ID, 
				  REQUEST_STATUS_ID, 
				  USER_CREATED, 
				  DATE_CREATED
				 )
			  VALUES
				  (@InterventionID, 
				   @vStatusID,
				   @pUser,
				   GETDATE());
	
			UPDATE [HRSC].[HR_REQUEST_INTERVENTION]
				SET [REQUEST_STATUS_ID] = @vStatusID,
					[REQUEST_STATUS_DATE] = GETDATE(),
					[USER_UPDATED] = @pUser,
					[DATE_UPDATED] = GetDate()
				WHERE [HR_REQUEST_INTERVENTION_ID] =@InterventionID

    		EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
				NULL, --@lngReqId 
				@InterventionID, --@lngIntId
				@vStatusID, --@lngStatusId
				@pUser, --@strUserCreated
				0,						--@lngJustificationID
				NULL,					--@strJustification
				@intReturnCode OUT; --@intReturnCode
  

			FETCH NEXT FROM objIntervention INTO @InterventionID
		END
	 
CLOSE objIntervention;

DEALLOCATE objIntervention;


IF @pNewCategoryID > 0 AND @pNewSubCategoryID > 0 
	BEGIN		
		UPDATE HRSC.HR_REQUEST
			SET 
				USER_UPDATED=@pUser,
				DATE_UPDATED=GetDate(),
				REQUEST_CATEGORY_ID=@pNewCategoryID,
				REQUEST_SUB_CATEGORY_ID=@pNewSubCategoryID
			WHERE HR_REQUEST_ID = @pRequestID;
	END


-- A Stored Proc always return 0 if no error.
SELECT @vError = @@ERROR;

IF @vError != 0
  set @pReturnCode = @vError
else
  set @pReturnCode = 0












