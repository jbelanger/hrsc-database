

CREATE   PROCEDURE [HRSC_APP].[usp_CD_Organization_Report]
(@Lang VARCHAR(10))
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_CD_Organization_Report
-- Retreives all active Organization for display on DDL in reports
-- Yves Robichaud  2013-09-10
------------------------------------------------------

IF @Lang = 'English'
BEGIN

    SELECT  organization_id AS id,
            organization_name_en AS Org_Name,
            organization_desc_en AS Org_Desc,
            organization_code AS code,
            organization_acronym_en AS Org_Acronym,
            effective_date,
            expiry_date,
            user_created,
            user_updated,
            date_created,
            date_updated
    FROM    hrsc.cd_organization
    WHERE   expiry_date IS null

END
ELSE
BEGIN

    SELECT  organization_id AS id,
            organization_name_fr AS Org_Name,
            organization_desc_fr AS Org_Desc,
            organization_code AS code,
            organization_acronym_fr AS Org_Acronym,
            effective_date,
            expiry_date,
            user_created,
            user_updated,
            date_created,
            date_updated
    FROM    hrsc.cd_organization
    WHERE   expiry_date IS null


END	
