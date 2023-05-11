



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_NOTE_Delete]
@lngid bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_NOTE_Delete
-- 
-- Tony Paradis 2017-17-01
------------------------------------------------------

UPDATE HRSC.HR_REQUEST_NOTE
Set [EXPIRY_DATE] = getdate()
where HR_REQUEST_NOTE_ID = @lngid






