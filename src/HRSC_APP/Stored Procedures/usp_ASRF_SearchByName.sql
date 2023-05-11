



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ASRF_SearchByName]
	@pGivenName nvarchar(50), 
	@pSurName nvarchar(50),
	@RowIndexStart bigint, 
	@RowIndexEnd bigint, 
	@RecCount bigint OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @pGivenName <> '' AND @pSurName <> ''
		BEGIN
				SELECT @RecCount = COUNT (F_ID) FROM
				(SELECT  F_ID
				 FROM HRSC.[ASRF_FORMS]
					WHERE  upper(R_EmployeeGivenName) like upper(@pGivenName + '%') AND
						 upper(R_EmployeeSurname) like upper(@pSurName + '%') AND 
						(S_StateName_En = 'Submitted' OR 
						S_StateName_En = 'Cancelled' OR 
						S_StateName_En = 'Assigned' OR 
						S_StateName_En = 'Extended' OR 
						S_StateName_En = 'Amended')
				) as NewReq

		END
	ELSE
		IF @pGivenName <> '' 
			BEGIN
				SELECT @RecCount = COUNT (F_ID) FROM
				(SELECT  F_ID
				 FROM HRSC.[ASRF_FORMS]
					WHERE  upper(R_EmployeeGivenName) like upper(@pGivenName + '%') AND
						(S_StateName_En = 'Submitted' OR 
						S_StateName_En = 'Cancelled' OR 
						S_StateName_En = 'Assigned' OR 
						S_StateName_En = 'Extended' OR 
						S_StateName_En = 'Amended')
				) as NewReq


			END
		ELSE
			BEGIN
				SELECT @RecCount = COUNT (F_ID) FROM
				(SELECT  F_ID
				 FROM HRSC.[ASRF_FORMS]
				 WHERE upper(R_EmployeeSurname) like upper(@pSurName + '%') AND 
						(S_StateName_En = 'Submitted' OR 
						S_StateName_En = 'Cancelled' OR 
						S_StateName_En = 'Assigned' OR 
						S_StateName_En = 'Extended' OR 
						S_StateName_En = 'Amended')
				) as NewReq
			END
	


