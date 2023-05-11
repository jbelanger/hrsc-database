



CREATE   PROCEDURE [HRSC_APP].[usp_CD_Organization_GetList]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_Organization_GetList
-- Retreives all Organization
-- Tony Paradis 2012-01-03 
------------------------------------------------------

select ORGANIZATION_ID, ORGANIZATION_NAME_EN +'/'+ ORGANIZATION_NAME_FR as ORGANIZATION_NAME
from HRSC.CD_ORGANIZATION
ORDER BY ORGANIZATION_NAME

