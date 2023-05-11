
CREATE PROCEDURE [HRSC_APP].[usp_REQUEST_Update]
@pRequestID bigint, @pSubjectText nvarchar(250), @pKeywordsText nvarchar(250), @pRequestDescText nvarchar(4000), 
@pReservedInd bit, @pEmailInd bit, @pCategoryID bigint, @pSubCategoryID bigint, @pPriorityID bigint, 
@pRegionID bigint, @pRcCode nvarchar(5), @pOrganizationID bigint, @pSubOrganizationID bigint, 
@pModeOfReceiptID bigint, @pLanguageCorrID bigint, @pLanguageDocID bigint, @pXmlManager xml, 
@pXmlManagerAlt xml, @pTermOfUseAgreementInd bit, @pRequestTypeID bigint, @pUser nvarchar(30), 
@pReturnCode bigint OUTPUT,@pXmlManagerSD XML, @pXmlManagerHost XML
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- REQUEST_Update
-- Update an existing HR Request in DB 
-- Gaétan Demers 2011-12-14 -- Gaétan Demers 2012-01-19 Update to take into account that 
--                          EmployeeRoleForRequest must be
--                          Updated with Users.
-- HR_REQUEST_IDENTIFIER can not be change.
------------------------------------------------------
-- Declare our variables
DECLARE @Error int
DECLARE @ReturnCall int;

-- Delete all records for Employee_Role_For_Request for this draft
exec @ReturnCall = usp_EMPLOYEE_ROLE_FOR_REQ_DeleteByRequest @pRequestID, @pUser

if @ReturnCall = 0
  begin
  -- No error, so we can update the Draft
  update HRSC.HR_REQUEST
    set 
      SUBJECT_TEXT=@pSubjectText,
      KEYWORDS_TEXT=@pKeywordsText,
      REQUEST_DESCRIPTION_TEXT=@pRequestDescText,
      RC_CODE=@pRcCode,
      --REQUEST_COUNT = @pRequestCount,
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
      REQUEST_SUB_CATEGORY_ID=@pSubCategoryID
  where HR_REQUEST_ID = @pRequestID;

  -- Move it to our local variable, and check for an error condition
  SELECT @Error = @@ERROR;

  ---- A Stored Proc always return 0 if no error.
	 -- IF @Error = 0
		--begin
		--	-- Now insert the Employee_Role_for_Request
		--	exec @ReturnCall = usp_EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID @pRequestID, @pUser, @pXmlManager
		--	if @ReturnCall = 0
		--	  begin
		--	  -- Insert AltManager
		--	  exec @ReturnCall = usp_EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID @pRequestID, @pUser, @pXmlManagerAlt
		--	  if @ReturnCall != 0
		--		 set @pReturnCode = @ReturnCall
		--	  else
		--		 set @pReturnCode = 0
		--	  end
		--	  end;
		--	return @pReturnCode
		
		IF @Error = 0
	BEGIN
    -- Now insert the Employee_Role_for_Request
--Lead Manager   
    EXEC @ReturnCall = usp_EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID @pRequestID, @pUser, @pXmlManager
    
    IF @ReturnCall = 0
      BEGIN
-- Insert AltManager
		  EXEC @ReturnCall = usp_EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID @pRequestID, @pUser, @pXmlManagerAlt
		  IF @ReturnCall != 0
			 SET @pReturnCode = @ReturnCall
		  ELSE
			 SET @pReturnCode = 0
      END

    IF @ReturnCall = 0
      BEGIN
-- Insert SubDelegateManager			 
		  EXEC @ReturnCall = usp_EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID @pRequestID, @pUser, @pXmlManagerSD
		  IF @ReturnCall != 0
			 SET @pReturnCode = @ReturnCall
		  ELSE
			 SET @pReturnCode = 0
      END
    IF @ReturnCall = 0
      BEGIN
-- Insert HostManager			 
		  EXEC @ReturnCall = usp_EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID @pRequestID, @pUser, @pXmlManagerHost
		  IF @ReturnCall != 0
			 SET @pReturnCode = @ReturnCall
		  ELSE
			 SET @pReturnCode = 0			 
      END
           
  ELSE
    SET @pReturnCode = @ReturnCall;
  END;
ELSE
   SET @pReturnCode = @Error;
	end
else
    return @Error
