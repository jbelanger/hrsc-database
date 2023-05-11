
CREATE   FUNCTION [HRSC_APP].[GetInterventionAgentsString] (@pInterventionId bigint)
RETURNS NVARCHAR(4000)
WITH EXEC AS CALLER
AS
BEGIN
declare @rolesStr NVARCHAR(4000)
declare @noaction bigint

	set @rolesStr = (
		SELECT STUFF((
            select '|' + (ISNULL(CAST(EMPLOYEE_ROLE_ID as VARCHAR(10)), '') + ';' + ISNULL(CAST(EMPLOYEE_ID as VARCHAR(20)), '') + ';' + CAST(i.HR_REQUEST_INTERVENTION_ID as VARCHAR(20)) + ';' + CAST(i.BUSINESS_CENTER_ID as VARCHAR(10))) 
			from hrsc.HR_REQUEST_INTERVENTION i
                left join hrsc.HR_RQST_INTRVNT_HRSC_USER ri on i.HR_REQUEST_INTERVENTION_ID = ri.REQUEST_INTERVENTION_ID
			where HR_REQUEST_INTERVENTION_ID = @pInterventionId 
				and ri.EXPIRY_DATE is null
			order by HR_RQST_INTRVNT_HRSC_USER_ID 
			for xml path('')), 1, 1, ''));
    return @rolesStr;
END
