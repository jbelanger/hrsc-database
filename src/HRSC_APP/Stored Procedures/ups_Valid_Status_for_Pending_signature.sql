



CREATE   PROCEDURE [HRSC_APP].[ups_Valid_Status_for_Pending_signature]
@request_id bigint,  @returnValidation Varchar(1) OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- ups_Valid_Status_for_Pending_signature
-- 
-- Tony Paradis 2013-02-12
------------------------------------------------------
-- Declare our variables
Declare @vCountResolved int;
Declare @vCountIntervention int;

BEGIN 

  Set @vCountResolved = (SELECT COUNT(HRI.HR_REQUEST_INTERVENTION_ID) 
  From HRSC.HR_REQUEST_INTERVENTION HRI 
  WHERE HRI.HR_REQUEST_ID = @request_id
  AND HRI.HR_REQUEST_INTERVENTION_ID IN (Select HRS.REQUEST_INTERVENTION_ID
										 From	HRSC.HR_REQUEST_STATUS HRS
												INNER JOIN HRSC.HR_REQUEST_INTERVENTION HRI ON HRI.HR_REQUEST_INTERVENTION_ID = HRS.REQUEST_INTERVENTION_ID
										 WHERE	HRI.HR_REQUEST_ID = @request_id AND 
												HRS.REQUEST_STATUS_ID IN (Select RS.REQUEST_STATUS_ID
																		  from HRSC.CD_REQUEST_STATUS RS
																		  where RS.REQUEST_STATUS_CODE = 'CLOSE' OR
																				RS.REQUEST_STATUS_CODE = 'NOACT' )))


  Set @vCountIntervention = (SELECT COUNT(HR_REQUEST_INTERVENTION_ID) 
  From HRSC.HR_REQUEST_INTERVENTION HRI
  WHERE HRI.HR_REQUEST_ID = @request_id)
  
  
  set @vCountResolved = @vCountResolved + 1
    
   IF @vCountResolved = @vCountIntervention 
   set @returnValidation = '1'
   else
   set @returnValidation = '0'
  
  --return @vCountResolved
  --return @vCountIntervention
END

  
