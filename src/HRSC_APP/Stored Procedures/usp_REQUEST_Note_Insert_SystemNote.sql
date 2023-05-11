



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Note_Insert_SystemNote]
	@lngReqId bigint, 
	@lngIntId bigint, 
	@lngNoteTypeId bigint,
	@strUserCreated nvarchar(30)


--EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_SystemNote]
--      @lngReqId = NULL, 
--		@lngIntId = NULL,
--		@strNoteTypeCode = NULL,
--		@strUserCreated = NULL,
--		@intReturnCode  = @intReturnCode OUT;

WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_Note_Insert_SystemNote
-- Insert a new system generated Note in REQUEST_NOTE
-- Yves Robichaud 2015/04/15
------------------------------------------------------

DECLARE @strNoteFr nvarchar(500);
DECLARE @strNoteEn nvarchar(500);

IF @lngReqId is NULL
BEGIN
	SELECT @lngReqId = HR_REQUEST_ID FROM [HRSC].[HR_REQUEST_INTERVENTION] WHERE [HR_REQUEST_INTERVENTION_ID] = @lngIntId;
END

SELECT
		@strNoteFr = RTRIM([NOTE_TYPE_NAME_DESC_FR]),
		@strNoteEn = RTRIM([NOTE_TYPE_NAME_DESC_EN])
FROM [HRSC].[CD_NOTE_TYPE]
WHERE [HRSC].[CD_NOTE_TYPE].NOTE_TYPE_ID = @lngNoteTypeId;

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
  @lngNoteTypeId,
  @strNoteEn,
  @strNoteFr,
  @strUserCreated,
  GetDate());
