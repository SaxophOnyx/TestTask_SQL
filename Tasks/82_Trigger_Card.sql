CREATE TRIGGER [CardOnBalanceUpdate]
ON [bankdb].[dbo].[card]
INSTEAD OF UPDATE
AS
BEGIN
	UPDATE [card]
	SET [balance] = (
		SELECT [balance]
		FROM [inserted]
		WHERE [inserted].[id] = [card].[id]
	)
	FROM [inserted], [account]
	WHERE
		[card].[id] IN (SELECT [inserted].[id] FROM [inserted]) AND (SELECT [account].[totalBalance] FROM [account] WHERE [card].[accountId] = [account].id) >= (
			(SELECT [curr].[sum]
			FROM (
				SELECT [account].[id] AS [accId], SUM([card].[balance]) AS [sum]
				FROM [card], [account]
				WHERE [card].[accountId] = [account].[id]
				GROUP BY [account].[id]
			) AS [curr]
			WHERE [account].[id] = [curr].[accId]) - (
				SELECT [prev].[sum]
				FROM (
					SELECT [account].[id] AS [accId], SUM([deleted].[balance]) AS [sum]
					FROM [account], [deleted]
					WHERE [deleted].[accountId] = [account].[id]
					GROUP BY [account].[id]
				) AS [prev]
				WHERE [account].[id] = [prev].[accId]) + (
					SELECT [next].[sum]
					FROM (
						SELECT [account].[id] AS [accId], SUM([inserted].[balance]) AS [sum]
						FROM [account], [inserted]
						WHERE [inserted].[accountId] = [account].[id]
						GROUP BY [account].[id]
					) AS [next]
					WHERE [account].[id] = [next].[accId]
				)
			)
END;