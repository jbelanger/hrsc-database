



CREATE   PROCEDURE [HRSC_APP].[usp_Employee_GetEmployeeIDWithGuid]
@pGuid nvarchar(50),
@pEmployeeID BIGINT OUTPUT
WITH EXEC AS CALLER
AS
select @pEmployeeID = HRSC.EMPLOYEE.EMPLOYEE_ID 
from HRSC.EMPLOYEE
where USER_AD_GUID = @pGuid
