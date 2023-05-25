



CREATE   PROCEDURE [HRSC_APP].[usp_CD_EmailTemplateType_SelectActive]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- SelectActiveCdEmailTemplateType 
-- Retreives all active Email Template Type 
-- Gaétan Demers 2011-12-13 
-- Eric Nolet 2011-12-15 Added Aliases
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
FROM    HRSC.CD_EMAIL_TEMPLATE_TYPE
WHERE   EXPIRY_DATE IS NULL
