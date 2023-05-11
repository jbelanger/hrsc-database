



CREATE   PROCEDURE [HRSC_APP].[usp_Employee_SubDel_Insert]
@pPri nvarchar(9), @pGivenName nvarchar(100), @pSurname nvarchar(100), @pSubstantive_lv nvarchar(5), @pActing_lv nvarchar(5), @pAssignment_lv nvarchar(30), @pBranch nvarchar(30), @pRegion nvarchar(30), @pAttestation bit, @pEmployeeID bigint, @pActiveInd bit, @pRC nvarchar(10), @pPositionEN nvarchar(250), @pPositionFR nvarchar(250), @pGroup nvarchar(30), @pUser nvarchar(30)
WITH EXEC AS CALLER
AS
UPDATE HRSC.EMPLOYEE_SUB_DELEGATED SET
	USER_UPDATED = @pUser,
	EXPIRY_DATE = getDate()
WHERE EMPLOYEE_ID = @pEmployeeID
      and expiry_date is null;

IF @pActiveInd = 1
	Insert into HRSC.EMPLOYEE_SUB_DELEGATED
    ( PRI,
      GIVEN_NAME,
      SURNAME, 
      SUBSTANTIVE_LEVEL, 
      ACTING_LEVEL, 
      ASSIGNMENT_LEVEL, 
      BRANCH, 
      REGION, 
      ATTESTATION, 
      EMPLOYEE_ID,
      RC_CODE,
      POSITION_EN,
      POSITION_FR, 
      [GROUP],
      USER_CREATED 
	  )
      values
      (@pPri,  
       @pGivenName, 
       @pSurname, 
       @pSubstantive_lv, 
       @pActing_lv, 
       @pAssignment_lv, 
       @pBranch, 
       @pRegion, 
       @pAttestation, 
       @pEmployeeID, 
       @pRC,
       @pPositionEN,
       @pPositionFR,
       @pGroup,
       @pUser
      )
