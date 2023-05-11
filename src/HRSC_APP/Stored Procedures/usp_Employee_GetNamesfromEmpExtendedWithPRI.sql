



CREATE   PROCEDURE [HRSC_APP].[usp_Employee_GetNamesfromEmpExtendedWithPRI]
@pPRI nvarchar(9),
@pGivenName nvarchar(100) OUTPUT,
@pSurName nvarchar(100) OUTPUT
WITH EXEC AS CALLER
AS
select @pGivenName = HRSC.EMPLOYEE_EXTENDED.GIVEN_NAME,
       @pSurName = HRSC.EMPLOYEE_EXTENDED.SURNAME
from HRSC.EMPLOYEE_EXTENDED
where EMPLOYEE_EXTENDED.PRI = @pPRI
