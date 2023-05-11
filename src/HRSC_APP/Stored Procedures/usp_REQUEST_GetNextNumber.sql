
CREATE PROCEDURE [HRSC_APP].[usp_REQUEST_GetNextNumber]
@pNextIdentifier nvarchar(16) OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_GetNextNumber
-- Retreives the next Request Identifier based on civil year. 
-- Gaétan Demers 2012-03-12 
------------------------------------------------------
declare @vLastIdentifier nvarchar(16) = '';
declare @vLastNumberIdentifier bigint = 0;
declare @vYearOfLastNumber bigint = 0;
declare @vCurrentYear bigint = 0;
declare @pNextNumber  bigint = 0;

select @vLastIdentifier =  R.HR_REQUEST_IDENTIFIER
from HRSC.HR_REQUEST R
WHERE R.HR_REQUEST_IDENTIFIER = (select max(HR_REQUEST_IDENTIFIER ) from HRSC.HR_REQUEST
									where not (SUBSTRING(HR_REQUEST_IDENTIFIER,1,4)) = 'COID');

set @vYearOfLastNumber = convert(bigint,SUBSTRING(@vLastIdentifier,1,4))
set @vLastNumberIdentifier = convert(bigint,SUBSTRING(@vLastIdentifier,6,8))
set @vCurrentYear = year(getdate())

if @vCurrentYear > @vYearOfLastNumber
begin 
	set @pNextNumber =  1;
end;
else
begin
	set @pNextNumber =  @vLastNumberIdentifier + 1;
end;

	set @pNextIdentifier = convert(nvarchar(4),@vCurrentYear) + '-' + right('0000000' + convert(varchar(7), @pNextNumber),7)
