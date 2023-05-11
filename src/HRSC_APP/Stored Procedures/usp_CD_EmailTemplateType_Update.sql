



CREATE   PROCEDURE [HRSC_APP].[usp_CD_EmailTemplateType_Update]
@pEmailTemplateTypeID bigint, @pNameEn nvarchar(250), @pNameFr nvarchar(250), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pCode nvarchar(5), @pEffectiveDate date, @pExpiryDate date, @pUserUpdated nvarchar(30), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdEmailTemplateType
-- Insert a new Email Template Type in DB 
-- Gaétan Demers 2011-12-13 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

update HRSC.CD_EMAIL_TEMPLATE_TYPE
  set EMAIL_TEMPLATE_TYPE_NAME_EN = @pNameEn,
      EMAIL_TEMPLATE_TYPE_NAME_FR = @pNameFr,
      EMAIL_TEMPLATE_TYPE_DESC_EN = @pDescEn,
      EMAIL_TEMPLATE_TYPE_DESC_FR = @pDescFr,
      EMAIL_TEMPLATE_TYPE_CODE = @pCode,
      EFFECTIVE_DATE = @pEffectiveDate,
      EXPIRY_DATE = @pExpiryDate,
      USER_UPDATED = @pUserUpdated,
      DATE_UPDATED = GetDate()
	WHERE EMAIL_TEMPLATE_TYPE_ID = @pEmailTemplateTypeID  
  
-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
