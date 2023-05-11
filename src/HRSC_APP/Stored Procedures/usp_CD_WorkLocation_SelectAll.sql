
--exec  [HRSC_APP].[usp_CD_WorkLocation_SelectAll]
CREATE PROCEDURE [HRSC_APP].[usp_CD_WorkLocation_SelectAll]
WITH EXEC AS CALLER
AS
/* 
	CD_WorkLocation_SelectAll 
	Retreives all Work Location (active and inactive)
	E.Akhmetova 2013-01-15
*/
DECLARE @OFFICE_SITE_ID BIGINT
SELECT 
	OFFICE_SITE_ID AS id,
    OFFICE_SITE_NAME AS name_en,
    OFFICE_SITE_NAME AS name_fr,
    OFFICE_SITE_NAME AS desc_en,
    OFFICE_SITE_NAME AS desc_fr,
    OFFICE_SITE_NUMBER AS code,
    effective_date,
    expiry_date,
    user_created,
    user_updated,
    date_created,
    date_updated
FROM HRSC.OFFICE_SITE 
WHERE EXPIRY_DATE IS NULL

UNION 

SELECT  
	OFFICE_SITE_ID AS id,
    OFFICE_SITE_NAME AS name_en,
    OFFICE_SITE_NAME AS name_fr,
    OFFICE_SITE_NAME AS desc_en,
    OFFICE_SITE_NAME AS desc_fr,
    OFFICE_SITE_NUMBER AS code,
    effective_date,
    expiry_date,
    user_created,
    user_updated,
    date_created,
    date_updated
FROM HRSC.OFFICE_SITE 
WHERE OFFICE_SITE_ID = @OFFICE_SITE_ID
