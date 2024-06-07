-- 收入凭证查询
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,g.md 借方金额,g.mc 贷方金额,g.cdigest 摘要,f.citemcode ,f.citemname 
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6001','6011','6021','6051','6301') 
	AND g.cdigest <> '期间损益结转' 
	AND g.mc <> 0
	AND g.iyear = 2024 AND g.iperiod = 3
;
-- 非正常项目的收入凭证查询，非正常项目指无项目和项目编码为 0100001 、0100099 的项目,其中，0100099 为电商通用项目，不计入
SELECT  g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.mc 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6001','6011','6021','6051','6301') 
	AND g.cdigest <> '期间损益结转' 
	AND g.mc <> 0
	AND (g.citem_id IS NULL OR g.citem_id = '0100001')
	AND g.iyear = 2024 
;
-- 正常项目的收入凭证查询，正常项目指项目编码非空且项目编码不是为 0100001 、0100099 的项目
SELECT g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.mc 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6001','6011','6021','6051','6301') 
	AND g.cdigest <> '期间损益结转' 
	AND g.mc <> 0
	AND g.citem_id IS NOT NULL AND  g.citem_id NOT IN ('0100099','0100001') 
	AND g.iyear = 2024 
;
-- 创建正常收入表
CREATE TABLE FR_6001_usual (
    autoid INT IDENTITY(1,1),
    i_id INT, -- 凭证主键
    iyear INT, -- 年度
    iperiod INT, -- 月份
    ino_id INT, -- 凭证号
    ccode VARCHAR(20), -- 科目代码
    citemcode VARCHAR(20), -- 项目代码
    citemname VARCHAR(120), -- 项目名称
    amount DECIMAL(18,4), -- 金额
    cdigest VARCHAR(255) -- 摘要
);
-- 插入正常收入查询结果
INSERT INTO FR_6001_usual (i_id, iyear, iperiod, ino_id, ccode, citemcode, citemname, amount, cdigest)
SELECT 
    g.i_id,
    g.iyear,
    g.iperiod,
    g.ino_id,
    g.ccode,
    f.citemcode,
    f.citemname,
    g.mc 金额,
    g.cdigest
FROM 
    GL_accvouch g
LEFT JOIN 
    fitemss00 f ON g.citem_id = f.citemcode
WHERE 
    LEFT(g.ccode,4) IN ('6001','6011','6021','6051','6301') 
    AND g.cdigest <> '期间损益结转' 
    AND g.mc <> 0
    AND g.citem_id IS NOT NULL 
    AND g.citem_id NOT IN ('0100099','0100001') 
    AND g.iyear = 2024
    ;
-- 创建非正常收入表
   CREATE TABLE FR_6001_unusual (
    autoid INT IDENTITY(1,1),
    i_id INT, -- 凭证主键
    iyear INT, -- 年度
    iperiod INT, -- 月份
    ino_id INT, -- 凭证号
    ccode VARCHAR(20), -- 科目代码
    citemcode VARCHAR(20), -- 项目代码
    citemname VARCHAR(120), -- 项目名称
    amount DECIMAL(18,4), -- 金额
    cdigest VARCHAR(255) -- 摘要
);
-- 插入非正常收入查询结果
INSERT INTO FR_6001_unusual (i_id, iyear, iperiod, ino_id, ccode, citemcode, citemname, amount, cdigest)
SELECT 
    g.i_id,
    g.iyear,
    g.iperiod,
    g.ino_id,
    g.ccode,
    f.citemcode,
    f.citemname,
    g.mc,
    g.cdigest
FROM 
    GL_accvouch g
LEFT JOIN 
    fitemss00 f ON g.citem_id = f.citemcode
WHERE 
    LEFT(g.ccode,4) IN ('6001','6011','6021','6051','6301') 
    AND g.cdigest <> '期间损益结转' 
    AND g.mc <> 0
    AND (g.citem_id IS NULL OR g.citem_id = '0100001')
    -- AND g.iyear = 2024
   ;
