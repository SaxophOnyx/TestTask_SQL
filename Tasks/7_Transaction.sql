USE [bankdb];
GO

DROP PROCEDURE PerformAccountTransaction;
GO

CREATE PROCEDURE PerformAccountTransaction
	@accId AS UNIQUEIDENTIFIER,
	@cardId AS UNIQUEIDENTIFIER,
	@sum AS INT
AS
BEGIN
	BEGIN TRANSACTION
		IF @accID NOT IN (SELECT [account].[id] FROM [account])
			THROW 51000, 'Account not found', 1;

		IF @cardId NOT IN (SELECT [card].[id] FROM [card] WHERE [card].[accountId] = @accId)
			THROW 51001, 'Card not found', 1;

		IF ((SELECT [account].[totalBalance] FROM [account] WHERE [account].[id] = @accId) - @sum) <
		   (SELECT SUM([card].[balance]) FROM [card] WHERE [card].[accountId] = @accId)
			THROW 51002, 'Not enough balance', 1;
   
		UPDATE [card]
		SET [card].[balance] = [card].[balance] + @sum
		WHERE [card].[id] = @cardId;

		IF @@ERROR <> 0
			ROLLBACK;
	COMMIT;
END;