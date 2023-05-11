


CREATE   FUNCTION [HRSC_APP].[CheckForAttachedDocuments]
(@ReqID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
DECLARE @intCount bigint;
DECLARE @blnReturn bit;

select @intCount = count(D.HR_DOCUMENT_ID) from HRSC.HR_DOCUMENT D where D.HR_REQUEST_ID = @ReqID;-- and D.PUBLIC_DOCUMENT_IND = 1; --Commented the "Public Only" flag... should return all docs

if @intCount > 0 
  set @blnReturn = 1;
else 
  set @blnReturn = 0;
   
return @blnReturn;
END
