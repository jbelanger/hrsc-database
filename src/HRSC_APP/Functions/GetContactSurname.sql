


CREATE   FUNCTION [HRSC_APP].[GetContactSurname]
(@ReqID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
declare @empName nvarchar(MAX);
       
  set @empName = (Select EMPLOYEE_SURNAME from HRSC.EMPLOYEE where EMPLOYEE_ID = 
                    (select EMPLOYEE_ID FROM HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_FOR_REQUEST_ID = 
                      (select MAX(EMPLOYEE_ROLE_FOR_REQUEST_ID) from HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_ID = 
                        (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE = 'AMAN') AND HR_REQUEST_ID = @ReqID AND EMPLOYEE_ROLE_FOR_REQUEST.EXPIRY_DATE is NULL)));

     
    if @empName is Null 
      begin
        set @empName = '';
      end
      
    return @empName;
END
