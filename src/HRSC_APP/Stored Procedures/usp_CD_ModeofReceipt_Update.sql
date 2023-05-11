



CREATE   PROCEDURE [HRSC_APP].[usp_CD_ModeofReceipt_Update]
	@pModeofReceipt_ID bigint,
	@pName_en nvarchar(100),
	@pName_fr nvarchar(100),
	@pDesc_en nvarchar(1000),
	@pDesc_fr nvarchar(1000),
	@pModeofReceiptCode nvarchar(5),
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
	
     UPDATE HRSC.CD_MODE_OF_RECEIPT
     SET
		
            MODE_OF_RECEIPT_NAME_EN = @pName_en  ,
            MODE_OF_RECEIPT_NAME_FR = @pName_fr  ,
            MODE_OF_RECEIPT_DESC_EN       = @pDesc_en,
            MODE_OF_RECEIPT_DESC_FR       = @pDesc_fr         ,
			MODE_OF_RECEIPT_CODE    = @pModeofReceiptCode,
            EXPIRY_DATE      =  CASE WHEN @pActive_IND = 1 Then GETDATE() ELSE NULL END,
            USER_UPDATED    = @pUser				  ,
			DATE_UPDATED    = GETDATE()			
			WHERE MODE_OF_RECEIPT_ID = @pModeofReceipt_ID  				   
          
     
			

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
