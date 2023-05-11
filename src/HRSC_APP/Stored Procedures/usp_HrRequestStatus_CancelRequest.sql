
CREATE PROCEDURE [HRSC_APP].[usp_HrRequestStatus_CancelRequest]
@pRequestID bigint, @pUserCreated nvarchar(30), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_HrRequestStatus_CancelRequest
-- Insert a entry for a cancellation Request with status = NEW 
-- Gaétan Demers 2012-01-04 
------------------------------------------------------
-- Declare our variables
declare @vStatusID bigint;
declare @vError bigint;

-- Get the status ID for the NEW status
select @vStatusID =  REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS 
  WHERE REQUEST_STATUS_CODE = 'CANC';
  
-- Insert the record
INSERT INTO HRSC.HR_REQUEST_STATUS
  (EXPIRY_DATE, 
   USER_CREATED, 
   DATE_CREATED, 
   HR_REQUEST_ID, 
   REQUEST_STATUS_ID)
  VALUES
  (NULL, 
   @pUserCreated, 
   GetDate(), 
   @pRequestID, 
   @vStatusID);

-- Update the latest status in the HR_REQUEST new field [REQUEST_STATUS_ID] which will always be set to the latest status. Y.R. 2015/07/22
	UPDATE [HRSC].[HR_REQUEST]
	SET [REQUEST_STATUS_ID] = @vStatusID,
		[REQUEST_STATUS_DATE] = GETDATE(),
		[USER_UPDATED] = @pUserCreated,
		[DATE_UPDATED] = GetDate()
	WHERE [HR_REQUEST_ID] = @pRequestID;

 
 DECLARE @intReturnCd Integer;
 EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
        @pRequestID, --@lngReqId 
		NULL, --@lngIntId
		@vStatusID, --@lngStatusId
		@pUserCreated, --@strUserCreated
		0,  --@lngJustificationID
		NULL, --@strJustification
		@intReturnCd OUT; --@intReturnCode

   
-- A Stored Proc always return 0 if no error.
SELECT @vError = @@ERROR;
IF @vError != 0
  set @pReturnCode = @vError
else
  set @pReturnCode = 0
