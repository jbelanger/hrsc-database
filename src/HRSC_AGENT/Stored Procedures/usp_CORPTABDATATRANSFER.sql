


CREATE PROCEDURE [HRSC_AGENT].[usp_CORPTABDATATRANSFER]
AS

BEGIN


exec sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

delete from HRSC.MUNICIPALITY
delete from HRSC.PROVINCE
delete from HRSC.STG_OP_CORPTAB_ORG

  
  ---- FILL OUT MUNICIPALITY TABLE
  
 INSERT INTO [HRSC].[MUNICIPALITY]
           ([MUNICIPALITY_ID]
           ,[MUNICIPALITY_NAME]
           ,[EFFECTIVE_DATE]
           ,[PROVINCE_ID]
           ,[ACCENTED_NAME]
           ,[EXPIRY_DATE]
           ,[USER_CREATED]
           ,[USER_UPDATED]
           ,[DATE_CREATED]
           ,[DATE_UPDATED])

SELECT [MUNICIPALITY_ID]
      ,[MUNICIPALITY_NAME]
      ,[EFFECTIVE_DATE]
      ,[PROVINCE_ID]
      ,[ACCENTED_NAME]
      ,[EXPIRY_DATE]
      ,[USER_CREATED]
      ,[USER_UPDATED]
      ,[DATE_CREATED]
      ,[DATE_UPDATED]
  FROM [CORPTAB_UAT]..[CORPTAB].[MUNICIPALITY]
    

  ---- FILL OUT PROVINCE TABLE

INSERT INTO [HRSC].[PROVINCE]
           ([PROVINCE_ID]
           ,[PROVINCE_CODE]
           ,[PROVINCE_NUMBER]
           ,[EFFECTIVE_DATE]
           ,[EXPIRY_DATE]
           ,[ENGLISH_NAME]
           ,[FRENCH_NAME]
           ,[PROVINCE_SEQUENCE_NUMBER]
           ,[USER_CREATED]
           ,[USER_UPDATED]
           ,[DATE_CREATED]
           ,[DATE_UPDATED])

SELECT [PROVINCE_ID]
      ,[PROVINCE_CODE]
      ,[PROVINCE_NUMBER]
      ,[EFFECTIVE_DATE]
      ,[EXPIRY_DATE]
      ,[ENGLISH_NAME]
      ,[FRENCH_NAME]
      ,[PROVINCE_SEQUENCE_NUMBER]
      ,[USER_CREATED]
      ,[USER_UPDATED]
      ,[DATE_CREATED]
      ,[DATE_UPDATED]
  FROM [CORPTAB_UAT]..[CORPTAB].[PROVINCE]  
  
  
  --- FILL OUT HRSC.STG_OP_CORPTAB_ORG
  
  INSERT INTO [HRSC_DEV2].[HRSC].[STG_OP_CORPTAB_ORG]
           ([OP_ORG_ID]
           ,[OP_ORG_ORG_ID],[OP_DEPT_ID],[OP_ALTERNATE_RC],[OP_ALTERNATE_RC_LEVEL]
           ,[OP_ALTERNATE_RC_PARENT]
           ,[OP_REGION]
           ,[OP_NAMEENG]
           ,[OP_NAMEFRE]
           ,[OP_OFFICE_ADDR_E]
           ,[OP_OFFICE_ADDR_F]
           ,[OP_BUILDINGENG]
           ,[OP_BUILDINGFRE]
           ,[OP_STREETNAMEENG]
           ,[OP_STREETNAMEFRE]
           ,[OP_CITYENG]
           ,[OP_CITYFRE]
           ,[OP_PROVCODE]
           ,[OP_PROVINCEENG]
           ,[OP_PROVINCEFRE]
           ,[OP_POSTALCODEENG]
           ,[OP_OFT_CAVALUE]
           ,[OP_OFFICETYPE_E]
           ,[OP_OFFICETYPE_F]
           ,[OP_OFFICETYPE_STATUS]
           ,[OP_OFT_E_ABBR_NAME]
           ,[OP_OFT_F_ABBR_NAME]
           ,[OP_OFT_ACTIV_IND]
           ,[OP_EMAIL_E]
           ,[OP_EMAIL_F]
           ,[OP_MAIN_PH_E]
           ,[OP_MAIN_PH_F]
           ,[OP_MAIN_FAX_E]
           ,[OP_MAIN_FAX_F]
           ,[OP_WHEELCHAIR_IND]
           ,[OP_PARKING_E]
           ,[OP_PARKING_F]
           ,[OP_LANG_OFFRD]
           ,[OP_OFFICE_OPENDATE]
           ,[OP_OFFICE_CLOSEDATE]
           ,[OP_LINEAGE]
           ,[OP_HRS_E]
           ,[OP_HRS_F]
           ,[OP_CRTN_DATE]
           ,[OP_MODIFIED_DATE]
           ,[OP_EMER_CLS_STARTDATE]
           ,[OP_EMER_CLS_ENDDATE]
           ,[OP_EMER_CLS_DETAILE]
           ,[OP_EMER_CLS_DETAILF]
           ,[OP_EMER_CLS_IND]
           ,[OP_EMER_CLS_REASON_E]
           ,[OP_EMER_CLS_REASON_F])
    

