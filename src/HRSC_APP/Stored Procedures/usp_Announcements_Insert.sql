






CREATE     PROCEDURE [HRSC_APP].[usp_Announcements_Insert]
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
-- Insert Announcement
-- Insert a new Announcement for request in DB 
-- Tony Paradis 2011-12-13 
--
-- Modified to include ANNOUNCEMENT_TYPE_ID
-- Jacqueline Pottle 2013-01-17 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int
	
     INSERT INTO HRSC.HRSC_ANNOUNCEMENTS
          ( 
            HRSC_ANNOUNCEMENTS_SBJCT_EN   ,
            HRSC_ANNOUNCEMENTS_SBJCT_FR   ,
            HRSC_ANNOUNCEMENTS_EN         ,
            HRSC_ANNOUNCEMENTS_FR         ,
            ACTIVE_IND                    ,
            DRAFT_IND                     ,
			EFFECTIVE_DATE				  ,
			EXPIRY_DATE					  ,
			USER_CREATED				  ,
			DATE_CREATED				  ,
			USER_UPDATED				  ,
			DATE_UPDATED				  ,
			ANNOUNCEMENT_TYPE_ID		  ,
			ICON						  ,
			ICON_LEVEL					  ,
			SORT_ORDER
          ) 
     VALUES 
          ( 
            @Announcements_sbj_en  ,
			@Announcements_sbj_fr  ,
			@Announcements_en      ,
			@Announcements_fr	   ,
			@Active_IND	           ,
			@Draft_IND			   ,
			@Effective_date        ,
			@Expiry_Date           ,
			@User                  ,
			GETDATE()			   ,
			@User                  ,
			GETDATE()			   ,
			@Announcement_Type_ID  ,
			@Icon				   ,
			@Icon_Level			   ,
			@Sort_Order)	

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0
