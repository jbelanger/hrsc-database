



CREATE   PROCEDURE [HRSC_APP].[usp_EMPLOYEE_SearchManagersByNames]
@strSurname nvarchar(64), @strGivenName nvarchar(30)
WITH EXEC AS CALLER
AS
  ------------------------------------------------------
  -- EMPLOYEE_SearchManagersByNames
  -- 
  -- Eric Nolet 2012-02-02
  -- MT 2018-10-25
  ------------------------------------------------------
  Select  distinct(EMP.EMPLOYEE_ID),
          --EMP.EMPLOYEE_SURNAME + ', ' + EMP.EMPLOYEE_GIVEN_NAME AS EMP_NAME,
          EMP.EMPLOYEE_SURNAME,
          EMP.EMPLOYEE_GIVEN_NAME,
          EMP.EMPLOYEE_EMAIL_ADDRESS,
          EMP.WORK_PHONE_NUMBER
  FROM  HRSC.EMPLOYEE EMP
	INNER JOIN HRSC.EMPLOYEE_ROLE_FOR_REQUEST ROLE ON ROLE.EMPLOYEE_ID = EMP.EMPLOYEE_ID          
  WHERE EMP.EMPLOYEE_SURNAME COLLATE Latin1_General_CI_AI = COALESCE(@strSurname, EMP.EMPLOYEE_SURNAME) COLLATE Latin1_General_CI_AI and
        EMP.EMPLOYEE_GIVEN_NAME COLLATE Latin1_General_CI_AI = COALESCE(@strGivenName, EMP.EMPLOYEE_GIVEN_NAME) COLLATE Latin1_General_CI_AI
  order by  EMP.EMPLOYEE_SURNAME, EMP.EMPLOYEE_GIVEN_NAME
