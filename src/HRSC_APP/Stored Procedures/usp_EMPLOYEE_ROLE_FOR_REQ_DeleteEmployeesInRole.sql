



CREATE   PROCEDURE [HRSC_APP].[usp_EMPLOYEE_ROLE_FOR_REQ_DeleteEmployeesInRole]
	@pRequestID bigint, 
	@pEmployeeRoleId bigint, 
	@pUser nvarchar(30)
WITH EXEC AS CALLER
AS

update HRSC.EMPLOYEE_ROLE_FOR_REQUEST set 
	EXPIRY_DATE = GETDATE(),
    USER_UPDATED = @pUser,
    DATE_UPDATED = getdate()
where HR_REQUEST_ID = @pRequestID
	and EMPLOYEE_ROLE_ID = @pEmployeeRoleId
	and EXPIRY_DATE IS NULL;
