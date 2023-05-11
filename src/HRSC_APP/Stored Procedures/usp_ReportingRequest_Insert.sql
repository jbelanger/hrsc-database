






-- =============================================
-- Author:		Michel tardif
-- Create date: 2018-04-20
-- Description:	Insert a new ReportingRequest in DB 
-- =============================================
CREATE     PROCEDURE [HRSC_APP].[usp_ReportingRequest_Insert]
	@HR_REQUEST_ID bigint,
	@REPORTREQUESTTYPE_ID bigint,
	@FILENAME varchar(256),  
	@NEWDATAFORMAT_IND bit, 
	@DEPARTMENT_IND bit,
	@CMSPPLSOFT_VAL varchar(60), 
	@FIELDSNEEDED nvarchar(4000),
	@EFFECTIVE_DATE datetime,
	@USER_CREATED varchar(60),
	@NewRowID bigint = null OUTPUT, 
	@ReturnCode bigint = null OUTPUT
	

AS
-- Declare our variables
DECLARE @VarError int;

INSERT INTO HRSC.REPORTING_REQUEST
		(HR_REQUEST_ID,
		REPORT_REQUEST_TYPE_ID,
		[FILENAME],
		NEW_DATA_FORMAT_IND,
		DEPARTMENT_IND,
		CMS_PPLSOFT_VALUE,
		FIELDS_NEEDED,
		EFFECTIVE_DATE,
		USER_CREATED,
		DATE_CREATED)
	VALUES (@HR_REQUEST_ID,
		@REPORTREQUESTTYPE_ID,
		@FILENAME,
		@NEWDATAFORMAT_IND,
		@DEPARTMENT_IND,
		@CMSPPLSOFT_VAL,
		@FIELDSNEEDED,
		@EFFECTIVE_DATE,
		@USER_CREATED,
		GetDate())

	 -- Move it to our local variable, and check for an error condition
SELECT @VarError = @@ERROR;
SET @NewRowID = @@IDENTITY;
