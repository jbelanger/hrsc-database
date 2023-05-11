


--/*================
--Created by:		Elena Akhmetova 
--Creation Date:	2013-05-27
--Description:	to get the latest status by request
--==================*/
CREATE   FUNCTION [HRSC_APP].[GetlatestStatus]
(@RequestID BIGINT)
RETURNS VARCHAR(10)  
AS 

/*test*/
--declare @RequestID bigint = 2503
BEGIN 
DECLARE @Code VARCHAR(10) 
DECLARE @Data TABLE (HR_REQUEST_STATUS_ID BIGINT,REQUEST_STATUS_CODE VARCHAR(10))
DECLARE	@New VARCHAR(10) = 'NEW', 
		@NewUpdated VARCHAR(10) = 'NUPD', 
		@NoAction  VARCHAR(10)= 'NOACT',
		@Resolved VARCHAR(10) = 'CLOSE',
		@Processing VARCHAR(10) = 'PROC',
		@Pending VARCHAR(10) = 'WAIT',
		@Declined VARCHAR(10) = 'REJ',
		@ReturnedClient VARCHAR(10) = 'RTRNC', 
		@PendingSignature VARCHAR(10) = 'WSIGN',
		@Modified VARCHAR(10) = 'RTNFC' 

/*Max status by interventions*/	
;WITH Data AS (
SELECT 
	MAX(HR_REQUEST_STATUS_ID) AS HR_REQUEST_STATUS_ID, 
	HR_REQUEST_INTERVENTION_ID
FROM (
	SELECT HR_REQUEST_STATUS_ID,I.HR_REQUEST_INTERVENTION_ID,R.HR_REQUEST_ID
	FROM HRSC.HR_REQUEST R	
	JOIN HRSC.HR_REQUEST_INTERVENTION I ON I.HR_REQUEST_ID = R.HR_REQUEST_ID
	JOIN HRSC.HR_REQUEST_STATUS RS ON I.HR_REQUEST_INTERVENTION_ID = RS.REQUEST_INTERVENTION_ID
	WHERE R.HR_REQUEST_ID = @RequestID) D
GROUP BY HR_REQUEST_INTERVENTION_ID)

/*just to add a Code*/	
INSERT INTO @Data
SELECT D.HR_REQUEST_STATUS_ID, S.REQUEST_STATUS_CODE
FROM Data D
JOIN HRSC.HR_REQUEST_STATUS RS ON D.HR_REQUEST_STATUS_ID = RS.HR_REQUEST_STATUS_ID
JOIN HRSC.CD_REQUEST_STATUS S ON S.REQUEST_STATUS_ID = RS.REQUEST_STATUS_ID

/*If no intervention- add status New*/	
IF (SELECT COUNT(*) FROM @Data) = 0
INSERT INTO @Data
SELECT HR_REQUEST_STATUS_ID, S.REQUEST_STATUS_CODE
FROM HRSC.HR_REQUEST_STATUS RS 
JOIN HRSC.CD_REQUEST_STATUS S ON RS.REQUEST_STATUS_ID = S.REQUEST_STATUS_ID
WHERE --REQUEST_STATUS_CODE = @New AND 
HR_REQUEST_ID = @RequestID

/*Data manipulation*/

/*find if there is a NoAction*/
DECLARE @cNoAct INT = (SELECT COUNT(DISTINCT REQUEST_STATUS_CODE)
						FROM @Data 
						WHERE REQUEST_STATUS_CODE = @NoAction)
						
/*Count distinct number of rows for all statuses*/
DECLARE @cAll INT = (SELECT COUNT(DISTINCT REQUEST_STATUS_CODE) FROM @Data)
DECLARE @cResv INT = (SELECT COUNT(DISTINCT REQUEST_STATUS_CODE) FROM @Data WHERE REQUEST_STATUS_CODE = @Resolved  )

/*if only two statuses- NoAction and Resolved- the latest created is correct one*/
IF @cAll = 2 AND @cNoAct > 0
BEGIN
	IF (SELECT COUNT(REQUEST_STATUS_CODE) FROM @Data
	WHERE REQUEST_STATUS_CODE = @Resolved)> 0
	BEGIN
		/*leave only the latest*/
		DELETE FROM @Data WHERE HR_REQUEST_STATUS_ID != 
		(SELECT MAX(HR_REQUEST_STATUS_ID) FROM @Data)
			/*if only NoAction - replace by New-updated*/
			IF (SELECT REQUEST_STATUS_CODE FROM @Data) = @NoAction
			BEGIN
				SET @Code = @NewUpdated
				DELETE FROM @Data
			END
	END
	ELSE DELETE FROM @Data WHERE REQUEST_STATUS_CODE = @NoAction
