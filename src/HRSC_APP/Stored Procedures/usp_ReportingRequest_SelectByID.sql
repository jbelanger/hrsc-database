





-- =============================================
-- Author:		Michel tardif
-- Create date: 2018-04-20
-- Description:	ReportingRequest Select by ID
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ReportingRequest_SelectByID]
	@pRequest_ID bigint
AS
SELECT 
		RR.*
	FROM HRSC.REPORTING_REQUEST RR 
	WHERE RR.HR_REQUEST_ID  = @pRequest_ID
