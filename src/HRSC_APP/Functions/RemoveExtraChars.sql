

CREATE   FUNCTION [HRSC_APP].[RemoveExtraChars] (@NAME nvarchar(255))
RETURNS nvarchar(255)
AS
BEGIN
  declare @TempString nvarchar(255)
  set @TempString = @NAME 
  set @TempString =  replace(@TempString,'à', 'a')
  set @TempString =  replace(@TempString,'è', 'e')
  set @TempString =  replace(@TempString,'é', 'e')
  set @TempString =  replace(@TempString,'ì', 'i')
  set @TempString =  replace(@TempString,'ò', 'o')
  set @TempString =  replace(@TempString,'ù', 'u')
  set @TempString =  replace(@TempString,'ç', 'c')
  return @TempString
END
