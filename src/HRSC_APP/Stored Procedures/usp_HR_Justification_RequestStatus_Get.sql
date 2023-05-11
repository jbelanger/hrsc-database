




CREATE   PROCEDURE [HRSC_APP].[usp_HR_Justification_RequestStatus_Get]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- SelectRequestStatus
-- Retreives Decline, Return to Client, Pending for Signature Request statuses 
-- Oksana Zhukova 2013-02-01
------------------------------------------------------
SELECT  request_status_id AS id,
        request_status_name_en AS name_en,
        request_status_name_fr AS name_fr,
        request_status_desc_en AS desc_en,
        request_status_desc_fr as desc_fr,
        request_status_code AS code,
        effective_date,
        expiry_date,
        user_created,
        user_updated,
        date_created,
        date_updated
FROM    hrsc.cd_request_status
WHERE   expiry_date IS null 
		and request_status_code IN ( 'REJ','RTRNC', 'WSIGN')
		--*****   Work Item# 47584 the Pending Signature don't need anymore to be part of the justification.


		--AND request_status_name_en ='Decline'
		--OR request_status_name_en ='Return to Client'
		--OR request_status_name_en ='Pending for Signature'
		
		
	
