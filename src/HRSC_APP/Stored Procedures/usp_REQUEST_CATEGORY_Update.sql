





CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_CATEGORY_Update]
	@pCategory_ID bigint,
	@pName_en nvarchar(250),
	@pName_fr nvarchar(250),
	@pDesc_en nvarchar(4000),
	@pDesc_fr nvarchar(4000),
	@pActive_IND bit,
	@pEmployee_IND bit,
	@pManager_IND bit,
	@pAgent_IND bit,
	@pACR_EN nvarchar(10),
	@pACR_FR nvarchar(10),
	@pCode nvarchar(5),
	@pUser nvarchar(30),
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

	
	UPDATE HRSC.CD_REQUEST_CATEGORY
	
     SET
            REQUEST_CATEGORY_NAME_EN = @pName_en    ,
            REQUEST_CATEGORY_NAME_FR = @pName_fr    ,
            REQUEST_CATEGORY_DESC_EN = @pDesc_en    ,
            REQUEST_CATEGORY_DESC_FR = @pDesc_fr    ,
            EXPIRY_DATE				 = CASE WHEN @pActive_IND = 1 Then GETDATE() ELSE NULL END,
            EMPLOYEE_CATEGORY_IND      = @pEmployee_IND ,
			MANAGER_CATEGORY_IND = @pManager_IND,
			AGENT_CATEGORY_IND = @pAgent_IND,
			REQUEST_CATEGORY_ACR_FR = @pACR_FR,
			REQUEST_CATEGORY_ACR_EN = @pACR_EN,
			--REQUEST_CATEGORY_CODE	 = @pCode 		,
			USER_UPDATED    = @pUser				,
			DATE_UPDATED    = GETDATE()			

			WHERE REQUEST_CATEGORY_ID = @pCategory_ID  		    
    
			

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0
