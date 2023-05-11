



CREATE   PROCEDURE [HRSC_APP].[usp_CD_BusinessCenter_Insert]
@p_ACRONYM_EN varchar(10), @p_ACRONYM_FR varchar(10), @pNameEn nvarchar(250), @pNameFr nvarchar(250), @p_SHORT_NAME_EN nvarchar(15), @p_SHORT_NAME_FR nvarchar(15), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pUserCreated nvarchar(120), @pBCCode nvarchar(5), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdBusinessCenter 
-- Insert a new Business center in DB 
-- Gaétan Demers 2011-12-13 
-- Modified by Tony Paradis 2012-01-04
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

insert into HRSC.CD_BUSINESS_CENTER
  (BUSINESS_CENTER_ACRONYM_EN,
   BUSINESS_CENTER_ACRONYM_FR,
   BUSINESS_CENTER_NAME_EN,
   BUSINESS_CENTER_NAME_FR,
   BUSINESS_CENTER_NAME_SHORT_EN,
   BUSINESS_CENTER_NAME_SHORT_FR, 
   BUSINESS_CENTER_DESC_EN,
   BUSINESS_CENTER_DESC_FR,
   BUSINESS_CENTER_CODE,
   EFFECTIVE_DATE,
   USER_CREATED,
   DATE_CREATED)
values
  (@p_ACRONYM_EN,
   @p_ACRONYM_FR,
   @pNameEn,
   @pNameFr,
   @p_SHORT_NAME_EN,
   @p_SHORT_NAME_FR, 
   @pDescEn,
   @pDescFr,
   @pBCCode,
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
