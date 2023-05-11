


CREATE   FUNCTION [HRSC_APP].[GetRelatedRolesForRequestString2]
(@ReqID bigint)
RETURNS NVARCHAR(4000)
WITH EXEC AS CALLER
AS
BEGIN
declare @rolesStr NVARCHAR(4000)

	set @rolesStr = (
		SELECT STUFF((
			select '|' + (CAST(EMPLOYEE_ROLE_ID as VARCHAR(30)) + ';' + CAST(EMPLOYEE_ID as VARCHAR(30))) 
			from hrsc.EMPLOYEE_ROLE_FOR_REQUEST er 
			where HR_REQUEST_ID = @ReqID AND er.EXPIRY_DATE is NULL 
			order by EMPLOYEE_ROLE_FOR_REQUEST_ID 
			for xml path('')), 1, 1, ''));
    return @rolesStr;
END
