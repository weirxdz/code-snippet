-- 销售订单修改项目编码的自定义项后自动更新项目名称的自定义项
ALTER   TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120)

    SELECT @itemname = citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);

    IF @itemname IS NOT NULL  -- AND (SELECT cdefine12 FROM inserted) IS null
    BEGIN
        UPDATE so_somain
        SET cdefine12 = @itemname
        WHERE id = (SELECT id FROM inserted);
    END
END


-- 发货单修改项目编码的自定义项后自动更新项目名称的自定义项
ALTER   TRIGGER trg_DispatchList_update
ON DispatchList 
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120)

    SELECT @itemname = citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);

    IF @itemname IS NOT NULL  AND (SELECT cdefine12 FROM inserted) IS null
    BEGIN
        UPDATE DispatchList
        SET cdefine12 = @itemname
        WHERE DLID  = (SELECT DLID  FROM inserted);
    END
END


-- 其他出库单修改项目编码的自定义项后自动更新项目名称的自定义项
ALTER   TRIGGER trg_RdRecord09_update
ON RdRecord09 
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120)

    SELECT @itemname = citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);

    IF @itemname IS NOT NULL -- AND (SELECT cdefine12 FROM inserted) <> @itemname 
    BEGIN
        UPDATE RdRecord09
        SET cdefine12 = @itemname
        WHERE ID  = (SELECT ID  FROM inserted);
    END
END
;
SELECT citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = '20230164';

-- 生产订单修改项目编码的自定义项后自动更新项目名称的自定义项
ALTER   TRIGGER trg_mom_order_update
ON mom_order 
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120)

    SELECT @itemname = citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = (SELECT define11 FROM inserted);

    IF @itemname IS NOT NULL -- AND (SELECT define12 FROM inserted) IS null
    BEGIN
        UPDATE mom_order
        SET define12 = @itemname
        WHERE MoId   = (SELECT MoId   FROM inserted);
    END
END

-- 采购订单修改项目编码的自定义项后自动更新项目名称的自定义项
CREATE  TRIGGER trg_PO_Pomain_update
ON PO_Pomain 
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120)

    SELECT @itemname = citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);

    IF @itemname IS NOT NULL  AND (SELECT cdefine12 FROM inserted) IS null
    BEGIN
        UPDATE PO_Pomain
        SET cdefine12 = @itemname
        WHERE POID    = (SELECT POID FROM inserted);
    END
END


-- 收付款单表头有项目编码和名称，不用自定义项
-- 付款单修改项目编码的自定义项后自动更新项目名称的自定义项
--CREATE   TRIGGER trg_Ap_CloseBill_update
--ON Ap_CloseBill 
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    DECLARE @itemname NVARCHAR(120)
--
--    SELECT @itemname = citemname
--    FROM fitemss00 f 
--    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);
--
--    IF @itemname IS NOT NULL
--    BEGIN
--        UPDATE Ap_CloseBill
--        SET cdefine12 = @itemname
--        WHERE iID  = (SELECT iID  FROM inserted);
--    END
--END

-- 付款单子表项目信息维护；收付款单的表体可能会是多个项目，所以这里不用触发器从表头向表体带项目；手工选择表头表体的项目
--CREATE TRIGGER trg_Ap_CloseBills_update
--ON Ap_CloseBills  
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    DECLARE @voucherId INT, @itemCode NVARCHAR(10), @itemName NVARCHAR(120), @headItemCode NVARCHAR(10)
--		set @voucherId = SELECT DISTINCT iID  FROM inserted;
--		SELECT  FROM Ap_CloseBill WHERE iID = @voucherId 
--    SELECT @itemname = citemname
--    FROM fitemss00 f 
--    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);
--
--    IF @itemname IS NOT NULL
--    BEGIN
--        UPDATE Ap_CloseBill
--        SET cdefine12 = @itemname
--        WHERE iID  = (SELECT iID  FROM inserted);
--    END
--END