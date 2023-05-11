


CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_APPROVAL_Insert] (
	@pHrRequestId bigint,
	@pEmployeeId bigint,  
	@pUserCreated nvarchar(60),
	@pNewRowID bigint OUTPUT
)

WITH EXEC AS CALLER
AS

INSERT INTO HRSC.HR_REQUEST_APPROVAL (
	HR_REQUEST_ID,
	EMPLOYEE_ID,
	USER_CREATED,
	DATE_CREATED
)
VALUES (
	@pHrRequestId,
	@pEmployeeId,
	@pUserCreated,
	GetDate()
);

UPDATE HRSC.EMPLOYEE SET IS_DELEGATE_APPROVER = 1 WHERE EMPLOYEE_ID = @pEmployeeId;

SET @pNewRowID = SCOPE_IDENTITY()