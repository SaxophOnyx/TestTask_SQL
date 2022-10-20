USE [bankdb];

SELECT [status].[name], (
    SELECT COUNT(*)
	FROM
		[client],
		[account],
		[card]
	WHERE
	    [status].[id] = [client].[statusId] AND
		[client].[id] = [account].[clientId] AND
		[card].[accountId] = [account].[id]
) AS [count]
FROM [status]