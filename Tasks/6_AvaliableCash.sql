USE [bankdb];

SELECT [client].[id],
(
	(
		SELECT SUM([account].[totalBalance])
		FROM [account]
		WHERE [account].[clientId] = [client].[id]
	) - 
	ISNULL((
		SELECT SUM([card].balance)
		FROM [card], [account]
		WHERE
			[client].[id] = [account].[clientId] AND
			[card].[accountId] = [account].[id]
	), 0)

) AS [cash]
FROM [client];