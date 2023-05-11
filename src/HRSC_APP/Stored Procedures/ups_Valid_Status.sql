



CREATE   PROCEDURE [HRSC_APP].[ups_Valid_Status]

 @request_status_id bigint,
 @StatusCode varchar(5) OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- SelectActiveCdRequestStatus
-- Retreives all active Request status 
-- Gaétan Demers  2011-12-13
-- Eric Nolet     2011-12-19 Added Aliases
------------------------------------------------------
set @StatusCode = (SELECT  request_status_code AS code
FROM    hrsc.cd_request_status
WHERE   request_status_id = @request_status_id
and		expiry_date IS null)
