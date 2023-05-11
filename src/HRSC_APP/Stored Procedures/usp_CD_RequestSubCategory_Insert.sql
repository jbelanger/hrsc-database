





CREATE   PROCEDURE [HRSC_APP].[usp_CD_RequestSubCategory_Insert]
@pNameEn NVARCHAR(250), 
@pNameFr NVARCHAR(250), 
@pDescEn NVARCHAR(4000), 
@pDescFr NVARCHAR(4000), 
@pEmployeeInd bit,
@pManagerInd bit,
@pAgentInd bit,
@pHrRequestType bigint,
@pACR_EN nvarchar(10),
@pACR_FR nvarchar(10),
@pCategoryCode NVARCHAR(5), 
@pRequestCategoryID bigint, 
@pUserCreated NVARCHAR(30), 
@pIs_Protected_Request bit,
@pReturnCode INT OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdRequestSubCategory
-- Insert a new Request sub-category  in DB 
-- Gaétan Demers 2011-12-13 
------------------------------------------------------
-- Declare our variables
DECLARE @Error INT

IF (@pCategoryCode IS NULL OR @pCategoryCode  ='') BEGIN  SET @pCategoryCode = 'N/A' END

INSERT INTO HRSC.CD_REQUEST_SUB_CATEGORY
  (REQUEST_SUB_CATEGORY_NAME_EN,
   REQUEST_SUB_CATEGORY_NAME_FR,
   REQUEST_SUB_CATEGORY_DESC_EN,
   REQUEST_SUB_CATEGORY_DESC_FR,
   EMPLOYEE_SUB_CATEGORY_IND,
   MANAGER_SUB_CATEGORY_IND,
   AGENT_CATEGORY_IND,
   HR_REQUEST_TYPE_ID,
   REQUEST_SUB_CATEGORY_ACR_FR,
   REQUEST_SUB_CATEGORY_ACR_EN,
   REQUEST_CATEGORY_ID,
   REQUEST_SUB_CATEGORY_CODE,
   EFFECTIVE_DATE,
   USER_CREATED,
   IS_PROTECTED_REQUEST,
   DATE_CREATED)
VALUES
  (@pNameEn,
   @pNameFr,
   @pDescEn,
   @pDescFr,
   @pEmployeeInd,
   @pManagerInd,
   @pAgentInd,
   @pHrRequestType,
   @pACR_FR,
   @pACR_EN,
   @pRequestCategoryID,
   @pCategoryCode ,
   GETDATE(),
   @pUserCreated,
   @pIs_Protected_Request,
   GETDATE())

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  SET @pReturnCode = @@ERROR
ELSE
  SET @pReturnCode = 0
