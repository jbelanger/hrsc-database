



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Get_ART34_IND]
@lngID bigint, @pArt34_ind bit OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_Get_ART34_IND
-- 
-- Tony Paradis 2015-04-10
------------------------------------------------------
Set @pArt34_ind = (Select  REQ.ART34_IND
				from  HRSC.HR_REQUEST REQ
				where REQ.HR_REQUEST_ID = @lngid);
