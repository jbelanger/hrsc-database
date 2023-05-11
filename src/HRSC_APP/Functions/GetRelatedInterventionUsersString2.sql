


CREATE   FUNCTION [HRSC_APP].[GetRelatedInterventionUsersString2]
(@IntID bigint)
RETURNS NVARCHAR(4000)
WITH EXEC AS CALLER
AS
BEGIN
declare @rolesStr NVARCHAR(4000)

	set @rolesStr = (
		SELECT STUFF((
            select '|' + (CAST(EMPLOYEE_ROLE_ID as VARCHAR(30)) + ';' + CAST(EMPLOYEE_ID as VARCHAR(30))) 
			from hrsc.HR_RQST_INTRVNT_HRSC_USER ri 
			where REQUEST_INTERVENTION_ID = @IntID 
				and ri.EXPIRY_DATE is null
			order by HR_RQST_INTRVNT_HRSC_USER_ID 
			for xml path('')), 1, 1, ''));
    return @rolesStr;
END
