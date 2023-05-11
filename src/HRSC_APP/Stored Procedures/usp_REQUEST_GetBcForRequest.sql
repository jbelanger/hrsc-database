



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_GetBcForRequest]
@pRequestID bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_GetBcForRequest
-- Retreives all the BC for a specific request HR_Request 
-- Gaétan Demers 2012-03-12 
------------------------------------------------------
/** Modified for SQL Server 2016 François Girouard ***/

SELECT	RI.HR_REQUEST_INTERVENTION_ID,
		RI.BUSINESS_CENTER_ID,
		RI.HR_REQUEST_ID,
		BC.BUSINESS_CENTER_CODE
FROM	HRSC.HR_REQUEST_INTERVENTION RI
		INNER JOIN HRSC.CD_BUSINESS_CENTER BC ON RI.BUSINESS_CENTER_ID = BC.BUSINESS_CENTER_ID
WHERE	RI.HR_REQUEST_ID = @pRequestID