END

/*if more than two statuses with NoAction among them- remove NoAction*/
IF @cAll > 2 AND @cNoAct > 0 
	BEGIN
		DELETE FROM @Data WHERE REQUEST_STATUS_CODE = @NoAction
	END

/*if only NoAction - replace by New-updated*/
IF @cNoAct = @cAll
BEGIN
	SET @Code = @NewUpdated
	DELETE FROM @Data
END

IF @cResv + @cNoAct = @cAll AND @cAll >1
BEGIN
Set @Code = @Resolved
DELETE FROM @Data
END


/*reset: Count distinct number of rows for all statuses*/
SET @cAll = NULL
SET @cAll = (SELECT COUNT(DISTINCT REQUEST_STATUS_CODE) FROM @Data)

/*if if only one status or same statuses for all*/
IF @cAll = 1
BEGIN
	SELECT @Code = (SELECT TOP 1 REQUEST_STATUS_CODE FROM @Data) 
END

/*Getting right code in some priority*/
IF @cAll > 1
BEGIN 
/*if there is a Declined intervention- display Request with this status*/
	If (SELECT COUNT(REQUEST_STATUS_CODE) FROM @Data WHERE REQUEST_STATUS_CODE = @Declined) > 0
		BEGIN 
			SELECT @Code = @Declined
		END
/*if there is a Returned to Client intervention- display Request with this status*/
	ELSE IF (SELECT COUNT(REQUEST_STATUS_CODE) FROM @Data WHERE REQUEST_STATUS_CODE = @ReturnedClient) > 0
		BEGIN 
			SELECT @Code = @ReturnedClient
		END
/*if there is a Pending Signature's intervention- display Request with this status*/
	ELSE IF (SELECT COUNT(REQUEST_STATUS_CODE) FROM @Data WHERE REQUEST_STATUS_CODE = @PendingSignature) > 0
		BEGIN 
			SELECT @Code = @PendingSignature
		END
/*if there is a "Modified" intervention and no other exlusions (above)- 
display Request with this status*/
	ELSE IF (SELECT COUNT(REQUEST_STATUS_CODE) FROM @Data 
			WHERE REQUEST_STATUS_CODE IN (@PendingSignature,@ReturnedClient,@Declined)) = 0 
			AND (SELECT COUNT(REQUEST_STATUS_CODE) 
				FROM @Data WHERE REQUEST_STATUS_CODE = @Modified) > 0
		BEGIN 
			SELECT @Code = @Modified
		END
/*if there is a Pending intervention and no other exlusions (above)-  
display Request with this status*/
	ELSE IF (SELECT COUNT(REQUEST_STATUS_CODE) FROM @Data 
			WHERE REQUEST_STATUS_CODE IN (@PendingSignature,@ReturnedClient,@Declined,@Modified)) = 0 
			AND (SELECT COUNT(REQUEST_STATUS_CODE) 
				FROM @Data WHERE REQUEST_STATUS_CODE = @Pending) > 0
		BEGIN 
			SELECT @Code = @Pending
		END
END

/*all others remaining -if no exlusions*/
DECLARE @cExcl INT = 
(SELECT COUNT(REQUEST_STATUS_CODE) 
FROM @Data 
WHERE REQUEST_STATUS_CODE IN 
(@PendingSignature,@ReturnedClient,@Declined,@Modified,@Pending)) 

IF @cAll > 1 AND @cExcl = 0
BEGIN
/*even if the latest request status is Assignment or any other-
and there is at least one Processing- display Processing*/
	IF (SELECT COUNT( REQUEST_STATUS_CODE) FROM @Data 
			WHERE REQUEST_STATUS_CODE = @Processing) > 0
		BEGIN
			SELECT @Code = @Processing
		END
	ELSE
/*if no Processing -display the latest request status */
		BEGIN
			SELECT @Code = (SELECT TOP 1 REQUEST_STATUS_CODE 
							FROM @Data
							WHERE REQUEST_STATUS_CODE != @Resolved
							ORDER BY HR_REQUEST_STATUS_ID DESC) 
		END
END 

RETURN @Code

--select @Code

END
