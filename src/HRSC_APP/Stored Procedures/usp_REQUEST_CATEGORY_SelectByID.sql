



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_CATEGORY_SelectByID]
	
	@pRequest_Category_ID bigint
	
WITH EXEC AS CALLER
AS

select * 
from HRSC.CD_REQUEST_CATEGORY
where 
REQUEST_CATEGORY_ID = @pRequest_Category_ID
