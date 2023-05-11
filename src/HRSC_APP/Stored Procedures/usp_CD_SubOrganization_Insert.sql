



CREATE   PROCEDURE [HRSC_APP].[usp_CD_SubOrganization_Insert]
@pOrganization_id bigint, @pNameEn nvarchar(250), @pNameFr nvarchar(250), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pSubOrganizationCode nvarchar(5), @pAcronymEn nvarchar(10), @pAcronymFr nvarchar(10),@pForcedRegionId bigint, @pUserCreated nvarchar(30)
WITH EXEC AS CALLER
AS

insert into HRSC.CD_SUB_ORGANIZATION
  ( ORGANIZATION_ID,
   SUB_ORGANIZATION_NAME_EN,
   SUB_ORGANIZATION_NAME_FR,
   SUB_ORGANIZATION_DESC_EN,
   SUB_ORGANIZATION_DESC_FR,
   SUB_ORGANIZATION_CODE,
   SUB_ORGANIZATION_ACR_EN,
   SUB_ORGANIZATION_ACR_FR,
   FORCED_REGION_ID,
   EFFECTIVE_DATE,
   USER_CREATED,
   DATE_CREATED  
)
values
  (@pOrganization_id,
   @pNameEn,
   @pNameFr,
   @pDescEn,
   @pDescFr,
   @pSubOrganizationCode,
   @pAcronymEn,
   @pAcronymFr,
   @pForcedRegionId,
   GetDate(),
   @pUserCreated,
   GetDate()
  )
