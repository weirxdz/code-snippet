CREATE  TRIGGER trg_AfterInsertQMCHECKVOUCHER
ON QMCHECKVOUCHER
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    -- 声明变量用于存储从QMINSPECTVOUCHERS表中查询到的cDefine28值
    DECLARE @cDefine28Value NVARCHAR(60);
    DECLARE @INSPECTAUTOID INT;
    -- 从插入的记录中获取INSPECTAUTOID值
    SELECT @INSPECTAUTOID = i.INSPECTAUTOID
    FROM INSERTED i;
    -- 查询QMINSPECTVOUCHERS表中的cDefine28值
    SELECT @cDefine28Value = cv.cDefine28
    FROM QMINSPECTVOUCHERS cv
    WHERE cv.AUTOID = @INSPECTAUTOID;
    -- 检查cDefine28值是否非空且唯一
    IF @cDefine28Value IS NOT NULL AND @cDefine28Value <> ''
    BEGIN
        -- 检查cDefine28值是否唯一
        IF (SELECT COUNT(*)
            FROM QMINSPECTVOUCHERS qiv
            WHERE qiv.cDefine28 = @cDefine28Value and qiv.autoid = @INSPECTAUTOID
           ) = 1
        BEGIN
            -- 如果唯一，则更新QMCHECKVOUCHER表的CDEFINE11列
            UPDATE qmv
            SET qmv.CDEFINE11 = @cDefine28Value
            FROM QMCHECKVOUCHER qmv
            INNER JOIN INSERTED i ON qmv.id = i.id
            WHERE i.INSPECTAUTOID = @INSPECTAUTOID;
        END
        ELSE
        BEGIN
            -- 如果不唯一，则抛出错误
            RAISERROR ('cDefine28 value is not unique for INSPECTAUTOID %d.', 16, 1, @INSPECTAUTOID);
        END
    END
END