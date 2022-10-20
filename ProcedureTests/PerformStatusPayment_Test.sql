USE [bankdb];

DECLARE @statusId UNIQUEIDENTIFIER;
SET @statusId = '00000000-0000-0000-0000-000000000035';

SELECT
	[account].[id] AS [accountId],
	[client].[id] AS [clientId],
	[status].[id] AS [statusId],
	[account].[totalBalance]
FROM [account]
	LEFT JOIN [client] ON [client].[id] = [account].[clientId]
	LEFT JOIN [status] ON [status].[id] = [client].[statusId];

EXEC [PerformStatusPayment] @statusId;

SELECT
	[account].[id] AS [accountId],
	[client].[id] AS [clientId],
	[status].[id] AS [statusId],
	[account].[totalBalance]
FROM [account]
	LEFT JOIN [client] ON [client].[id] = [account].[clientId]
	LEFT JOIN [status] ON [status].[id] = [client].[statusId];