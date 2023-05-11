





CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Update_New2]
	@pRequestID bigint, 
	@pSubjectText nvarchar(250), 
	@pKeywordsText nvarchar(250), 
	@pRequestDescText nvarchar(4000), 
	@pRcCode nvarchar(10),
	@pEX_IND bit,
	@pReservedInd bit, 
	@pEmailInd bit, 
	@pTermOfUseAgreementInd bit, 
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
	@pUser nvarchar(30),
	@pEffectiveDate date, 
	@PayPeriodNumber bigint, 
	@ProcessingOpenDate date, 
	@ProcessingCloseDate date,
	@pTempData varchar(4000),
	@pIsProtected bit,
	@pIsRecalled bit,
	@SELECTION_PROCESS_NUMBER varchar(30)

WITH EXEC AS CALLER
AS

  update HRSC.HR_REQUEST
    set 
      SUBJECT_TEXT=@pSubjectText,
      KEYWORDS_TEXT=@pKeywordsText,
      REQUEST_DESCRIPTION_TEXT=@pRequestDescText,
      RC_CODE=@pRcCode,
	  EX_IND=@pEX_IND,
      RESERVED_IND=@pReservedInd,
      SEND_EMAIL_IND=@pEmailInd,
      TERM_OF_USE_AGREEMENT_IND=@pTermOfUseAgreementInd,
      USER_UPDATED=@pUser,
      DATE_UPDATED=GetDate(),
      DOCUMENTS_LANGUAGE_ID=@pLanguageDocID,
      CORRESPONDENCE_LANGUAGE_ID=@pLanguageCorrID,
      MODE_OF_RECEIPT_ID=@pModeOfReceiptID,
      REGION_ID=@pRegionID,
      ORGANIZATION_ID=@pOrganizationID,
      REQUEST_CATEGORY_ID=@pCategoryID,
      SUB_ORGANIZATION_ID=@pSubOrganizationID,
      HR_REQUEST_TYPE_ID=@pRequestTypeID,
      PRIORITY_OF_REQUEST_ID=@pPriorityID,
      REQUEST_SUB_CATEGORY_ID=@pSubCategoryID,
	  PAY_PERIOD_NUMBER = @PayPeriodNumber,
	  PROCESSING_OPEN_DATE = @ProcessingOpenDate,
	  PROCESSING_CLOSE_DATE = @ProcessingCloseDate,
	  EFFECTIVE_DATE = @pEffectiveDate,
	  TEMP_DATA = @pTempData,
	  IS_PROTECTED = @pIsProtected,
	  IS_RECALLED = @pIsRecalled,
	  [STAFFING_PROCESS_NUMBER] = @SELECTION_PROCESS_NUMBER
  where HR_REQUEST_ID = @pRequestID;
