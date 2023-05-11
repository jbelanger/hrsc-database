



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_UpdateStatus]
@lngIntID bigint, @lngStatusID bigint, @lngJustificationID bigint, @strJustification nvarchar(max), @strUser nvarchar(50), @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
	
	DECLARE @intReturnCode Integer;

	set @lngJustificationID = CASE WHEN @lngJustificationID <= 0 Then NULL ELSE @lngJustificationID END;

    INSERT INTO HRSC.HR_REQUEST_STATUS ( 
		REQUEST_INTERVENTION_ID, 
		REQUEST_STATUS_ID, 
		HR_JUSTIFICATION_ID,
		JUSTIFICATION_TXT,
        USER_CREATED, 
        DATE_CREATED)
    VALUES (
		@lngIntID, 
		@lngStatusID,
		@lngJustificationID,
		@strJustification,
		@strUser,
		GETDATE());


  	-- Update the latest status in the HR_REQUEST_INTERVENTION new field [REQUEST_STATUS_ID] which will always be set to the latest status.  Y.R. 2015/07/22
	-- Will need to revisit this and somehow populate the new field TOTAL_TIME_ELAPSED.
	UPDATE [HRSC].[HR_REQUEST_INTERVENTION]
	SET [REQUEST_STATUS_ID] = @lngStatusID,
		[REQUEST_STATUS_DATE] = GETDATE(),
		[USER_UPDATED] = @strUser,
		[DATE_UPDATED] = GetDate()
	WHERE [HR_REQUEST_INTERVENTION_ID] = @lngIntID

    
	EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
        NULL, --@lngReqId 
		@lngIntID, --@lngIntId
		@lngStatusID, --@lngStatusId
		@strUser, --@strUserCreated
		@lngJustificationID,	--@lngJustificationID
		@strJustification,		--@strJustification
		@intReturnCode OUT; --@intReturnCode

