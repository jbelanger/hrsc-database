


/*================
Created by:		Elena Akhmetova 
Creation Date:	2012-11-27
Description:	Used in several report SPs: 
calculation of business hours (from 7.30 to 19.00) with no 
holidays (common for all provinces, no special ones) and weekends.
==================*/
CREATE   FUNCTION [HRSC_APP].[GetPreviousStatus]
(@ReqID bigint = null, @IntID bigint = null)
RETURNS float
WITH EXEC AS CALLER
AS
BEGIN
-- Return the status before the current status.
-- Function being used by the recall SP to flip the status once a recall happens.
DECLARE @intStatus bigint;
DECLARE @intLastStatusCode varchar(10); 

/* Check if the last status is Pending Signature or Return to Client*/
if not @ReqID is null
  BEGIN
    SELECT TOP 1  @intLastStatusCode = CSTAT.REQUEST_STATUS_CODE FROM HRSC.HR_REQUEST_STATUS STAT
                  JOIN HRSC.CD_REQUEST_STATUS CSTAT ON CSTAT.REQUEST_STATUS_ID = STAT.REQUEST_STATUS_ID

    WHERE         STAT.HR_REQUEST_ID = @ReqID 

    ORDER BY  STAT.HR_REQUEST_STATUS_ID DESC

    if (@intLastStatusCode = 'WSIGN' or @intLastStatusCode = 'RTRNC')
      -- Return the Previous Status
      SELECT TOP 1 @intStatus = REQUEST_STATUS_ID FROM HRSC.HR_REQUEST_STATUS 
        WHERE HR_REQUEST_ID = @ReqID 
          AND REQUEST_STATUS_ID NOT IN (SELECT REQUEST_STATUS_ID  FROM HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE IN (N'RTRNC',N'WSIGN'))
          ORDER BY HR_REQUEST_STATUS_ID DESC
       
    else
      --Do nothing
      set @intStatus = NULL; 
  END

  
if not @IntID is null
  BEGIN

    SELECT TOP 1  @intLastStatusCode = CSTAT.REQUEST_STATUS_CODE FROM HRSC.HR_REQUEST_STATUS STAT
                  JOIN HRSC.CD_REQUEST_STATUS CSTAT ON CSTAT.REQUEST_STATUS_ID = STAT.REQUEST_STATUS_ID

    WHERE         STAT.REQUEST_INTERVENTION_ID = @IntID 

    ORDER BY  STAT.HR_REQUEST_STATUS_ID DESC

    if (@intLastStatusCode = 'WSIGN' or @intLastStatusCode = 'RTRNC')
      -- Return the Previous Status
      SELECT TOP 1 @intStatus = REQUEST_STATUS_ID FROM HRSC.HR_REQUEST_STATUS 
      WHERE REQUEST_INTERVENTION_ID = @IntID
          AND REQUEST_STATUS_ID NOT IN (SELECT REQUEST_STATUS_ID  FROM HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE IN (N'RTRNC',N'WSIGN'))
      ORDER BY HR_REQUEST_STATUS_ID DESC
       
    else
      --Do nothing
      set @intStatus = NULL; 
 END

if (not @ReqID is null and not @IntID is null)
    set @intStatus = null;

return @intStatus;
END
