

CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_SelectByID]
@pRequestID bigint
WITH EXEC AS CALLER
AS
SET NOCOUNT ON

/*test*/
--declare @pRequestID bigint=2501
/*------------------------------------------------------
	Request_SelectByID
	Retreives all information for a specific HR_Request 
	Gaétan Demers 2012-01-26 
	E.A. (2013/06):	Status code and note corrected
  ENO  - Remove function call to get latest status code... should be one from the Request...
------------------------------------------------------*/
DECLARE @Code VARCHAR(10), @Note VARCHAR(MAX)
DECLARE @NoteTypeID bigint;

Set @NoteTypeID = (SELECT [NOTE_TYPE_ID]
								FROM [HRSC].[CD_NOTE_TYPE]
								WHERE [HRSC].[CD_NOTE_TYPE].[NOTE_TYPE_CODE] = 'NOTE')

SET @Note = 
(SELECT TOP 1 HR_REQUEST_NOTE_TEXT
FROM HRSC.HR_REQUEST_NOTE N
JOIN HRSC.HR_REQUEST R ON N.HR_REQUEST_ID = R.HR_REQUEST_ID
JOIN HRSC.HR_REQUEST_INTERVENTION I ON I.HR_REQUEST_ID = R.HR_REQUEST_ID
JOIN HRSC.HR_REQUEST_STATUS RS ON I.HR_REQUEST_INTERVENTION_ID = RS.REQUEST_INTERVENTION_ID
JOIN HRSC.CD_REQUEST_STATUS S ON S.REQUEST_STATUS_ID = RS.REQUEST_STATUS_ID
WHERE R.HR_REQUEST_ID = @pRequestID AND REQUEST_STATUS_CODE = 'CANC' AND N.NOTE_TYPE_ID = @NoteTypeID
ORDER BY HR_REQUEST_NOTE_ID DESC)

-- ENO Get the Code from the Request Status...
SELECT @Code = request_status_code FROM HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_ID = 
    (select REQUEST_STATUS_ID from HRSC.HR_REQUEST where HR_REQUEST_ID = @pRequestID) 

SELECT 
	R.*, 
	@Code AS STATUS_CODE,
	@Note AS HR_REQUEST_NOTE_TEXT,
  c.GIVEN_NAME + ' ' + c.SURNAME as EMP_NAME
  
FROM HRSC.HR_REQUEST R
	LEFT JOIN HRSC.HR_REQUEST_CLIENT c on c.HR_REQUEST_CLIENT_ID = r.HR_REQUEST_CLIENT_ID
WHERE HR_REQUEST_ID = @pRequestID
