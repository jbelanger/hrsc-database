


CREATE   FUNCTION [HRSC_APP].[GetRelatedInterventionUsersString]
(@IntID bigint)
RETURNS NVARCHAR(4000)
WITH EXEC AS CALLER
AS
BEGIN
declare @rolesStr NVARCHAR(4000)

	set @rolesStr = (
		SELECT STUFF((
			select '|' + (EMPLOYEE_ROLE_CODE + ';' + DISPLAY_NAME) 
			from hrsc.HR_RQST_INTRVNT_HRSC_USER ri 
			join hrsc.employee e on e.EMPLOYEE_ID = ri.EMPLOYEE_ID 
			join HRSC.CD_EMPLOYEE_ROLE cer on cer.EMPLOYEE_ROLE_ID = ri.EMPLOYEE_ROLE_ID
			where REQUEST_INTERVENTION_ID = @IntID 
				and ri.EXPIRY_DATE is null
			order by HR_RQST_INTRVNT_HRSC_USER_ID 
			for xml path('')), 1, 1, ''));
    return @rolesStr;
END
