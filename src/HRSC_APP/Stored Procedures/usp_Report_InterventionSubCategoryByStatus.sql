


/*================
Created by:          Elena Akhmetova 
Creation Date:       2012-12-03
Description:  
TEST:
exec [HRSC_APP].[usp_Report_InterventionSubCategoryByStatus] 'English', 32,21,'2012/03/01','2012/07/01'
==================*/

CREATE   PROCEDURE [HRSC_APP].[usp_Report_InterventionSubCategoryByStatus]
(
       @Lang VARCHAR(10),
       @BusinessCenterID INT,
       @StartDate DATETIME,
       @EndDate DATETIME
)
WITH EXEC AS CALLER
AS
SET NOCOUNT ON

----TEST
--DECLARE @Lang VARCHAR(10) = 'English',
--            @BusinessCenterID INT = 35,
--            @StartDate DATETIME = '2013/04/01',
--            @EndDate DATETIME = '2013/06/01'

----------------------------------------------------
IF @BusinessCenterID = 0 SET @BusinessCenterID = NULL 
ELSE SET @BusinessCenterID = @BusinessCenterID

--Status
DECLARE 
@AI VARCHAR(10) = 'AI',
@Total VARCHAR(10) = 'Total',
@ATP VARCHAR(10) = 'ATP', 
@NAT VARCHAR(10) = 'NAT',
@TNT VARCHAR(10) = 'TNT',
@New VARCHAR(10) = 'NEW',
@Assignment VARCHAR(10) = 'ASGN',
@Pending VARCHAR(10) = 'WAIT',
@AutoTrans VARCHAR(10) = 'ATSF',
@Trans VARCHAR(10) = 'TSF',
@Resolved VARCHAR(10) = 'CLOSE',
@Processed VARCHAR(10) = 'PROC',
@Canceled VARCHAR(10) = 'CANC',
@NoAction VARCHAR(10) = 'NOACT',
@Modified VARCHAR(10) = 'RTNFC',
@PendingSignature VARCHAR(10) = 'WSIGN',
@DocumentSigned VARCHAR(10) = 'SIGND',
@Declined VARCHAR(10) = 'REJ',
@ReturnedToClient VARCHAR(10) = 'RTRNC'
----------------------
--All data for a a diven period, business center and assignment (lead, collaborator or both)
CREATE TABLE #REQUEST (    CategoryID INT, 
                                         SubCategoryID INT,
                                         InterventionID INT,
                                         CreatedDate DATETIME,
                                         StatusCode VARCHAR(10),
                                         RequestCount INT,
                                         RequestStatusID INT)
INSERT INTO #REQUEST
       SELECT
              RC.REQUEST_CATEGORY_ID,
              RSC.REQUEST_SUB_CATEGORY_ID,
              RS.REQUEST_INTERVENTION_ID,
              RS.DATE_CREATED,
              S.REQUEST_STATUS_CODE,
              RI.REQUEST_COUNT,
              RS.HR_REQUEST_STATUS_ID
       FROM HRSC.HR_REQUEST_STATUS RS
       JOIN HRSC.HR_REQUEST_INTERVENTION RI ON RS.REQUEST_INTERVENTION_ID = RI.HR_REQUEST_INTERVENTION_ID
       JOIN HRSC.CD_REQUEST_STATUS S ON RS.REQUEST_STATUS_ID = S.REQUEST_STATUS_ID
       JOIN HRSC.CD_REQUEST_CATEGORY RC ON RI.REQUEST_CATEGORY_ID = RC.REQUEST_CATEGORY_ID
       JOIN HRSC.CD_REQUEST_SUB_CATEGORY RSC ON RSC.REQUEST_SUB_CATEGORY_ID = RI.REQUEST_SUB_CATEGORY_ID
       WHERE (RI.BUSINESS_CENTER_ID = @BusinessCenterID OR @BusinessCenterID IS NULL)
                     AND (RS.DATE_CREATED >= @StartDate AND RS.DATE_CREATED < @EndDate)
