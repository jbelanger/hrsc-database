CREATE TABLE [HRSC].[CD_ACADEMIC_LEVEL] (
    [ACADEMIC_LEVEL_ID]      BIGINT          NOT NULL,
    [ACADEMIC_LEVEL_CODE]    NVARCHAR (5)    NOT NULL,
    [ACADEMIC_LEVEL_NAME_EN] NVARCHAR (250)  NOT NULL,
    [ACADEMIC_LEVEL_NAME_FR] NVARCHAR (250)  NOT NULL,
    [ACADEMIC_LEVEL_DESC_EN] NVARCHAR (4000) NULL,
    [ACADEMIC_LEVEL_DESC_FR] NVARCHAR (4000) NULL,
    [EFFECTIVE_DATE]         DATE            NOT NULL,
    [EXPIRY_DATE]            DATE            NULL,
    [USER_CREATED]           VARCHAR (30)    NOT NULL,
    [USER_UPDATED]           VARCHAR (30)    NULL,
    [DATE_CREATED]           DATE            DEFAULT (getdate()) NOT NULL,
    [DATE_UPDATED]           DATE            NULL,
    CONSTRAINT [CDACDLVL_PK] PRIMARY KEY CLUSTERED ([ACADEMIC_LEVEL_ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [CDACDLVL_UK] UNIQUE NONCLUSTERED ([ACADEMIC_LEVEL_CODE] ASC, [EXPIRY_DATE] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Code to keep permanent value of each code type.Identifier can be changed when it is deleted and recreated.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'ACADEMIC_LEVEL_CODE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'English name of academic level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'ACADEMIC_LEVEL_NAME_EN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'French name of academic level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'ACADEMIC_LEVEL_NAME_FR';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'English description of the academic level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'ACADEMIC_LEVEL_DESC_EN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'French description of the academic level', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'ACADEMIC_LEVEL_DESC_FR';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Date the record came (or will come) into effect.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'EFFECTIVE_DATE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'The date the record is considered expired. Once expired the record can not be referenced.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'EXPIRY_DATE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Data Base Administrator audit stamp. The unique identifier of the person who created the record.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'USER_CREATED';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Data Base Administrator audit stamp. The unique identifier of the most recent user to modify the record.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'USER_UPDATED';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'The date on which the record was created/loaded into the database.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'DATE_CREATED';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'The date on which the record was updated in the database.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'CD_ACADEMIC_LEVEL', @level2type = N'COLUMN', @level2name = N'DATE_UPDATED';

