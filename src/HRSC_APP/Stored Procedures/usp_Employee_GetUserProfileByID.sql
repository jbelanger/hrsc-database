



CREATE   PROCEDURE [HRSC_APP].[usp_Employee_GetUserProfileByID]
@pEmployeeID bigint
WITH EXEC AS CALLER
AS
select * from HRSC.EMPLOYEE
where EMPLOYEE_ID = @pEmployeeID