--UNION 
--     SELECT        
--            RC.REQUEST_CATEGORY_ID,
--            RSC.REQUEST_SUB_CATEGORY_ID,
--            RS.REQUEST_INTERVENTION_ID,
--            RS.DATE_CREATED,
--            S.REQUEST_STATUS_CODE,
--            RI.REQUEST_COUNT,
--            RS.HR_REQUEST_STATUS_ID
--     FROM HRSC.HR_REQUEST_INTERVENTION RI 
--     JOIN HRSC.HR_REQUEST_STATUS RS ON RS.HR_REQUEST_ID = RI.HR_REQUEST_ID
--     JOIN HRSC.CD_REQUEST_STATUS S ON RS.REQUEST_STATUS_ID = S.REQUEST_STATUS_ID 
--     JOIN HRSC.CD_REQUEST_CATEGORY RC ON RI.REQUEST_CATEGORY_ID = RC.REQUEST_CATEGORY_ID
--     JOIN HRSC.CD_REQUEST_SUB_CATEGORY RSC ON RSC.REQUEST_SUB_CATEGORY_ID = RI.REQUEST_SUB_CATEGORY_ID
--     WHERE S.REQUEST_STATUS_CODE = @New
--                   AND (RI.BUSINESS_CENTER_ID = @BusinessCenterID OR @BusinessCenterID IS NULL)
--                   AND RS.DATE_CREATED >= @StartDate AND RS.DATE_CREATED < @EndDate
-----------------
--interventions by employee with max status
CREATE TABLE #RequestMax ( CategoryID INT, 
                                                SubCategoryID INT,
                                                InterventionID INT,
                                                CreatedDate DATETIME,
                                                StatusCode VARCHAR(10),
                                                RequestCount INT)
INSERT INTO #RequestMax
SELECT
       CategoryID, 
       SubCategoryID,
       InterventionID,
       CreatedDate,
       StatusCode,
       RequestCount
FROM #REQUEST R
WHERE R.RequestStatusID = 
       (SELECT MAX(RequestStatusID) 
       FROM #REQUEST
       WHERE InterventionID = R.InterventionID AND StatusCode != @New) 
---------------------
--to find all categories/subcateghories with all possible status 
DECLARE @Matrix TABLE (CategoryName VARCHAR(100), SubCategoryName VARCHAR(MAX), 
                                                CategoryID INT, SubCategoryID INT, Code VARCHAR(10), Value FLOAT)
                                                
;WITH Category AS (
SELECT 
       CASE 
              WHEN @Lang = 'English' THEN REQUEST_CATEGORY_NAME_EN 
              ELSE REQUEST_CATEGORY_NAME_FR 
       END AS CategoryName,
       CASE 
              WHEN @Lang = 'English' THEN REQUEST_SUB_CATEGORY_NAME_EN 
              ELSE REQUEST_SUB_CATEGORY_NAME_FR 
       END AS SubCategoryName,
       RC.REQUEST_CATEGORY_ID AS CategoryID,
       RSC.REQUEST_SUB_CATEGORY_ID AS SubCategoryID
FROM HRSC.CD_REQUEST_CATEGORY RC 
JOIN HRSC.CD_REQUEST_SUB_CATEGORY RSC ON RC.REQUEST_CATEGORY_ID = RSC.REQUEST_CATEGORY_ID
WHERE RC.EXPIRY_DATE IS NULL AND RSC.EXPIRY_DATE IS NULL
)

INSERT INTO @Matrix (CategoryName, SubCategoryName, CategoryID, SubCategoryID, Code)
SELECT CategoryName, SubCategoryName, CategoryID, SubCategoryID, S.Code
FROM ( SELECT REQUEST_STATUS_CODE AS Code
              FROM HRSC.CD_REQUEST_STATUS S
              --WHERE S.REQUEST_STATUS_CODE IN (@Assignment,@Processed,@Pending,@Resolved,@Canceled,@NoAction)
       UNION 
              SELECT @AI  AS Code
       UNION 
              SELECT @Total  AS Code
       UNION 
              SELECT @ATP  AS Code
       UNION 
              SELECT @NAT  AS Code
       UNION 
              SELECT @TNT  AS Code 
       ) S
CROSS JOIN Category C

--data manipulation - calculations of business hours for a given period between New and Resolved
DECLARE @ATPTable AS TABLE (Value FLOAT, CategoryID INT, SubCategoryID INT, InterventionID INT)
INSERT INTO @ATPTable
SELECT 
       [HRSC_APP].[GetBusinessHours] (N.CreatedDate,R.CreatedDate,0) AS Value,
       N.CategoryID, 
       N.SubCategoryID,
       N.InterventionID
FROM ( SELECT CategoryID, SubCategoryID, InterventionID, MIN(CreatedDate) AS CreatedDate
              FROM #REQUEST
              GROUP BY CategoryID, SubCategoryID, InterventionID
       ) N
JOIN ( SELECT CategoryID, SubCategoryID, InterventionID, CreatedDate 
              FROM #REQUEST
              WHERE StatusCode = @Resolved
       ) R ON R.CategoryID = N.CategoryID 
                     AND R.SubCategoryID = N.SubCategoryID 
                     AND R.InterventionID = N.InterventionID
                    
