



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_SUBCATEGORY_GetList]
@pRequest_Category_ID bigint, @pSURVEY_IND BIT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- RequestCategory_GetList
-- Retreives all Category
-- Tony Paradis 2011-12-13 
-- ENO          2016-05-25 'Added French
------------------------------------------------------

select REQUEST_SUB_CATEGORY_ID,
       REQUEST_SUB_CATEGORY_NAME_EN +'/'+ REQUEST_SUB_CATEGORY_NAME_FR as SUBCATEGORY_NAME,
       REQUEST_SUB_CATEGORY_NAME_FR +'/'+ REQUEST_SUB_CATEGORY_NAME_EN as SUBCATEGORY_NAME_FR
       
from HRSC.CD_REQUEST_SUB_CATEGORY
WHERE REQUEST_CATEGORY_ID = @pRequest_Category_ID and SURVEY_IND = @pSURVEY_IND
ORDER BY SUBCATEGORY_NAME
