



CREATE   PROCEDURE [HRSC_APP].[usp_AgreementTerms_GetByCode]
------------------------------------------------------
-- usp_AgreementTerms_GetByCode
-- Retreives specific Agreement based on param
-- Dave Seddon 2013-01-21 
------------------------------------------------------
@Agreement_term_ID bigint

WITH EXEC AS CALLER
AS




SELECT  agreement_term_id AS agreement_term_id,
agreement_term_code AS termcode,
agreement_term_name_en AS name_en,
agreement_term_name_fr AS name_fr,
agreement_term_desc_en AS desc_en,
agreement_term_desc_fr AS desc_fr,
effective_date,
expiry_date
       
FROM HRSC.HR_AGREEMENT_TERM 
WHERE agreement_term_id = @agreement_term_id


SELECT HAT.agreement_term_id AS agreement_term_id,
  HART.HR_Request_Type_ID as request_type_id,
  HART.expiry_date
      
FROM HRSC.HR_Agreement_Request_Type HART 
INNER JOIN HRSC.HR_AGREEMENT_TERM HAT ON HAT.agreement_term_id = HART.agreement_term_id
  
WHERE HAT.agreement_term_id = @agreement_term_id
AND  HART.EXPIRY_DATE IS NULL















