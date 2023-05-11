



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_NOTE_Insert2]
	@lngReqId bigint, 
	@lngIntId bigint, 
	@NoteTypeID bigint,
	@noteText nvarchar(4000),
	@autoNoteFr nvarchar(500),
	@autoNoteEn nvarchar(500),
	@strUserCreated nvarchar(30)


WITH EXEC AS CALLER
AS

INSERT INTO HRSC.HR_REQUEST_NOTE(
	HR_REQUEST_ID,
	HR_REQUEST_INTERVENTION_ID,
	HR_REQUEST_NOTE_TEXT,
	NOTE_TYPE_ID,
	[HR_REQUEST_AUTO_NOTE_EN],
	[HR_REQUEST_AUTO_NOTE_FR],
	USER_CREATED,
	DATE_CREATED
)
values (
	@lngReqId,
	@lngIntId,
	@noteText,
	@NoteTypeID,
	@autoNoteEn,
	@autoNoteFr,
	@strUserCreated,
	GetDate());
