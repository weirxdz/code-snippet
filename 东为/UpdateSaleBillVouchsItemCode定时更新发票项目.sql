-- 创建存储过程
CREATE PROCEDURE UpdateSaleBillVouchsItemCode
AS
BEGIN
    -- 声明变量
    DECLARE @voucherId INT, @itemCode NVARCHAR(10), @headItemCode NVARCHAR(10)

    -- 打开游标
    DECLARE v_cursor CURSOR FOR
    SELECT distinct SBVID, cItemCode
    FROM SaleBillVouchs
    WHERE cItemCode IS NULL or cItemCode = ''
    

    -- 打开游标
    OPEN v_cursor

    -- 获取游标中的数据
    FETCH NEXT FROM v_cursor INTO @voucherId, @itemCode

    -- 循环遍历游标中的数据
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- 取发票表头项目编码,表头自定义项11
	    	SELECT @headItemCode = isnull(cdefine11,'0100001') FROM SaleBillVouch WHERE SBVID = @voucherId;
	    	-- 更新SaleBillVouchs表中的cItemCode字段
        UPDATE SaleBillVouchs
        SET cItemCode = @headItemCode ,cItem_class = '00'
        WHERE SBVID = @voucherId

        -- 获取下一个数据
        FETCH NEXT FROM v_cursor INTO @voucherId, @itemCode
    END

    -- 关闭游标
    CLOSE v_cursor

    -- 释放游标资源
    DEALLOCATE v_cursor
END
GO


