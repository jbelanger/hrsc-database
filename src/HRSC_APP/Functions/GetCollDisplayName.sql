


CREATE   FUNCTION [HRSC_APP].[GetCollDisplayName]
(@IntID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN

declare @empName nvarchar(MAX);

SELECT @empName = COALESCE(@empName + '; ', '') + EMP.DISPLAY_NAME
	FROM    HRSC.HR_RQST_INTRVNT_HRSC_USER REQUSER
	INNER JOIN HRSC.EMPLOYEE EMP ON EMP.EMPLOYEE_ID = REQUSER.EMPLOYEE_ID
	WHERE   REQUEST_INTERVENTION_ID = @IntId and
			employee_role_id = (SELECT role.EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE role where role.EMPLOYEE_ROLE_CODE = 'COL')

    if @empName is Null 
      begin
        set @empName = '';
      end
      
    return @empName;
END     
