
CREATE PROCEDURE [HRSC_APP].[usp_CD_VERSION_SelectAll]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_CD_VERSION_SelectAll
------------------------------------------------------
SELECT  VERSION_ID AS id,
        VERSION_NAME_EN AS name_en,
        VERSION_NAME_FR AS name_fr,
        VERSION_DESC_EN AS desc_en,
        VERSION_DESC_FR AS desc_fr,
        VERSION_CODE AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM    HRSC.CD_VERSION