-- 项目
SELECT* FROM fitemss00 f 
;
-- 非正常项目的成本凭证查询，非正常项目指无项目和项目编码为 0100001 、0100099 的项目,其中，0100099 为电商通用项目，不计入
SELECT  g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6401','6402') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND (g.citem_id IS NULL OR g.citem_id = '0100001')
	AND g.iyear = 2024 
;
-- 正常项目的成本凭证查询，正常项目指项目编码非空且项目编码不是为 0100001 、0100099 的项目
SELECT g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6401','6402') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND g.citem_id IS NOT NULL AND  g.citem_id NOT IN ('0100099','0100001') 
	AND g.iyear = 2024 
;
-- 创建正常成本表
CREATE TABLE FR_6401_usual (
    autoid INT IDENTITY(1,1),
    i_id INT, -- 凭证主键
    iyear INT, -- 年度
    iperiod INT, -- 月份
    ino_id INT, -- 凭证号
    ccode VARCHAR(20), -- 科目代码
    citemcode VARCHAR(20), -- 项目代码
    citemname VARCHAR(120), -- 项目名称
    amount DECIMAL(18,4), -- 金额
    cdigest VARCHAR(255) -- 摘要
);
-- 插入正常成本查询结果
INSERT INTO FR_6401_usual (i_id, iyear, iperiod, ino_id, ccode, citemcode, citemname, amount, cdigest)
SELECT g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6401','6402') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND g.citem_id IS NOT NULL AND  g.citem_id NOT IN ('0100099','0100001') 
    ;
-- 创建非正常成本表
   CREATE TABLE FR_6401_unusual (
    autoid INT IDENTITY(1,1),
    i_id INT, -- 凭证主键
    iyear INT, -- 年度
    iperiod INT, -- 月份
    ino_id INT, -- 凭证号
    ccode VARCHAR(20), -- 科目代码
    citemcode VARCHAR(20), -- 项目代码
    citemname VARCHAR(120), -- 项目名称
    amount DECIMAL(18,4), -- 金额
    cdigest VARCHAR(255) -- 摘要
);
-- 插入非正常成本查询结果
INSERT INTO FR_6401_unusual (i_id, iyear, iperiod, ino_id, ccode, citemcode, citemname, amount, cdigest)
SELECT  g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6401','6402') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND (g.citem_id IS NULL OR g.citem_id = '0100001')
   ;
   

-- 非正常项目的费用凭证查询，非正常项目指无项目和项目编码为 0100001 、0100099 的项目,其中，0100099 为电商通用项目，不计入
SELECT  g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6601','6602') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND (g.citem_id IS NULL OR g.citem_id = '0100001')
	AND g.iyear = 2024 
;
-- 正常项目的费用凭证查询，正常项目指项目编码非空且项目编码不是为 0100001 、0100099 的项目
SELECT g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6601','6602') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND g.citem_id IS NOT NULL AND  g.citem_id NOT IN ('0100099','0100001') 
	AND g.iyear = 2024 
;
-- 创建正常费用表
CREATE TABLE FR_6601_usual (
    autoid INT IDENTITY(1,1),
    i_id INT, -- 凭证主键
    iyear INT, -- 年度
    iperiod INT, -- 月份
    ino_id INT, -- 凭证号
    ccode VARCHAR(20), -- 科目代码
    citemcode VARCHAR(20), -- 项目代码
    citemname VARCHAR(120), -- 项目名称
    amount DECIMAL(18,4), -- 金额
    cdigest VARCHAR(255) -- 摘要
);
-- 插入正常费用查询结果
INSERT INTO FR_6601_usual (i_id, iyear, iperiod, ino_id, ccode, citemcode, citemname, amount, cdigest)
SELECT g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6601','6602') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND g.citem_id IS NOT NULL AND  g.citem_id NOT IN ('0100099','0100001') 
    ;
