



CREATE   PROCEDURE [HRSC_APP].[usp_EMPLOYEE_ROLE_FOR_REQ_DeleteByRequest]
@pRequestID bigint, @pUser nvarchar(30)
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- EMPLOYEE_ROLE_FOR_REQ_DeleteByRequest
-- Delete (logical) records for a specific Request.
-- Gaétan Demers 2012-02-02
-- Do not Delete the Submitter role, if there is one.
------------------------------------------------------
declare @vErrorNum int;

update HRSC.EMPLOYEE_ROLE_FOR_REQUEST
set EXPIRY_DATE = GETDATE(),
    USER_UPDATED = @pUser,
    DATE_UPDATED = getdate()
where HR_REQUEST_ID = @pRequestID
and EMPLOYEE_ROLE_ID <> (select employee_role_id from HRSC.CD_EMPLOYEE_ROLE where EMPLOYEE_ROLE_CODE = 'SUBTR')
