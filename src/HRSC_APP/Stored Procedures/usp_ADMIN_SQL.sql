








CREATE   PROCEDURE[HRSC_APP].[usp_ADMIN_SQL]
@SQLStatement nvarchar(MAX) 



WITH EXEC AS SELF
AS
EXEC sp_executesql @SQLStatement
