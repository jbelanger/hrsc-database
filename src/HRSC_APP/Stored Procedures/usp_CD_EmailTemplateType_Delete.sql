



CREATE   PROCEDURE [HRSC_APP].[usp_CD_EmailTemplateType_Delete]
@pEmailTemplateTypeID bigint, @pUserUpdated nvarchar(30), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_EmailTemplateType_Delete
-- Delete (logical) an Email Template Type in DB 
-- Gaétan Demers 2012-01-24 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

update HRSC.CD_EMAIL_TEMPLATE_TYPE
  set EXPIRY_DATE = GetDate(),
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
