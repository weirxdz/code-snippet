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