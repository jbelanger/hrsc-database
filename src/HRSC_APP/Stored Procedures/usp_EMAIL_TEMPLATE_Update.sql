
CREATE PROCEDURE [HRSC_APP].[usp_EMAIL_TEMPLATE_Update]
	@pEmailTemplateID bigint, 
	@pSubjectEN nvarchar(100), 
	@pSubjectFR nvarchar(100), 
	@pBodyEN nvarchar(max), 
	@pBodyFR nvarchar(max), 
	@pEffectiveDate date, 
	@pExpiryDate date, 
	@pUserUpdated nvarchar(30)
WITH EXEC AS CALLER
AS
    UPDATE HRSC.EMAIL_TEMPLATE
    SET EMAIL_TEMPLATE_SUBJECT_EN = @pSubjectEN,
        EMAIL_TEMPLATE_SUBJECT_FR = @pSubjectFR,
        EMAIL_TEMPLATE_BODY_EN = @pBodyEN,
        EMAIL_TEMPLATE_BODY_FR = @pBodyFR,
        EFFECTIVE_DATE = @pEffectiveDate,
        EXPIRY_DATE = @pExpiryDate,
        USER_UPDATED = @pUserUpdated,
        DATE_UPDATED = GetDate()
    WHERE EMAIL_TEMPLATE_ID = @pEmailTemplateID


