create TRIGGER trg_CheckQuantityMatch
ON PU_ArrivalVouchs
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- 声明一个变量用于存储错误消息
    DECLARE @ErrorMessage NVARCHAR(255);

    -- 检查是否存在cDefine28非空且iQuantity超订单的记录
    IF EXISTS (
        SELECT 1
        FROM PU_ArrivalVouchs a
        INNER JOIN PO_Podetails b ON a.iPOsID = b.ID
        WHERE a.cDefine28 IS NOT NULL
        AND a.iQuantity > b.iQuantity
    )
    BEGIN
        -- 设置错误消息
        SET @ErrorMessage = '到货单数量超订单数量了，请检查.';
        -- 抛出错误
        RAISERROR(@ErrorMessage, 16, 1);
        -- 回滚事务以撤销更改；不用回滚事务了。
        -- ROLLBACK TRANSACTION;
    END
END