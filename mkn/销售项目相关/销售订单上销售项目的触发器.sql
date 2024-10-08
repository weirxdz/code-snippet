alter  TRIGGER trg_so_somain_update
ON so_somain
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
        UPDATE so_somain
        SET cdefine12 = @itemname
        WHERE id in (SELECT DISTINCT  id FROM inserted);
    END
END;

SELECT t.cSOCode ,t.cDefine11 ,t.cdefine12 ,f.citemname 
FROM so_somain t 
LEFT JOIN fitemss01 f ON t.cDefine11 = f.citemcode 
WHERE t.cdefine12 <> f.citemname ;
SELECT t.cSOCode ,t.cDefine11 ,t.cdefine12 ,f.citemname 
FROM so_somain t 
LEFT JOIN fitemss01 f ON t.cDefine11 = f.citemcode 
WHERE t.cSOCode = 'XSDD2024010600050' ;

--UPDATE so_somain 
--SET cDefine12 = '1' 
--WHERE cSOCode in(SELECT t.cSOCode
--		FROM so_somain t 
--		LEFT JOIN fitemss01 f ON t.cDefine11 = f.citemcode 
--		WHERE t.cdefine12 <> f.citemname ) 
--;

-- 江浙分公司参照账套生成新账套的时候没有结转基本档案，所以销售项目用的表不是 fitemss01，单据不多，在后台直接改过来吧
SELECT t.cSOCode ,t.cDefine11 ,t.cdefine12 ,f.citemname 
FROM so_somain t 
LEFT JOIN fitemss00 f ON t.cDefine11 = f.citemcode 
WHERE t.cdefine12 <> f.citemname ;
SELECT t.cSOCode ,t.cDefine11 ,t.cdefine12 ,f.citemname 
FROM so_somain t 
LEFT JOIN fitemss00 f ON t.cDefine11 = f.citemcode 
WHERE t.cSOCode = 'XSDD2024010600050' ;

--UPDATE so_somain 
--SET cDefine12 = '1' 
--WHERE cSOCode in(SELECT t.cSOCode
--		FROM so_somain t 
--		LEFT JOIN fitemss00 f ON t.cDefine11 = f.citemcode 
--		WHERE t.cdefine12 <> f.citemname ) 
--;
-- 付款申请单
SELECT h.pid,h.cVouchID,h.cdefine11,h.cdefine12 ,h.cItemCode,h.cItemName,h.cItem_Class,b.cItemCode ,b.cItemName ,b.cItem_Class 
FROM AP_ApplyPayVouch h
INNER JOIN AP_ApplyPayVouchs b ON h.PID = b.PID 
WHERE h.cdefine11 IS NOT NULL 
;
CREATE  TRIGGER trg_so_somain_update
ON AP_ApplyPayVouch
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
        UPDATE so_somain
        SET cdefine12 = @itemname
        WHERE id in (SELECT DISTINCT  id FROM inserted);
    END
END;
-- 更新付款申请单项目
UPDATE h 
SET h.cDefine12 = f.citemname ,h.cItemCode = h.cDefine11 ,h.cItemName = f.citemname,h.cItem_Class = '01'
FROM AP_ApplyPayVouch h
LEFT JOIN fitemss01 f ON h.cdefine11 = f.citemcode
WHERE h.cDefine11 IS NOT NULL 
;
SELECT * FROM fitemss01 f 