-- 创建非正常费用表
   CREATE TABLE FR_6601_unusual (
    autoid INT IDENTITY(1,1),
    i_id INT, -- 凭证主键
    iyear INT, -- 年度
    iperiod INT, -- 月份
    ino_id INT, -- 凭证号
    ccode VARCHAR(20), -- 科目代码
    citemcode VARCHAR(20), -- 项目代码
    citemname VARCHAR(120), -- 项目名称
    amount DECIMAL(18,4), -- 金额
    cdigest VARCHAR(255) -- 摘要
);
-- 插入非正常费用查询结果
INSERT INTO FR_6601_unusual (i_id, iyear, iperiod, ino_id, ccode, citemcode, citemname, amount, cdigest)
SELECT  g.i_id 凭证主键,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode ,f.citemcode ,f.citemname ,g.md 金额,g.cdigest 摘要
FROM GL_accvouch g
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6601','6602') 
	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND (g.citem_id IS NULL OR g.citem_id = '0100001')
   ;

WITH a AS (--项目收入汇总
		SELECT DISTINCT  f.citemcode ,f.citemname ,sum(f.amount) over(PARTITION BY f.citemcode ,f.citemname) 收入,sum(f.amount) over() 总收入  
		FROM FR_6001_usual f
		WHERE f.dDate >= '${开始日期}' AND f.dDate <= '${截至日期}'
	),
	b  AS (--项目成本汇总 
		SELECT f.citemcode ,f.citemname ,sum(f.amount) 成本  
		FROM FR_6401_usual f 
		WHERE f.dDate >= '${开始日期}' AND f.dDate <= '${截至日期}'
		GROUP BY f.citemcode ,f.citemname 
	),
	b1 AS (--无项目成本汇总 
		SELECT sum(f.amount) 成本  
		FROM FR_6401_unusual f 
		WHERE f.dDate >= '${开始日期}' AND f.dDate <= '${截至日期}'
	),
	c  AS (--项目费用汇总 
		SELECT f.citemcode ,f.citemname ,sum(f.amount) 费用  
		FROM FR_6601_usual f 
		WHERE f.dDate >= '${开始日期}' AND f.dDate <= '${截至日期}'
		GROUP BY f.citemcode ,f.citemname 
	),
	c1 AS (--无项目费用汇总 
		SELECT sum(f.amount) 费用  
		FROM FR_6601_unusual f 
		WHERE f.dDate >= '${开始日期}' AND f.dDate <= '${截至日期}'
	),
	lt AS (-- 项目列表
		SELECT a.citemcode ,a.citemname FROM a
		UNION 
		SELECT b.citemcode ,b.citemname FROM b
		UNION 
		SELECT c.citemcode ,c.citemname FROM c		
	)
	SELECT lt.citemcode ,lt.citemname,a.收入,a.总收入,b.成本,b1.成本 待摊成本,c.费用,c1.费用 待摊费用
	FROM lt 
	LEFT JOIN a ON lt.citemcode = a.citemcode
	LEFT JOIN b ON lt.citemcode = b.citemcode
	LEFT JOIN c ON lt.citemcode = c.citemcode
	LEFT JOIN b1 ON 1=1 
	LEFT JOIN c1 ON 1=1 
	
;
SELECT f.citemcode ,f.citemname ,sum(f.amount) 收入,sum(f.amount) over() 总收入  FROM FR_6001_usual f GROUP BY f.citemcode ,f.citemname;
SELECT DISTINCT  f.citemcode ,f.citemname ,sum(f.amount) over(PARTITION BY f.citemcode ,f.citemname) 收入,sum(f.amount) over() 总收入  FROM FR_6001_usual f
;
SELECT sum(f.amount) 费用  FROM FR_6601_usual f 
;
SELECT  t.autoid, t.i_id, t.iyear, t.iperiod, t.ino_id, t.ccode,c.ccode_name , t.citemcode, t.citemname, t.amount, t.cdigest,t.ddate
FROM fr_6601_unusual t
INNER JOIN code c ON t.ccode = c.ccode AND t.iyear = c.iyear 
;

