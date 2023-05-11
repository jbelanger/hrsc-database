



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_SUBCATEGORY_SelectByID]
	
	@pRequest_SubCategory_ID bigint
	
WITH EXEC AS CALLER
AS

select * 
from HRSC.CD_REQUEST_SUB_CATEGORY
where 
REQUEST_SUB_CATEGORY_ID = @pRequest_SubCategory_ID
