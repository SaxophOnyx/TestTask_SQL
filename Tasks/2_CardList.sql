USE [bankdb];

SELECT
	[card].[balance],
	[client].[name] AS [clientName],
	[bank].[name] AS [bankName]
FROM [card]
	JOIN [account] ON [card].[accountId] = [account].[id]
	JOIN [client] ON [account].[clientId] = [client].[id]
	JOIN [bank] ON [account].[bankId] = [bank].[id]