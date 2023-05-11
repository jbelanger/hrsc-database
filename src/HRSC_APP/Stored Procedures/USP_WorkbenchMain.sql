



CREATE   PROCEDURE [HRSC_APP].[USP_WorkbenchMain]
@EMP_ID bigint, @BCs xml
WITH EXEC AS CALLER
AS

DECLARE @EMP_NAME NVARCHAR(200)

SELECT @EMP_NAME = EMPLOYEE_SURNAME + ', ' + EMPLOYEE_GIVEN_NAME
FROM HRSC.EMPLOYEE
WHERE EMPLOYEE_ID = @EMP_ID

SELECT A.BUSINESS_CENTER_ID AS BC_ID, D.BUSINESS_CENTER_NAME_EN AS BC_NAME_EN, D.BUSINESS_CENTER_NAME_FR AS BC_NAME_FR,  D.BUSINESS_CENTER_CODE AS BC_CODE,
		@EMP_NAME AS EMPLOYEE_NAME, @EMP_ID AS EMPLOYEE_ID,
		ISNULL(B.UnAssignedPD, 0) AS UNASSIGNED_PD, ISNULL(B.UnAssignedCurrent, 0) AS UNASSIGNED_CURRENT, ISNULL(B.UnAssignedFuture, 0) AS UNASSIGNED_FD, ISNULL(B.UnAssignedCount, 0) AS UNASSIGNED_COUNT,
		ISNULL(C.ActivePD, 0) AS ACTIVE_PD, ISNULL(C.ActiveCurrent, 0) AS ACTIVE_CURRENT, ISNULL(C.ActiveFuture, 0) AS ACTIVE_FD, ISNULL(C.ActiveCount, 0) AS ACTIVE_COUNT,
		ISNULL(C.PendingPD, 0) AS PENDING_PD, ISNULL(C.PendingCurrent, 0) AS PENDING_CURRENT, ISNULL(C.PendingFuture, 0) AS PENDING_FD, ISNULL(C.PendingCount, 0) AS PENDING_COUNT
