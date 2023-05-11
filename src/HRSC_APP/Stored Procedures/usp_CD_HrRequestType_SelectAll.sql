




CREATE   PROCEDURE [HRSC_APP].[usp_CD_HrRequestType_SelectAll]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_HrRequestType_SelectAll 
-- Retreives all active HR Request Type (Active and inactive)
-- Gaétan Demers  2011-12-13
-- Eric Nolet     2011-12-15 Added Aliases
------------------------------------------------------
SELECT  hr_request_type_id AS id,
        hr_request_type_name_en AS name_en,
        hr_request_type_name_fr AS name_fr,
        hr_request_type_desc_en AS desc_en,
        hr_request_type_desc_fr AS desc_fr,
        hr_request_type_code AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM    hrsc.cd_hr_request_type

