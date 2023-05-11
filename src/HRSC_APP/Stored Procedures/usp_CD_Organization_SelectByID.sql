



CREATE   PROCEDURE [HRSC_APP].[usp_CD_Organization_SelectByID]
	
	@pCD_Organization_ID bigint
	
WITH EXEC AS CALLER
AS

select * 
from HRSC.CD_ORGANIZATION
where 
ORGANIZATION_ID = @pCD_Organization_ID