FROM

	(SELECT DISTINCT (I.BUSINESS_CENTER_ID) 
	FROM HRSC.HR_RQST_INTRVNT_HRSC_USER Rl
	JOIN HRSC.HR_REQUEST_INTERVENTION I ON Rl.REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID
	WHERE Rl.EMPLOYEE_ID = @EMP_ID
			AND Rl.EMPLOYEE_ROLE_ID IN (SELECT EMPLOYEE_ROLE_ID FROM HRSC.CD_EMPLOYEE_ROLE WHERE EMPLOYEE_ROLE_CODE IN (N'LEAD', N'COL'))
			AND I.REQUEST_STATUS_ID NOT IN (SELECT  REQUEST_STATUS_ID FROM HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE IN (N'CANC', N'CLOSE', N'REJ', N'NOACT'))
	UNION
	SELECT DISTINCT (BUSINESS_CENTER_ID)
	FROM HRSC.CD_BUSINESS_CENTER
	WHERE BUSINESS_CENTER_CODE IN (SELECT x.y.value('BCCode[1]', 'nvarchar(20)') AS BC_Code FROM @BCs.nodes('/ArrayOfClsDashBoardSQL/clsDashBoardSQL') x(y))) 
	AS A
				    
	LEFT OUTER JOIN

	(SELECT I.BUSINESS_CENTER_ID,
			COUNT(R.HR_REQUEST_ID) AS UnAssignedCount,
			COUNT(CASE WHEN PROCESSING_CLOSE_DATE < GETUTCDATE() THEN 1 ELSE NULL END) AS UnAssignedPD,
			COUNT(CASE WHEN PROCESSING_OPEN_DATE IS NULL OR (PROCESSING_OPEN_DATE <= GETUTCDATE() AND PROCESSING_CLOSE_DATE >= GETUTCDATE()) THEN 1 ELSE NULL END) AS UnAssignedCurrent,
			COUNT(CASE WHEN PROCESSING_OPEN_DATE > GETUTCDATE() THEN 1 ELSE NULL END) AS UnAssignedFuture
	FROM HRSC.HR_REQUEST_INTERVENTION I
	JOIN HRSC.HR_REQUEST R ON I.HR_REQUEST_ID = R.HR_REQUEST_ID
	JOIN HRSC.CD_REQUEST_STATUS SS ON SS.REQUEST_STATUS_ID = I.REQUEST_STATUS_ID
	WHERE SS.REQUEST_STATUS_CODE IN ('ATSF', 'NEW', 'NUPD','TSF') 
	GROUP BY I.BUSINESS_CENTER_ID) 
	AS B ON A.BUSINESS_CENTER_ID = B.BUSINESS_CENTER_ID

	LEFT OUTER JOIN
				
	(SELECT I.BUSINESS_CENTER_ID,
			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('ASGN', 'PROC', 'SIGND', 'RTNFC') THEN 1 ELSE NULL END) AS ActiveCount,
			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('ASGN', 'PROC', 'SIGND', 'RTNFC') 
					AND PROCESSING_CLOSE_DATE < GETUTCDATE() THEN 1 ELSE NULL END) AS ActivePD,
			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('ASGN', 'PROC', 'SIGND', 'RTNFC') 
					AND (PROCESSING_OPEN_DATE IS NULL OR (PROCESSING_OPEN_DATE <= GETUTCDATE() AND PROCESSING_CLOSE_DATE >= GETUTCDATE())) THEN 1 ELSE NULL END) AS ActiveCurrent,
			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('ASGN', 'PROC', 'SIGND', 'RTNFC') 
					AND PROCESSING_OPEN_DATE > GETUTCDATE() THEN 1 ELSE NULL END) AS ActiveFuture,

			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('WAIT', 'WSIGN', 'RTRNC', 'RTURN') THEN 1 ELSE NULL END) AS PendingCount,
			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('WAIT', 'WSIGN', 'RTRNC', 'RTURN') 
					AND PROCESSING_CLOSE_DATE < GETUTCDATE() THEN 1 ELSE NULL END) AS PendingPD,
			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('WAIT', 'WSIGN', 'RTRNC', 'RTURN') 
					AND (PROCESSING_OPEN_DATE IS NULL OR (PROCESSING_OPEN_DATE <= GETUTCDATE() AND PROCESSING_CLOSE_DATE >= GETUTCDATE())) THEN 1 ELSE NULL END) AS PendingCurrent,
			COUNT(CASE WHEN REQUEST_STATUS_CODE IN ('WAIT', 'WSIGN', 'RTRNC', 'RTURN') 
					AND PROCESSING_OPEN_DATE > GETUTCDATE() THEN 1 ELSE NULL END) AS PendingFuture
	FROM HRSC.HR_REQUEST_INTERVENTION I
	JOIN HRSC.HR_RQST_INTRVNT_HRSC_USER U ON U.REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID
	JOIN HRSC.HR_REQUEST R ON I.HR_REQUEST_ID = R.HR_REQUEST_ID
	JOIN HRSC.CD_REQUEST_STATUS SS ON SS.REQUEST_STATUS_ID = I.REQUEST_STATUS_ID
	WHERE EMPLOYEE_ID = @EMP_ID AND SS.REQUEST_STATUS_CODE IN ('ASGN', 'PROC', 'SIGND', 'RTNFC', 'WAIT', 'WSIGN', 'RTRNC', 'RTURN')  
	GROUP BY I.BUSINESS_CENTER_ID)
	AS C ON A.BUSINESS_CENTER_ID = C.BUSINESS_CENTER_ID

	LEFT OUTER JOIN

	(SELECT BUSINESS_CENTER_ID, BUSINESS_CENTER_NAME_EN, BUSINESS_CENTER_NAME_FR,  BUSINESS_CENTER_CODE 
	FROM HRSC.CD_BUSINESS_CENTER) 
	AS D ON A.BUSINESS_CENTER_ID = D.BUSINESS_CENTER_ID

ORDER BY BC_NAME_EN



--DECLARE @BC_ID bigint;
--DECLARE @return_value int;

--DECLARE @DashXML XML;
----SET @BCs = '<?xml version="1.0"?>  <ArrayOfClsDashBoardSQL xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">    <clsDashBoardSQL>      <BCCode>HP</BCCode>    </clsDashBoardSQL>    <clsDashBoardSQL>      <BCCode>HRSC</BCCode>    </clsDashBoardSQL>  </ArrayOfClsDashBoardSQL>"' 
--declare @BC_INFO table
--  (
--    BC_ID bigint,
--    BC_NAME_EN nvarchar(250),
--    BC_NAME_FR nvarchar(250),
--    BC_CODE nvarchar(5),
--    EMPLOYEE_NAME nvarchar(100),
--    EMPLOYEE_ID bigint,
--    UNASSIGNED_PD bigint,
--    UNASSIGNED_CURRENT bigint,
--    UNASSIGNED_FD bigint,
--    UNASSIGNED_COUNT bigint,
--    ACTIVE_PD bigint,
--    ACTIVE_CURRENT bigint,
--    ACTIVE_FD bigint,
--    ACTIVE_COUNT bigint,
--    PENDING_PD bigint,
--    PENDING_CURRENT bigint,
--    PENDING_FD bigint,
--    PENDING_COUNT bigint
--  )
  
--   DECLARE BC_Cursor CURSOR FOR

