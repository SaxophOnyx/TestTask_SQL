CREATE TRIGGER [AccountOnBalanceUpdate]
ON [bankdb].[dbo].[account]
INSTEAD OF UPDATE
AS
BEGIN
	UPDATE [account]
	SET [totalBalance] = (
		SELECT [totalBalance]
		FROM [inserted]
		WHERE [inserted].[id] = [account].[id]
	)
	FROM [inserted]
	WHERE
		[account].[id] IN (SELECT [inserted].[id] FROM [inserted]) AND
		[inserted].[totalBalance] >= (
		SELECT [tmp].[sum]
		FROM (
			SELECT [account].id AS [accId], SUM([card].[balance]) AS [sum]
			FROM [card], [account]
			WHERE [card].[accountId] = [account].[id]
			GROUP BY [account].[id]
		) AS [tmp]
		WHERE [account].[id] = [tmp].[accId]
	)
END;