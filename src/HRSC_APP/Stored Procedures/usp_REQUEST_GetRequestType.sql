

CREATE   procedure [HRSC_APP].[usp_REQUEST_GetRequestType]
@lngID bigint, @pRequestTypeCode nvarchar(5) OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_GetRequestType
-- 
-- Tony Paradis 2013-03-05
/** Modified for SQL Server 2016 Michel Tardif ***/
------------------------------------------------------
SET @pRequestTypeCode = (SELECT  STAT.HR_REQUEST_TYPE_CODE
		FROM  HRSC.CD_HR_REQUEST_TYPE STAT
			INNER JOIN HRSC.HR_REQUEST REQ ON REQ.HR_REQUEST_TYPE_ID = STAT.HR_REQUEST_TYPE_ID 
		WHERE REQ.HR_REQUEST_ID  = @lngid);
