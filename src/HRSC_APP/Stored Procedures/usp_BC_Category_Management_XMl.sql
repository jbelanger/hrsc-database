



CREATE   PROCEDURE [HRSC_APP].[usp_BC_Category_Management_XMl]
@strUser nvarchar(30), @xmlData xml, @SubCatID bigint, @EX_IND bit
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- BC_Category_Management for Auto Transfer
-- Eric Nolet 2016-05-19
------------------------------------------------------

/***** TESTING *****  
DECLARE @XMLData xml;
DECLARE @strUser varchar(max);
DECLARE @SubCatID bigint;

SET @XMLData = '<?xml version="1.0"?>  <ArrayOfLong xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">    <long>17</long>    <long>35</long>  </ArrayOfLong>'
set @strUser = 'ENO'
set @SubCatID = 300
*/

  
    UPDATE HRSC.BC_CATEGORY
    SET EXPIRY_DATE = GetDate(),
         USER_UPDATED = @struser,
         DATE_UPDATED = Getdate()
    WHERE REQUEST_SUB_CATEGORY_ID = @SubCatID and EX_IND = @EX_IND ;
      
    INSERT into HRSC.BC_CATEGORY
    (
      USER_CREATED,
      DATE_CREATED,
      REQUEST_SUB_CATEGORY_ID,
      BUSINESS_CENTER_ID,
      EFFECTIVE_DATE,
	  EX_IND
    )
      SELECT    
      @strUser,
      GetDate(),
      @SubCatID,
      x.y.value( '(.)[1]', 'bigint' ) AS BCID,      
      GetDate(),
	  @EX_IND
      FROM @xmlData.nodes('/ArrayOfLong/long') x(y);
