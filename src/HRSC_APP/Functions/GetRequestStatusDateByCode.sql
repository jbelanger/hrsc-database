

CREATE   FUNCTION [HRSC_APP].[GetRequestStatusDateByCode]
(@ReqID bigint = null, @IntID bigint = null, @StatusCode varchar(15))
RETURNS datetime
WITH EXEC AS CALLER
AS
BEGIN
declare @statusDate DATETIME

		set @statusDate = (
			SELECT TOP 1 h.DATE_CREATED
			FROM HRSC.HR_REQUEST_STATUS H
				JOIN HRSC.CD_REQUEST_STATUS C ON C.REQUEST_STATUS_ID = H.REQUEST_STATUS_ID
			WHERE REQUEST_INTERVENTION_ID  = @IntID AND C.REQUEST_STATUS_CODE = @StatusCode
			ORDER BY HR_REQUEST_STATUS_ID DESC
		)
     
    return @statusDate;
END
