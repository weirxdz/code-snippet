CREATE DEFINER=`blog`@`%` TRIGGER `FR_RW_RDS_FRIN_B_BEFORE_INSERT` BEFORE INSERT ON `fr_rw_rds_frin_b` FOR EACH ROW BEGIN
	DECLARE IJARSCODE VARCHAR(12); -- 酒坛罐编号
	DECLARE IFIRSTDATE_IN VARCHAR(20); -- 首次入库日期
	DECLARE IID INT; -- 结存表主键
	DECLARE IWINECODE VARCHAR(12); -- 结存原酒编码	
	DECLARE ITEAMNUMBER VARCHAR(12); -- 结存原酒生产酒班
	DECLARE IBALANCE_STRENGTH DECIMAL(20,2); -- 结存原酒度数
	DECLARE IBALANCE_AQUANTITY DECIMAL(20,2); -- 结存原酒重量
	DECLARE IBALANCE_QUANTITY DECIMAL(20,2); -- 结存原酒65度折算重量
	DECLARE IBATCH VARCHAR(60); -- 结存批次号
	DECLARE IBILLTEAMNUMBER VARCHAR(12); -- 单据原酒生产酒班	
	DECLARE TEMP_DENSITY_UP DECIMAL(8,6); -- 原酒酒精度向上取整对应密度
	DECLARE TEMP_DENSITY_FLOOR DECIMAL(8,6); -- 原酒酒精度向下取整对应密度	
	DECLARE IBALANCE_DENSITY DECIMAL(8,6); -- 结存原酒密度
	DECLARE IBILL_DENSITY DECIMAL(8,6); -- 单据原酒密度
	DECLARE INEW_BALANCE_STRENGTH DECIMAL(20,2); -- 混合后结存原酒度数
	DECLARE INEW_BALANCE_AQUANTITY DECIMAL(20,2); -- 混合后结存原酒实际重量
	DECLARE INEW_CONVERSION_RATE DECIMAL(6,4); -- 混合后65度酒折算率
	
	/*查询当前坛罐是否有存在最新的入库记录*/
	SET IFIRSTDATE_IN := (SELECT H.FIRSTDATE_IN FROM FR_RW_JARS_BALANCE_H H WHERE H.JARSCODE = NEW.JARSCODE AND H.ILATEST = 1);
	/*查询当前坛罐最新的有效ID*/
	SET IID := (SELECT H.ID FROM FR_RW_JARS_BALANCE_H H WHERE H.JARSCODE = NEW.JARSCODE AND H.ILATEST = 1);
	/*关联查询入库单主表上的酒班，其他字段子表都可以取到*/
	SET IBILLTEAMNUMBER := (SELECT H.DEPTCODE  FROM FR_RW_RDS_FRIN_H  H WHERE H.ID = NEW.ID);
	/*空坛，向结存表插入新纪录*/
	IF IFIRSTDATE_IN IS NULL THEN
		/*如果入库数量小于零，空坛不允许红字入库，报错*/
		IF NEW.ACTUAL_WEIGHT < 0 OR NEW.CONVERT_65_WEIGHT < 0 THEN 
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '当前为空坛，不能做红字入库';
		END IF;	
		IF NEW.ACTUAL_WEIGHT > 0 AND NEW.CONVERT_65_WEIGHT > 0 THEN		/*插入数据*/
			INSERT INTO FR_RW_JARS_BALANCE_H (JARSCODE, ILATEST, ISEMPTY, FIRSTDATE_IN, WINECODE, TEAMNUMBER, LASTDAYE_OUT, FIRSTBILLCODE, BALANCE_STRENGTH, AQUANTITY_BALANCE, QUANTITY_BALANCE, CBATCH) VALUES(NEW.JARSCODE, 1, 0, NEW.DDATE, NEW.PRODUCTCODE, IBILLTEAMNUMBER, '', NEW.ID, NEW.ACTUAL_STRENGTH, NEW.ACTUAL_WEIGHT, NEW.CONVERT_65_WEIGHT, NEW.CBATCH);
		END IF;
	END IF;
	/*空坛，向结存表插入新纪录结束*/

	/*非空坛，*/
	IF IFIRSTDATE_IN IS NOT NULL THEN
		-- 计算结存原酒度数
		SET IBALANCE_STRENGTH := (SELECT H.BALANCE_STRENGTH  FROM FR_RW_JARS_BALANCE_H H WHERE H.JARSCODE = NEW.JARSCODE AND H.ILATEST = 1);		
		-- 计算结存原酒重量
		SET IBALANCE_AQUANTITY := (SELECT H.AQUANTITY_BALANCE  FROM FR_RW_JARS_BALANCE_H H WHERE H.JARSCODE = NEW.JARSCODE AND H.ILATEST = 1);
		-- 计算结存原酒65度折算重量
		SET IBALANCE_QUANTITY := (SELECT H.QUANTITY_BALANCE  FROM FR_RW_JARS_BALANCE_H H WHERE H.JARSCODE = NEW.JARSCODE AND H.ILATEST = 1);
		-- 计算结存批次号
		SET IBATCH := (SELECT H.CBATCH FROM FR_RW_JARS_BALANCE_H H WHERE H.JARSCODE = NEW.JARSCODE AND H.ILATEST = 1); 	
		IF NEW.ACTUAL_WEIGHT > 0 THEN -- 蓝字入库
			/*
			* 计算结存原酒密度 IBALANCE_DENSITY
			* 先计算向下取整的酒精度数对应的原酒密度 TEMP_DENSITY_FLOOR
			* 再计算向上取整的酒精度数对应的密度 TEMP_DENSITY_UP
			* IBALANCE_DENSITY = TEMP_DENSITY_FLOOR - MOD(TRUNCATE(IBALANCE_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP)
			* */
			-- 计算原酒酒精度向下取整对应密度
				SET TEMP_DENSITY_FLOOR := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = FLOOR(IBALANCE_STRENGTH));
			-- 计算原酒酒精度向上取整对应密度
				SET TEMP_DENSITY_UP := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = CEIL(IBALANCE_STRENGTH));
			-- 计算结存原酒密度
				SET IBALANCE_DENSITY := TEMP_DENSITY_FLOOR - MOD(TRUNCATE(IBALANCE_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP);
			/*
			* 计算单据原酒密度 IBILL_DENSITY
			* 先计算向下取整的酒精度数对应的原酒密度 TEMP_DENSITY_FLOOR
			* 再计算向上取整的酒精度数对应的密度 TEMP_DENSITY_UP
			* IBILL_DENSITY = TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP)
			* */
			-- 计算原酒酒精度向下取整对应密度
				SET TEMP_DENSITY_FLOOR := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = FLOOR(NEW.ACTUAL_STRENGTH));
			-- 计算原酒酒精度向上取整对应密度
				SET TEMP_DENSITY_UP := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = CEIL(NEW.ACTUAL_STRENGTH));
			-- 计算单据原酒密度
				SET IBILL_DENSITY := TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP);
			-- 计算混合后结存原酒度数
			SET INEW_BALANCE_STRENGTH := ROUND((IBALANCE_STRENGTH*IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_STRENGTH*NEW.ACTUAL_WEIGHT/IBILL_DENSITY)/(IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_WEIGHT/IBILL_DENSITY),1);
			/*更新数据*/
			UPDATE FR_RW_JARS_BALANCE_H	SET  BALANCE_STRENGTH = INEW_BALANCE_STRENGTH, AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE = IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH	WHERE ID = IID;
		ELSEIF NEW.ACTUAL_WEIGHT < 0 THEN -- 红字入库
			IF IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT < 0 THEN 
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '单据保存后结存实际重量小于零,请修改实际重量!';
			ELSEIF IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT < 0 THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '单据保存后结存65度重量小于零,请修改65度重量!';
			ELSEIF IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT = 0 AND IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT = 0 THEN
				/*更新数据*/
					UPDATE FR_RW_JARS_BALANCE_H	SET AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE = IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH	WHERE ID = IID;
			ELSEIF IBALANCE_STRENGTH = NEW.ACTUAL_STRENGTH AND IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT > 0 AND IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT > 0 THEN -- 结存酒度与单据酒度一致,直接加减即可
				IF NEW.CONVERT_65_WEIGHT < 0 THEN
					/*更新数据*/
					UPDATE FR_RW_JARS_BALANCE_H	SET AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE = IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH	WHERE ID = IID;
				ELSEIF NEW.CONVERT_65_WEIGHT >= 0 THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '65度重量不小于零,请重新修改单据65度重量!';
				END IF;	
			ELSEIF IBALANCE_STRENGTH <> NEW.ACTUAL_STRENGTH AND IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT > 0 AND IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT > 0 THEN -- 结存酒度与单据酒度不一致,需要计算混合酒度
				/*
				* 计算结存原酒密度 IBALANCE_DENSITY
				* 先计算向下取整的酒精度数对应的原酒密度 TEMP_DENSITY_FLOOR
				* 再计算向上取整的酒精度数对应的密度 TEMP_DENSITY_UP
				* IBALANCE_DENSITY = TEMP_DENSITY_FLOOR - MOD(TRUNCATE(IBALANCE_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP)
				* */
				-- 计算原酒酒精度向下取整对应密度
					SET TEMP_DENSITY_FLOOR := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = FLOOR(IBALANCE_STRENGTH));
				-- 计算原酒酒精度向上取整对应密度
					SET TEMP_DENSITY_UP := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = CEIL(IBALANCE_STRENGTH));
				-- 计算结存原酒密度
					SET IBALANCE_DENSITY := TEMP_DENSITY_FLOOR - MOD(TRUNCATE(IBALANCE_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP);		
				/*
				* 计算单据原酒密度 IBILL_DENSITY
				* 先计算向下取整的酒精度数对应的原酒密度 TEMP_DENSITY_FLOOR
				* 再计算向上取整的酒精度数对应的密度 TEMP_DENSITY_UP
				* IBILL_DENSITY = TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP)
				* */
				-- 计算原酒酒精度向下取整对应密度
					SET TEMP_DENSITY_FLOOR := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = FLOOR(NEW.ACTUAL_STRENGTH));
				-- 计算原酒酒精度向上取整对应密度
					SET TEMP_DENSITY_UP := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = CEIL(NEW.ACTUAL_STRENGTH));
				-- 计算单据原酒密度
					SET IBILL_DENSITY := TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP); 
				
				-- 计算混合后原酒度数
				SET INEW_BALANCE_STRENGTH := ROUND((IBALANCE_STRENGTH*IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_STRENGTH*NEW.ACTUAL_WEIGHT/IBILL_DENSITY)/(IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_WEIGHT/IBILL_DENSITY),1);
				/*更新结存主表数据*/
				UPDATE FR_RW_JARS_BALANCE_H	SET   BALANCE_STRENGTH = INEW_BALANCE_STRENGTH, AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE = IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH WHERE ID = IID;			
			END IF;
		END IF;
	END IF;
END