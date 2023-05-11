





CREATE     PROCEDURE [HRSC_APP].[usp_Request_Intervention_Insert]
	@lngReqID bigint, 
	@HR_REQUEST_TYPE_ID bigint,
	@intCatID int, 
	@intSubCatID int, 
	@intBCID int, 
	@strRC nvarchar(5), 
	@blnAutoTransfer bit, 
	@blnSendEmail bit, 
	@pStatusId bigint,
	@pStatusDate datetime,
	@strUserCreated varchar(50), 
	@pNewRowID bigint OUTPUT
WITH EXEC AS CALLER
AS

INSERT INTO HRSC.HR_REQUEST_INTERVENTION( 
	HR_REQUEST_ID,
	HR_REQUEST_TYPE_ID,
	REQUEST_CATEGORY_ID,
	REQUEST_SUB_CATEGORY_ID,  
	BUSINESS_CENTER_ID,
	PROCESSING_RC_CODE,
	AUTOMATIC_TRANSFER_IND,
	SEND_EMAIL_IND,
	REQUEST_STATUS_ID,
	REQUEST_STATUS_DATE,
	USER_CREATED,
	DATE_CREATED)
values ( 
	@lngReqid,
	@HR_REQUEST_TYPE_ID,
	@intCatId,
	@intSubCatId,
	@intBCId,
	@strRC,
	@blnAutoTransfer,
	@blnSendEmail,
	@pStatusId,
	getdate(), -- Ignored @pStatusDate param on purpose
	@strUserCreated,
	GetDate());

set @pNewRowID = @@IDENTITY;
