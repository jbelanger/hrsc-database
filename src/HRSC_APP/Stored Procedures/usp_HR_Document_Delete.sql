



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Document_Delete]
@pHrDocumentID bigint,
@pUserID nvarchar(30)

WITH EXEC AS CALLER
AS

DECLARE @pRequestID bigint;
DECLARE @pName nvarchar(255);
DECLARE @intReturnCode Integer;

select	@pRequestID = HR_REQUEST_ID,
		@pName = HR_DOCUMENT_NAME

From HRSC.HR_DOCUMENT
where HR_DOCUMENT_ID = @pHrDocumentID

		EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_SystemNote_ConcatenateWithNoteValues]
			@pRequestID, --@lngReqId, 
			NULL, --@lngIntId
			'DOCD', --@strNoteTypeCode
			@pName, --@strNoteFr,
			@pName, --@strNoteEn,
			@pUserID, --@strUserCreated
			@intReturnCode OUT;


delete from HRSC.HR_DOCUMENT
where HR_DOCUMENT_ID = @pHrDocumentID
