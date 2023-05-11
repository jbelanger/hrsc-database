



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Note_Insert_SystemNote_withNoteValues]
	@lngReqId bigint, 
	@lngIntId bigint, 
	@strNoteTypeCode nvarchar(6),
	@strNoteFr nvarchar(500),
	@strNoteEn nvarchar(500),
	@strUserCreated nvarchar(30), 
	@intReturnCode int OUTPUT

--EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_SystemNote_withNoteValues]
--      @lngReqId = NULL, 
--		@lngIntId = NULL,
--		@strNoteTypeCode = NULL,
--      @strNoteFr = NULL,
--      @strNoteEn = NULL,
--		@strUserCreated = NULL,
--		@intReturnCode  = @intReturnCode OUT;

WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_Note_Insert_SystemNote_withNoteValues
-- Insert a new system generated Note in REQUEST_NOTE with values sent in parameters
-- Yves Robichaud 2015/04/17
------------------------------------------------------

DECLARE @Error int;
--DECLARE @lngReqId bigint;
DECLARE @NoteTypeID bigint;
--DECLARE @strNoteFr nvarchar(500);
--DECLARE @strNoteEn nvarchar(500);

IF @lngReqId is NULL
BEGIN
	SELECT @lngReqId = HR_REQUEST_ID FROM [HRSC].[HR_REQUEST_INTERVENTION] WHERE [HR_REQUEST_INTERVENTION_ID] = @lngIntId;
END


SELECT
		@NoteTypeID = [NOTE_TYPE_ID]
		--@strNoteFr = RTRIM([NOTE_TYPE_NAME_DESC_FR]),
		--@strNoteEn = RTRIM([NOTE_TYPE_NAME_DESC_EN])
FROM [HRSC].[CD_NOTE_TYPE]
WHERE [HRSC].[CD_NOTE_TYPE].[NOTE_TYPE_CODE] = @strNoteTypeCode;

DECLARE @strNote nvarchar(500) = @strNoteEn + ' / ' + @strNoteFr

INSERT INTO HRSC.HR_REQUEST_NOTE

( HR_REQUEST_ID,
  HR_REQUEST_INTERVENTION_ID,
  HR_REQUEST_NOTE_TEXT,
  NOTE_TYPE_ID,
  [HR_REQUEST_AUTO_NOTE_EN],
  [HR_REQUEST_AUTO_NOTE_FR],
  USER_CREATED,
  DATE_CREATED
)
values
( @lngReqId,
  @lngIntId,
  @strNote,
  @NoteTypeID,
  @strNoteEn,
  @strNoteFr,
  @strUserCreated,
  GetDate());

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR;

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @intReturnCode = @@ERROR;

