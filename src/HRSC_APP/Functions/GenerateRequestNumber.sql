


CREATE   FUNCTION [HRSC_APP].[GenerateRequestNumber] ()
RETURNS nvarchar(MAX)

WITH EXEC AS CALLER
AS

BEGIN
	declare @vLastIdentifier nvarchar(16) = '';
	declare @vLastNumberIdentifier bigint = 0;
	declare @vYearOfLastNumber bigint = 0;
	declare @vCurrentYear bigint = 0;
	declare @pNextNumber  bigint = 0;

	select @vLastIdentifier =  R.HR_REQUEST_IDENTIFIER
	from HRSC.HR_REQUEST R
	WHERE R.HR_REQUEST_IDENTIFIER = (select max(HR_REQUEST_IDENTIFIER ) from HRSC.HR_REQUEST
										where not (SUBSTRING(HR_REQUEST_IDENTIFIER,1,4)) in ('COID', 'ISL-'));

	set @vYearOfLastNumber = convert(bigint,SUBSTRING(@vLastIdentifier,1,4))
	set @vLastNumberIdentifier = convert(bigint,SUBSTRING(@vLastIdentifier,6,8))
	set @vCurrentYear = year(getdate())

	if @vCurrentYear > @vYearOfLastNumber
		set @pNextNumber =  1;
	else
		set @pNextNumber =  @vLastNumberIdentifier + 1;

	return convert(nvarchar(4),@vCurrentYear) + '-' + right('0000000' + convert(varchar(7), @pNextNumber),7)
END;
