



CREATE   PROCEDURE [HRSC_APP].[usp_CD_HrscUserRole_byRole]
@pRoleCode as varchar(10)
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_HrscUserRole_SelectAll 
-- Retreives all active HR User Role (Active and inactive)
-- Gaétan Demers  2011-12-13
-- Eric Nolet     2011-12-15 Added Aliases
------------------------------------------------------
if @pRoleCode = 'Management' 

SELECT  hrsc_user_role_id AS id,
        hrsc_user_role_name_en AS name_en,
        hrsc_user_role_name_fr AS name_fr,
        hrsc_user_role_desc_en AS desc_en,
        hrsc_user_role_desc_fr AS desc_fr,
        hrsc_user_role_code AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM    hrsc.cd_hrsc_user_role
WHERE  Upper(cd_hrsc_user_role.hrsc_user_role_code) = 'BCE'

Else if @pRoleCode = 'Admin' 

SELECT  hrsc_user_role_id AS id,
        hrsc_user_role_name_en AS name_en,
        hrsc_user_role_name_fr AS name_fr,
        hrsc_user_role_desc_en AS desc_en,
        hrsc_user_role_desc_fr AS desc_fr,
        hrsc_user_role_code AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM    hrsc.cd_hrsc_user_role
WHERE Upper(cd_hrsc_user_role.hrsc_user_role_code) != 'IITB'

else
SELECT  hrsc_user_role_id AS id,
        hrsc_user_role_name_en AS name_en,
        hrsc_user_role_name_fr AS name_fr,
        hrsc_user_role_desc_en AS desc_en,
        hrsc_user_role_desc_fr AS desc_fr,
        hrsc_user_role_code AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM    hrsc.cd_hrsc_user_role
