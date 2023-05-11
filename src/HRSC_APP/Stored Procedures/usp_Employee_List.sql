




CREATE     PROCEDURE [HRSC_APP].[usp_Employee_List]
@pAlpha Varchar(4)
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- Employee_List
-- Retreives all Employee 
-- Tony Paradis  2012-01-12

------------------------------------------------------

If DATALENGTH(@pAlpha) > 1 
Begin
set @pAlpha = '%';
end


SELECT  EMPLOYEE_ID AS ID,
       DISPLAY_NAME AS EMPLOYEE_NAME
FROM    hrsc.EMPLOYEE
WHERE EXPIRY_DATE IS NULL and EMPLOYEE_SURNAME like '' + @pAlpha + '%'
ORDER BY EMPLOYEE_NAME
