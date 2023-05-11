


CREATE   PROCEDURE [HRSC_APP].[usp_CD_Organization_Update]
	@pOrganization_ID bigint,
	@pName_en nvarchar(250),
	@pName_fr nvarchar(250),
	@pAcro_en nvarchar(5),
	@pAcro_fr nvarchar(5),
	@pDesc_en nvarchar(4000),
	@pDesc_fr nvarchar(4000),
	@pActive_IND bit,
	@pCode nvarchar(5),
	@pUser nvarchar(30)
	

		
WITH EXEC AS CALLER
AS
	
	UPDATE HRSC.CD_ORGANIZATION
	
     SET
            ORGANIZATION_NAME_EN = @pName_en    ,
            ORGANIZATION_NAME_FR = @pName_fr    ,
            ORGANIZATION_DESC_EN = @pDesc_en    ,
            ORGANIZATION_DESC_FR = @pDesc_fr    ,
			ORGANIZATION_ACRONYM_EN = @pAcro_en,
			ORGANIZATION_ACRONYM_FR = @pAcro_fr,
            EXPIRY_DATE				 = CASE WHEN @pActive_IND = 1 Then GETDATE() ELSE NULL END,
            ORGANIZATION_CODE	 = @pCode 		,
			USER_UPDATED    = @pUser				,
			DATE_UPDATED    = GETDATE()			

			WHERE ORGANIZATION_ID = @pOrganization_ID
