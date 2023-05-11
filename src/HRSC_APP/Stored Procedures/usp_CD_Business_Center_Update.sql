



CREATE   PROCEDURE [HRSC_APP].[usp_CD_Business_Center_Update]
	@pBC_ID bigint,
  @p_ACRONYM_EN varchar(10), 
  @p_ACRONYM_FR varchar(10),  
	@pName_en nvarchar(250),
	@pName_fr nvarchar(250),
  @p_SHORT_NAME_EN nvarchar(15), 
  @p_SHORT_NAME_FR nvarchar(15),  
	@pDesc_en nvarchar(4000),
	@pDesc_fr nvarchar(4000),
	@pBCCode nvarchar(5),
	@pActive_IND	bit ,
	@pUser nvarchar(120),
	@pReturnCode int OUTPUT

		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- UPDATE CD_BUSINESS_CENTER
-- UPDATE an existing Business center for request in DB 
-- Tony Paradis 2012-01-04 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int
	
     UPDATE HRSC.CD_BUSINESS_CENTER
     SET
		      BUSINESS_CENTER_ACRONYM_EN = @p_ACRONYM_EN,
          BUSINESS_CENTER_ACRONYM_FR = @p_ACRONYM_FR, 
          BUSINESS_CENTER_NAME_EN = @pName_en,
          BUSINESS_CENTER_NAME_FR = @pName_fr,
          BUSINESS_CENTER_NAME_SHORT_EN = @p_SHORT_NAME_EN, 
          BUSINESS_CENTER_NAME_SHORT_FR = @p_SHORT_NAME_FR, 
          BUSINESS_CENTER_DESC_EN = @pDesc_en,
          BUSINESS_CENTER_DESC_FR = @pDesc_fr,
			    BUSINESS_CENTER_CODE    = @pBCCode,
          EXPIRY_DATE      =  CASE WHEN @pActive_IND = 1 Then GETDATE() ELSE NULL END,
          USER_UPDATED    = @pUser				  ,
			    DATE_UPDATED    = GETDATE()			
			
      WHERE BUSINESS_CENTER_ID = @pBC_ID  				   
          
		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
