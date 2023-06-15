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

    -- #1670 
    -- Column as created a while ago in the goal of replacing the LANGUAGE_CODE column which was created as an integer. 
    -- Migrate data before dropping
    IF NOT COL_LENGTH('HRSC.CD_LANGUAGE','LANGUAGE_CODE') IS NULL
    BEGIN
        -- USING sp_executesql to be able to run this script again even if column has been dropped previously.
        -- Otherwise, we get "Invalid column name 'LANGUAGE_CODE'."
        DECLARE @sql nvarchar(max)
        SET @sql = 'UPDATE HRSC.CD_LANGUAGE SET LANGUAGE_CODE2 = LANGUAGE_CODE'
        EXECUTE sp_executesql @sql
    END


    -- Add missing FK on HR_CONTRACT.SIGNED_CONTRACT_ID. 
    -- Fix bad data.
    UPDATE HRSC.HR_CONTRACT SET
	    SIGNED_CONTRACT_ID = null
    WHERE SIGNED_CONTRACT_ID in(
	    select orig.SIGNED_CONTRACT_ID from hrsc.hr_contract orig
	    left join hrsc.hr_contract signed on orig.SIGNED_CONTRACT_ID = signed.HR_CONTRACT_ID 
	    where orig.SIGNED_CONTRACT_ID is not null and signed.HR_CONTRACT_ID is null
    )

    PRINT 'END Pre-deployment script'
end