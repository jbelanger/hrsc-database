



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_Validate_Cancel]
@lngId bigint,
@Count bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- [usp_REQUEST_INTERVENTION_Validate_Cancel]
-- Once the request is sent to Data Capture and Encryptions, the manager can NO LONGER cancel the reques.
-- Paradis Tony 2018-06-28
/** Modified for SQL Server 2016 Michel Tardif ***/
------------------------------------------------------


set @Count = (SELECT  count(I.HR_REQUEST_INTERVENTION_ID) 
       

FROM    HRSC.HR_REQUEST_INTERVENTION AS I          
		INNER JOIN  HRSC.HR_REQUEST AS REQ ON  REQ.HR_REQUEST_ID = I.HR_REQUEST_ID    
        INNER JOIN  HRSC.CD_BUSINESS_CENTER AS BC ON BC.BUSINESS_CENTER_ID = I.BUSINESS_CENTER_ID      
WHERE   BC.BUSINESS_CENTER_CODE in ('PAY6', 'HRBU4') and       
        I.REQUEST_STATUS_ID not in (SELECT REQUEST_STATUS_ID FROM HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE = 'NOACT') AND
        REQ.HR_REQUEST_ID = @LNGID )

