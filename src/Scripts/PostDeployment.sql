/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
if @@servername <> 'MLDBSQL16CL01' -- Production and training
begin 
    /*
    Insert lookup data. Allowed on dev environments only.
    */
    :r ./"Seed/HRSC.CD_ACADEMIC_LEVEL.Table.sql"
    :r ./"Seed/HRSC.CD_ACCOMODATION_REQUIRED.Table.sql"
    :r ./"Seed/HRSC.CD_ACTION_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_ANNOUNCEMENT_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_BUSINESS_CENTER.Table.sql"
    :r ./"Seed/HRSC.CD_CHKLST_STATUS.Table.sql"
    :r ./"Seed/HRSC.CD_CLASSIFICATION_GROUP.Table.sql"
    :r ./"Seed/HRSC.CD_CLASSIFICATION_LEVEL.Table.sql"
    :r ./"Seed/HRSC.CD_CLASSIFICATION_SUB_GROUP.Table.sql"    
    :r ./"Seed/HRSC.CD_COMMUNICATION_REQ.Table.sql"
    :r ./"Seed/HRSC.CD_DEPARTMENT.Table.sql"
    :r ./"Seed/HRSC.CD_DEPLOYMENT_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_DOCUMENT_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_DOUBLE_BANKING.Table.sql"
    :r ./"Seed/HRSC.CD_EMAIL_TEMPLATE_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_EMPLOYEE_ROLE.Table.sql"
    :r ./"Seed/HRSC.CD_EMPLOYEE_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_EXCLUSION_OPTION.Table.sql"
    :r ./"Seed/HRSC.CD_FISCAL_YEAR.Table.sql"
    :r ./"Seed/HRSC.CD_GD_ACCOUNT_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_HRSC_USER_ROLE.Table.sql"
    :r ./"Seed/HRSC.CD_HR_GUIDE_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_HR_REQUEST_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_HR_JUSTIFICATION.Table.sql"
    :r ./"Seed/HRSC.CD_LANGUAGE.Table.sql"
    :r ./"Seed/HRSC.CD_LANGUAGE_LEVEL.Table.sql"
    :r ./"Seed/HRSC.CD_LANG_PROFICIENCY.Table.sql"
    :r ./"Seed/HRSC.CD_LEAVE_WITHOUT_PAY.Table.sql"
    :r ./"Seed/HRSC.CD_MODE_OF_RECEIPT.Table.sql"
    :r ./"Seed/HRSC.CD_NOTE_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_ORGANIZATION.Table.sql"
    :r ./"Seed/HRSC.CD_PAY_STATUS.Table.sql"
    :r ./"Seed/HRSC.CD_POSITION_REQUEST_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_PRIORITY_OF_REQUEST.Table.sql"
    :r ./"Seed/HRSC.CD_PRIORITY_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_REASON_FOR_SLE.Table.sql"
    :r ./"Seed/HRSC.CD_REASON_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_REGION.Table.sql"
    :r ./"Seed/HRSC.CD_RELOCATION_EXPENSE.Table.sql"
    :r ./"Seed/HRSC.CD_REPORT_REQUEST_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_REQUEST_CATEGORY.Table.sql"
    :r ./"Seed/HRSC.CD_REQUEST_STATUS.Table.sql"
    :r ./"Seed/HRSC.CD_REQUEST_SUB_CATEGORY.Table.sql"
    :r ./"Seed/HRSC.CD_SECURITY_CLEARANCE.Table.sql"
    :r ./"Seed/HRSC.CD_SEPARATION_CHCKLST.Table.sql"
    :r ./"Seed/HRSC.CD_SEPARATION_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_SERVICE.Table.sql"
    :r ./"Seed/HRSC.CD_STAFFING_PROCESS_STATUS.Table.sql"
    :r ./"Seed/HRSC.CD_STUDENT_PROGRAM.Table.sql"
    :r ./"Seed/HRSC.CD_SUBMITTER_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_SUB_ORGANIZATION.Table.sql"
    :r ./"Seed/HRSC.CD_SUNSET_FUNDING_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_TENURE_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_TYPE_OF_STAFFING_ACTION.Table.sql"
    :r ./"Seed/HRSC.CD_VERSION.Table.sql"
    :r ./"Seed/HRSC.CD_COI_DECLARATION_TYPE.Table.sql"
    :r ./"Seed/HRSC.CD_COI_QUESTION.Table.sql"
    :r ./"Seed/HRSC.CD_WORK_TYPE.Table.sql"
    :r ./"Seed/HRSC.EMAIL_TEMPLATE.Table.sql"
    :r ./"Seed/HRSC.GD_ACCOUNT_EMAIL.Table.sql"
    :r ./"Seed/HRSC.HR_AGREEMENT_TERM.Table.sql"
    :r ./"Seed/HRSC.PROVINCE.Table.sql"
    :r ./"Seed/HRSC.MUNICIPALITY.Table.sql"
    :r ./"Seed/HRSC.OFFICE_SITE.Table.sql"
    :r ./"Seed/HRSC.REQ_STATUS_JUSTIFICATION.Table.sql"
    :r ./"Seed/HRSC.SEPARATION_CHKLST_TYPE.Table.sql"
    :r ./"Seed/HRSC.BC_CATEGORY.Table.sql"
end


begin
    PRINT 'BEGIN Post-deployment script'
    :r ./"Db Changes.sql"
    PRINT 'END Post-deployment script'
end