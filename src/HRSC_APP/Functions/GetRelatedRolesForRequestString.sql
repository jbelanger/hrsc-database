


CREATE   FUNCTION [HRSC_APP].[GetRelatedRolesForRequestString]
(@ReqID bigint)
RETURNS NVARCHAR(4000)
WITH EXEC AS CALLER
AS
BEGIN
declare @rolesStr NVARCHAR(4000)

	set @rolesStr = (
		SELECT STUFF((
			select '|' + (EMPLOYEE_ROLE_CODE + ';' + DISPLAY_NAME) 
			from hrsc.EMPLOYEE_ROLE_FOR_REQUEST er 
			join hrsc.employee e on e.EMPLOYEE_ID = er.EMPLOYEE_ID 
			join HRSC.CD_EMPLOYEE_ROLE cer on cer.EMPLOYEE_ROLE_ID = er.EMPLOYEE_ROLE_ID
			where HR_REQUEST_ID = @ReqID AND er.EXPIRY_DATE is NULL 
			order by EMPLOYEE_ROLE_FOR_REQUEST_ID 
			for xml path('')), 1, 1, ''));
    return @rolesStr;
END
