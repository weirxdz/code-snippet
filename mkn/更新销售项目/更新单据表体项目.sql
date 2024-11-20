/**
 * done 1、更新各公司销售订单表体销售项目【触发器、存储过程】
 * 2、更新各公司销售发货单表体销售项目
 * 3、更新各公司销售出库单表体销售项目
 * 4、更新各公司销售发票表体销售项目
 * 5、更新各公司应收明细账、存货明细账、发出商品明细账
 */
-- 1、更新各公司销售订单表体销售项目【触发器、存储过程】
--100 迈凯诺公司
USE UFDATA_100_2024;
ALTER  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE h.cSOCode = 'XSDD2024010100051'
--h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
SELECT * FROM SO_SODetails b WHERE b.cItem_class = '01'
--UPDATE SO_SOMain SET csocode = 'XSDD2024010100051' WHERE cSOCode = 'XSDD202401010005'
;
SELECT f.citemname FROM UFDATA_100_2024.dbo.fitemss01 f WHERE f.citemcode = '0187'
--400 华筑公司
USE UFDATA_400_2024;
ALTER  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
--UPDATE SO_SOMain SET csocode = 'XSDD2024010100051' WHERE cSOCode = 'XSDD202401010005'
SELECT f.citemname FROM UFDATA_400_2024.dbo.fitemss01 f
;
--500 防火公司
USE UFDATA_500_2024;
ALTER  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
--h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
h.cSOCode = '0000000070'
;
SELECT f.citemname FROM UFDATA_500_2024.dbo.fitemss01 f WHERE f.citemcode = '0270'
;
--510 深圳防火公司
USE UFDATA_510_2024;
create  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
SELECT f.citemname FROM UFDATA_510_2024.dbo.fitemss01 f
;

--600 耐火公司
USE UFDATA_600_2024;
alter  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
SELECT f.citemname FROM UFDATA_600_2024.dbo.fitemss01 f
;


--610 四川耐火公司
USE UFDATA_610_2024;
create  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
SELECT f.citemname FROM UFDATA_610_2024.dbo.fitemss01 f
;

--700 众诺
USE UFDATA_700_2024;
alter  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
SELECT f.citemname FROM UFDATA_700_2024.dbo.fitemss01 f WHERE f.citemcode = '0100001'
;

--800 江浙
USE UFDATA_800_2024;
alter  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120) 
		DECLARE @itemname2 NVARCHAR(120) 
    SELECT DISTINCT  @itemname = citemname
    FROM fitemss00 f 
    WHERE f.citemcode  = (SELECT TOP 1  cdefine11 FROM inserted);
		SELECT @itemname2 = COALESCE(cdefine12,'X') FROM inserted;
    IF @itemname IS NOT NULL  AND @itemname <> @itemname2
    BEGIN
        UPDATE so_somain
        SET cdefine12 = @itemname
        WHERE id in (SELECT DISTINCT  id FROM inserted);
    END
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
SELECT f.citemname FROM UFDATA_800_2024.dbo.fitemss00 f --WHERE f.citemcode = '0100001'
;

--900 西部
USE UFDATA_900_2024;
alter  TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT,UPDATE
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
    EXEC UpdateSoDetailsItemCode;
END;
-- 
-- 查询销售订单表头项目与表体项目不一致的记录
SELECT h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE --h.cSOCode = 'XSDD2024010100051'
h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;
SELECT f.citemname FROM UFDATA_900_2024.dbo.fitemss01 f --WHERE f.citemcode = '0100001'
;