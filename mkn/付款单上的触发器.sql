-- mssql数据库，在 Ap_CloseBill 表上加一个触发器。如果 cDefine8 = '是',则 cDefine11 不能为空；且需要根据 cDefine11 的值 到 fitemss01 中查询 citemcode 值 等于 cDefine11 的记录的 citemname 的值，赋值给 cDefine12

CREATE TRIGGER trg_ValidateAndAssignItemName
ON Ap_CloseBill
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(cDefine8) AND (SELECT cDefine8 FROM inserted) = '是'
    BEGIN
        -- 检查 cDefine11 是否为空
        IF (SELECT cDefine11 FROM inserted) IS NULL
        BEGIN
            RAISERROR('cDefine11 不能为空', 16, 1);
            ROLLBACK TRANSACTION;
        END

        -- 查询 fitemss01 表获取 citemname
        DECLARE @citemname NVARCHAR(100)
        SELECT TOP 1 @citemname = citemname
        FROM fitemss01
        WHERE citemcode = (SELECT cDefine11 FROM inserted);

        -- 如果查询到记录，则更新 cDefine12
        IF @citemname IS NOT NULL
					BEGIN
							-- 仅更新当前触发器操作的单据记录
							UPDATE Ap_CloseBill
							SET cDefine12 = @citemname
							FROM Ap_CloseBill AS ab
							INNER JOIN inserted AS i ON ab.[iID ] = i.[iID ]
							WHERE ab.cDefine8 = '是'
							AND ab.cDefine11 = i.cDefine11;
					END
    END
END

-- 把销售出库单备注带入到付款申请单表体