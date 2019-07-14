DECLARE @Backup NVARCHAR(400)
SET @Backup=CONCAT('D:\MP\BackUp\TicketClosed-',(FORMAT(GETDATE(),'yyyy-MM-dd-hh-mm-ss-tt')),'.bak')
BACKUP DATABASE [POS_Test][TicketClosed] TO  DISK = @Backup
WITH NOFORMAT, NOINIT,  NAME = N'POS_Test-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


-- idf does not work take out ticket closed part