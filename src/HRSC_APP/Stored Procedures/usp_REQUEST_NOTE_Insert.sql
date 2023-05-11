



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_NOTE_Insert]
@lngReqId bigint, @lngIntId bigint, @strNote nvarchar(4000), @strUserCreated nvarchar(30), @intReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- REQUEST_NOTE_Insert
-- Insert a new Note in REQUEST_NOTE
-- Eric Nolet 2012-01-18
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;
DECLARE @NoteTypeID bigint;

Set @NoteTypeID = (SELECT [NOTE_TYPE_ID]
								FROM [HRSC].[CD_NOTE_TYPE]
								WHERE [HRSC].[CD_NOTE_TYPE].[NOTE_TYPE_CODE] = 'NOTE')

INSERT INTO HRSC.HR_REQUEST_NOTE

( HR_REQUEST_ID,
  HR_REQUEST_INTERVENTION_ID,
  HR_REQUEST_NOTE_TEXT,
  NOTE_TYPE_ID,
  USER_CREATED,
  DATE_CREATED
)
values
( @lngReqId,
  @lngIntId,
  @strNote,
  @NoteTypeID,
  @strUserCreated,
  GetDate());

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR;

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @intReturnCode = @@ERROR;
