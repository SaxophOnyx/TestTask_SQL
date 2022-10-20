USE [bankdb];

SELECT
	[bank].[id],
	[bank].[name]
FROM [bank]
WHERE [bank].[id] = ANY (
	SELECT [branch].[bankId]
	FROM [branch]
	WHERE [branch].[cityId] = '00000000-0000-0000-0000-000000000002'
);