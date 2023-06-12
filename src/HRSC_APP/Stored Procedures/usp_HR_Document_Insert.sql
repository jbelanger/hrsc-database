



CREATE     PROCEDURE [HRSC_APP].[usp_HR_Document_Insert] @pDocumentFile VARBINARY(MAX)
	,@pName NVARCHAR(255)
	,@pDescEN NVARCHAR(250)
	,@pDescFR NVARCHAR(250)
	,@pPublicInd BIT
	,@pRequestID BIGINT
	,@pDocumentSize INT
	,@pUserID NVARCHAR(30)
	,@pNewRowID BIGINT OUTPUT
	WITH
EXEC AS CALLER AS

DECLARE @intReturnCode INTEGER

INSERT INTO HRSC.HR_DOCUMENT (
	HR_DOCUMENT_FILE
	,PUBLIC_DOCUMENT_IND
	,EXPIRY_DATE
	,USER_CREATED
	,DATE_CREATED
	,HR_REQUEST_ID
	,HR_DOCUMENT_NAME
	,HR_DOCUMENT_DESC_EN
	,HR_DOCUMENT_DESC_FR
	,FILE_SIZE -- TODO: Stores file size for now, create separate column and reestablish original purpose
	)
VALUES (
	@pDocumentFile
	,@pPublicInd
	,NULL
	,@pUserID
	,GetDate()
	,@pRequestID
	,@pName
	,@pDescEN
	,@pDescFR
	,@pDocumentSize
	);

SET @pNewRowID = @@IDENTITY;

EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_SystemNote_ConcatenateWithNoteValues] @pRequestID
	,NULL
	,'DOCA'
	,@pName
	,@pName
	,@pUserID
	,@intReturnCode OUT;
