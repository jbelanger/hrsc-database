



CREATE   PROCEDURE [HRSC_APP].[usp_ADMIN_Check_Last_Status_Request]
WITH EXEC AS CALLER
AS
-- ENO
-- List the Requests that have a last status different then the Max status from the Status table.

DECLARE @intCount bigint;

SELECT  @intCount = count(r.HR_REQUEST_ID)
FROM HRSC.HR_REQUEST R
WHERE R.REQUEST_STATUS_ID <> (select HRSC.HR_REQUEST_STATUS.REQUEST_STATUS_ID  from HRSC.HR_REQUEST_STATUS where HR_REQUEST_STATUS_ID = (select MAX(HR_REQUEST_STATUS_ID) from HRSC.HR_REQUEST_STATUS where HR_REQUEST_ID = R.HR_REQUEST_ID))

  if @intCount < 100
    begin
      if @intCount = 0
        select @intCount as RecordCount;
      else
        SELECT  r.HR_REQUEST_ID,
                r.REQUEST_STATUS_ID,
                (select HRSC.HR_REQUEST_STATUS.REQUEST_STATUS_ID  from HRSC.HR_REQUEST_STATUS where HR_REQUEST_STATUS_ID = (select MAX(HR_REQUEST_STATUS_ID) from HRSC.HR_REQUEST_STATUS where HR_REQUEST_ID = R.HR_REQUEST_ID)) as Max_Status

        FROM HRSC.HR_REQUEST R
        WHERE R.REQUEST_STATUS_ID <> (select HRSC.HR_REQUEST_STATUS.REQUEST_STATUS_ID  from HRSC.HR_REQUEST_STATUS where HR_REQUEST_STATUS_ID = (select MAX(HR_REQUEST_STATUS_ID) from HRSC.HR_REQUEST_STATUS where HR_REQUEST_ID = R.HR_REQUEST_ID))
    end;

  else
    select @intCount as RecordCount;
