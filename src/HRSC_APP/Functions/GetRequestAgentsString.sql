


CREATE   FUNCTION [HRSC_APP].[GetRequestAgentsString] (@pRequestId bigint)
RETURNS NVARCHAR(4000)
WITH EXEC AS CALLER
AS
BEGIN
declare @rolesStr NVARCHAR(4000)

	set @rolesStr = (
		SELECT STUFF((
            select '|' + (CAST(EMPLOYEE_ROLE_ID as VARCHAR(30)) + ';' + CAST(EMPLOYEE_ID as VARCHAR(30)) + ';' + CAST(ri.REQUEST_INTERVENTION_ID as VARCHAR(30))) 
			from hrsc.HR_REQUEST_INTERVENTION i
                join hrsc.HR_RQST_INTRVNT_HRSC_USER ri on i.HR_REQUEST_INTERVENTION_ID = ri.REQUEST_INTERVENTION_ID
			where HR_REQUEST_ID = @pRequestId 
				and ri.EXPIRY_DATE is null
			order by HR_RQST_INTRVNT_HRSC_USER_ID 
			for xml path('')), 1, 1, ''));
    return @rolesStr;
END
