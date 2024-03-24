CREATE  TRIGGER trg_Check_FDISQUANTITY
ON QMCHECKVOUCHER
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- 检查CDEFINE11是否非空且FDISQUANTITY不为0
    IF  EXISTS (SELECT 1
               FROM INSERTED
               WHERE CDEFINE11 IS NOT NULL AND FDISQUANTITY <> 0)
    BEGIN
        -- 如果条件满足，则抛出错误
        RAISERROR ('总经销产品的包材采购不能填写不合格数量！', 16, 1);
        -- 回滚当前的插入或更新操作
        --ROLLBACK TRANSACTION;
    END
END