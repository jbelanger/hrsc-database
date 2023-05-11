


/*================
Created by:		Elena Akhmetova 
Creation Date:	2012-11-27
Description:	get all weekends for a period (in days)
==================*/
CREATE   FUNCTION [HRSC_APP].[GetWeekends]

(  
    @startDate SMALLDATETIME,  
    @endDate SMALLDATETIME  
) 
RETURNS INT  
AS 
BEGIN 
	RETURN (datediff(ww,@startDate,@endDate) * 2) 
END
