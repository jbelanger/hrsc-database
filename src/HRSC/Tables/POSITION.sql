CREATE TABLE [HRSC].[POSITION] (
    [POSITION_ID]                         [HRSC].[IDENTIFIER_BIGINT] IDENTITY (1, 1) NOT NULL,
    [CLASSIFICATION_GROUP_ID]             [HRSC].[IDENTIFIER_BIGINT] NULL,
    [CLASSIFICATION_SUB_GROUP_ID]         [HRSC].[IDENTIFIER_BIGINT] NULL,
    [CLASSIFICATION_LEVEL_ID]             [HRSC].[IDENTIFIER_BIGINT] NULL,
    [EXCLUSION_OPT_ID]                    [HRSC].[IDENTIFIER_BIGINT] NULL,
    [LANG_PROFICIENCY_ID]                 [HRSC].[IDENTIFIER_BIGINT] NULL,
    [OFFICE_SITE_ID]                      [HRSC].[IDENTIFIER_BIGINT] NULL,
    [PRIORITY_TYPE_ID]                    [HRSC].[IDENTIFIER_BIGINT] NULL,
    [REGION_ID]                           [HRSC].[IDENTIFIER_BIGINT] NULL,
    [RELOCATION_EXPENSE_ID]               [HRSC].[IDENTIFIER_BIGINT] NULL,
    [ORGANIZATION_ID]                     [HRSC].[IDENTIFIER_BIGINT] NOT NULL,
    [SUB_ORGANIZATION_ID]                 [HRSC].[IDENTIFIER_BIGINT] NULL,
    [WORK_TYPE_ID]                        [HRSC].[IDENTIFIER_BIGINT] NULL,
    [EMPLOYEE_PREVIOUS_POSITION_ID]       [HRSC].[IDENTIFIER_BIGINT] NULL,
    [LANGUAGE_ID]                         [HRSC].[IDENTIFIER_BIGINT] NULL,
    [POSITION_REQUEST_TYPE_ID]            [HRSC].[IDENTIFIER_BIGINT] NULL,
    [STUDENT_PROGRAM_ID]                  [HRSC].[IDENTIFIER_BIGINT] NULL,
    [RATE_PAY_PER_HOUR]                   DECIMAL (10, 2)            NULL,
    [CANADIAN_CTZN_PREF_IND]              BIT                        CONSTRAINT [DF_POSITION_CANADIAN_CTZN_PREF_IND] DEFAULT ((0)) NULL,
    [CLASSIFICATION_GROUP_HOST_ID]        [HRSC].[IDENTIFIER_BIGINT] NULL,
    [CLSFCTN_SUB_GROUP_HOST_ID]           [HRSC].[IDENTIFIER_BIGINT] NULL,
    [CLASSIFICATION_LEVEL_HOST_ID]        [HRSC].[IDENTIFIER_BIGINT] NULL,
    [OFFICE_SITE_HOST_ID]                 [HRSC].[IDENTIFIER_BIGINT] NULL,
    [ORGANIZATION_HOST_ID]                [HRSC].[IDENTIFIER_BIGINT] NULL,
    [SUB_ORGANIZATION_HOST_ID]            [HRSC].[IDENTIFIER_BIGINT] NULL,
    [REGION_HOST_ID]                      [HRSC].[IDENTIFIER_BIGINT] NULL,
    [SELECTION_PROCESS_NUMBER]            NVARCHAR (30)              NULL,
    [DPRTMNTL_PRIORITY_CLRNCE_NBR]        NVARCHAR (10)              NULL,
    [RECLASSIFICATION_IND]                [HRSC].[INDICATOR_BIT]     NULL,
    [POSITION_TITLE]                      NVARCHAR (500)             NULL,
    [POSITION_NUMBER_HOME]                NVARCHAR (30)              NULL,
    [START_DATE]                          DATETIME                   NULL,
    [END_DATE]                            DATETIME                   NULL,
    [EXTENSION_DATE]                      DATETIME                   NULL,
    [ALLOTMENT_CODE]                      NVARCHAR (3)               NULL,
    [RC_CODE]                             NVARCHAR (10)              NULL,
    [ACTIVITY_CODE]                       NVARCHAR (3)               NULL,
    [PROJECT_CODE]                        NVARCHAR (5)               NULL,
    [LINE_OBJECT_CODE]                    NVARCHAR (4)               NULL,
    [COLLECTIVE_STAFFING_PROCESS_IN]      BIT                        CONSTRAINT [DF__POSITION__COLSTAFFPROC_IN] DEFAULT ((0)) NULL,
    [DEPLOYMENT_TYPE_ID]                  BIGINT                     NULL,
    [EMPLYMNT_CNDTN_MET_BY_EMP_IND]       [HRSC].[INDICATOR_BIT]     NULL,
    [INTRNL_ADVRTSD_PRCS_IND]             [HRSC].[INDICATOR_BIT]     NULL,
    [REASONABLE_JOB_OFFER_IND]            [HRSC].[INDICATOR_BIT]     NULL,
    [Classified_Position_Ind]             [HRSC].[INDICATOR_BIT]     NULL,
    [OUTLND_TRMS_CNDTNS_COMMENT]          [HRSC].[TEXT_4000]         NULL,
    [SELECTION_CRITERIA_COMMENTS]         [HRSC].[TEXT_4000]         NULL,
    [SUNSET_FUNDING_IND]                  [HRSC].[INDICATOR_BIT]     NULL,
    [UNREPRESENTED_POSITION_IND]          [HRSC].[INDICATOR_BIT]     NULL,
    [VACANT_POSITION_IND]                 [HRSC].[INDICATOR_BIT]     NULL,
    [GIVEN_NAME]                          [HRSC].[TEXT_30]           NULL,
    [SURNAME]                             [HRSC].[TEXT_30]           NULL,
    [PRI]                                 NVARCHAR (9)               NULL,
    [MONDAY]                              NUMERIC (4, 2)             NULL,
    [TUESDAY]                             NUMERIC (4, 2)             NULL,
    [WEDNESDAY]                           NUMERIC (4, 2)             NULL,
    [THURSDAY]                            NUMERIC (4, 2)             NULL,
    [FRIDAY]                              NUMERIC (4, 2)             NULL,
    [SATURDAY]                            NUMERIC (4, 2)             NULL,
    [SUNDAY]                              NUMERIC (4, 2)             NULL,
    [HOME_ORG_CONTACT_NAME]               NVARCHAR (30)              NULL,
    [HOME_ORG_CONTACT_EMAIL]              NVARCHAR (50)              NULL,
    [HOME_ORG_CONTACT_PHONE]              NVARCHAR (25)              NULL,
    [FTE_HOME_ORG_IND]                    INT                        NULL,
    [SAL_HOME_ORG_IND]                    INT                        NULL,
    [POSITION_NUMBER_HOST]                NVARCHAR (30)              NULL,
    [FTE_HOST_ORG_IND]                    INT                        NULL,
    [SAL_HOST_ORG_IND]                    INT                        NULL,
    [ALLOTMENT_HOST_CODE]                 NVARCHAR (3)               NULL,
    [RC_HOST_CODE]                        NVARCHAR (10)              NULL,
    [ACTIVITY_HOST_CODE]                  NVARCHAR (3)               NULL,
    [PROJECT_HOST_CODE]                   NVARCHAR (5)               NULL,
    [LINE_OBJECT_HOST_CODE]               NVARCHAR (4)               NULL,
    [PAYLIST_NUMBER]                      INT                        NULL,
    [SECURITY_CLEARANCE_ID]               [HRSC].[IDENTIFIER_BIGINT] NULL,
    [LANG_PROFILE_NEW_ID]                 [HRSC].[IDENTIFIER_BIGINT] NULL,
    [LANG_PROFILE_CURRENT_ID]             [HRSC].[IDENTIFIER_BIGINT] NULL,
    [TMP_ACTNG_APPNTMNT_IND]              [HRSC].[INDICATOR_BIT]     CONSTRAINT [DF__POSITION__TMP_AC__48DABF76] DEFAULT ((0)) NULL,
    [TMP_DPLYMNT_TERM_IND]                [HRSC].[INDICATOR_BIT]     CONSTRAINT [DF__POSITION__TMP_DP__49CEE3AF] DEFAULT ((0)) NULL,
    [TMP_TERM_IND]                        [HRSC].[INDICATOR_BIT]     CONSTRAINT [DF__POSITION__TMP_TE__4AC307E8] DEFAULT ((0)) NULL,
    [PERMNT_INDTRMNT_IND]                 [HRSC].[INDICATOR_BIT]     CONSTRAINT [DF__POSITION__PERMNT__4BB72C21] DEFAULT ((0)) NULL,
    [PERMNT_DPLYMNT_INDTRMNT_IND]         [HRSC].[INDICATOR_BIT]     CONSTRAINT [DF__POSITION__PERMNT__4CAB505A] DEFAULT ((0)) NULL,
    [HRSDC_EMPLOYEE_IND]                  [HRSC].[INDICATOR_BIT]     NULL,
    [STAFF_LOCATION]                      [HRSC].[TEXT_4000]         NULL,
    [COMMENTS]                            [HRSC].[TEXT_4000]         NULL,    
    [EXPIRY_DATE]                         DATETIME                   NULL,
    [USER_CREATED]                        [HRSC].[TEXT_60]           NOT NULL,
    [DATE_CREATED]                        [HRSC].[DEFAULT_SYSDATE]   CONSTRAINT [DF__POSITION__DATE_C__125EB334] DEFAULT (getdate()) NOT NULL,
    [USER_UPDATED]                        [HRSC].[TEXT_60]           NULL,
    [DATE_UPDATED]                        DATETIME                   NULL,
    [PSC_Priority_referrals]              BIT                        CONSTRAINT [DF__POSITION__PSC_Pr__1466F737] DEFAULT ((0)) NULL,
    [BNFT_ADVSR_CONTACT_NAME]             [HRSC].[TEXT_30]           NULL,
    [BNFT_ADVSR_CONTACT_EMAIL]            [HRSC].[TEXT_60]           NULL,
    [BNFT_ADVSR_CONTACT_PHONE]            NVARCHAR (25)              NULL,
    [TERMS_CONDITIONS_DIFFRNT]            [HRSC].[INDICATOR_BIT]     NULL,
    [BUROLIS_CODE]                        NUMERIC (8)                NULL,
    [SUPERVISOR_POSITION_NUMBER]          NVARCHAR (30)              NULL,
    [REGION_NEW_ID]                       [HRSC].[IDENTIFIER_BIGINT] NULL,
    [OFFICE_SITE_NEW_ID]                  [HRSC].[IDENTIFIER_BIGINT] NULL,
    [RC_CODE_NEW]                         NVARCHAR (10)              NULL,
    [SSA]                                 NVARCHAR (3)               NULL,
    [SSA_NEW]                             NVARCHAR (3)               NULL,
    [ORGANIZATION_OTHER]                  VARCHAR (50)               NULL,
    [POSITION_GEOGRAPHIC_LOCATION]        VARCHAR (50)               NULL,
    [FINANCIAL_CODING]                    VARCHAR (50)               NULL,
    [DEPARTMENT_ID]                       [HRSC].[IDENTIFIER_BIGINT] NULL,
    [LANG_CHNGE_JUSTIFICATION]            [HRSC].[TEXT_4000]         NULL,
    [PROVINCE_ID]                         [HRSC].[IDENTIFIER_BIGINT] NULL,
    [OFFICE_SITE_HOME]                    NVARCHAR (250)             NULL,
    [OFFICE_SITE_HOST]                    NVARCHAR (250)             NULL,
    [LANG_REQ_MET_BY_EMP_IND]             [HRSC].[INDICATOR_BIT]     NULL,
    [COMPANY_CODE]                        NVARCHAR (4)               NULL,
    [FUND_CENTRE]                         NVARCHAR (6)               NULL,
    [FUND]                                NVARCHAR (4)               NULL,
    [FUNCTIONAL_AREA]                     NVARCHAR (9)               NULL,
    [GENERAL_LEDGER]                      NVARCHAR (6)               NULL,
    [COMPANY_CODE_HOST]                   NVARCHAR (4)               NULL,
    [FUND_CENTRE_HOST]                    NVARCHAR (6)               NULL,
    [FUND_HOST]                           NVARCHAR (4)               NULL,
    [FUNCTIONAL_AREA_HOST]                NVARCHAR (9)               NULL,
    [GENERAL_LEDGER_HOST]                 NVARCHAR (6)               NULL,
    [JOB_CODE_HOME]                       NVARCHAR (30)              NULL,
    [ACADEMIC_LEVEL_ID]                   BIGINT                     NULL,
    [STAFFING_CODE_HOME_IND]              INT                        NULL,
    [STAFFING_CODE_HOST_IND]              INT                        NULL,
    [JOB_CODE_HOST]                       NVARCHAR (30)              NULL,
    [EMPLOYEE_ID]                         BIGINT                     NULL,
    [OFFICE_SITE_HOME_MUNICIPALITY_ID]    NUMERIC (10)               NULL,
    [OFFICE_SITE_HOST_MUNICIPALITY_ID]    NUMERIC (10)               NULL,
    [APPOINTMENT_TYPE_INDETERMINATE_IND]  BIT                        NULL,
    [APPOINTMENT_TYPE_TERM_IND]           BIT                        NULL,
    [HIRING_FORMER_STUDENT_IND]           BIT                        NULL,
    [POSITION_BASED_EXISTING_JOBCODE_IND] BIT                        NULL,
    [IS_POSITION_SUPERVISOR_IND]          BIT                        NULL,
    [POSITION_TITLE_EN]                   NVARCHAR (250)             NULL,
    [POSITION_TITLE_FR]                   NVARCHAR (250)             NULL,
    [NEW_SUPERVISOR_POSITION_NUMBER]      NVARCHAR (10)              NULL,
    [IS_POSITION_EXCLUDED_IND]            BIT                        NULL,
    [IS_POSITION_DESIGNATED_IND]          BIT                        NULL,
    [DEPARTMENT_TITLE_NAME_EN]            NVARCHAR (30)              NULL,
    [DEPARTMENT_TITLE_NAME_FR]            NVARCHAR (30)              NULL,
    [DEPARTMENT_ABREV_EN]                 NVARCHAR (10)              NULL,
    [DEPARTMENT_ABREV_FR]                 NVARCHAR (10)              NULL,
    [NEW_DEPARTMENT_CODE]                 NVARCHAR (10)              NULL,
    [DEPARTMENT_PARENT_CODE]              NVARCHAR (10)              NULL,
    [DEPARTMENT_CODE]                     NVARCHAR (10)              NULL,
    [SUNSET_FUNDING_TYPE_ID]              BIGINT                     NULL,
    [WILL_EMPL_BE_TRAVEL_STATUS_IND]      BIT                        NULL,
    [LOC_WORK_MATCH_WITH_PEOPLESOFT_IND]  BIT                        NULL,
    [DOUBLE_BANKING_ID]                   INT                        NULL,
    [EXCLUSION_OPT_HOST_ID]               BIGINT                     NULL,
    [TENURE_TYPE_ID]                      BIGINT                     NULL,
    [EXERCISE_SAME_FN_BEFORE_IND]         BIT                        DEFAULT ((0)) NOT NULL,
    [POSITION_ID_PARENT]                  BIGINT                     NULL,
    [HR_REQUEST_TYPE_ID]                  BIGINT                     NULL,
    [HR_REQUEST_ID]                       BIGINT                     NULL,
    [SHIFT_WORK_IND]                      BIT                        NULL,
    [SHIFT_WORK_COMMENTS]                 NVARCHAR (4000)            NULL,
    [STUDENT_SUB_PROGRAM_ID]              BIGINT                     NULL,
    [STUDENT_ELIGIBLE_PROGRAM_IND]        BIT                        NULL,
    [TELEWORK_IND]                        BIT                        NULL,
    [CONFIRMED_FUNDS_IND]                 BIT                        NULL,
    CONSTRAINT [PSTN_PK] PRIMARY KEY CLUSTERED ([POSITION_ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [PSTN_CK1] CHECK ([FTE_HOME_ORG_IND]=(0) OR [FTE_HOME_ORG_IND]=(1) OR [FTE_HOME_ORG_IND]=(2) OR [FTE_HOME_ORG_IND] IS NULL),
    CONSTRAINT [PSTN_CK2] CHECK ([FTE_HOME_ORG_IND]=(0) OR [FTE_HOME_ORG_IND]=(1) OR [FTE_HOME_ORG_IND]=(2) OR [FTE_HOME_ORG_IND] IS NULL),
    CONSTRAINT [PSTN_CK3] CHECK ([FTE_HOME_ORG_IND]=(0) OR [FTE_HOME_ORG_IND]=(1) OR [FTE_HOME_ORG_IND]=(2) OR [FTE_HOME_ORG_IND] IS NULL),
    CONSTRAINT [PSTN_CK4] CHECK ([FTE_HOME_ORG_IND]=(0) OR [FTE_HOME_ORG_IND]=(1) OR [FTE_HOME_ORG_IND]=(2) OR [FTE_HOME_ORG_IND] IS NULL),
    FOREIGN KEY ([HR_REQUEST_ID]) REFERENCES [HRSC].[HR_REQUEST] ([HR_REQUEST_ID]),
    FOREIGN KEY ([HR_REQUEST_TYPE_ID]) REFERENCES [HRSC].[CD_HR_REQUEST_TYPE] ([HR_REQUEST_TYPE_ID]),
    CONSTRAINT [fk_student_sub_program] FOREIGN KEY ([STUDENT_SUB_PROGRAM_ID]) REFERENCES [HRSC].[CD_STUDENT_PROGRAM] ([STUDENT_PROGRAM_ID]),
    CONSTRAINT [PSTN_CDACDLVL_FK] FOREIGN KEY ([ACADEMIC_LEVEL_ID]) REFERENCES [HRSC].[CD_ACADEMIC_LEVEL] ([ACADEMIC_LEVEL_ID]),
    CONSTRAINT [PSTN_CDSTFGTE_FK] FOREIGN KEY ([SUNSET_FUNDING_TYPE_ID]) REFERENCES [HRSC].[CD_SUNSET_FUNDING_TYPE] ([SUNSET_FUNDING_TYPE_ID]),
    CONSTRAINT [PSTN_DBLBNKNG_FK] FOREIGN KEY ([DOUBLE_BANKING_ID]) REFERENCES [HRSC].[CD_DOUBLE_BANKING] ([DOUBLE_BANKING_ID]),
    CONSTRAINT [PSTN_DPLMNTTP_FK] FOREIGN KEY ([DEPLOYMENT_TYPE_ID]) REFERENCES [HRSC].[CD_DEPLOYMENT_TYPE] ([DEPLOYMENT_TYPE_ID]),
    CONSTRAINT [PSTN_EMPLY_FK] FOREIGN KEY ([EMPLOYEE_ID]) REFERENCES [HRSC].[EMPLOYEE] ([EMPLOYEE_ID]),
    CONSTRAINT [PSTN_EXCLOPT_FK2] FOREIGN KEY ([EXCLUSION_OPT_HOST_ID]) REFERENCES [HRSC].[CD_EXCLUSION_OPTION] ([EXCLUSION_OPT_ID]),
    CONSTRAINT [PSTN_LANGPRFL_FK] FOREIGN KEY ([LANG_PROFILE_NEW_ID]) REFERENCES [HRSC].[LANGUAGE_PROFILE] ([LANGUAGE_PROFILE_ID]),
    CONSTRAINT [PSTN_LANGPRFL_FK2] FOREIGN KEY ([LANG_PROFILE_CURRENT_ID]) REFERENCES [HRSC].[LANGUAGE_PROFILE] ([LANGUAGE_PROFILE_ID]),
    CONSTRAINT [PSTN_MUNICIPALITY_FK] FOREIGN KEY ([OFFICE_SITE_HOME_MUNICIPALITY_ID]) REFERENCES [HRSC].[MUNICIPALITY] ([MUNICIPALITY_ID]),
    CONSTRAINT [PSTN_MUNICIPALITY_FK2] FOREIGN KEY ([OFFICE_SITE_HOST_MUNICIPALITY_ID]) REFERENCES [HRSC].[MUNICIPALITY] ([MUNICIPALITY_ID]),
    CONSTRAINT [PSTN_POSREQTP_FK] FOREIGN KEY ([POSITION_REQUEST_TYPE_ID]) REFERENCES [HRSC].[CD_POSITION_REQUEST_TYPE] ([POSITION_REQUEST_TYPE_ID]),
    CONSTRAINT [PSTN_PSTN_FK] FOREIGN KEY ([POSITION_ID_PARENT]) REFERENCES [HRSC].[POSITION] ([POSITION_ID]),
    CONSTRAINT [PSTN_RELEXP_FK] FOREIGN KEY ([RELOCATION_EXPENSE_ID]) REFERENCES [HRSC].[CD_RELOCATION_EXPENSE] ([RELOCATION_EXPENSE_ID]),
    CONSTRAINT [PSTN_SECCLRNC_FK] FOREIGN KEY ([SECURITY_CLEARANCE_ID]) REFERENCES [HRSC].[CD_SECURITY_CLEARANCE] ([SECURITY_CLEARANCE_ID]),
    CONSTRAINT [PSTN_STDNTPRG_FK] FOREIGN KEY ([STUDENT_PROGRAM_ID]) REFERENCES [HRSC].[CD_STUDENT_PROGRAM] ([STUDENT_PROGRAM_ID]),
    CONSTRAINT [PSTN_TNRTP_FK] FOREIGN KEY ([TENURE_TYPE_ID]) REFERENCES [HRSC].[CD_TENURE_TYPE] ([TENURE_TYPE_ID]),
    CONSTRAINT [PSTN_WRKTP_FK] FOREIGN KEY ([WORK_TYPE_ID]) REFERENCES [HRSC].[CD_WORK_TYPE] ([WORK_TYPE_ID])
);




GO
CREATE NONCLUSTERED INDEX [PSTN_HRREQ_FK_I]
    ON [HRSC].[POSITION]([HR_REQUEST_ID] ASC) WITH (FILLFACTOR = 95);


GO
CREATE NONCLUSTERED INDEX [PSTN_SLCTNPRCSSNMBR_I]
    ON [HRSC].[POSITION]([SELECTION_PROCESS_NUMBER] ASC) WITH (FILLFACTOR = 95);


GO
CREATE NONCLUSTERED INDEX [PSTN_TNRTP_FK]
    ON [HRSC].[POSITION]([TENURE_TYPE_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_EXCLOPT_FK2_I]
    ON [HRSC].[POSITION]([EXCLUSION_OPT_HOST_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_DBLBNKNG_FK_I]
    ON [HRSC].[POSITION]([DOUBLE_BANKING_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_CDACDLVL_FK_I]
    ON [HRSC].[POSITION]([ACADEMIC_LEVEL_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_OFFSITE_FK_I]
    ON [HRSC].[POSITION]([OFFICE_SITE_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_PRTTP_FK_I]
    ON [HRSC].[POSITION]([PRIORITY_TYPE_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_RELEXP_FK_I]
    ON [HRSC].[POSITION]([RELOCATION_EXPENSE_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_STDNTPRG_FK_I]
    ON [HRSC].[POSITION]([STUDENT_PROGRAM_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_RGN_FK_I]
    ON [HRSC].[POSITION]([REGION_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_CLSLVL_FK_I]
    ON [HRSC].[POSITION]([CLASSIFICATION_LEVEL_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_WRKTP_FK_I]
    ON [HRSC].[POSITION]([WORK_TYPE_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_ORGNZTN_FK_I]
    ON [HRSC].[POSITION]([ORGANIZATION_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_CLSGRP_FK_I]
    ON [HRSC].[POSITION]([CLASSIFICATION_GROUP_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_CLSSUBGR_FK_I]
    ON [HRSC].[POSITION]([CLASSIFICATION_SUB_GROUP_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_SBORGNZ_FK_I]
    ON [HRSC].[POSITION]([SUB_ORGANIZATION_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_LNGPRFCY_FK_I]
    ON [HRSC].[POSITION]([LANG_PROFICIENCY_ID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [PSTN_EXCLOPT_FK_I]
    ON [HRSC].[POSITION]([EXCLUSION_OPT_ID] ASC) WITH (FILLFACTOR = 80);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'System generated number used internally. The value is meaningfull only as pointers or keys and does not show on end user reports, screens etc.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'POSITION', @level2type = N'COLUMN', @level2name = N'WORK_TYPE_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'work schedule', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'POSITION', @level2type = N'COLUMN', @level2name = N'MONDAY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Position number for non-manager position.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'POSITION', @level2type = N'COLUMN', @level2name = N'JOB_CODE_HOME';