IF @pGivenName <> '' AND @pSurName <> ''
	BEGIN
		SELECT * FROM
		(SELECT 
			 Row_Number() over (order by R_EmployeeSurname asc, R_EmployeeGivenName asc) as RowIndex
			  , [F_ID]
			  ,[F_AdditionalComments] AS ADDITIONAL_COMMENTS
			  ,[F_AdminSupportContact] AS ADMIN_SUPPORT_CONTACT
			  ,[F_AssignedTo_En] AS ASSIGNED_TO_ENGLISH
			  ,[F_AssignedTo_Fr] AS ASSIGN_TO_FRENCH
			  ,[F_Author] AS AUTHOR
			  ,[F_ClassGroupName] AS CLASS_GROUP_NAME
			  ,[F_ClassSubGroupName] AS CLASS_SUB_GROUP_NAME
			  ,[F_ClassLvlName] AS CLASS_LVL_NAME
			  ,[F_DateSubmitted] AS DATE_SUBMITTED
			  ,[F_DepartementAcronym_En] 
			  ,[F_DepartementAcronym_Fr]
			  ,[F_DepartementName_En] AS DEPARTEMENT_NAME_EN
			  ,[F_DepartementName_Fr] AS DEPARTEMENT_NAME_FR
			  ,[F_Organization_En] AS ORGANISATION_EN
			  ,[F_Organization_Fr] AS ORGANISATION_FR
			  ,[F_OriginalFID] AS ORGINAL_FID
			  ,[F_Region_EN] AS REGION_EN
			  ,[F_Region_Fr] AS REGION_FR
			  ,[F_RequestForm] AS REQUEST_FORM
			  ,[F_RequestType_En] AS REQUEST_TYPE_EN
			  ,[F_RequestType_Fr] AS REQUEST_TYPE_FR
			  ,[F_StaffingProcessType_En] AS STAFFING_PROCESS_TYPE_EN
			  ,[F_StaffingProcessType_Fr] AS STAFFING_PROCESS_TYPE_FR
			  ,[F_SubOrganization_En] AS SUB_ORGANIZATION_EN
			  ,[F_SubOrganization_Fr] AS SUB_ORGANIZATION_FR
			  ,[R_AddClassGroupName] AS ADD_CLASS_GROUP_NAME
			  ,[R_AddClassSubGroupName] AS ADD_CLASS_SUB_GROUP_NAME
			  ,[R_AddClassLevelName] AS ADD_CLASS_LEVEL_NAME
			  ,[R_AdminContactEmail] AS ADMIN_CONTACT_EMAIL
			  ,[R_AppointmentTenure_En] AS APPOINTMENT_TENURE_EN
			  ,[R_AppointmentTenure_Fr] AS APPOINTMENT_TENURE_FR
			  ,[R_CC] 
			  ,[R_CitizenshipCheck_En] AS CITIZEN_SHIP_CHECK_EN
			  ,[R_CitizenshipCheck_Fr] AS CITIZEN_SHIP_CHECK_FR
			  ,[R_CompPhone] AS COMP_PHONE
			  ,[R_EmpCompAdvisorName] AS EMP_COMP_ADVISOR_NAME
			  ,[R_EmpCompPhone] AS EMP_COMP_PHONE
			  ,[R_EmpLastClassGroupName] AS EMP_LAST_CLASS_GROUP_NAME
			  ,[R_EmpLastClassSubGroupName] AS EMP_LAST_CLASS_SUB_GROUP_NAME
			  ,[R_EmpLastClassLvlName] AS EMP_LAST_CLASS_LVL_NAME
			  ,[R_EmpLastDept_En] AS EMP_LAST_DEPT_EN
			  ,[R_EmpLastDept_Fr] AS EMP_LAST_DEPT_FR
			  ,[R_EmployeeGivenName] AS EMPLOYEE_GIVENNAME
			  ,[R_EmployeeSurname] AS EMPLOYEE_SURNAME
			  ,[R_EmpMeetsConditions_En] AS EMP_MEETS_CONDITIONS_EN
			  ,[R_EmpMeetsConditions_Fr] AS EMP_MEETS_CONDITIONS_FR
			  ,[R_EmpPrefLangCorr_En] AS EMP_PREF_LANG_CORR_EN
			  ,[R_EmpPrefLangCorr_Fr] AS EMP_PREF_LANG_CORR_FR
			  ,[R_EmpPRI] AS EMP_PRI
			  ,[R_FinCodeAllot] AS FIN_CODE_ALLOT
			  ,[R_FinCodeRC] AS FIN_CODE_RC
			  ,[R_FinCodeAct] AS FIN_CODE_ACT
			  ,[R_FinCodeProj] AS FIN_CODE_PROJ
			  ,[R_FinCodeLO] AS  FIN_CODE_LO
			  ,[R_InitialStartDate] AS INITIAL_STARTDATE
			  ,[R_LanguageProfile] AS LANGUAGE_PROFILE
			  ,[F_LeadManager] AS LEAD_MANAGER
			  ,[R_LeadManagerEmail] AS LEAD_MANAGER_EMAIL
			  ,[R_LocationOfWork_En] AS LOCATION_OF_WORK_EN
			  ,[R_LocationOfWork_Fr] AS LOCATION_OF_WORK_FR
			  ,[R_NewEndDateOfTerm] AS NEW_ENDDATE_OF_TERM
			  ,[R_PositionExclusionInfo_En] AS POSITION_EXCLUSION_INFO_EN
			  ,[R_PositionExclusionInfo_Fr] AS POSITION_EXCLUSION_INFO_FR
			  ,[R_PositionNumber] AS POSITION_NUMBER
			  ,[R_PositionTitle] AS POSITION_TITLE
			  ,[R_RateOfPay] AS RATE_OF_PAY
			  ,[R_RationalForSAPPAssign]  AS RATIONAL_FOR_SAPP_ASSIGN
			  ,[R_RelocationExpensesApplic_En] AS RELOCATION_EXPENSES_APPLIC_EN
			  ,[R_RelocationExpensesApplic_Fr] AS RELOCATION_EXPENSES_APPLIC_FR
			  ,[R_RequestCandRef_En] AS REQUEST_CANDREF_EN
			  ,[R_RequestCandRef_Fr] AS REQUEST_CANDREF_FR
			  ,[R_StaffActProjStartDate] AS STAFF_ACT_PROJ_STARTDATE
			  ,[R_StaffActProjEndDate] AS STAFF_ACT_PROJ_ENDDATE
			  ,[R_StaffingProcessNumber] AS STAFFING_PROCESS_NUMBER
			  ,[R_SelectionRationaleText] AS SELECTION_RATIONAL_TEXT
			  ,[F_SubDelegatedManager] AS SUB_DELEGATED_MANAGER
			  ,[R_SubDelegatedManagerEmail] AS SUB_DELEGATED_MANAGER_EMAIL
			  ,[R_SunsetFundApplic_En] AS SUNSET_FUND_APPLIC_EN
			  ,[R_SunsetFundApplic_Fr] AS SUNSET_FUND_APPLIC_FR
			  ,[R_Vtec] 
			  ,[R_WorkSchedule_En] AS WORK_SCHEDULE_EN
			  ,[R_WorkSchedule_Fr] AS WORK_SCHEDULE_FR
			  ,[S_StateName_En] AS STATE_NAME_EN
			  ,[S_StateName_Fr] AS STATE_NAME_FR
			  ,[S_StateTimestamp] AS STATE_TIMESTAMP
		  FROM HRSC.[ASRF_FORMS]
		  WHERE  upper(R_EmployeeGivenName) like upper(@pGivenName + '%') AND
				 upper(R_EmployeeSurname) like upper(@pSurName + '%') AND 
				(S_StateName_En = 'Submitted' OR 
				S_StateName_En = 'Cancelled' OR 
				S_StateName_En = 'Assigned' OR 
				S_StateName_En = 'Extended' OR 
				S_StateName_En = 'Amended')

		) as NewReq

		WHERE NewReq.RowIndex >= @RowIndexStart and NewReq.rowindex < @RowIndexEnd;
	END
