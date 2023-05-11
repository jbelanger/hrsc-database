



CREATE   PROCEDURE [HRSC_APP].[usp_CD_EmailTemplateType_Insert]
@pNameEn nvarchar(250), @pNameFr nvarchar(250), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pCode nvarchar(5), @pEffectiveDate date, @pExpiryDate date, @pUserCreated nvarchar(30), @pNewRowID bigint OUTPUT, @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdEmailTemplateType
-- Insert a new Email Template Type in DB 
-- Gaétan Demers 2011-12-13 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

-- Effective date can not be null
if @pEffectiveDate IS null 
  set @pEffectiveDate = GetDate()
  
insert into HRSC.CD_EMAIL_TEMPLATE_TYPE
  (EMAIL_TEMPLATE_TYPE_NAME_EN,
   EMAIL_TEMPLATE_TYPE_NAME_FR,
   EMAIL_TEMPLATE_TYPE_DESC_EN,
   EMAIL_TEMPLATE_TYPE_DESC_FR,
   EMAIL_TEMPLATE_TYPE_CODE,
   EFFECTIVE_DATE,
   EXPIRY_DATE,
   USER_CREATED,
   DATE_CREATED)
values
  (@pNameEn,
   @pNameFr,
   @pDescEn,
   @pDescFr,
   @pCode,
   @pEffectiveDate,
   @pExpiryDate,
   @pUserCreated,
   GetDate())
   

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR
set @pNewRowID = @@IDENTITY;

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
