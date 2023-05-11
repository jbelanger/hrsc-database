



CREATE   PROCEDURE [HRSC_APP].[usp_CD_Region_Insert]
@pNameEn nvarchar(250), @pNameFr nvarchar(250), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pRegionCode nvarchar(5), @pUserCreated nvarchar(30), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdRegion
-- Insert a new Region  in DB 
-- Gaétan Demers 2011-12-13 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

insert into HRSC.CD_REGION
  (REGION_NAME_EN,
   REGION_NAME_FR,
   REGION_DESC_EN,
   REGION_DESC_FR,
   REGION_CODE	 ,
   EFFECTIVE_DATE,
   USER_CREATED,
   DATE_CREATED)
values
  (@pNameEn,
   @pNameFr,
   @pDescEn,
   @pDescFr,
   @pRegionCode,
   GetDate(),
   @pUserCreated,
   GetDate())

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
