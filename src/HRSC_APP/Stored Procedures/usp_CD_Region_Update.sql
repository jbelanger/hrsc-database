



CREATE   PROCEDURE [HRSC_APP].[usp_CD_Region_Update]
	@pRegion_ID bigint,
	@pName_en nvarchar(100),
	@pName_fr nvarchar(100),
	@pDesc_en nvarchar(1000),
	@pDesc_fr nvarchar(1000),
	@pRegionCode nvarchar(5),
	@pActive_IND	bit ,
	@pUser nvarchar(100),
	@pReturnCode int OUTPUT

		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- UPDATE CD_CD_MODE_OF_RECEIPT
-- UPDATE an existing CD_MODE_OF_RECEIPT for request in DB 
-- Tony Paradis 2012-01-05 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int
	
     UPDATE HRSC.CD_REGION
     SET
		
            REGION_NAME_EN = @pName_en  ,
            REGION_NAME_FR = @pName_fr  ,
            REGION_DESC_EN       = @pDesc_en,
            REGION_DESC_FR       = @pDesc_fr         ,
			REGION_CODE    = @pRegionCode,
            EXPIRY_DATE      =  CASE WHEN @pActive_IND = 1 Then GETDATE() ELSE NULL END,
            USER_UPDATED    = @pUser				  ,
			DATE_UPDATED    = GETDATE()			
			WHERE REGION_ID = @pRegion_ID  				   
          
     
			

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
