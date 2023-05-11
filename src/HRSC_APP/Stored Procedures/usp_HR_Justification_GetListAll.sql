





CREATE   PROCEDURE [HRSC_APP].[usp_HR_Justification_GetListAll]
@Request_StatusID BIGINT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_HR_Justification_GetListAll
-- Retreives all Justification
-- Tony Paradis 2013-02-04
------------------------------------------------------

	SELECT 
		HR_JUSTIFICATION_ID,	
		HR_JUSTIFICATION_NAME_EN, 
		HR_JUSTIFICATION_NAME_FR, 
		HR_JUSTIFICATION_DESC_EN, 
		HR_JUSTIFICATION_DESC_FR
	FROM HRSC.CD_HR_JUSTIFICATION
	WHERE EFFECTIVE_DATE <= GETDATE() 
		AND (EXPIRY_DATE > getdate() or EXPIRY_DATE is null)
		AND HR_JUSTIFICATION_ID in (
			select HR_JUSTIFICATION_ID 
			from HRSC.REQ_STATUS_JUSTIFICATION 
			WHERE REQUEST_STATUS_ID = @Request_StatusID
			AND EXPIRY_DATE is null
		)
