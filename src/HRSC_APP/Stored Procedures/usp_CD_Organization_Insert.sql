



CREATE   PROCEDURE [HRSC_APP].[usp_CD_Organization_Insert]
@pNameEn nvarchar(250), @pNameFr nvarchar(250), @pAcronEn nvarchar(6), @pAcronFr nvarchar(6), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pOrganizationCode nvarchar(5), @pUserCreated nvarchar(30)
WITH EXEC AS CALLER
AS

insert into HRSC.CD_ORGANIZATION
  (ORGANIZATION_NAME_EN,
   ORGANIZATION_NAME_FR,
   ORGANIZATION_ACRONYM_EN,
   ORGANIZATION_ACRONYM_FR,
   ORGANIZATION_DESC_EN,
   ORGANIZATION_DESC_FR,
   ORGANIZATION_CODE,
   EFFECTIVE_DATE,
   USER_CREATED,
   DATE_CREATED
)
values
  (@pNameEn,
   @pNameFr,
   @pAcronEn,
   @pAcronFr,
   @pDescEn,
   @pDescFr,
   @pOrganizationCode,
   GetDate(),
   @pUserCreated,
   GetDate())
