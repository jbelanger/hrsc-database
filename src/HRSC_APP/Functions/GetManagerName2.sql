


CREATE   FUNCTION [HRSC_APP].[GetManagerName2]
(@ReqID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
declare @empName nvarchar(MAX);
       
						set @empName = (SELECT TOP 1 DISPLAY_NAME 
						FROM HRSC.EMPLOYEE E
						--SELECT ER.EMPLOYEE_ROLE_ID, EMPLOYEE_ROLE_CODE 
						JOIN HRSC.EMPLOYEE_ROLE_FOR_REQUEST ER ON E.EMPLOYEE_ID = ER.EMPLOYEE_ID
						JOIN (
							select EMPLOYEE_ROLE_ID, EMPLOYEE_ROLE_CODE 
							from HRSC.CD_EMPLOYEE_ROLE 
							WHERE EMPLOYEE_ROLE_CODE IN ('MAN', 'SDEL', 'HOST')							
							) A ON ER.EMPLOYEE_ROLE_ID = A.EMPLOYEE_ROLE_ID
						WHERE HR_REQUEST_ID = @ReqID AND ER.EXPIRY_DATE is NULL
						ORDER BY CASE EMPLOYEE_ROLE_CODE WHEN 'MAN' THEN 1 WHEN 'SDEL' THEN 2 WHEN 'HOST' THEN 3 END);
     
    if @empName is Null 
      begin
        set @empName = '';
      end
      
    return @empName;
END
