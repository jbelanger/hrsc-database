CREATE TABLE [HRSC].[MUNICIPALITY] (
    [MUNICIPALITY_ID]   NUMERIC (10) NOT NULL,
    [MUNICIPALITY_NAME] VARCHAR (30) NOT NULL,
    [EFFECTIVE_DATE]    DATETIME     NOT NULL,
    [PROVINCE_ID]       NUMERIC (10) NOT NULL,
    [ACCENTED_NAME]     VARCHAR (60) NULL,
    [EXPIRY_DATE]       DATETIME     NULL,
    [USER_CREATED]      VARCHAR (30) NOT NULL,
    [USER_UPDATED]      VARCHAR (30) NULL,
    [DATE_CREATED]      DATETIME     NOT NULL,
    [DATE_UPDATED]      DATETIME     NULL,
    CONSTRAINT [MPLTY_PK] PRIMARY KEY CLUSTERED ([MUNICIPALITY_ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [MPLTY_PROV_FK] FOREIGN KEY ([PROVINCE_ID]) REFERENCES [HRSC].[PROVINCE] ([PROVINCE_ID]),
    CONSTRAINT [MPLTY_UK] UNIQUE NONCLUSTERED ([PROVINCE_ID] ASC, [MUNICIPALITY_NAME] ASC, [EXPIRY_DATE] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MUNICIPALITY', @value = N'A municipality is any city, town or village in Canada that is recognized as a valid mailing address by Canada Post.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY';


GO
EXECUTE sp_addextendedproperty @name = N'MUNICIPALITY ID', @value = N'A sequence-generated (unique) identifier for a municipality.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'MUNICIPALITY_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MUNICIPALITY NAME', @value = N'The English name for a municipality. E.g. Ottawa, Toronto, Montreal.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'MUNICIPALITY_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'EFFECTIVE DATE', @value = N'The date the municipality is effective.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'EFFECTIVE_DATE';


GO
EXECUTE sp_addextendedproperty @name = N'PROVINCE ID', @value = N'A sequence-generated (unique) identifier for a province.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'PROVINCE_ID';


GO
EXECUTE sp_addextendedproperty @name = N'ACCENTED NAME', @value = N'The accented name of the municipality when the accent indicator from the Canada Post address file indicates the name should be accented', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'ACCENTED_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'EXPIRY DATE', @value = N'The date the municipality is no longer effective', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'EXPIRY_DATE';


GO
EXECUTE sp_addextendedproperty @name = N'USER CREATED', @value = N'Database administrator audit stamp. The unique identifier of the person who created the record', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'USER_CREATED';


GO
EXECUTE sp_addextendedproperty @name = N'USER UPDATED', @value = N'Database administrator audit stamp. The unique identifier of the most recent user to modify the record.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'USER_UPDATED';


GO
EXECUTE sp_addextendedproperty @name = N'DATE CREATED', @value = N'Database administrator audit stamp. The date when the record was created', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'DATE_CREATED';


GO
EXECUTE sp_addextendedproperty @name = N'DATE UPDATED', @value = N'Database administrator audit stamp. The date on which the record was modified.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'MUNICIPALITY', @level2type = N'COLUMN', @level2name = N'DATE_UPDATED';

