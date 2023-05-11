


CREATE   FUNCTION [HRSC_APP].[GetContractNumber]
(@ReqID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
DECLARE @intCount bigint;

select @intCount = count(C.HR_CONTRACT_ID) from HRSC.HR_CONTRACT C where C.HR_REQUEST_ID = @ReqID;-- and D.PUBLIC_DOCUMENT_IND = 1; --Commented the "Public Only" flag... should return all docs


   
return @intCount;
END
