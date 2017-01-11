DECLARE @Lines TABLE (Line NVARCHAR(MAX)) ;

DECLARE @FullText NVARCHAR(MAX) = '' ;

DROP TABLE IF EXISTS tbl_spstorage
CREATE TABLE tbl_spstorage (sprow int identity(1,1), spname nvarchar(200))

INSERT INTO  tbl_spstorage (spname)
SELECT name
  FROM dbo.sysobjects
 WHERE (type = 'P')
 and name like 'sp_help%'
 DECLARE @counter INT = 1


 DECLARE @maxint INT = (SELECT COUNT(*) FROM tbl_spstorage)
  WHILE @counter < @maxint
  Begin
 DECLARE @spname nvarchar(200) = (SELECT spname FROM tbl_spstorage WHERE sprow= @counter)
 INSERT @Lines EXEC sp_helptext @spname ;
 SELECT @FullText = @FullText + Line FROM @Lines 

PRINT @FullText 
SET @counter = @counter+1
END