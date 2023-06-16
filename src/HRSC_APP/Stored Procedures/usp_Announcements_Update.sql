





CREATE     PROCEDURE [HRSC_APP].[usp_Announcements_Update]
	@Announcements_ID bigint,
	@Announcements_sbj_en nvarchar(100),
	@Announcements_sbj_fr nvarchar(100),
	@Announcements_en nvarchar(1500),
	@Announcements_fr nvarchar(1500),
	@Active_IND	bit ,
	@Draft_IND bit,
	@Effective_date datetime,
	@Expiry_Date datetime,
	@User nvarchar(100),
	@Announcement_Type_ID bigint,
	@Icon nvarchar(100),
	@Icon_Level nvarchar(100),
	@Sort_Order bigint,
	@ReturnCode int OUTPUT

		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- UPDATE Announcement
-- UPDATE an existing Announcement for request in DB 
-- Tony Paradis 2011-12-18 
--
-- Modified to include ANNOUNCEMENT_TYPE_ID
-- Jacqueline Pottle 2013-01-17 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int
	
     UPDATE HRSC.HRSC_ANNOUNCEMENTS
     SET
		
            HRSC_ANNOUNCEMENTS_SBJCT_EN = @Announcements_sbj_en  ,
            HRSC_ANNOUNCEMENTS_SBJCT_FR = @Announcements_sbj_fr  ,
            HRSC_ANNOUNCEMENTS_EN       = @Announcements_en,
            HRSC_ANNOUNCEMENTS_FR       = @Announcements_fr         ,
            ACTIVE_IND      = @Active_IND                 ,
            DRAFT_IND       = @Draft_IND                  ,
			EFFECTIVE_DATE	= @Effective_date			  ,
			EXPIRY_DATE		= @Expiry_Date			  ,
			USER_UPDATED    = @User				  ,
			DATE_UPDATED    = GETDATE(),
			ANNOUNCEMENT_TYPE_ID = @Announcement_Type_ID,
			ICON = @Icon,
			ICON_LEVEL = @Icon_Level,
			SORT_ORDER = @Sort_Order
			
			WHERE HRSC_ANNOUNCEMENTS_ID = @Announcements_ID  				   
          
     
			

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0
