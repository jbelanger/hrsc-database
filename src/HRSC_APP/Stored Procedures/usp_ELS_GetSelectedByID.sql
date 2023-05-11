



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ELS_GetSelectedByID]
	@pID BIGINT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	   [id]	AS ID
      ,[Canceled] AS CANCELED 
      ,[DateCanceled]  AS DATE_CANCELED
      ,[DateSubmitted] AS DATE_SUBMITTED
      ,[Resolved] AS RESOLVED
      ,[DateResolved] AS DATE_RESOLVED
      ,[Declined] AS DECLINED
      ,[DateDeclined] AS DATE_DECLINED
      ,[Pending] AS PENDING
      ,[Datepending] AS DATE_PENDING
      ,[elsstaffauth] AS ELS_STAFF_AUTH
      ,[elscomment] AS ELS_COMMENT
      ,[DateAssign] AS DATE_ASSIGN
      ,[FormName_EN] AS FORM_NAME_EN
      ,[FormName_FR] AS FORM_NAME_FR
      ,[subbyauth] AS SUB_BY_AUTH
      ,[subbyip] AS SUB_BY_IP
      ,[deptype] AS DEP_TYPE
      ,[usersName] AS USERSNAME
      ,[delegatedmanager] AS DELEGATED_MANAGER
      ,[delegatedmanageremail] AS DELEGATED_MANAGER_EMAIL
      ,[BranchTitle_EN] AS BRANCH_TITLE_EN
      ,[BranchTitle_FR] AS BRANCH_TITLE_FR
      ,[RegionTitle_EN] AS REGION_TITLE_EN
      ,[RegionTitle_FR] AS REGION_TITLE_FR
      ,[location] AS LOCATION
      ,[positiontitle] AS POSITION_TITLE
      ,[position] AS POSITION
      ,[group_Value] AS GROUP_NAME
      ,[SubGroup_Value] AS SUBGROUP_NAME
      ,[level_Value] AS LEVEL_NAME
      ,[employeeGivenName] AS EMPLOYEE_GIVENNAME
      ,[employeeSurname] AS EMPLOYEE_SURNAME
      ,[employeeTitle_EN] AS EMPLOYEE_TITLE_EN
      ,[employeeTitle_FR] AS EMPLOYEE_TITLE_FR
      ,[pri] AS PRI
      ,[emptype_EN] AS EMP_TYPE_EN
      ,[emptype_FR] AS EMP_TYPE_FR
      ,[startdate] AS STARTDATE
      ,[enddate] AS ENDDATE
      ,[newenddate] AS NEW_ENDDATE
      ,[worksch] 
      ,[worksch_EN] AS WORK_SCH_EN
      ,[worksch_FR] AS WORK_SCH_FR
      ,[sunday] AS SUNDAY
      ,[monday] AS MONDAY
      ,[tuesday] AS TUESDAY
      ,[wednesday] AS WEDNESDAY
      ,[thursday] AS THURSDAY
      ,[friday] AS FRIDAY
      ,[saturday] AS SATURDAY
      ,[languageRec] AS LANGUAGE_REC
      ,[security] 
      ,[LangCorr] AS LANG_CORR
      ,[Reloc] AS RELOC
      ,[probation] AS PROBATION
      ,[fincode1] AS FINCODE1
      ,[fincode2] AS FINCODE2
      ,[fincode3] AS FINCODE3
      ,[fincode4] AS FINCODE4
      ,[fincode5] AS FINCODE5
      ,[department] AS DEPARTMENT
      ,[prevgroup_Value] AS PREV_GROUP_NAME
      ,[prevSubGroup_Value] AS PREV_SUBGROUP_NAME
      ,[prevlevel_Value] AS PREV_LEVEL_NAME
      ,[cbname] AS CB_NAME
      ,[cbphone] AS CB_PHONE
      ,[cbphoneext] AS CB_PHONE_EXT
      ,[comments] AS COMMENTS
      ,[lanreqTitle_EN] AS LAN_REQ_TITLE_EN
      ,[lanreqTitle_FR] AS LAN_REQ_TITLE_FR
      ,[excluded] AS EXCLUDED
      ,[unrepresented] AS UNREPRESENTED
      ,[citizenship] AS CITIZENSHIP
      ,[cndpreference] AS CND_PREFERENCE
      ,[actinglevel_Value] AS ACTING_LEVEL_NAME
      ,[actingGroup_Value] AS ACTING_GROUP_NAME
      ,[actingSubGroup_Value] AS ACTING_SUBGROUP_NAME
      ,[actingtypeName_EN] AS ACTING_TYPE_NAME_EN
      ,[actingtypeName_FR] AS ACTING_TYPE_NAME_FR
      ,[confirmationName_EN] AS CONFIRMATION_EN
      ,[confirmationName_FR] AS CONFIRMATION_FR
      ,[rateofpay] AS RATE_OF_PAY
      ,[studentprogram_EN] AS STUDENT_PROGRAM_EN
      ,[studentprogram_FR] AS STUDENT_PROGRAM_FR
      ,[studentcontracttype]
      ,[studentcontracttype_Name_EN] AS STUDENT_CONTRACT_TYPE_NAME_EN
      ,[studentcontracttype_Name_FR] AS STUDENT_CONTRACT_TYPE_NAME_FR
      ,[sunset_Name_EN] AS SUNSET_NAME_EN
      ,[sunset_Name_FR] AS SUNSET_NAME_FR
      ,[submissionLanguage] AS SUBMISSION_LANGUAGE
      ,[SubOrg_Name_EN] AS SUBORG_NAME_EN
      ,[SubOrg_Name_FR] AS SUBORG_NAME_FR
      ,[Paylist] AS PAYLIST
      ,[draft] AS DRAFT
      ,[ccemail] AS CCEMAIL
      ,[PSR_Name_EN] AS PSR_NAME_EN
      ,[PSR_Name_FR] AS PAS_NAME_FR
      ,[Assignment_Name_EN] AS ASSIGNMENT_NAME_EN
      ,[Assignment_Name_FR] AS ASSIGNMENT_NAME_FR
      ,[HomeDept_Name_EN] AS HOME_DEP_NAME_EN
      ,[HomeDept_Name_FR] AS HOME_DEP_NAME_FR
      ,[homeorg] AS HOME_ORG
      ,[homefincode] AS HOME_FINCODE
      ,[homemanager]  AS HOME_MANAGER
      ,[homemanageremail] AS HOME_MANAGER_EMAIL
      ,[homemanagerphone] AS HOME_MANAGER_PHONE
      ,[homecomp] AS HOME_COMP
      ,[homecompemail] AS HOME_COMP_EMAIL
      ,[homecompphone] AS HOME_COMP_PHONE
      ,[hostregion_Name_EN] AS HOST_REGION_NAME_EN
      ,[hostregion_Name_FR] AS HOST_REGION_NAME_FR
      ,[hostbranch_Name_EN] AS HOST_BRANCH_NAME_EN
      ,[hostbranch_Name_FR] AS HOST_BRANCH_NAME_FR
      ,[hostsuborg_Name_EN] AS HOST_SUBORG_NAME_EN
      ,[hostsuborg_Name_FR] AS HOST_SUBORG_NAME_FR
      ,[hostposition] AS HOST_POSITION
      ,[hostpositionlocation] AS HOST_POSITION_LOCATION
      ,[hostgroup_Value] AS HOST_GROUP_NAME
      ,[hostSubGroup_Value] AS HOST_SUBGROUP_NAME
      ,[hostLevel_Value] AS HOST_LEVEL_NAME
      ,[hostmanagername] AS HOST_MANAGER_NAME
      ,[hostmanageremail] AS HOST_MANAGER_EMAIL
      ,[hostmanagerphone] AS HOST_MANAGER_PHONE
      ,[hostfincode1] AS HOST_FINCODE1
      ,[hostfincode2] AS HOST_FINCODE2
      ,[hostfincode3] AS HOST_FINCODE3
      ,[hostfincode4] AS HOST_FINCODE4
      ,[hostfincode5] AS HOST_FINCODE5
      ,[ftehome_Name_EN] AS FTE_HOME_NAME_EN
      ,[ftehome_Name_FR] AS FTE_HOME_NAME_FR
      ,[ftehost_Name_EN] AS FTE_HOST_NAME_EN
      ,[ftehost_Name_FR] AS FTE_HOST_NAME_FR
      ,[salaryhome_Name_EN] AS SALARY_HOME_NAME_EN
      ,[salaryhome_Name_FR] AS SALARY_HOME_NAME_FR
      ,[salaryhost_Name_EN] AS SALARY_HOST_NAME_EN
      ,[salaryhost_Name_FR] AS SALARY_HOST_NAME_FR
      ,[priority] AS PRIORITY
      ,[Amended] AS AMENDED
      ,[AmendedDate] AS AMENDED_DATE
  FROM [HRSC].[ELS_Request_TEMP]
 WHERE ID = @pID 

END

