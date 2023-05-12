/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

begin
    PRINT 'BEGIN Pre-deployment script'

    /*
    Since the PostDeployment script recreates all code tables, 
    it can cause FK errors if some table references rows that no longer exists in those code tables.

    We only have to clear data from the new code tables that are not yet in the PostDeployment script.
    */
    IF OBJECT_ID(N'HRSC.APPROVAL_TRANSFER_RULE', N'U') IS NOT NULL  
        DELETE [HRSC].[APPROVAL_TRANSFER_RULE];  

    IF OBJECT_ID(N'HRSC.BUSINESS_CENTER_ATTR', N'U') IS NOT NULL  
        DELETE [HRSC].[BUSINESS_CENTER_ATTR];  

    IF OBJECT_ID(N'HRSC.CD_ATTRIBUTE', N'U') IS NOT NULL  
        DELETE [HRSC].[CD_ATTRIBUTE]; 

    IF OBJECT_ID(N'HRSC.CD_CANDIDATE_TYPE', N'U') IS NOT NULL  
        DELETE [HRSC].[CD_CANDIDATE_TYPE]; 

    PRINT 'END Pre-deployment script'

end