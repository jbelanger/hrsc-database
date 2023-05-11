



CREATE   PROCEDURE [HRSC_APP].[usp_EMPLOYEE_ROLE_FOR_REQ_Insert]
@pEmployeeID bigint, @pRequestID bigint, @pEmployeeRoleID bigint, @pUserCreated nvarchar(30), @pNewRowID bigint OUTPUT

WITH EXEC AS CALLER
AS
 
	INSERT INTO HRSC.EMPLOYEE_ROLE_FOR_REQUEST (
		EMPLOYEE_ID,
		HR_REQUEST_ID,
		EMPLOYEE_ROLE_ID,
		DATE_CREATED,
		USER_CREATED
    )
    values (
		@pEmployeeID,
		@pRequestID,
		@pEmployeeRoleID,
		GETDATE(),
		@pUserCreated
	)

	set @pNewRowID = @@IDENTITY;
