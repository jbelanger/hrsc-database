



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_DRAFT_Delete]
@pRequestDraftID bigint, @pUser nvarchar(30), @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- RequestDraft_Delete
-- Delete (Physical) an existing HR Request Draft in DB 
-- Tony Paradis 2022-03-25 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;

Delete HRSC.HR_REQUEST_DRAFT
where HR_REQUEST_DRAFT_ID = @pRequestDraftID

--update HRSC.HR_REQUEST_DRAFT
--set 
-- expiry_date = GetDate(),
-- USER_UPDATED=@pUser,
-- DATE_UPDATED=GetDate()

--where HR_REQUEST_DRAFT_ID = @pRequestDraftID

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0

