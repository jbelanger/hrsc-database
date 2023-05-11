



CREATE   PROCEDURE [HRSC_APP].[usp_AgreementTerms_GetList]
------------------------------------------------------
-- usp_AgreementTerms_GetList
-- Retreives all active Agreements
-- Dave Seddon 2013-01-21 
------------------------------------------------------
	
WITH EXEC AS CALLER
AS

SELECT  agreement_term_id AS id,
        agreement_term_code AS termcode,
        agreement_term_name_en AS name_en,
		agreement_term_name_fr AS name_fr,
        agreement_term_desc_en AS desc_en,
        agreement_term_desc_fr AS desc_fr,
        expiry_date

FROM HRSC.HR_AGREEMENT_TERM
WHERE   expiry_date is NULL OR expiry_date > GETDATE()


