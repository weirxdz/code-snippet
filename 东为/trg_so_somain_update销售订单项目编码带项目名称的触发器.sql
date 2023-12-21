-- 修改项目编码的自定义项后自动更新项目名称的自定义项
CREATE   TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120)

    SELECT @itemname = citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);

    IF @itemname IS NOT NULL
    BEGIN
        UPDATE so_somain
        SET cdefine12 = @itemname
        WHERE id = (SELECT id FROM inserted);
    END
END
