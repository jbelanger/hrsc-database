CREATE TABLE [HRSC].[CD_WORK_TYPE] (
    [WORK_TYPE_ID]          [HRSC].[IDENTIFIER_BIGINT] IDENTITY (1, 1) NOT NULL,
    [WORK_TYPE_CODE]        [HRSC].[TEXT_05]           NOT NULL,
    [WORK_TYPE_NAME_EN]     [HRSC].[TEXT_250]          NOT NULL,
    [WORK_TYPE_NAME_FR]     [HRSC].[TEXT_250]          NOT NULL,
    [WORK_TYPE_DESC_EN]     [HRSC].[TEXT_4000]         NULL,
    [WORK_TYPE_DESC_FR]     [HRSC].[TEXT_4000]         NULL,
    [EFFECTIVE_DATE]        DATETIME                   NOT NULL,
    [EXPIRY_DATE]           DATETIME                   NULL,
    [USER_CREATED]          [HRSC].[TEXT_60]           NOT NULL,
    [USER_UPDATED]          [HRSC].[TEXT_60]           NULL,
    [DATE_CREATED]          [HRSC].[DEFAULT_SYSDATE]   DEFAULT (getdate()) NOT NULL,
    [DATE_UPDATED]          DATETIME                   NULL,
    [EMPLOYMENT_IND]        [HRSC].[INDICATOR_BIT]     DEFAULT ((0)) NULL,
    [SCHEDULE_IND]          [HRSC].[INDICATOR_BIT]     DEFAULT ((0)) NULL,
    [OVERTIME_SCHEDULE_IND] BIT                        NULL,
    [OVERTIME_TIME_IND]     BIT                        NULL,
    CONSTRAINT [WRKTP_PK] PRIMARY KEY CLUSTERED ([WORK_TYPE_ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [WRKTP_UK] UNIQUE NONCLUSTERED ([WORK_TYPE_CODE] ASC, [EXPIRY_DATE] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '0 / 1 - Indicator used to identify work type related to schedule type.
', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_WORK_TYPE', @level2type = N'COLUMN', @level2name = N'OVERTIME_SCHEDULE_IND';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '0 / 1 - Indicator used to identify work type related to time type
', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_WORK_TYPE', @level2type = N'COLUMN', @level2name = N'OVERTIME_TIME_IND';