DECLARE @AvgAtpTotal FLOAT 
SELECT @AvgAtpTotal = AVG(Value) FROM @ATPTable--average for all categories
------------------
--data manipulation - counting interventions for a given period
;WITH Data AS (
       SELECT COUNT(DISTINCT R.InterventionID) AS Value, 
                     R.CategoryID, R.SubCategoryID, R.StatusCode
       FROM #RequestMax R
       GROUP BY R.CategoryID, R.SubCategoryID, R.StatusCode
UNION
       SELECT COUNT(DISTINCT R.InterventionID) AS Value, R.CategoryID, 
                     R.SubCategoryID, @Total AS StatusCode
       FROM #RequestMax R
       --WHERE R.StatusCode IN (@Canceled,@NoAction,@Assignment,@Processed,@Pending,@Resolved)
       GROUP BY R.CategoryID, 
                     R.SubCategoryID
UNION
       SELECT COUNT(DISTINCT R.InterventionID) AS Value, 
                     R.CategoryID, R.SubCategoryID, @AI AS StatusCode
       FROM #RequestMax R
       WHERE R.StatusCode IN (@Assignment,@Processed,@Pending,@Modified,
                                                @DocumentSigned)--@Trans, @AutoTrans,@PendingSignature,
       GROUP BY R.CategoryID, R.SubCategoryID
UNION
       SELECT COUNT(R.RequestCount) AS Value, 
                     R.CategoryID, R.SubCategoryID, @NAT AS StatusCode
       FROM #RequestMax R
       WHERE R.StatusCode IN (@Assignment,@Processed,@Pending,@Modified,
                                                @DocumentSigned)--@Trans, @AutoTrans,@PendingSignature,
       GROUP BY R.CategoryID, R.SubCategoryID
UNION
       SELECT COUNT(R.RequestCount) AS Value, 
                     R.CategoryID, R.SubCategoryID, @TNT AS StatusCode
       FROM #RequestMax R
       --WHERE R.StatusCode IN (@Assignment,@Processed,@Pending,@Resolved,@Canceled,@NoAction)--?
       GROUP BY R.CategoryID, R.SubCategoryID
UNION
--data manipulation - calculations of business hours for a given period between Assignment and Resolved
       SELECT AVG(Value) AS Value, 
                     CategoryID, SubCategoryID, @ATP AS StatusCode
       FROM @ATPTable
       GROUP BY CategoryID, SubCategoryID
),
------------------
--IN CASE OF CHANGING CODES THE PIVOT MUST BE UPDATED
Final AS (
SELECT 
       CategoryName, SubCategoryName, CategoryID, SubCategoryID,
       ISNULL([ATSF],0) + ISNULL([TSF],0) AS [TSF],
       [AI],[ASGN],[PROC], [WAIT],[CLOSE],[CANC],[NOACT],
       [RTNFC],[WSIGN],[SIGND],[REJ],[Total],[RTRNC],
       [ATP],[NAT],[TNT],
       @AvgAtpTotal AS AvgAtpTotal

FROM
       (SELECT M.CategoryName, M.SubCategoryName, M.Code, D.Value, M.CategoryID, M.SubCategoryID
       FROM @Matrix M
       LEFT JOIN Data D ON D.CategoryID = M.CategoryID 
                                         AND D.SubCategoryID = M.SubCategoryID
                                         AND D.StatusCode = M.Code) D
PIVOT
       (AVG(Value) 
       FOR Code IN ([AI],[ASGN],[PROC],[WAIT],[CLOSE],[CANC],[NOACT],[Total],[ATP],
                           [NAT],[TNT],[RTNFC],[WSIGN],[SIGND],[REJ],[RTRNC],[ATSF],[TSF])
       ) PT

)

SELECT 
       CategoryName, SubCategoryName, F.CategoryID, SubCategoryID,
       NULLIF([TSF],0) AS [TSF],
       [AI],[ASGN],[PROC], [WAIT],[CLOSE],[CANC],[NOACT],
       [RTNFC],[WSIGN],[SIGND],[REJ],[Total],[RTRNC],
       [ATP],[NAT],[TNT],
       @AvgAtpTotal AS AvgAtpTotal, 
T.AvgATPCategory
FROM Final F
LEFT JOIN (   SELECT AVG(Value) AS AvgATPCategory, CategoryID 
                     FROM @ATPTable
                     GROUP BY CategoryID
              ) T ON F.CategoryID = T.CategoryID


DROP TABLE #REQUEST
DROP TABLE #RequestMax

