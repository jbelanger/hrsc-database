



CREATE   PROCEDURE [HRSC_APP].[usp_CD_SubOrganization_Update]
	@pSubOrganization_ID bigint,
	@pName_en nvarchar(250),
	@pName_fr nvarchar(250),
	@pDesc_en nvarchar(4000),
	@pDesc_fr nvarchar(4000),
	@pAcronym_en nvarchar(10),
	@pAcronym_fr nvarchar(10),
	@pActive_IND bit,
	@pCode nvarchar(5),
	@pForcedRegionId bigint,
	@pUser nvarchar(30)
	

		
WITH EXEC AS CALLER
AS	
	UPDATE HRSC.CD_SUB_ORGANIZATION
	
     SET
            SUB_ORGANIZATION_NAME_EN = @pName_en    ,
            SUB_ORGANIZATION_NAME_FR = @pName_fr    ,
            SUB_ORGANIZATION_DESC_EN = @pDesc_en    ,
            SUB_ORGANIZATION_DESC_FR = @pDesc_fr    ,
			SUB_ORGANIZATION_ACR_EN = @pAcronym_en  ,
			SUB_ORGANIZATION_ACR_FR = @pAcronym_fr  ,
			EXPIRY_DATE				 = CASE WHEN @pActive_IND = 1 Then GETDATE() ELSE NULL END,
            SUB_ORGANIZATION_CODE	 = @pCode 		,
			USER_UPDATED    = @pUser				,
			DATE_UPDATED    = GETDATE()				,
			FORCED_REGION_ID = @pForcedRegionId

			WHERE SUB_ORGANIZATION_ID = @pSubOrganization_ID
