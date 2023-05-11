





CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_UpdateStatus_WithJustification]
@pRequestID bigint, @lngStatusID bigint, @lngJustificationID bigint, @strJustification nvarchar(max), @strUser nvarchar(50), @Email_reminder date, @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS

	DECLARE @intReturnCd Integer;

	Begin

		INSERT INTO HRSC.HR_REQUEST_STATUS ( 
			HR_REQUEST_ID, 
			REQUEST_STATUS_ID, 
			HR_JUSTIFICATION_ID,
			JUSTIFICATION_TXT,
			USER_CREATED, 
			DATE_CREATED)
		VALUES (
			@pRequestID, 
			@lngStatusID,
			CASE WHEN @lngJustificationID <= 0 Then NULL ELSE @lngJustificationID END,
			@strJustification,
			@strUser,
			GETDATE());


		UPDATE [HRSC].[HR_REQUEST] SET 
			[REQUEST_STATUS_ID] = @lngStatusID,
			[REQUEST_STATUS_DATE] = GETDATE(),
			EMAIL_REMINDER_COUNT = CASE WHEN not @Email_reminder is null then 1 else EMAIL_REMINDER_COUNT end,
			NEXT_EMAIL_REMINDER_DATE = CASE WHEN not @Email_reminder is null then @Email_reminder else NEXT_EMAIL_REMINDER_DATE end,
			[USER_UPDATED] = @strUser,
			[DATE_UPDATED] = GetDate(),
			IS_RECALLED = 0
		WHERE [HR_REQUEST_ID] = @pRequestID;


		EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
			@pRequestID, --@lngReqId 
			NULL, --@lngIntId
			@lngStatusID, --@lngStatusId
			@strUser, --@strUserCreated
			@lngJustificationID,	--@lngJustificationID
			@strJustification,		--@strJustification
			@intReturnCd OUT; --@intReturnCode
	End
