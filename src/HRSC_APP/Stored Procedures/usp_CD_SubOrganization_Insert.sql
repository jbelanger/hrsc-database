



CREATE   PROCEDURE [HRSC_APP].[usp_CD_SubOrganization_Insert]
@pOrganization_id bigint, @pNameEn nvarchar(250), @pNameFr nvarchar(250), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pSubOrganizationCode nvarchar(5), @pAcronymEn nvarchar(10), @pAcronymFr nvarchar(10), @pUserCreated nvarchar(30), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdOrganization
-- Insert a new Organization in DB 
-- Gaétan Demers 2011-12-13 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

insert into HRSC.CD_SUB_ORGANIZATION
  (SUB_ORGANIZATION_NAME_EN,
   SUB_ORGANIZATION_NAME_FR,
   SUB_ORGANIZATION_DESC_EN,
   SUB_ORGANIZATION_DESC_FR,
   SUB_ORGANIZATION_CODE,
   SUB_ORGANIZATION_ACR_EN,
   SUB_ORGANIZATION_ACR_FR,
   ORGANIZATION_ID,
   EFFECTIVE_DATE,
   USER_CREATED,
   DATE_CREATED
)
values
  (@pNameEn,
   @pNameFr,
   @pDescEn,
   @pDescFr,
   @pSubOrganizationCode,
   @pAcronymEn,
   @pAcronymFr,
   @pOrganization_id,
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
