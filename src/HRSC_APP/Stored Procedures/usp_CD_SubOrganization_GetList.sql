



CREATE   PROCEDURE [HRSC_APP].[usp_CD_SubOrganization_GetList]
@pOrganization_ID bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- RequestCategory_GetList
-- Retreives all Category
-- Tony Paradis 2011-12-13 
------------------------------------------------------

select SUB_ORGANIZATION_ID, SUB_ORGANIZATION_NAME_EN +'/'+ SUB_ORGANIZATION_NAME_FR as SUB_ORGANIZATION_NAME
from HRSC.CD_SUB_ORGANIZATION
WHERE ORGANIZATION_ID = @pOrganization_ID
ORDER BY SUB_ORGANIZATION_NAME