SELECT [OP_ORG_ID]
      ,[OP_ORG_ORG_ID]
      ,[OP_DEPT_ID]
      ,[OP_ALTERNATE_RC]
      ,[OP_ALTERNATE_RC_LEVEL]
      ,[OP_ALTERNATE_RC_PARENT]
      ,[OP_REGION]
      ,[OP_NAMEENG]
      ,[OP_NAMEFRE]
      ,[OP_OFFICE_ADDR_E]
      ,[OP_OFFICE_ADDR_F]
      ,[OP_BUILDINGENG]
      ,[OP_BUILDINGFRE]
      ,[OP_STREETNAMEENG]
      ,[OP_STREETNAMEFRE]
      ,[OP_CITYENG]
      ,[OP_CITYFRE]
      ,[OP_PROVCODE]
      ,[OP_PROVINCEENG]
      ,[OP_PROVINCEFRE]
      ,[OP_POSTALCODEENG]
      ,[OP_OFT_CAVALUE]
      ,[OP_OFFICETYPE_E]
      ,[OP_OFFICETYPE_F]
      ,[OP_OFFICETYPE_STATUS]
      ,[OP_OFT_E_ABBR_NAME]
      ,[OP_OFT_F_ABBR_NAME]
      ,[OP_OFT_ACTIV_IND]
      ,[OP_EMAIL_E]
      ,[OP_EMAIL_F]
      ,[OP_MAIN_PH_E]
      ,[OP_MAIN_PH_F]
      ,[OP_MAIN_FAX_E]
      ,[OP_MAIN_FAX_F]
      ,[OP_WHEELCHAIR_IND]
      ,[OP_PARKING_E]
      ,[OP_PARKING_F]
      ,[OP_LANG_OFFRD]
      ,[OP_OFFICE_OPENDATE]
      ,[OP_OFFICE_CLOSEDATE]
      ,[OP_LINEAGE]
      ,[OP_HRS_E]
      ,[OP_HRS_F]
      ,[OP_CRTN_DATE]
      ,[OP_MODIFIED_DATE]
      ,[OP_EMER_CLS_STARTDATE]
      ,[OP_EMER_CLS_ENDDATE]
      ,[OP_EMER_CLS_DETAILE]
      ,[OP_EMER_CLS_DETAILF]
      ,[OP_EMER_CLS_IND]
      ,[OP_EMER_CLS_REASON_E]
      ,[OP_EMER_CLS_REASON_F]
  FROM [CORPTAB_UAT]..[CORPTAB_STAGE].[STG_OP_CORPTAB_ORG]


  
exec sp_msforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL'

END