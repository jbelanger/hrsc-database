


CREATE     PROCEDURE [HRSC_APP].[usp_COI_SelectByRequestID]
@RequestID bigint, @RequestDraftID bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- COI_Select
-- Select COI in DB 
------------------------------------------------------

DECLARE @COI_ID bigint;

DECLARE @munID AS VARCHAR(100) = '', @munNameEn AS VARCHAR(100) = '', 
@munNameFr AS VARCHAR(100) = '',@provCode AS CHAR(2) = '', @Street VARCHAR(250) = ''




if @RequestID > 0
  select @COI_ID = COI_ID from HRSC.COI where HR_REQUEST_ID = @RequestID;
    
IF (SELECT ISNULL(OFFICE_SITE_ID,0) 
	FROM HRSC.COI C
	WHERE COI_ID = @COI_ID) = 0
BEGIN
set @munID = ''
	set @Street = ''
	SELECT 
		@munID = MUNICIPALITY_ID,
		@Street = C.CURRENT_OFFICE_LOCATION
	FROM HRSC.COI C
	WHERE COI_ID = @COI_ID and COI_ORIGINAL_ID is NULL

	SELECT 
		@provCode = ISNULL(PROVINCE_CODE,''), 
		@munNameEn = ISNULL(M.MUNICIPALITY_NAME,''),
		@munNameFr = ISNULL(COALESCE(M.ACCENTED_NAME,M.MUNICIPALITY_NAME),'') 
	FROM HRSC.PROVINCE P
	JOIN HRSC.MUNICIPALITY M ON M.PROVINCE_ID = P.PROVINCE_ID 
	WHERE MUNICIPALITY_ID  = CONVERT(BIGINT,@munID) 
  
END

SELECT 
	
		   [C].[COI_ID]
      ,[C].[COI_ORIGINAL_ID]
      --,[C].[TITLE_ID]      
      ,[C].[POSITION_TITLE]
      ,[C].[CLASSIFICATION_GROUP_ID]
      ,[C].[CLASSIFICATION_SUB_GROUP_ID]
      ,[C].[CLASSIFICATION_LEVEL_ID] 
      ,[C].[COI_ORGANISATION_EN]
      ,[C].[COI_ORGANISATION_FR]
      ,[C].[COI_SUB_ORGANISATION_EN]
      ,[C].[COI_SUB_ORGANISATION_FR]
      ,[C].[DATE_SUBMITTED_TO_COES]
      ,[C].[DATE_PACKAGE_SENT_TO_DGO]
      ,[C].[DATE_RESPONSE_LETTER_SENT]
      --,[C].[FOLLOW_UP_REQUIRED]
	  ,CAST([C].[FOLLOW_UP_REQUIRED] AS BIT) AS [FOLLOW_UP_REQUIRED]
      ,[C].[DATE_FOLLOW_UP_CONDUCTED]
      --,[C].[COMPLIANCE_MEASURE]
	  ,CAST([C].[COMPLIANCE_MEASURE] AS BIT) AS [COMPLIANCE_MEASURE]
      ,[C].[ASSIGNED_TO]
      ,[C].[DATE_ASSIGNED]
      ,[C].[VERSION_ID]
      ,[C].[EFFECTIVE_DATE]
      ,[C].[EXPIRY_DATE]
      ,[C].[USER_CREATED]
      ,[C].[USER_UPDATED]
      ,[C].[DATE_CREATED]
      ,[C].[DATE_UPDATED]
      ,[C].[CURRENT_OFFICE_LOCATION]
      ,[C].[OFFICE_SITE_ID]
      ,[C].[HOME_PHONE]
      ,[C].[WORK_PHONE]
      ,[C].[EMPLOYEE_ID]
      ,[C].[MANAGER_EMPLOYEE_ID]
      ,[C].[DECLARATION_IND]
      ,[C].[PROVINCE_ID]
      ,[C].[MUNICIPALITY_ID]
      ,CASE 
		      WHEN @Street = '' THEN ISNULL(OffSite.OFFICE_SITE_NAME,'')
		      ELSE @Street + ', ' + @munNameEn + ' ' + @provCode
		      END AS OSForReportEn
      ,CASE 
		      WHEN @Street = '' THEN ISNULL(OffSite.OFFICE_SITE_NAME_FR,'') 
		      ELSE @Street + ', ' + @munNameFr + ' ' + @provCode
	        END AS OSForReportFR

FROM HRSC.COI C
LEFT JOIN HRSC.OFFICE_SITE OffSite ON OffSite.OFFICE_SITE_ID = C.OFFICE_SITE_ID
WHERE COI_ID = @COI_ID;
