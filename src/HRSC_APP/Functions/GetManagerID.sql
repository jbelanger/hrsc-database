


CREATE   FUNCTION [HRSC_APP].[GetManagerID]
(@ReqID bigint)
RETURNS bigint
WITH EXEC AS CALLER
AS
BEGIN
declare @empID bigint;
       
  set @empID = (Select EMPLOYEE_ID from HRSC.EMPLOYEE where EMPLOYEE_ID = 
                    (select EMPLOYEE_ID FROM HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_FOR_REQUEST_ID = 
                      (select MAX(EMPLOYEE_ROLE_FOR_REQUEST_ID) from HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_ID = 
                        (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE = 'MAN') AND HR_REQUEST_ID = @ReqID AND EMPLOYEE_ROLE_FOR_REQUEST.EXPIRY_DATE is NULL)));

  
  if @empID is null
    begin
      set @empID = (Select EMPLOYEE_ID from HRSC.EMPLOYEE where EMPLOYEE_ID = 
                      (select EMPLOYEE_ID FROM HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_FOR_REQUEST_ID = 
                        (select MAX(EMPLOYEE_ROLE_FOR_REQUEST_ID) from HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_ID = 
                          (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE = 'SDEL') AND HR_REQUEST_ID = @ReqID AND EMPLOYEE_ROLE_FOR_REQUEST.EXPIRY_DATE is NULL)));

    end
      
  if @empID is null
    begin
      set @empID = (Select EMPLOYEE_ID from HRSC.EMPLOYEE where EMPLOYEE_ID = 
                      (select EMPLOYEE_ID FROM HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_FOR_REQUEST_ID = 
                        (select MAX(EMPLOYEE_ROLE_FOR_REQUEST_ID) from HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_ID = 
                          (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE = 'HOST') AND HR_REQUEST_ID = @ReqID AND EMPLOYEE_ROLE_FOR_REQUEST.EXPIRY_DATE is NULL)));

    end
     
    if @empID is Null 
      begin
        set @empID = 0;
      end
      
    return @empID;
END
