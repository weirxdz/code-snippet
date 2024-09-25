CREATE TRIGGER trg_CheckOrgName
ON SO_SOMain
AFTER INSERT, UPDATE
AS
BEGIN
    -- 声明变量用于存储不满足条件的 cDefine14 值
    DECLARE @InvalidValue NVARCHAR(MAX);
    
    -- 检查插入或更新的 cDefine14 字段值是否在 RS_OrgList 表的 CNAME 字段范围内
    -- 并且只检查 DocDate 在 2024-09-01 之后的记录
    IF NOT EXISTS (
        SELECT i.cDefine14
        FROM inserted i
        WHERE i.ddate > '2024-07-01'
          AND EXISTS (
              SELECT 1
              FROM FR_RS.dbo.RS_OrgList r
              WHERE r.CNAME = i.cDefine14
          )
    )
    BEGIN
        -- 选择不满足条件的 cDefine14 值
        SELECT @InvalidValue = STRING_AGG(i.cDefine14, ', ')
        FROM inserted i
        WHERE i.DDate > '2024-07-01';

        -- 如果存在不满足条件的 cDefine14 值，抛出错误
        IF @InvalidValue IS NOT NULL
        BEGIN
            RAISERROR ('：表头销售公司算填写的值  value(s) %s 不符合规范，请重新填写。', 16, 1, @InvalidValue);
        END
    END
END