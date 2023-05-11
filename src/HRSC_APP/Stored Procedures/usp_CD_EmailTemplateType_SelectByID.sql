



CREATE   PROCEDURE [HRSC_APP].[usp_CD_EmailTemplateType_SelectByID]
@pEmailTemplateTypeID bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_EmailTemplateType_SelectByID 
-- Retreives info from s specific EmailTemplateType 
-- Gaétan Demers 2012-01-24
------------------------------------------------------
SELECT  email_template_type_id AS id,
        email_template_type_name_en AS name_en,
        email_template_type_name_fr AS name_fr,
        email_template_type_desc_en AS desc_en,
        email_template_type_desc_fr AS desc_fr,
        email_template_type_code AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM hrsc.cd_email_template_type 
WHERE email_template_type_id = @pEmailTemplateTypeID
