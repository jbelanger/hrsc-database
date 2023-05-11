




CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange]
--@lngReqId bigint, @lngIntId bigint, @lngStatusId bigint, @strUserCreated nvarchar(30), @intReturnCode int OUTPUT
@lngReqId bigint, @lngIntId bigint, @lngStatusId bigint, @strUserCreated nvarchar(30), @lngJustificationID bigint, @strJustification nvarchar(1000), @intReturnCode int OUTPUT
WITH EXEC AS CALLER
AS

-- Example of how to call this SP
--  Begin
--    DECLARE @intReturnCode Integer;
--	EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
--        NULL, --@lngReqId 
--		@lngIntID, --@lngIntId
--		@lngStatusID, --@lngStatusId
--		@strUser, --@strUserCreated
--      @lngJustificationID,
--		@strJustification,
--		@intReturnCode OUT; --@intReturnCode
--  End

------------------------------------------------------
-- REQUEST_NOTE_Insert_forStatusChange
-- Insert a new system generated Note in REQUEST_NOTE
-- Yves Robichaud 2015/04/14
------------------------------------------------------

DECLARE @Error int;
--DECLARE @lngReqId bigint;
DECLARE @NoteTypeID bigint;
DECLARE @strStatusFr nvarchar(20);
DECLARE @strStatusEn nvarchar(20);
DECLARE @strNoteFr nvarchar(4000);
DECLARE @strNoteEn nvarchar(4000);
DECLARE @strJustificationTextEn nvarchar(250) = '';
DECLARE @strJustificationTextFr nvarchar(250) = '';

--// For testing only //**
--DECLARE @lngJustificationID BIGINT = 25;
--DECLARE @strJustification nvarchar(1000) = 'TEST - usp_REQUEST_Note_Insert_forStatusChange';

IF @lngReqId is NULL
BEGIN
	SELECT @lngReqId = HR_REQUEST_ID FROM [HRSC].[HR_REQUEST_INTERVENTION] WHERE [HR_REQUEST_INTERVENTION_ID] = @lngIntId;
END

SELECT
		@strStatusFr = REQUEST_STATUS_NAME_FR,
		@strStatusEn = REQUEST_STATUS_NAME_EN
FROM HRSC.CD_REQUEST_STATUS 
WHERE REQUEST_STATUS_ID = @lngStatusId;

IF @lngJustificationID > 0
BEGIN
SELECT
		@strJustificationTextEn = RTRIM(HR_JUSTIFICATION_DESC_EN),
		@strJustificationTextFr = RTRIM(HR_JUSTIFICATION_DESC_FR)
FROM HRSC.CD_HR_JUSTIFICATION
WHERE HR_JUSTIFICATION_ID = @lngJustificationID;
END

SELECT 
		@NoteTypeID = [NOTE_TYPE_ID],
		@strNoteFr = RTRIM([NOTE_TYPE_NAME_DESC_FR]),
		@strNoteEn = RTRIM([NOTE_TYPE_NAME_DESC_EN])
FROM [HRSC].[CD_NOTE_TYPE]
WHERE [HRSC].[CD_NOTE_TYPE].[NOTE_TYPE_CODE] = 'STATUS';

--SET @strNoteFr += ' ' + RTRIM(@strStatusFr)
--SET @strNoteEn += ' ' + RTRIM(@strStatusEn)
SET @strNoteFr = REPLACE(@strNoteFr, '{STATUSNAME}', RTRIM(@strStatusFr))
IF @strJustificationTextFr IS NULL OR @strJustificationTextFr = ''
BEGIN
	SET @strNoteFr = REPLACE(@strNoteFr, '<br />Justification: {JUSTIFICATIONDESC}', '')
END
ELSE
BEGIN
	SET @strNoteFr = REPLACE(@strNoteFr, '{JUSTIFICATIONDESC}', RTRIM(@strJustificationTextFr))
END

IF @strJustification IS NULL OR @strJustification = ''
BEGIN
	SET @strNoteFr = REPLACE(@strNoteFr, '<br />Autre justification: {OTHERJUSTIFICATION}', '')
END
ELSE
BEGIN
	SET @strNoteFr = REPLACE(@strNoteFr, '{OTHERJUSTIFICATION}', RTRIM(@strJustification))
END

SET @strNoteEn = REPLACE(@strNoteEn, '{STATUSNAME}', RTRIM(@strStatusEn))
IF @strJustificationTextEn IS NULL OR @strJustificationTextEn = ''
BEGIN
	SET @strNoteEn = REPLACE(@strNoteEn, '<br />Justification: {JUSTIFICATIONDESC}', '')
END
ELSE
BEGIN
	SET @strNoteEn = REPLACE(@strNoteEn, '{JUSTIFICATIONDESC}', RTRIM(@strJustificationTextEn))
END

IF @strJustification IS NULL OR @strJustification = ''
BEGIN
	SET @strNoteEn = REPLACE(@strNoteEn, '<br />Other justification: {OTHERJUSTIFICATION}', '')
END
ELSE
BEGIN
	SET @strNoteEn = REPLACE(@strNoteEn, '{OTHERJUSTIFICATION}', RTRIM(@strJustification))
END



DECLARE @strNote nvarchar(4000) = @strNoteEn + ' / ' + @strNoteFr

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

