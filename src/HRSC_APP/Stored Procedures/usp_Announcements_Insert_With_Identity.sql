



CREATE     PROCEDURE [HRSC_APP].[usp_Announcements_Insert_With_Identity]
	@Announcements_sbj_en nvarchar(100),
	@Announcements_sbj_fr nvarchar(100),
	@Announcements_en nvarchar(4000),
	@Announcements_fr nvarchar(4000),
	@Active_IND	bit ,
	@Draft_IND bit,
	@Effective_date datetime,
	@Expiry_Date datetime,
	@User nvarchar(100),
	@Announcement_Type_ID bigint,
	@NewID bigint OUTPUT,
	@ReturnCode int OUTPUT
		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- Insert Announcement
-- Insert a new Announcement for request in DB 
-- And Return the Identity of the newly inserted row
-- Jacqueline Pottle 2013-02-12 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int,
		@TODAY datetime
		
SELECT @TODAY = GETDATE()
	
-- If Effective date is null, set to today
if @Effective_date IS null 
  set @Effective_date = GetDate()	
	
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
			ANNOUNCEMENT_TYPE_ID 
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
			@TODAY			   ,
			@User                  ,
			@TODAY			   ,
			@Announcement_Type_ID)	
			
		
		SELECT @Error = @@ERROR
		SET @NewID = @@IDENTITY;

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0
