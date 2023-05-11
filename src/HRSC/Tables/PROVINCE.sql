CREATE TABLE [HRSC].[PROVINCE] (
    [PROVINCE_ID]              NUMERIC (10) NOT NULL,
    [PROVINCE_CODE]            VARCHAR (2)  NOT NULL,
    [PROVINCE_NUMBER]          NUMERIC (2)  NOT NULL,
    [EFFECTIVE_DATE]           DATETIME     NOT NULL,
    [EXPIRY_DATE]              DATETIME     NULL,
    [ENGLISH_NAME]             VARCHAR (35) NOT NULL,
    [FRENCH_NAME]              VARCHAR (35) NOT NULL,
    [PROVINCE_SEQUENCE_NUMBER] NUMERIC (2)  NOT NULL,
    [USER_CREATED]             VARCHAR (30) NOT NULL,
    [USER_UPDATED]             VARCHAR (30) NULL,
    [DATE_CREATED]             DATETIME     NOT NULL,
    [DATE_UPDATED]             DATETIME     NULL,
    CONSTRAINT [PROV_PK] PRIMARY KEY CLUSTERED ([PROVINCE_ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [PROV_PROV1_UK] UNIQUE NONCLUSTERED ([EXPIRY_DATE] ASC, [PROVINCE_CODE] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'PROVINCE', @value = N'A geopolitical area known as a territory or province, officially recognized by the federal government, which is comprised of municipalities and  
represented in Parliament by officially elected representatives.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE';


GO
EXECUTE sp_addextendedproperty @name = N'PROVINCE ID', @value = N'A sequence-generated (unique) identifier for a province.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'PROVINCE_ID';


GO
EXECUTE sp_addextendedproperty @name = N'PROVINCE CODE', @value = N'The ISO 3166-2, 2-character alpha code used by ISO and CPC to designate a province or territory in Canada.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'PROVINCE_CODE';


GO
EXECUTE sp_addextendedproperty @name = N'PROVINCE NUMBER', @value = N'Province number e.g. 24, 35.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'PROVINCE_NUMBER';


GO
EXECUTE sp_addextendedproperty @name = N'EFFECTIVE DATE', @value = N'The date the province code is effective.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'EFFECTIVE_DATE';


GO
EXECUTE sp_addextendedproperty @name = N'EXPIRY DATE', @value = N'The date the official province code and name expire.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'EXPIRY_DATE';


GO
EXECUTE sp_addextendedproperty @name = N'ENGLISH NAME', @value = N'The English full name of a Canadian province or territory.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'ENGLISH_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'FRENCH NAME', @value = N'The French full name of a Canadian province or territory.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'FRENCH_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'PROVINCE SEQUENCE NUMBER', @value = N'The CPC numeric code listing the province or territory''s position geographically.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'PROVINCE_SEQUENCE_NUMBER';


GO
EXECUTE sp_addextendedproperty @name = N'USER CREATED', @value = N'Database administrator audit stamp. The unique identifier of the person who created the record.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'USER_CREATED';


GO
EXECUTE sp_addextendedproperty @name = N'USER UPDATED', @value = N'Database administrator audit stamp. The unique identifier of the most recent user to modify the record.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'USER_UPDATED';


GO
EXECUTE sp_addextendedproperty @name = N'DATE CREATED', @value = N'Database administrator audit stamp. The date when the record was created.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'DATE_CREATED';


GO
EXECUTE sp_addextendedproperty @name = N'DATE UPDATED', @value = N'Database administrator audit stamp. The date on which the record was modified.', @level0type = N'SCHEMA', @level0name = N'HRSC', @level1type = N'TABLE', @level1name = N'PROVINCE', @level2type = N'COLUMN', @level2name = N'DATE_UPDATED';

