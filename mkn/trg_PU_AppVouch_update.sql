CREATE  TRIGGER trg_PU_AppVouch_update
ON PU_AppVouch 
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120) 
		DECLARE @itemname2 NVARCHAR(120) 
    SELECT DISTINCT  @itemname = citemname
    FROM fitemss01 f 
    WHERE f.citemcode  = (SELECT TOP 1  cdefine11 FROM inserted);
		SELECT @itemname2 = COALESCE(cdefine12,'X') FROM inserted;
    IF @itemname IS NOT NULL  AND @itemname <> @itemname2
    BEGIN
        UPDATE PU_AppVouch 
        SET cdefine12 = @itemname
        WHERE id in (SELECT DISTINCT  id FROM inserted);
    END
END;