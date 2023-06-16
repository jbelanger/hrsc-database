



CREATE   PROCEDURE [HRSC_APP].[usp_CD_EmailTemplateType_SelectByID]
@pEmailTemplateTypeID bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_EmailTemplateType_SelectByID 
-- Retreives info from s specific EmailTemplateType 
-- Gaétan Demers 2012-01-24
------------------------------------------------------
SELECT  EMAIL_TEMPLATE_TYPE_ID AS ID,
        EMAIL_TEMPLATE_TYPE_NAME_EN AS NAME_EN,
        EMAIL_TEMPLATE_TYPE_NAME_FR AS NAME_FR,
        EMAIL_TEMPLATE_TYPE_DESC_EN AS DESC_EN,
        EMAIL_TEMPLATE_TYPE_DESC_FR AS DESC_FR,
        EMAIL_TEMPLATE_TYPE_CODE AS CODE,
        EFFECTIVE_DATE,
        EXPIRY_DATE,
        USER_CREATED,
        USER_UPDATED,
        DATE_CREATED,
        DATE_UPDATED
FROM HRSC.CD_EMAIL_TEMPLATE_TYPE 
WHERE EMAIL_TEMPLATE_TYPE_ID = @pEmailTemplateTypeID
