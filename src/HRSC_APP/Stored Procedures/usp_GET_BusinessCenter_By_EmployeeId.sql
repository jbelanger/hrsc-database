



CREATE   PROCEDURE [HRSC_APP].[usp_GET_BusinessCenter_By_EmployeeId]
@pEmployeeid bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- SelectActiveCdBusinessCenter for and Employee
--Tony Paradis 2013-09-105 Added Aliases
-- MT 2018-10-29
------------------------------------------------------
SELECT  BC.business_center_id AS id,
        BC.business_center_name_en AS name_en,
        BC.business_center_name_fr AS name_fr,
        BC.business_center_desc_en AS desc_en,
        BC.business_center_desc_fr AS desc_fr,
        BC.business_center_code AS code,
        BC.effective_date,
        BC.expiry_date,
        BC.user_created,
        BC.user_updated,
        BC.date_created,
        BC.date_updated
 FROM  hrsc.HRSC_USER_ROLE_BC UR
		INNER JOIN  hrsc.cd_business_center BC ON  BC.business_center_id = UR.BUSINESS_CENTER_ID
 Where  UR.EMPLOYEE_ID = @pEmployeeid
 and	UR.expiry_date is null
 and    BC.expiry_date IS null
