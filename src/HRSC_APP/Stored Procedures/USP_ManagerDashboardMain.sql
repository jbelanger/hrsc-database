



CREATE   PROCEDURE [HRSC_APP].[USP_ManagerDashboardMain]
@BCs xml
WITH EXEC AS CALLER
AS
DECLARE @BCCode nvarchar(20);

DECLARE @return_value int;
DECLARE @DashXML XML;

--select @BCCode = N'HP';
--SET @BCs = '<?xml version="1.0"?>  <ArrayOfString xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">    <string>HP</string>    <string>HRSC</string>  </ArrayOfString>' 
--SET @BCs = '<?xml version="1.0"?>  <ArrayOfClsDashBoardSQL xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">    <clsDashBoardSQL>      <BCCode>HP</BCCode>    </clsDashBoardSQL>    <clsDashBoardSQL>      <BCCode>HRSC</BCCode>    </clsDashBoardSQL>  </ArrayOfClsDashBoardSQL>"' 

declare @BC_INFO table
  (
    BC_ID bigint,
    BC_NAME_EN nvarchar(250),
    BC_NAME_FR nvarchar(250),
    UNRESOLVED_PD bigint,
    UNRESOLVED_CURRENT bigint,
    UNRESOLVED_FD bigint,
    UNRESOLVED_COUNT bigint,
    ACTIVE_PD bigint,
    ACTIVE_CURRENT bigint,
    ACTIVE_FD bigint,
    ACTIVE_COUNT bigint,
    PENDING_PD bigint,
    PENDING_CURRENT bigint,
    PENDING_FD bigint,
    PENDING_COUNT bigint
  )
  
  DECLARE xml_cursor CURSOR FOR
  
  --SELECT  x.y.value( 'string[1]', 'nvarchar(20)' ) AS BC
  --FROM @BCs.nodes('/ArrayOfString') x(y);
  
    SELECT  x.y.value( 'BCCode[1]', 'nvarchar(20)' ) AS BC
    FROM @BCs.nodes('/ArrayOfClsDashBoardSQL/clsDashBoardSQL') x(y);

  OPEN xml_cursor
  FETCH NEXT FROM xml_cursor INTO @BCCode
      
  WHILE @@FETCH_STATUS = 0

      BEGIN
      
      EXEC  @return_value = HRSC_APP.USP_ManagerDashboardLoopXML 
      @BC = @BCCode,
      @OutXML = @DashXML out;

  insert into @BC_INFO
    (BC_ID,
    BC_NAME_EN,
    BC_NAME_FR,
    UNRESOLVED_PD,
    UNRESOLVED_CURRENT,
    UNRESOLVED_FD,
    UNRESOLVED_COUNT,
    ACTIVE_PD,
    ACTIVE_CURRENT,
    ACTIVE_FD,
    ACTIVE_COUNT,
    PENDING_PD,
    PENDING_CURRENT,
    PENDING_FD,
    PENDING_COUNT)

    SELECT  Data.Col.value('(/DashResults/DashResult/BC_ID)[1]','BigInt') as BC_ID,
            Data.Col.value('(/DashResults/DashResult/BC_NAME_EN)[1]','nvarchar(250)') as BC_NAME_EN,
            Data.Col.value('(/DashResults/DashResult/BC_NAME_FR)[1]','nvarchar(250)') as BC_NAME_FR,
    
            Data.Col.value('(/DashResults/DashResult/UnresolvedPD)[1]','BigInt') as UnResoldedPD,
            Data.Col.value('(/DashResults/DashResult/UnresolvedCurrent)[1]','BigInt') as UnresolvedCurrent,
            Data.Col.value('(/DashResults/DashResult/UnresolvedFuture)[1]','BigInt') as UnresolvedFuture,
            Data.Col.value('(/DashResults/DashResult/UnresolvedCount)[1]','BigInt') as UnresolvedCount,

            Data.Col.value('(/DashResults/DashResult/ActivePD)[1]','BigInt') as ActivePD,
            Data.Col.value('(/DashResults/DashResult/ActiveCurrent)[1]','BigInt') as ActiveCurrent,
            Data.Col.value('(/DashResults/DashResult/ActiveFuture)[1]','BigInt') as ActiveFuture,
            Data.Col.value('(/DashResults/DashResult/ActiveCount)[1]','BigInt') as ActiveCount,
       
            Data.Col.value('(/DashResults/DashResult/PendingPD)[1]','BigInt') as PendingPD,
            Data.Col.value('(/DashResults/DashResult/PendingCurrent)[1]','BigInt') as PendingCurrent,
            Data.Col.value('(/DashResults/DashResult/PendingFuture)[1]','BigInt') as PendingFuture,
            Data.Col.value('(/DashResults/DashResult/PendingCount)[1]','BigInt') as PendingCount

      FROM @DashXML.nodes('/DashResults') AS Data(Col)  
        
      FETCH NEXT FROM xml_cursor INTO @BCCode
	END

  CLOSE xml_cursor
  DEALLOCATE xml_cursor
  
  SELECT * from @BC_INFO order by BC_NAME_EN;

-- Ecran Eric
--"UnResolved"            (@StatusGroupID = 0 and CDSTAT.REQUEST_STATUS_CODE IN ('NEW', 'NUPD', 'TSF', 'ATSF', 'ASGN', 'PROC', 'SIGND', 'WAIT', 'WSIGN','RTURN', 'RTNFC', 'RTRNC' )
--"Active Workload"     	(@StatusGroupID = 1 and CDSTAT.REQUEST_STATUS_CODE IN ('ASGN', 'PROC', 'SIGND', 'RTNFC')
--"Non Active Workload" 	(@StatusGroupID = 2 and CDSTAT.REQUEST_STATUS_CODE IN ('WAIT', 'WSIGN', 'RTRNC', 'RTURN')
--"Closed"		            (@StatusGroupID = 3 and CDSTAT.REQUEST_STATUS_CODE IN ('CLOSE', 'NOACT', 'CANC', 'REJ')

-- Ecran Tony
--			                  (@StatusGroupID = 0 and CDSTAT.REQUEST_STATUS_CODE IN ('NEW', 'NUPD', 'TSF', 'ATSF', 'ASGN', 'WAIT', 'PROC', 'RTURN', 'RTNFC', 'SIGND'))) AND 
--"Active Workload"     	(@StatusGroupID = 1 and CDSTAT.REQUEST_STATUS_CODE IN ('NEW', 'NUPD', 'TSF', 'ATSF', 'ASGN', 'PROC', 'SIGND')) OR
--"Non Active Workload" 	(@StatusGroupID = 2 and CDSTAT.REQUEST_STATUS_CODE IN ('WSIGN', 'WAIT', 'NOACT', 'RTRNC', 'RTURN')) OR
--"Closed"		            (@StatusGroupID = 3 and CDSTAT.REQUEST_STATUS_CODE IN ('CLOSE')) OR 'SIGND'))) AND
