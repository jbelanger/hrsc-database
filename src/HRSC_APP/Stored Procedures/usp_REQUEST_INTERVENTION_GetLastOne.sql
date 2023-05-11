
------------------------------------------------------
-- usp_REQUEST_INTERVENTION_GetLastOne
-- 
-- Michel Tardif 2017-04-10
------------------------------------------------------

CREATE PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_GetLastOne]
@lngID bigint,  @lngInterventionId bigint OUTPUT
WITH EXEC AS CALLER
AS
	SELECT  @lngInterventionId =  [HR_REQUEST_INTERVENTION_ID]
 
FROM   HRSC.HR_REQUEST_INTERVENTION 
		
WHERE [HR_REQUEST_ID] = @lngID 
     
ORDER BY [DATE_CREATED]
