


CREATE   FUNCTION [HRSC_APP].[GetLeadDisplayName]
(@IntID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN

declare @empName nvarchar(MAX);

  set @empName = (SELECT EMP.DISPLAY_NAME
					FROM    HRSC.HR_RQST_INTRVNT_HRSC_USER REQUSER,
							HRSC.EMPLOYEE EMP
					WHERE   EMP.EMPLOYEE_ID = REQUSER.EMPLOYEE_ID AND
							REQUEST_INTERVENTION_ID = @IntID and
			 			    employee_role_id = (SELECT role.EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE role where role.EMPLOYEE_ROLE_CODE = 'LEAD'))

    if @empName is Null 
      begin
        set @empName = '';
      end
      
    return @empName;
END     
 

