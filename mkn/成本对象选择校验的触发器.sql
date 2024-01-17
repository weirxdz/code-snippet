-- 成本对象选择校验的触发器
CREATE OR ALTER TRIGGER trg_selectObject
ON UFDATA_997_2024.dbo.rdrecords11
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @current_value VARCHAR(50), @target_code VARCHAR(50), @cDepCode VARCHAR(50);

    -- 主表部门编码
    SELECT DISTINCT @cDepCode = cDepCode FROM rdrecord11 WHERE ID  IN (SELECT DISTINCT ID FROM inserted);
    -- 部门等级，记录的是成本中心编码，也即成本对象分类编码
    SELECT @target_code = isnull(cCreGrade, 'N') FROM department WHERE cDepCode = @cDepCode;
		-- 如果领料部门的成本中心编码为空，即为非生产部门，报错
		IF @target_code = 'N' 
			BEGIN
			 	RAISERROR('材料出库单表头部门有误，请选择正确的领料部门！', 16, 1);
			END 

    -- 表体成本对象的分类编码，如果存在表体的成本对象分类编码与 @target_code 不一致的情况，报错
    IF @target_code <> 'N'
	    BEGIN
	        -- 如果表体成本对象为空，报错
	        IF EXISTS (SELECT 1 FROM inserted WHERE cDefine22 = '' OR cDefine22 IS NULL)
	        BEGIN
	            RAISERROR('成本中心下的领料必须对应成本对象，请检查表体成本对象是否选择正确', 16, 1);
	        END
	
	        -- 表体成本对象非空的时候
	        IF EXISTS (SELECT 1 FROM fitemss00 f WHERE f.citemcode IN (SELECT cDefine22 FROM inserted) AND f.citemccode <> @target_code)
	        BEGIN
	            RAISERROR('表头领料部门与表体成本对象所属成本中心不匹配，请修改！', 16, 1);
	        END
	    END
END