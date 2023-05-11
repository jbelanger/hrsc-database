CREATE TABLE [HRSC].[EMPLOYEE_SUB_DELEGATED] (
    [EMPLOYEE_SUBDEL_ID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [PRI]                NVARCHAR (9)   NULL,
    [GIVEN_NAME]         NVARCHAR (100) NULL,
    [SURNAME]            NVARCHAR (100) NULL,
    [SUBSTANTIVE_LEVEL]  NVARCHAR (5)   NULL,
    [ACTING_LEVEL]       NVARCHAR (5)   NULL,
    [ASSIGNMENT_LEVEL]   NVARCHAR (5)   NULL,
    [BRANCH]             NVARCHAR (30)  NULL,
    [REGION]             NVARCHAR (30)  NULL,
    [ATTESTATION]        BIT            NULL,
    [EMPLOYEE_ID]        BIGINT         NOT NULL,
    [EXPIRY_DATE]        DATETIME       NULL,
    [USER_CREATED]       NVARCHAR (120) NULL,
    [USER_UPDATED]       NVARCHAR (120) NULL,
    [DATE_CREATED]       DATETIME       CONSTRAINT [DF__EMPLOYEE___DATE___68143F04] DEFAULT (getdate()) NULL,
    [DATE_UPDATED]       DATETIME       NULL,
    [RC_CODE]            NVARCHAR (10)  NULL,
    [POSITION_EN]        NVARCHAR (250) NULL,
    [POSITION_FR]        NVARCHAR (250) NULL,
    [GROUP]              NVARCHAR (30)  NULL,
    CONSTRAINT [EMPSBDLD_PK] PRIMARY KEY CLUSTERED ([EMPLOYEE_SUBDEL_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [EMPSBDLD_EMPLY_FK] FOREIGN KEY ([EMPLOYEE_ID]) REFERENCES [HRSC].[EMPLOYEE] ([EMPLOYEE_ID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Key, AutoIncrement', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'EMPLOYEE_SUBDEL_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Substantive Sub-Delegated Level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'SUBSTANTIVE_LEVEL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Acting Sub-Delegated Level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'ACTING_LEVEL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Assignment Sub-Delegated Level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'ASSIGNMENT_LEVEL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Attestation form Received (yes or no)', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'ATTESTATION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Data Base Administrator audit stamp. The unique identifier of the person who created the record.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'USER_CREATED';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Data Base Administrator audit stamp. The unique identifier of the most recent user to modify the record.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'USER_UPDATED';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'RC code', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'RC_CODE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Position name in english', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'POSITION_EN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Poistion name in French', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'POSITION_FR';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Group and level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'EMPLOYEE_SUB_DELEGATED', @level2type = N'COLUMN', @level2name = N'GROUP';

