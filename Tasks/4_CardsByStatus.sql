USE [bankdb];

SELECT [status].[name], COUNT(*) AS [count]
FROM [card]
	LEFT JOIN [account] ON [account].[id] = [card].[accountId]
	LEFT JOIN [client] ON [client].id = [account].[clientId]
	LEFT JOIN [status] ON [status].[id] = [client].[statusId]
GROUP BY [status].[name]
GO


USE [bankdb];

SELECT [status].[name],
(
    SELECT COUNT(*)
	FROM [client], [account], [card]
	WHERE
	    [status].[id] = [client].[statusId] AND
		[client].[id] = [account].[clientId] AND
		[card].[accountId] = [account].[id]
) AS [count]
FROM [status]