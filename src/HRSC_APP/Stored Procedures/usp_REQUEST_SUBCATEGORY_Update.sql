





CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_SUBCATEGORY_Update]
	@pSubcategory_ID bigint,
	@pName_en nvarchar(250),
	@pName_fr nvarchar(250),
	@pDesc_en nvarchar(4000),
	@pDesc_fr nvarchar(4000),
	@pActive_IND bit,
	@pEmployee_IND bit,
	@pManager_IND bit,
	@pAgent_IND bit,
	@pSURVEY_IND bit,
	@pHrRequest_Type_ID bigint,
	@pACR_EN nvarchar(10),
	@pACR_FR nvarchar(10),
	@pCode nvarchar(5),
	@pUser nvarchar(30),
	@pIs_Protected_Request bit,
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

	
	UPDATE HRSC.CD_REQUEST_SUB_CATEGORY
	
     SET
            REQUEST_SUB_CATEGORY_NAME_EN = @pName_en    ,
            REQUEST_SUB_CATEGORY_NAME_FR = @pName_fr    ,
            REQUEST_SUB_CATEGORY_DESC_EN = @pDesc_en    ,
            REQUEST_SUB_CATEGORY_DESC_FR = @pDesc_fr    ,
            EXPIRY_DATE				 = CASE WHEN @pActive_IND = 1 Then GETDATE() ELSE NULL END,
            EMPLOYEE_SUB_CATEGORY_IND      = @pEmployee_IND ,
			MANAGER_SUB_CATEGORY_IND = @pManager_IND	,
			AGENT_CATEGORY_IND = @pAgent_IND,
			SURVEY_IND = @pSURVEY_IND,
			HR_REQUEST_TYPE_ID = @pHrRequest_Type_ID	, 
			REQUEST_SUB_CATEGORY_ACR_EN = @pACR_EN		,
			REQUEST_SUB_CATEGORY_ACR_FR = @pACR_FR		,
			--REQUEST_SUB_CATEGORY_CODE	 = @pCode 		,
			USER_UPDATED    = @pUser					,
			DATE_UPDATED    = GETDATE()			        ,
			IS_PROTECTED_REQUEST = @pIs_Protected_Request

			WHERE REQUEST_SUB_CATEGORY_ID = @pSubCategory_ID  		    
    
			

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0
