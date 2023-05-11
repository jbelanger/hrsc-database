
CREATE PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_Cancel]
@pRequestID bigint, @pUserCreated nvarchar(30), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_INTERVENTION_Cancel
-- 
-- Eric Nolet 09-03-2012
------------------------------------------------------
-- Declare our variables
declare @vStatusID bigint;
declare @vError bigint;
declare @InterventionID bigint;
DECLARE @intReturnCode Integer;

-- Get the status ID for the NEW status
select @vStatusID =  REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE = 'CANC';
  
    DECLARE objIntervention CURSOR FOR
            SELECT hr_request_intervention_id 
            FROM HRSC.HR_REQUEST_INTERVENTION 
            WHERE HRSC.HR_REQUEST_INTERVENTION.HR_REQUEST_ID = @pRequestID;

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
       @pUserCreated,
       GETDATE());

  	-- Update the latest status in the HR_REQUEST_INTERVENTION new field [REQUEST_STATUS_ID] which will always be set to the latest status.  Y.R. 2015/07/22
	-- Will need to revisit this and somehow populate the new field TOTAL_TIME_ELAPSED.
	UPDATE [HRSC].[HR_REQUEST_INTERVENTION]
	SET [REQUEST_STATUS_ID] = @vStatusID,
		[REQUEST_STATUS_DATE] = GETDATE(),
		[USER_UPDATED] = @pUserCreated,
		[DATE_UPDATED] = GetDate()
	WHERE [HR_REQUEST_INTERVENTION_ID] = @InterventionID
            
	  EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
        NULL, --@lngReqId 
		@InterventionID, --@lngIntId
		@vStatusID, --@lngStatusId
		@pUserCreated, --@strUserCreated
		0,						--@lngJustificationID
		NULL,					--@strJustification
		@intReturnCode OUT; --@intReturnCode
  

      FETCH NEXT FROM objIntervention INTO @InterventionID
    END
    
    CLOSE objIntervention;

    DEALLOCATE objIntervention;

  
-- A Stored Proc always return 0 if no error.
SELECT @vError = @@ERROR;

IF @vError != 0
  set @pReturnCode = @vError
else
  set @pReturnCode = 0
