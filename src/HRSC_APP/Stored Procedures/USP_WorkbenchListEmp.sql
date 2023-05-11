




CREATE     PROCEDURE [HRSC_APP].[USP_WorkbenchListEmp]
@BCs xml, @Emp_id bigint
WITH EXEC AS CALLER
AS
--SET @BCs = '<?xml version="1.0"?>  <ArrayOfClsDashBoardSQL xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">    <clsDashBoardSQL>      <BCCode>HP</BCCode>    </clsDashBoardSQL>    <clsDashBoardSQL>      <BCCode>HRSC</BCCode>    </clsDashBoardSQL>  </ArrayOfClsDashBoardSQL>"' 

select distinct EMPLOYEE_ID, Emp_name from 

(select distinct Rl.EMPLOYEE_ID, E.EMPLOYEE_SURNAME + ', ' + E.EMPLOYEE_GIVEN_NAME as Emp_name

FROM HRSC.HR_RQST_INTRVNT_HRSC_USER Rl 
JOIN HRSC.HR_REQUEST_INTERVENTION I ON Rl.REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID
JOIN HRSC.EMPLOYEE E ON Rl.EMPLOYEE_ID = E.EMPLOYEE_ID
where I.BUSINESS_CENTER_ID in (select BUSINESS_CENTER_ID from HRSC.CD_BUSINESS_CENTER where BUSINESS_CENTER_CODE in (SELECT  x.y.value( 'BCCode[1]', 'nvarchar(20)' ) AS BC_Code FROM @BCs.nodes('/ArrayOfClsDashBoardSQL/clsDashBoardSQL') x(y)))
      and I.REQUEST_STATUS_ID not in (select  REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE in (N'CANC', N'CLOSE', N'REJ', N'NOACT'))

union

select distinct E.EMPLOYEE_ID, E.EMPLOYEE_SURNAME + ', ' + E.EMPLOYEE_GIVEN_NAME as Emp_name

FROM HRSC.EMPLOYEE E

where E.EMPLOYEE_ID = @Emp_id) as Temp
order by emp_name

--select distinct Rl.EMPLOYEE_ID, E.EMPLOYEE_GIVEN_NAME + ' ' + E.EMPLOYEE_SURNAME as Emp_name
--
--FROM HRSC.HR_RQST_INTRVNT_HRSC_USER Rl, HRSC.HR_REQUEST_INTERVENTION I, HRSC.EMPLOYEE E
--
--where Rl.REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID
--      and Rl.EMPLOYEE_ID = E.EMPLOYEE_ID
--      and I.BUSINESS_CENTER_ID in (select BUSINESS_CENTER_ID from HRSC.CD_BUSINESS_CENTER where BUSINESS_CENTER_CODE in (SELECT  x.y.value( 'BCCode[1]', 'nvarchar(20)' ) AS BC_Code FROM @BCs.nodes('/ArrayOfClsDashBoardSQL/clsDashBoardSQL') x(y)))
--      and I.REQUEST_STATUS_ID not in (select  REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE in (N'CANC', N'CLOSE', N'REJ', N'NOACT'))
--      order by emp_name
