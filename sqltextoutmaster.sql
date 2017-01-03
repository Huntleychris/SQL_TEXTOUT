CREATE TABLE tbl_spstorage (sprow int identity(1,1), spname nvarchar(200))

INSERT INTO  tbl_spstorage (spname)
SELECT name
  FROM dbo.sysobjects
 WHERE (type = 'P')
 and name like 'sp_help%'
 DECLARE @counter INT = 1
 DECLARE @maxint INT = (SELECT COUNT(*) FROM tbl_spstorage)

 CREATE TABLE spoutput (rownumber int identity(1,1) ,sptext varchar(max))
 WHILE @counter <= @maxint
 BEGIN
 INSERT INTO spoutput (sptext)
 EXEC sp_helptext sp_helptext
 SET @counter = @maxint
 END

 SELECT * FROM spoutput

 DECLARE @rowcounter int = 1
DECLARE @OutputFile NVARCHAR(100) ,    @FilePath NVARCHAR(100) ,    @bcpCommand NVARCHAR(1000)
DECLARE @spname nvarchar(200)


SET @spname = (SELECT spname from  tbl_spstorage where sprow =1)
 
SET @bcpCommand = 'bcp "SELECT sptext from  spoutput where rownumber = @counter  " queryout '
SET @FilePath = 'D:\somanyfiles\'
SET @OutputFile = @spname + '.txt'
SET @bcpCommand = @bcpCommand + @FilePath + @OutputFile + ' -c -t, -T -S'+ @@servername
exec master..xp_cmdshell @bcpCommand


DROP TABLE  tbl_spstorage
DROP TABLE spoutput