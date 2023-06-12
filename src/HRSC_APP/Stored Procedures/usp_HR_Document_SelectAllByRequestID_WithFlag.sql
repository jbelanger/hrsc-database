




CREATE     PROCEDURE [HRSC_APP].[usp_HR_Document_SelectAllByRequestID_WithFlag]
@intViewPublicOnly int, @lngID bigint
WITH EXEC AS CALLER
AS
if @intViewPublicOnly = 1
  select  D.HR_DOCUMENT_ID as ID,
          D.HR_DOCUMENT_NAME as NAME,
          D.PUBLIC_DOCUMENT_IND AS PUBLIC_IND,
          D.HR_REQUEST_ID,
          D.HR_DOCUMENT_DESC_EN as DESC_EN,
          D.HR_DOCUMENT_DESC_FR as DESC_FR,
          D.USER_CREATED,
          D.DATE_CREATED,
		  D.FILE_SIZE

  from HRSC.HR_DOCUMENT D
  where D.HR_REQUEST_ID = @lngID and
        D.PUBLIC_DOCUMENT_IND = @intViewPublicOnly
  order by D.DATE_CREATED desc
else

  select  D.HR_DOCUMENT_ID as ID,
          D.HR_DOCUMENT_NAME as NAME,
          D.PUBLIC_DOCUMENT_IND AS PUBLIC_IND,
          D.HR_REQUEST_ID,
          D.HR_DOCUMENT_DESC_EN as DESC_EN,
          D.HR_DOCUMENT_DESC_FR as DESC_FR,
          D.USER_CREATED,
          D.DATE_CREATED,
		  D.FILE_SIZE

  from HRSC.HR_DOCUMENT D
  where D.HR_REQUEST_ID = @lngID
  order by D.DATE_CREATED desc
