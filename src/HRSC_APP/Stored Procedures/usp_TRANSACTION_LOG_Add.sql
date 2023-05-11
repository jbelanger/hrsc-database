




CREATE     PROCEDURE [HRSC_APP].[usp_TRANSACTION_LOG_Add]
	@pI_TRANSACTION_LOG_TIMESTAMP datetime, 
	@pI_ENTRY_TYPE nvarchar(100), 
	@pI_TRANSACTION_COMPONENT nvarchar(100), 
	@pI_TRANSACTION_SOURCE nvarchar(300), 
	@pI_SERVER_NAME nvarchar(100), 
	@pI_SESSION_ID nvarchar(100), 
	@pI_SESSION_DATA nvarchar(4000), 
	@pI_REMOTE_IP nvarchar(100), 
	@pI_THREAD_ID bigint, 
	@pI_THREAD_USER nvarchar(300), 
	@pI_MESSAGE_TEXT nvarchar(4000), 
	@pI_DETAILS_TEXT nvarchar(4000), 
	@pI_DUMP_TEXT nvarchar(4000), 
	@pI_SP_NAME nvarchar(100), 
	@pI_SP_CATEGORY nvarchar(100), 
	@pI_SP_RETURN_TYPE nvarchar(100), 
	@pI_START_DATE datetime, 
	@pI_END_DATE datetime, 
	@pI_TRANSACTION_DURATION int, 
	@pI_DB_REQUEST nvarchar(4000), 
	@pI_DB_RESULT nvarchar(4000), 
	@pI_HTTP_METHOD nvarchar(5), 
	@pI_URL nvarchar(300), 
	@pI_WEB_PAGE nvarchar(300), 
	@pI_OBJECT_TYPE nvarchar(300), 
	@pI_CATEGORY_TYPE nvarchar(300), 
	@pI_EXCEPTION_IND bit, 
	@NewRowID BIGINT = null OUTPUT
WITH EXEC AS CALLER
AS

    INSERT INTO HRSC.HRSC_TRANSACTION_LOG
    ( TRANSACTION_LOG_TIMESTAMP,
      ENTRY_TYPE,
      TRANSACTION_COMPONENT,
      TRANSACTION_SOURCE, 
      SERVER_NAME, 
      SESSION_ID, 
      SESSION_DATA, 
      REMOTE_IP, 
      THREAD_ID, 
      THREAD_USER, 
      MESSAGE_TEXT, 
      DETAILS_TEXT, 
      DUMP_TEXT, 
      SP_NAME, 
      SP_CATEGORY, 
      SP_RETURN_TYPE, 
      START_DATE, 
      END_DATE, 
      TRANSACTION_DURATION, 
      DB_REQUEST, 
      DB_RESULT, 
      HTTP_METHOD, 
      URL, 
      WEB_PAGE, 
      OBJECT_TYPE, 
      CATEGORY_TYPE, 
      EXCEPTION_IND
    )
    VALUES
    (
      @pI_TRANSACTION_LOG_TIMESTAMP,
      @pI_ENTRY_TYPE,
      @pI_TRANSACTION_COMPONENT,
      @pI_TRANSACTION_SOURCE,
      @pI_SERVER_NAME,
      @pI_SESSION_ID,
      @pI_SESSION_DATA,
      @pI_REMOTE_IP,
      @pI_THREAD_ID,
      @pI_THREAD_USER,
      @pI_MESSAGE_TEXT,
      @pI_DETAILS_TEXT,
      @pI_DUMP_TEXT,
      @pI_SP_NAME,
      @pI_SP_CATEGORY,
      @pI_SP_RETURN_TYPE,
      @pI_START_DATE,
      @pI_END_DATE,
      @pI_TRANSACTION_DURATION,
      @pI_DB_REQUEST,
      @pI_DB_RESULT,
      @pI_HTTP_METHOD,
      @pI_URL,
      @pI_WEB_PAGE,
      @pI_OBJECT_TYPE,
      @pI_CATEGORY_TYPE,
      @pI_EXCEPTION_IND
    )
     
	 SET @NewRowID = @@IDENTITY;
