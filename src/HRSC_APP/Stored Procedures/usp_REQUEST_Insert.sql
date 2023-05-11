






CREATE     PROCEDURE [HRSC_APP].[usp_REQUEST_Insert]
	@pSubjectText nvarchar(250), 
	@pKeywordsText nvarchar(250), 
	@pRequestDescText nvarchar(4000), 
	@pRcCode nvarchar(10), 
	@pEX_IND bit, 
	@pReservedInd bit, 
	@pEmailInd bit, 
	@pTermOfUseAgreementInd numeric(1, 0), 
	@pLanguageDocID bigint, 
	@pLanguageCorrID bigint, 
	@pModeOfReceiptID bigint, 
	@pRegionID bigint, 
	@pOrganizationID bigint, 
	@pSubOrganizationID bigint, 
	@pCategoryID bigint, 
	@pSubCategoryID bigint, 
	@pRequestTypeID bigint, 
	@pPriorityID bigint, 	
	@pFormVersion tinyint, 
	@pSubmitterTypeId bigint, 
	@pArt34Indicator bit,
	@pPeriodNumber integer,
	@pEffectiveDate date,
	@pProcessingOpenDate date,
	@pProcessingCloseDate date,
	@pRequestClientId bigint,
	@pStatusId as bigint,
	@pTempData varchar(4000),
	@pUserCreated nvarchar(30), 
	@pIsProtected bit,
	@pNewRowID bigint OUTPUT,
	@pRequestIdentifier nvarchar(16) OUTPUT,
	@SELECTION_PROCESS_NUMBER nvarchar(30)
WITH EXEC AS CALLER
AS

	SELECT @pRequestIdentifier = HRSC_APP.GenerateRequestNumber();
	

	INSERT INTO [HRSC].[HR_REQUEST]
           ([HR_REQUEST_IDENTIFIER]
           ,[SUBJECT_TEXT]
           ,[KEYWORDS_TEXT]
           ,[REQUEST_DESCRIPTION_TEXT]
           ,[RC_CODE]
		   ,[EX_IND]
           ,[RESERVED_IND]
           ,[SEND_EMAIL_IND]
           ,[TERM_OF_USE_AGREEMENT_IND]
           ,[USER_CREATED]
           ,[DATE_CREATED]
           ,[DOCUMENTS_LANGUAGE_ID]
           ,[CORRESPONDENCE_LANGUAGE_ID]
           ,[MODE_OF_RECEIPT_ID]
           ,[REGION_ID]
           ,[ORGANIZATION_ID]
           ,[REQUEST_CATEGORY_ID]
           ,[SUB_ORGANIZATION_ID]
           ,[HR_REQUEST_TYPE_ID]
           ,[PRIORITY_OF_REQUEST_ID]
           ,[REQUEST_SUB_CATEGORY_ID]
           ,[FORM_VERSION]
           ,[ART34_IND]
           ,[PAY_PERIOD_NUMBER]
           ,[PROCESSING_OPEN_DATE]
           ,[PROCESSING_CLOSE_DATE]
           ,[REQUEST_STATUS_ID]
           ,[EFFECTIVE_DATE]
           ,[SUBMITTER_TYPE_ID]
           ,[REQUEST_STATUS_DATE]
           ,[LANGUAGE_ID]
           ,[NEXT_EMAIL_REMINDER_DATE]
           ,[EMAIL_REMINDER_COUNT]
		   ,[HR_REQUEST_CLIENT_ID]
		   ,[TEMP_DATA]
		   ,[IS_PROTECTED]
		   ,[STAFFING_PROCESS_NUMBER])
     VALUES (
           @pRequestIdentifier,
           @pSubjectText,
           @pKeywordsText,
           @pRequestDescText,
           @pRcCode,
		   @pEX_IND,
           @pReservedInd,
           @pEmailInd,
           @pTermOfUseAgreementInd,
           @pUserCreated,
           GETDATE(),
           @pLanguageDocID,
           @pLanguageCorrID,
           @pModeOfReceiptID,
           @pRegionID,
           @pOrganizationID,
           @pCategoryID,
           @pSubOrganizationID,
           @pRequestTypeID,
           @pPriorityID,
           @pSubCategoryID,
           @pFormVersion,
           @pArt34Indicator,
           @pPeriodNumber,
           @pProcessingOpenDate,
           @pProcessingCloseDate,
           @pStatusId,
           @pEffectiveDate,
           @pSubmitterTypeId,
           GetDate(),
           null,
           null,
           null,
		   @pRequestClientId,
		   @pTempData,
		   @pIsProtected,
		   @SELECTION_PROCESS_NUMBER);

  set @pNewRowID = @@IDENTITY;
