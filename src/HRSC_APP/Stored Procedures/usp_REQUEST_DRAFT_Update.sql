



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_DRAFT_Update] (
	@pRequestDraftID bigint, 
	@pDraftName varchar(250),
	@pRequestTypeId bigint,
	@pFormVersion tinyint,
	@pEmployeeId bigint, 
	@pTemplateInd bit, 
	@pDraftObject nvarchar(MAX),
	@pUserUpdated nvarchar(30)
)

WITH EXEC AS CALLER
AS

	UPDATE HRSC.HR_REQUEST_DRAFT SET 
		SUBJECT_TEXT = @pDraftName,
		HR_REQUEST_TYPE_ID = @pRequestTypeId,
        TEMPLATE_IND=@pTemplateInd,
		FORM_VERSION = @pFormVersion,
		EMPLOYEE_ID = @pEmployeeId,
        USER_UPDATED=@pUserUpdated,
        DRAFT = @pDraftObject,
		DATE_UPDATED=GETDATE()
	WHERE HR_REQUEST_DRAFT_ID = @pRequestDraftID;