ALTER TABLE UFDATA_001_2023.dbo.FR_6001_unusual ADD ddate varchar(23) NULL;
ALTER TABLE UFDATA_001_2023.dbo.FR_6001_usual ADD ddate varchar(23) NULL;
ALTER TABLE UFDATA_001_2023.dbo.FR_6401_unusual ADD ddate varchar(23) NULL;
ALTER TABLE UFDATA_001_2023.dbo.FR_6401_usual ADD ddate varchar(23) NULL;
ALTER TABLE UFDATA_001_2023.dbo.FR_6601_unusual ADD ddate varchar(23) NULL;
ALTER TABLE UFDATA_001_2023.dbo.FR_6601_usual ADD ddate varchar(23) NULL;
--更新日期
	UPDATE FR_6001_unusual
	SET ddate = CONVERT(varchar(100),GL_accvouch.dbill_date, 23) 
	FROM FR_6001_unusual
	INNER JOIN GL_accvouch ON FR_6001_unusual.i_id = GL_accvouch.i_id 
	;
	UPDATE FR_6001_usual
	SET ddate = CONVERT(varchar(100),GL_accvouch.dbill_date, 23) 
	FROM FR_6001_usual
	INNER JOIN GL_accvouch ON FR_6001_usual.i_id = GL_accvouch.i_id 
	;
	UPDATE FR_6401_unusual
	SET ddate = CONVERT(varchar(100),GL_accvouch.dbill_date, 23) 
	FROM FR_6401_unusual
	INNER JOIN GL_accvouch ON FR_6401_unusual.i_id = GL_accvouch.i_id 
	;
	UPDATE FR_6401_usual
	SET ddate = CONVERT(varchar(100),GL_accvouch.dbill_date, 23) 
	FROM FR_6401_usual
	INNER JOIN GL_accvouch ON FR_6401_usual.i_id = GL_accvouch.i_id 
	;
	UPDATE FR_6601_unusual
	SET ddate = CONVERT(varchar(100),GL_accvouch.dbill_date, 23) 
	FROM FR_6601_unusual
	INNER JOIN GL_accvouch ON FR_6601_unusual.i_id = GL_accvouch.i_id 
	;
	UPDATE FR_6601_usual
	SET ddate = CONVERT(varchar(100),GL_accvouch.dbill_date, 23) 
	FROM FR_6601_usual
	INNER JOIN GL_accvouch ON FR_6601_usual.i_id = GL_accvouch.i_id 
	;
	

SELECT g.iyear 年度,g.iperiod 月份,g.ccode 科目,c.ccode_name ,g.md 金额,g.cdigest ,g.citem_id 
	FROM GL_accvouch g
	INNER JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
	WHERE g.ccode IN ('660216','660217','660218','660219','660220','660221','660222','660223','660224','660225','660226','660229') 
	AND g.cdigest <> '期间损益结转'
	AND COALESCE(g.iflag,0) <> 1
	AND (g.citem_id IS  NULL OR g.citem_id = '0100001')
	ORDER BY g.iyear ,g.iperiod ,g.ccode
	
SELECT g.iyear 年度,g.iperiod 月份,g.ccode 科目,c.ccode_name ,g.md 金额,g.cdigest ,g.citem_id 
	FROM GL_accvouch g
	INNER JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
	WHERE g.ccode IN ('660216','660217','660218','660219','660220','660221','660222','660223','660224','660225','660226','660229') 
	AND g.cdigest <> '期间损益结转'
	AND COALESCE(g.iflag,0) <> 1
	AND (g.citem_id = '0100001' or g.citem_id IS  NULL )
	AND CONVERT(varchar,g.dbill_date , 23) >= '2023-12-01' AND CONVERT(varchar,g.dbill_date , 23) <= '2024-04-30'