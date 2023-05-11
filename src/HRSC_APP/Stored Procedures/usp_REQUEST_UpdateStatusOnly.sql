





CREATE PROCEDURE [HRSC_APP].[usp_REQUEST_UpdateStatusOnly]
	@pRequestID bigint, 
	@pStatusId bigint, 
	@pStatusDate datetime,
	@pUserUpdated varchar(30)

WITH EXEC AS CALLER
AS

  update HRSC.HR_REQUEST set 
	REQUEST_STATUS_ID = @pStatusId,
	REQUEST_STATUS_DATE = getdate(), -- Ignored param on purpose. Wait until all code calls this SPs.
	USER_UPDATED = @pUserUpdated,
	DATE_UPDATED = getdate()
  where HR_REQUEST_ID = @pRequestID;
