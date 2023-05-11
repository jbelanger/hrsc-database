




-- =============================================
-- Author:		Michel tardif
-- Create date: 2018-04-20
-- Description:	Update ReportingRequest 
-- =============================================
CREATE     PROCEDURE [HRSC_APP].[usp_ReportingRequest_Update]
	@REPORTREQUESTTYPE_ID bigint,
	@FILENAME varchar(256),  
	@NEWDATAFORMAT_IND bit, 
	@DEPARTMENT_IND bit, 
	@CMSPPLSOFT_VAL varchar(100), 
	@FIELDSNEEDED nvarchar(4000),
	@EFFECTIVE_DATE datetime,
	@pUser varchar(60),
	@REPORTINGREQUEST_ID bigint 
AS

-- Declare our variables
DECLARE @Error int

UPDATE HRSC.REPORTING_REQUEST
	SET REPORT_REQUEST_TYPE_ID = @REPORTREQUESTTYPE_ID,
	[FILENAME] = @FILENAME,
	NEW_DATA_FORMAT_IND = @NEWDATAFORMAT_IND,
	DEPARTMENT_IND = @DEPARTMENT_IND,
	CMS_PPLSOFT_VALUE = @CMSPPLSOFT_VAL,
	FIELDS_NEEDED = @FIELDSNEEDED,
	EFFECTIVE_DATE = @EFFECTIVE_DATE,
	DATE_UPDATED = GetDate()
WHERE REPORTING_REQUEST_ID = @REPORTINGREQUEST_ID
