

CREATE   FUNCTION [HRSC_APP].[GetRelatedStatusesString]
(@IntID bigint)
RETURNS NVARCHAR(4000)
WITH EXEC AS CALLER
AS
BEGIN
declare @statusStr NVARCHAR(4000)

	set @statusStr = (
		SELECT STUFF((
			select '|' + (CAST(REQUEST_STATUS_CODE as NVARCHAR) + ';' + CONVERT(VARCHAR, rs.DATE_CREATED, 121)) 
			from hrsc.hr_request_status rs
			join HRSC.CD_REQUEST_STATUS s on s.REQUEST_STATUS_ID = rs.REQUEST_STATUS_ID
			where REQUEST_INTERVENTION_ID = @IntID 
			order by hr_request_status_id
			for xml path('')), 1, 1, '')
		);
     
    return @statusStr;
END
