CREATE PROCEDURE [dbo].[UpdateSoDetailsItemCode]
AS
BEGIN
    -- 声明变量
    DECLARE @voucherId INT, @itemCode NVARCHAR(10), @itemName NVARCHAR(100), @headItemCode NVARCHAR(10)

    -- 打开游标
    DECLARE v_cursor CURSOR FOR
    SELECT distinct id, cItemCode
    FROM SO_SODetails  t
    WHERE cItemCode IS NULL or cItemCode = ''
    -- 打开游标
    OPEN v_cursor
    -- 获取游标中的数据
    FETCH NEXT FROM v_cursor INTO @voucherId, @itemCode
    -- 循环遍历游标中的数据
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- 取销售订单表头项目编码,表头自定义项11
	    	SELECT @headItemCode = isnull(cdefine11,'0100001') FROM SO_SOMain  WHERE ID = @voucherId;
	    	-- 取项目名称
	    	SELECT @itemname = citemname
		    FROM fitemss00 f 
		    WHERE f.citemcode  = @headItemCode;
	    	-- 更新SO_SODetails表中的cItemCode字段
        UPDATE SO_SODetails
        SET cItemCode = @headItemCode,citemname = @itemname,cItem_CName = '销售项目' ,cItem_class = '01'
        WHERE id = @voucherId
        -- 获取下一个数据
        FETCH NEXT FROM v_cursor INTO @voucherId, @itemCode
    END
    -- 关闭游标
    CLOSE v_cursor
    -- 释放游标资源
    DEALLOCATE v_cursor
END