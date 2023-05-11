



CREATE   PROCEDURE [HRSC_APP].[usp_RequestSubCategory_Delete]
	@pSubcategory_ID bigint,
	@ReturnCode int OUTPUT

		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- UPDATE Category
-- UPDATE an existing Category for request in DB 
-- Tony Paradis 2011-12-18 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

	
	Delete HRSC.CD_REQUEST_SUB_CATEGORY
	WHERE REQUEST_SUB_CATEGORY_ID = @pSubCategory_ID  		    
    
			

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0
