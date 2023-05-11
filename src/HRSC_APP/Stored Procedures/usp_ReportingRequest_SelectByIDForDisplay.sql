





-- =============================================
-- Author:		Michel tardif
-- Create date: 2018-04-20
-- Description:	ReportingRequest Select by ID for display
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ReportingRequest_SelectByIDForDisplay]
	@pRequest_ID bigint
AS
SELECT	
--REQUEST
		R.HR_REQUEST_ID,
--REPORTING_REQUEST
		RR.*,
--CD_REPORT_REQUEST_TYPE
		RRT.REPORT_REQUEST_TYPE_NAME_EN,
		RRT.REPORT_REQUEST_TYPE_NAME_FR,
		RRT.REPORT_REQUEST_TYPE_CODE

	FROM HRSC.HR_REQUEST R 
		LEFT JOIN HRSC.REPORTING_REQUEST RR ON RR.[HR_REQUEST_ID]= R.HR_REQUEST_ID
		LEFT JOIN HRSC.CD_REPORT_REQUEST_TYPE RRT ON RRT.REPORT_REQUEST_TYPE_ID = RR.REPORT_REQUEST_TYPE_ID
	WHERE R.HR_REQUEST_ID  = @pRequest_ID
