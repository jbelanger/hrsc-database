


CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_DRAFT_Insert] (
	@pDraftName varchar(250),
	@pRequestTypeId bigint,
	@pFormVersion tinyint,
	@pEmployeeId bigint, 
	@pTemplateInd bit, 
	@pDraftObject nvarchar(MAX),
	@pUserCreated nvarchar(30),  
	@pNewRowID bigint OUTPUT
)

WITH EXEC AS CALLER
AS

INSERT INTO HRSC.HR_REQUEST_DRAFT (
	SUBJECT_TEXT,
	HR_REQUEST_TYPE_ID,
	TEMPLATE_IND,
	FORM_VERSION,
	USER_CREATED,
	DATE_CREATED,
	EMPLOYEE_ID,
	DRAFT
)
VALUES (
	@pDraftName,
	@pRequestTypeId,
	@pTemplateInd,
	@pFormVersion,
	@pUserCreated,
	GetDate(),
	@pEmployeeId,
	@pDraftObject
);

SET @pNewRowID = SCOPE_IDENTITY()
