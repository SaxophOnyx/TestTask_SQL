USE [bankdb];
GO

CREATE PROCEDURE [PerformStatusPayment]
	@statusId UNIQUEIDENTIFIER
AS
BEGIN
	IF @statusId NOT IN (SELECT [status].[id] FROM [status])
		THROW 51000, 'Status Not Found', 1;

	UPDATE [account]
	SET [totalBalance] = [totalBalance] + 10
	WHERE [account].[id] IN (
		SELECT [account].[id]
		FROM
			[account],
			[client]
		WHERE
			[client].[statusId] = @statusId AND
			[account].[clientId] = [client].[id]
	);
END;