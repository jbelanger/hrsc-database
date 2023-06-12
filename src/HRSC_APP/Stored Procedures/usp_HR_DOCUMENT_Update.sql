


/* This procedure never updates the binary data. */
CREATE   PROCEDURE [HRSC_APP].[usp_HR_DOCUMENT_Update] @pDocumentId BIGINT
	,@pName NVARCHAR(255)
	,@pDescEN NVARCHAR(250)
	,@pDescFR NVARCHAR(250)
	,@pPublicInd BIT
	,@pRequestID BIGINT
	,@pExpiryDate DATETIME
	,@pUserID NVARCHAR(30)
	WITH
EXEC AS CALLER AS

UPDATE HRSC.HR_DOCUMENT
SET PUBLIC_DOCUMENT_IND = @pPublicInd
	,EXPIRY_DATE = @pExpiryDate
	--USER_UPDATED = @pUserID, TODO: Stores file size for now, create separate column and reestablish original purpose
	,DATE_UPDATED = GetDate()
	,HR_REQUEST_ID = @pRequestID
	,HR_DOCUMENT_NAME = @pName
	,HR_DOCUMENT_DESC_EN = @pDescEN
	,HR_DOCUMENT_DESC_FR = @pDescFR
WHERE HR_DOCUMENT_ID = @pDocumentId;

