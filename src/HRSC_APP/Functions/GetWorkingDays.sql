


/*================
Created by:		Elena Akhmetova 
Creation Date:	2012-11-27
Description:	get work days for a period (in days)
==================*/
CREATE   FUNCTION [HRSC_APP].[GetWorkingDays]

(  
    @startDate SMALLDATETIME,  
    @endDate SMALLDATETIME  
) 
RETURNS INT  
AS 
BEGIN 
      RETURN (datediff(d,@startDate,@endDate) + 1) - (datediff(ww,@startDate,@endDate) * 2) 
END