--      SELECT DISTINCT (I.BUSINESS_CENTER_ID) 
--      FROM HRSC.HR_RQST_INTRVNT_HRSC_USER Rl
--	  JOIN HRSC.HR_REQUEST_INTERVENTION I ON Rl.REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID
--      WHERE rl.EMPLOYEE_ID = @EMP_ID
--            AND rl.employee_role_id IN (select EMPLOYEE_ROLE_ID from HRSC.CD_EMPLOYEE_ROLE where EMPLOYEE_ROLE_CODE IN (N'LEAD', N'COL'))
--            and I.REQUEST_STATUS_ID not in (select  REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE in (N'CANC', N'CLOSE', N'REJ', N'NOACT'))

--    UNION

--      SELECT DISTINCT (business_center_id)
--          FROM HRSC.CD_BUSINESS_CENTER
--          WHERE BUSINESS_CENTER_CODE in (SELECT  x.y.value( 'BCCode[1]', 'nvarchar(20)' ) AS BC_Code FROM @BCs.nodes('/ArrayOfClsDashBoardSQL/clsDashBoardSQL') x(y))

--  OPEN BC_Cursor
--  FETCH NEXT FROM BC_Cursor INTO @BC_ID
      
--  WHILE @@FETCH_STATUS = 0
  
--    BEGIN
      
--      EXEC  @return_value = HRSC_APP.USP_WorkBenchLoopXML 
--            @BC_ID = @BC_ID,
--            @EMP_ID = @EMP_ID,
--            @OutXML = @DashXML out;
      
--        INSERT INTO @BC_INFO
--               (BC_ID,
--                BC_NAME_EN,
--                BC_NAME_FR,
--                BC_CODE,
--                EMPLOYEE_NAME,
--                EMPLOYEE_ID,
--                UNASSIGNED_PD,
--                UNASSIGNED_CURRENT,
--                UNASSIGNED_FD,
--                UNASSIGNED_COUNT,
--                ACTIVE_PD,
--                ACTIVE_CURRENT,
--                ACTIVE_FD,
--                ACTIVE_COUNT,
--                PENDING_PD,
--                PENDING_CURRENT,
--                PENDING_FD,
--                PENDING_COUNT)

--                SELECT  Data.Col.value('(/DashResults/DashResult/BC_ID)[1]','BigInt') as BC_ID,
--                        Data.Col.value('(/DashResults/DashResult/BC_NAME_EN)[1]','nvarchar(250)') as BC_NAME_EN,
--                        Data.Col.value('(/DashResults/DashResult/BC_NAME_FR)[1]','nvarchar(250)') as BC_NAME_FR,
--                        Data.Col.value('(/DashResults/DashResult/BC_CODE)[1]','nvarchar(5)') as BC_CODE,
--                        Data.Col.value('(/DashResults/DashResult/EMPLOYEE_NAME)[1]','nvarchar(100)') as EMPLOYEE_NAME,
--                        @EMP_ID,
                
--                        Data.Col.value('(/DashResults/DashResult/UnAssignedPD)[1]','BigInt') as UnAssignedPD,
--                        Data.Col.value('(/DashResults/DashResult/UnAssignedCurrent)[1]','BigInt') as UnAssignedCurrent,
--                        Data.Col.value('(/DashResults/DashResult/UnAssignedFuture)[1]','BigInt') as UnAssignedFuture,
--                        Data.Col.value('(/DashResults/DashResult/UnAssignedCount)[1]','BigInt') as UnAssignedCount,

--                        Data.Col.value('(/DashResults/DashResult/ActivePD)[1]','BigInt') as ActivePD,
--                        Data.Col.value('(/DashResults/DashResult/ActiveCurrent)[1]','BigInt') as ActiveCurrent,
--                        Data.Col.value('(/DashResults/DashResult/ActiveFuture)[1]','BigInt') as ActiveFuture,
--                        Data.Col.value('(/DashResults/DashResult/ActiveCount)[1]','BigInt') as ActiveCount,
                   
--                        Data.Col.value('(/DashResults/DashResult/PendingPD)[1]','BigInt') as PendingPD,
--                        Data.Col.value('(/DashResults/DashResult/PendingCurrent)[1]','BigInt') as PendingCurrent,
--                        Data.Col.value('(/DashResults/DashResult/PendingFuture)[1]','BigInt') as PendingFuture,
--                        Data.Col.value('(/DashResults/DashResult/PendingCount)[1]','BigInt') as PendingCount

--                FROM @DashXML.nodes('/DashResults') AS Data(Col)  
        
--          FETCH NEXT FROM BC_Cursor INTO @BC_ID
--	    END

--  CLOSE BC_Cursor
--  DEALLOCATE BC_Cursor
  
--  SELECT * from @BC_INFO order by BC_NAME_EN;
