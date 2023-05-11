





CREATE   PROCEDURE [HRSC_APP].[usp_CD_RequestCategory_Insert]
@pNameEn NVARCHAR(250), 
@pNameFr NVARCHAR(250), 
@pDescEn NVARCHAR(4000), 
@pDescFr NVARCHAR(4000), 
@pEmployeeInd bit,
@pManagerInd bit,
@pAgentInd bit,
@pACR_EN nvarchar(10),
@pACR_FR nvarchar(10), 
@pCategoryCode NVARCHAR(5), 
@pUserCreated NVARCHAR(30), 
@pReturnCode INT OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdRequestCategory
-- Insert a new Request category  in DB 
-- Gaétan Demers 2011-12-13 
------------------------------------------------------
-- Declare our variables
DECLARE @Error INT

IF (@pCategoryCode IS NULL OR @pCategoryCode  ='') BEGIN  SET @pCategoryCode = 'N/A' END

INSERT INTO HRSC.CD_REQUEST_CATEGORY
  (REQUEST_CATEGORY_NAME_EN,
   REQUEST_CATEGORY_NAME_FR,
   REQUEST_CATEGORY_DESC_EN,
   REQUEST_CATEGORY_DESC_FR,
   EMPLOYEE_CATEGORY_IND,
   MANAGER_CATEGORY_IND,
   AGENT_CATEGORY_IND,
   REQUEST_CATEGORY_ACR_FR,
   REQUEST_CATEGORY_ACR_EN,
   REQUEST_CATEGORY_CODE,
   EFFECTIVE_DATE,
   USER_CREATED,
   DATE_CREATED)
VALUES
  (@pNameEn,
   @pNameFr,
   @pDescEn,
   @pDescFr,
   @pEmployeeInd,
   @pManagerInd,
   @pAgentInd,
   @pACR_EN,
   @pACR_FR,
   @pCategoryCode,
   GETDATE(),
   @pUserCreated,
   GETDATE())

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  SET @pReturnCode = @@ERROR
ELSE
  SET @pReturnCode = 0
