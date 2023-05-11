


CREATE   FUNCTION [HRSC_APP].[GetManagerEmail]
(@ReqID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
declare @empEmail nvarchar(MAX);
       
  set @empEmail = (Select EMPLOYEE_EMAIL_ADDRESS from HRSC.EMPLOYEE where EMPLOYEE_ID = 
                    (select EMPLOYEE_ID FROM HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_FOR_REQUEST_ID = 
                      (select MAX(EMPLOYEE_ROLE_FOR_REQUEST_ID) from HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_ID = 
                        (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE = 'MAN') AND HR_REQUEST_ID = @ReqID AND EMPLOYEE_ROLE_FOR_REQUEST.EXPIRY_DATE is NULL)));

  
  if @empEmail is null
    begin
      set @empEmail = (Select EMPLOYEE_EMAIL_ADDRESS from HRSC.EMPLOYEE where EMPLOYEE_ID = 
                      (select EMPLOYEE_ID FROM HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_FOR_REQUEST_ID = 
                        (select MAX(EMPLOYEE_ROLE_FOR_REQUEST_ID) from HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_ID = 
                          (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE = 'SDEL') AND HR_REQUEST_ID = @ReqID AND EMPLOYEE_ROLE_FOR_REQUEST.EXPIRY_DATE is NULL)));

    end
      
  if @empEmail is null
    begin
      set @empEmail = (Select EMPLOYEE_EMAIL_ADDRESS from HRSC.EMPLOYEE where EMPLOYEE_ID = 
                      (select EMPLOYEE_ID FROM HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_FOR_REQUEST_ID = 
                        (select MAX(EMPLOYEE_ROLE_FOR_REQUEST_ID) from HRSC.EMPLOYEE_ROLE_FOR_REQUEST where EMPLOYEE_ROLE_ID = 
                          (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE = 'HOST') AND HR_REQUEST_ID = @ReqID AND EMPLOYEE_ROLE_FOR_REQUEST.EXPIRY_DATE is NULL)));

    end
     
    if @empEmail is Null 
      begin
        set @empEmail = '';
      end
      
    return @empEmail;
END
