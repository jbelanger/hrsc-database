
CREATE PROCEDURE [HRSC_APP].[usp_Request_Status_Insert]
	@pRequestID bigint, 
	@pInterventionId bigint, 
	@lngStatusID bigint, 
	@pSTATUS_DATE datetime,
	@lngJustificationID bigint, 
	@strJustification nvarchar(max), 
	@strUser nvarchar(50)
WITH EXEC AS CALLER
AS

	INSERT INTO HRSC.HR_REQUEST_STATUS ( 
		HR_REQUEST_ID, 
		REQUEST_INTERVENTION_ID,
		REQUEST_STATUS_ID, 
		HR_JUSTIFICATION_ID,
		JUSTIFICATION_TXT,
		USER_CREATED, 
		DATE_CREATED)
	VALUES (
		@pRequestID, 
		@pInterventionId,
		@lngStatusID,
		CASE WHEN @lngJustificationID <= 0 Then NULL ELSE @lngJustificationID END,
		@strJustification,
		@strUser,
		getdate());