ELSE
	IF @pGivenName <> '' 
		BEGIN
			SELECT * FROM
			(SELECT 
				 Row_Number() over (order by R_EmployeeSurname asc, R_EmployeeGivenName asc) as RowIndex
				  , [F_ID]
				  ,[F_AdditionalComments] AS ADDITIONAL_COMMENTS
				  ,[F_AdminSupportContact] AS ADMIN_SUPPORT_CONTACT
				  ,[F_AssignedTo_En] AS ASSIGNED_TO_ENGLISH
				  ,[F_AssignedTo_Fr] AS ASSIGN_TO_FRENCH
				  ,[F_Author] AS AUTHOR
				  ,[F_ClassGroupName] AS CLASS_GROUP_NAME
				  ,[F_ClassSubGroupName] AS CLASS_SUB_GROUP_NAME
				  ,[F_ClassLvlName] AS CLASS_LVL_NAME
				  ,[F_DateSubmitted] AS DATE_SUBMITTED
				  ,[F_DepartementAcronym_En] 
				  ,[F_DepartementAcronym_Fr]
				  ,[F_DepartementName_En] AS DEPARTEMENT_NAME_EN
				  ,[F_DepartementName_Fr] AS DEPARTEMENT_NAME_FR
				  ,[F_Organization_En] AS ORGANISATION_EN
				  ,[F_Organization_Fr] AS ORGANISATION_FR
				  ,[F_OriginalFID] AS ORGINAL_FID
				  ,[F_Region_EN] AS REGION_EN
				  ,[F_Region_Fr] AS REGION_FR
				  ,[F_RequestForm] AS REQUEST_FORM
				  ,[F_RequestType_En] AS REQUEST_TYPE_EN
				  ,[F_RequestType_Fr] AS REQUEST_TYPE_FR
				  ,[F_StaffingProcessType_En] AS STAFFING_PROCESS_TYPE_EN
				  ,[F_StaffingProcessType_Fr] AS STAFFING_PROCESS_TYPE_FR
				  ,[F_SubOrganization_En] AS SUB_ORGANIZATION_EN
				  ,[F_SubOrganization_Fr] AS SUB_ORGANIZATION_FR
				  ,[R_AddClassGroupName] AS ADD_CLASS_GROUP_NAME
				  ,[R_AddClassSubGroupName] AS ADD_CLASS_SUB_GROUP_NAME
				  ,[R_AddClassLevelName] AS ADD_CLASS_LEVEL_NAME
				  ,[R_AdminContactEmail] AS ADMIN_CONTACT_EMAIL
				  ,[R_AppointmentTenure_En] AS APPOINTMENT_TENURE_EN
				  ,[R_AppointmentTenure_Fr] AS APPOINTMENT_TENURE_FR
				  ,[R_CC] 
				  ,[R_CitizenshipCheck_En] AS CITIZEN_SHIP_CHECK_EN
				  ,[R_CitizenshipCheck_Fr] AS CITIZEN_SHIP_CHECK_FR
				  ,[R_CompPhone] AS COMP_PHONE
				  ,[R_EmpCompAdvisorName] AS EMP_COMP_ADVISOR_NAME
				  ,[R_EmpCompPhone] AS EMP_COMP_PHONE
				  ,[R_EmpLastClassGroupName] AS EMP_LAST_CLASS_GROUP_NAME
				  ,[R_EmpLastClassSubGroupName] AS EMP_LAST_CLASS_SUB_GROUP_NAME
				  ,[R_EmpLastClassLvlName] AS EMP_LAST_CLASS_LVL_NAME
				  ,[R_EmpLastDept_En] AS EMP_LAST_DEPT_EN
				  ,[R_EmpLastDept_Fr] AS EMP_LAST_DEPT_FR
				  ,[R_EmployeeGivenName] AS EMPLOYEE_GIVENNAME
				  ,[R_EmployeeSurname] AS EMPLOYEE_SURNAME
				  ,[R_EmpMeetsConditions_En] AS EMP_MEETS_CONDITIONS_EN
				  ,[R_EmpMeetsConditions_Fr] AS EMP_MEETS_CONDITIONS_FR
				  ,[R_EmpPrefLangCorr_En] AS EMP_PREF_LANG_CORR_EN
				  ,[R_EmpPrefLangCorr_Fr] AS EMP_PREF_LANG_CORR_FR
				  ,[R_EmpPRI] AS EMP_PRI
				  ,[R_FinCodeAllot] AS FIN_CODE_ALLOT
				  ,[R_FinCodeRC] AS FIN_CODE_RC
				  ,[R_FinCodeAct] AS FIN_CODE_ACT
				  ,[R_FinCodeProj] AS FIN_CODE_PROJ
				  ,[R_FinCodeLO] AS  FIN_CODE_LO
				  ,[R_InitialStartDate] AS INITIAL_STARTDATE
				  ,[R_LanguageProfile] AS LANGUAGE_PROFILE
				  ,[F_LeadManager] AS LEAD_MANAGER
				  ,[R_LeadManagerEmail] AS LEAD_MANAGER_EMAIL
				  ,[R_LocationOfWork_En] AS LOCATION_OF_WORK_EN
				  ,[R_LocationOfWork_Fr] AS LOCATION_OF_WORK_FR
				  ,[R_NewEndDateOfTerm] AS NEW_ENDDATE_OF_TERM
				  ,[R_PositionExclusionInfo_En] AS POSITION_EXCLUSION_INFO_EN
				  ,[R_PositionExclusionInfo_Fr] AS POSITION_EXCLUSION_INFO_FR
				  ,[R_PositionNumber] AS POSITION_NUMBER
				  ,[R_PositionTitle] AS POSITION_TITLE
				  ,[R_RateOfPay] AS RATE_OF_PAY
				  ,[R_RationalForSAPPAssign]  AS RATIONAL_FOR_SAPP_ASSIGN
				  ,[R_RelocationExpensesApplic_En] AS RELOCATION_EXPENSES_APPLIC_EN
				  ,[R_RelocationExpensesApplic_Fr] AS RELOCATION_EXPENSES_APPLIC_FR
				  ,[R_RequestCandRef_En] AS REQUEST_CANDREF_EN
				  ,[R_RequestCandRef_Fr] AS REQUEST_CANDREF_FR
				  ,[R_StaffActProjStartDate] AS STAFF_ACT_PROJ_STARTDATE
				  ,[R_StaffActProjEndDate] AS STAFF_ACT_PROJ_ENDDATE
				  ,[R_StaffingProcessNumber] AS STAFFING_PROCESS_NUMBER
				  ,[R_SelectionRationaleText] AS SELECTION_RATIONAL_TEXT
				  ,[F_SubDelegatedManager] AS SUB_DELEGATED_MANAGER
				  ,[R_SubDelegatedManagerEmail] AS SUB_DELEGATED_MANAGER_EMAIL
				  ,[R_SunsetFundApplic_En] AS SUNSET_FUND_APPLIC_EN
				  ,[R_SunsetFundApplic_Fr] AS SUNSET_FUND_APPLIC_FR
				  ,[R_Vtec] 
				  ,[R_WorkSchedule_En] AS WORK_SCHEDULE_EN
				  ,[R_WorkSchedule_Fr] AS WORK_SCHEDULE_FR
				  ,[S_StateName_En] AS STATE_NAME_EN
				  ,[S_StateName_Fr] AS STATE_NAME_FR
				  ,[S_StateTimestamp] AS STATE_TIMESTAMP
			  FROM HRSC.[ASRF_FORMS]
			  WHERE  upper(R_EmployeeGivenName) like upper(@pGivenName + '%') AND
					(S_StateName_En = 'Submitted' OR 
					S_StateName_En = 'Cancelled' OR 
					S_StateName_En = 'Assigned' OR 
					S_StateName_En = 'Extended' OR 
					S_StateName_En = 'Amended')

			) as NewReq

			WHERE NewReq.RowIndex >= @RowIndexStart and NewReq.rowindex < @RowIndexEnd;

		END
	ELSE
		BEGIN
			SELECT * FROM
			(SELECT 
				 Row_Number() over (order by R_EmployeeSurname asc, R_EmployeeGivenName asc) as RowIndex
				  , [F_ID]
				  ,[F_AdditionalComments] AS ADDITIONAL_COMMENTS
				  ,[F_AdminSupportContact] AS ADMIN_SUPPORT_CONTACT
				  ,[F_AssignedTo_En] AS ASSIGNED_TO_ENGLISH
				  ,[F_AssignedTo_Fr] AS ASSIGN_TO_FRENCH
				  ,[F_Author] AS AUTHOR
				  ,[F_ClassGroupName] AS CLASS_GROUP_NAME
				  ,[F_ClassSubGroupName] AS CLASS_SUB_GROUP_NAME
				  ,[F_ClassLvlName] AS CLASS_LVL_NAME
				  ,[F_DateSubmitted] AS DATE_SUBMITTED
				  ,[F_DepartementAcronym_En] 
				  ,[F_DepartementAcronym_Fr]
				  ,[F_DepartementName_En] AS DEPARTEMENT_NAME_EN
				  ,[F_DepartementName_Fr] AS DEPARTEMENT_NAME_FR
				  ,[F_Organization_En] AS ORGANISATION_EN
				  ,[F_Organization_Fr] AS ORGANISATION_FR
				  ,[F_OriginalFID] AS ORGINAL_FID
				  ,[F_Region_EN] AS REGION_EN
				  ,[F_Region_Fr] AS REGION_FR
				  ,[F_RequestForm] AS REQUEST_FORM
				  ,[F_RequestType_En] AS REQUEST_TYPE_EN
				  ,[F_RequestType_Fr] AS REQUEST_TYPE_FR
				  ,[F_StaffingProcessType_En] AS STAFFING_PROCESS_TYPE_EN
				  ,[F_StaffingProcessType_Fr] AS STAFFING_PROCESS_TYPE_FR
				  ,[F_SubOrganization_En] AS SUB_ORGANIZATION_EN
				  ,[F_SubOrganization_Fr] AS SUB_ORGANIZATION_FR
				  ,[R_AddClassGroupName] AS ADD_CLASS_GROUP_NAME
				  ,[R_AddClassSubGroupName] AS ADD_CLASS_SUB_GROUP_NAME
				  ,[R_AddClassLevelName] AS ADD_CLASS_LEVEL_NAME
				  ,[R_AdminContactEmail] AS ADMIN_CONTACT_EMAIL
				  ,[R_AppointmentTenure_En] AS APPOINTMENT_TENURE_EN
				  ,[R_AppointmentTenure_Fr] AS APPOINTMENT_TENURE_FR
				  ,[R_CC] 
				  ,[R_CitizenshipCheck_En] AS CITIZEN_SHIP_CHECK_EN
				  ,[R_CitizenshipCheck_Fr] AS CITIZEN_SHIP_CHECK_FR
				  ,[R_CompPhone] AS COMP_PHONE
				  ,[R_EmpCompAdvisorName] AS EMP_COMP_ADVISOR_NAME
				  ,[R_EmpCompPhone] AS EMP_COMP_PHONE
				  ,[R_EmpLastClassGroupName] AS EMP_LAST_CLASS_GROUP_NAME
				  ,[R_EmpLastClassSubGroupName] AS EMP_LAST_CLASS_SUB_GROUP_NAME
				  ,[R_EmpLastClassLvlName] AS EMP_LAST_CLASS_LVL_NAME
				  ,[R_EmpLastDept_En] AS EMP_LAST_DEPT_EN
				  ,[R_EmpLastDept_Fr] AS EMP_LAST_DEPT_FR
				  ,[R_EmployeeGivenName] AS EMPLOYEE_GIVENNAME
				  ,[R_EmployeeSurname] AS EMPLOYEE_SURNAME
				  ,[R_EmpMeetsConditions_En] AS EMP_MEETS_CONDITIONS_EN
				  ,[R_EmpMeetsConditions_Fr] AS EMP_MEETS_CONDITIONS_FR
				  ,[R_EmpPrefLangCorr_En] AS EMP_PREF_LANG_CORR_EN
				  ,[R_EmpPrefLangCorr_Fr] AS EMP_PREF_LANG_CORR_FR
				  ,[R_EmpPRI] AS EMP_PRI
				  ,[R_FinCodeAllot] AS FIN_CODE_ALLOT
				  ,[R_FinCodeRC] AS FIN_CODE_RC
				  ,[R_FinCodeAct] AS FIN_CODE_ACT
				  ,[R_FinCodeProj] AS FIN_CODE_PROJ
				  ,[R_FinCodeLO] AS  FIN_CODE_LO
				  ,[R_InitialStartDate] AS INITIAL_STARTDATE
				  ,[R_LanguageProfile] AS LANGUAGE_PROFILE
				  ,[F_LeadManager] AS LEAD_MANAGER
				  ,[R_LeadManagerEmail] AS LEAD_MANAGER_EMAIL
				  ,[R_LocationOfWork_En] AS LOCATION_OF_WORK_EN
				  ,[R_LocationOfWork_Fr] AS LOCATION_OF_WORK_FR
				  ,[R_NewEndDateOfTerm] AS NEW_ENDDATE_OF_TERM
				  ,[R_PositionExclusionInfo_En] AS POSITION_EXCLUSION_INFO_EN
				  ,[R_PositionExclusionInfo_Fr] AS POSITION_EXCLUSION_INFO_FR
				  ,[R_PositionNumber] AS POSITION_NUMBER
				  ,[R_PositionTitle] AS POSITION_TITLE
				  ,[R_RateOfPay] AS RATE_OF_PAY
				  ,[R_RationalForSAPPAssign]  AS RATIONAL_FOR_SAPP_ASSIGN
				  ,[R_RelocationExpensesApplic_En] AS RELOCATION_EXPENSES_APPLIC_EN
				  ,[R_RelocationExpensesApplic_Fr] AS RELOCATION_EXPENSES_APPLIC_FR
				  ,[R_RequestCandRef_En] AS REQUEST_CANDREF_EN
				  ,[R_RequestCandRef_Fr] AS REQUEST_CANDREF_FR
				  ,[R_StaffActProjStartDate] AS STAFF_ACT_PROJ_STARTDATE
				  ,[R_StaffActProjEndDate] AS STAFF_ACT_PROJ_ENDDATE
				  ,[R_StaffingProcessNumber] AS STAFFING_PROCESS_NUMBER
				  ,[R_SelectionRationaleText] AS SELECTION_RATIONAL_TEXT
				  ,[F_SubDelegatedManager] AS SUB_DELEGATED_MANAGER
				  ,[R_SubDelegatedManagerEmail] AS SUB_DELEGATED_MANAGER_EMAIL
				  ,[R_SunsetFundApplic_En] AS SUNSET_FUND_APPLIC_EN
				  ,[R_SunsetFundApplic_Fr] AS SUNSET_FUND_APPLIC_FR
				  ,[R_Vtec] 
				  ,[R_WorkSchedule_En] AS WORK_SCHEDULE_EN
				  ,[R_WorkSchedule_Fr] AS WORK_SCHEDULE_FR
				  ,[S_StateName_En] AS STATE_NAME_EN
				  ,[S_StateName_Fr] AS STATE_NAME_FR
				  ,[S_StateTimestamp] AS STATE_TIMESTAMP
			  FROM HRSC.[ASRF_FORMS]
			  WHERE  upper(R_EmployeeSurname) like upper(@pSurName + '%') AND 
					(S_StateName_En = 'Submitted' OR 
					S_StateName_En = 'Cancelled' OR 
					S_StateName_En = 'Assigned' OR 
					S_StateName_En = 'Extended' OR 
					S_StateName_En = 'Amended')

			) as NewReq

			WHERE NewReq.RowIndex >= @RowIndexStart and NewReq.rowindex < @RowIndexEnd;

		END


END

