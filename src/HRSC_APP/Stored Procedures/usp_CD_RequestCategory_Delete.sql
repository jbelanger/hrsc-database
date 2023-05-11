



-- =============================================
-- Delete Category
-- Delete an existing Category for request in DB 
-- Tony Paradis 2011-12-18 
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_CD_RequestCategory_Delete]
		@pCategory_ID bigint,
	@ReturnCode int OUTPUT
AS
	DECLARE @Error int
	DECLARE @vCount bigint
	SELECT @vCount = COUNT(*)
		 FROM [HRSC].[CD_REQUEST_SUB_CATEGORY]
			 WHERE REQUEST_CATEGORY_ID = @pCategory_ID

--	Delete HRSC.CD_REQUEST_SUB_CATEGORY where REQUEST_CATEGORY_ID = @pCategory_ID
	IF @vCount > 0
		UPDATE HRSC.CD_REQUEST_CATEGORY SET [EXPIRY_DATE] = GETDATE()
			WHERE REQUEST_CATEGORY_ID = @pCategory_ID  
	ELSE
		DELETE HRSC.CD_REQUEST_CATEGORY
				WHERE REQUEST_CATEGORY_ID = @pCategory_ID  		    

	
	SELECT @Error = @@ERROR

	-- A Stored Proc always return 0 if no error.
	IF @Error != 0
	set @ReturnCode = @@ERROR
	else
	set @ReturnCode = 0

