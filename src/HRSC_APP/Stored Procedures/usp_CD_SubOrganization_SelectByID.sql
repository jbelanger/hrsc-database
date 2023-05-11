



CREATE   PROCEDURE [HRSC_APP].[usp_CD_SubOrganization_SelectByID]
	
	@pCD_SubOrganization_ID bigint
	
WITH EXEC AS CALLER
AS

select * 
from HRSC.CD_SUB_ORGANIZATION
where 
SUB_ORGANIZATION_ID = @pCD_SubOrganization_ID
