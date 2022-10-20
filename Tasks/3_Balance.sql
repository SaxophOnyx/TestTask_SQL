USE [bankdb];

SELECT
    [account].[id],
	[account].[totalBalance] - (
	SELECT SUM([card].[balance])
	FROM [card]
	WHERE [card].[accountId] = [account].[id]
)
FROM [account]
WHERE [account].[totalBalance] <> (
	SELECT SUM([card].[balance])
	FROM [card]
	WHERE [card].[accountId] = [account].[id]
)