


CREATE   FUNCTION [HRSC_APP].[GetOvertimeGroupTypeID]
(@GroupeID bigint, @TypeID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
declare @GroupeTypeID bigint;

  select @GroupeTypeID = OVERTIME_GROUP_TYPE_ID from HRSC.OVERTIME_GROUP_TYPE where OVERTIME_GROUP_ID = @GroupeID and OVERTIME_TYPE_ID = @TypeID;
   
  return @GroupeTypeID;
END
