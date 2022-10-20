USE [bankdb];

DECLARE @accId UNIQUEIDENTIFIER;
DECLARE @cardId UNIQUEIDENTIFIER;
DECLARE @sum INT;

SET @accId = '00000000-0000-0000-0000-000000000051';
SET @cardId = '00000000-0000-0000-0000-000000000061';
SET @sum = 10;

SELECT
	[account].[id] AS [accountId],
	[card].[balance] AS [cardBalance],
	[account].[totalBalance]
FROM
	[card],
	[account]
WHERE [card].[accountId] = [account].[id];

EXEC [PerformAccountTransaction] @accId, @cardId, @sum;

SELECT
	[account].[id] AS [accountId],
	[card].[balance] AS [cardBalance],
	[account].[totalBalance]
FROM
	[card],
	[account]
WHERE [card].[accountId] = [account].[id];