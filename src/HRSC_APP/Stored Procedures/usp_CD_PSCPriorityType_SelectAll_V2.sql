
CREATE PROCEDURE [HRSC_APP].[usp_CD_PSCPriorityType_SelectAll_V2]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_CD_PSCPriorityType_SelectAll_V2
-- Yves Robichaud 2014-12-22
------------------------------------------------------
SELECT  PRIORITY_TYPE_id AS id,
        PRIORITY_TYPE_name_en AS name_en,
        PRIORITY_TYPE_name_fr AS name_fr,
        PRIORITY_TYPE_desc_en AS desc_en,
        PRIORITY_TYPE_desc_fr AS desc_fr,
        PRIORITY_TYPE_code AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM    HRSC.CD_PRIORITY_TYPE
WHERE PSC_PRIORITY_IND = 1 AND
	  PRIORITY_TYPE_code <> 'Other' -- This value is only valid in version 1 of the forms
