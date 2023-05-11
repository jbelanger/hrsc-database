



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_APPROVAL_Update] (
	@pRequestApprovalId bigint, 
	@pIsApproved bit,
	@pDateValidated datetime,
	@pDeclineReason nvarchar(4000),
	@pUserUpdated nvarchar(30)
)

WITH EXEC AS CALLER
AS

	UPDATE HRSC.HR_REQUEST_APPROVAL SET 
		IS_APPROVED=@pIsApproved,
		DATE_VALIDATED=@pDateValidated,
		DECLINE_REASON=@pDeclineReason,
        USER_UPDATED=@pUserUpdated,
		DATE_UPDATED=GETDATE()
	WHERE HR_REQUEST_APPROVAL_ID = @pRequestApprovalId;