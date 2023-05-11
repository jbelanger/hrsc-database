



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_UpdateStatus_ConcurrencySafe] 
@lngIntID bigint, @lngStatusID bigint, @lngJustificationID bigint, @strJustification nvarchar(max), @rowversion  datetime, @strUser nvarchar(50) 
WITH EXEC AS CALLER
AS

DECLARE @error int;
DECLARE @intReturnCode Integer;

set @lngJustificationID = CASE WHEN @lngJustificationID = 0 Then NULL ELSE @lngJustificationID END;

	UPDATE [HRSC].[HR_REQUEST_INTERVENTION]
	SET [REQUEST_STATUS_ID] = @lngStatusID,
		[REQUEST_STATUS_DATE] = GETDATE(),
		[USER_UPDATED] = @strUser,
		[DATE_UPDATED] = GetDate()
	WHERE [HR_REQUEST_INTERVENTION_ID] = @lngIntID
		AND ((DATE_UPDATED is NULL AND @rowversion IS NULL) OR DATE_UPDATED = @rowversion)

	SELECT @error = @@ROWCOUNT

	if @error = 0
		RAISERROR('1001 - RowVersion is not the same, record could have been updated already.', 16,1);
	else
		BEGIN
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

			EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange]
				NULL, --@lngReqId 
				@lngIntID, --@lngIntId
				@lngStatusID, --@lngStatusId
				@strUser, --@strUserCreated
				@lngJustificationID,	--@lngJustificationID
				@strJustification,		--@strJustification
				@intReturnCode OUT; --@intReturnCode
		END 
	
