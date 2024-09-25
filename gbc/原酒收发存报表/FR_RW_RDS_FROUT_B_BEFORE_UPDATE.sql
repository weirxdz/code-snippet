CREATE DEFINER=`blog`@`%` TRIGGER `FR_RW_RDS_FROUT_B_BEFORE_UPDATE` BEFORE UPDATE ON `fr_rw_rds_frout_b` FOR EACH ROW BEGIN
	DECLARE IJARSCODE VARCHAR(12); -- 酒坛罐编号
	DECLARE IFIRSTDATE_IN VARCHAR(20); -- 首次入库日期
	DECLARE IID INT; -- 结存表主键
	DECLARE IILATEST INT; -- 结存表最新有效标识
	DECLARE IDR INT; -- 单据删除标识
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
	DECLARE IBALANCE_DENSITY_TEMP DECIMAL(8,6); -- 中间临时结存原酒密度
	DECLARE IBALANCE_STRENGTH_TEMP DECIMAL(20,2); -- 中间临时结存原酒度数
	DECLARE IBALANCE_AQUANTITY_TEMP DECIMAL(20,2); -- 中间临时结存原酒重量
	DECLARE IBILL_DENSITY_OLD DECIMAL(8,6); -- 单据修改前原酒密度
	DECLARE IBILL_DENSITY_NEW DECIMAL(8,6); -- 单据修改后原酒密度
	DECLARE INEW_DENSITY DECIMAL(8,6); -- 新结存酒密度
	DECLARE IBALANCE_STRENGTH_NEW DECIMAL(20,2); -- 最终结存原酒度数
	DECLARE IBALANCE_AQUANTITY_NEW DECIMAL(20,2); -- 最终结存原酒重量
	DECLARE INEW_CONVERSION_RATE DECIMAL(6,4); -- 混合后65度酒折算率
	
	IF NEW.ACTUAL_WEIGHT <> OLD.ACTUAL_WEIGHT/*重量不同*/ OR NEW.ACTUAL_STRENGTH <> OLD.ACTUAL_STRENGTH/*酒精度数不同*/ OR NEW.CONVERT_65_WEIGHT <> OLD.CONVERT_65_WEIGHT /*65度重量不同*/ OR NEW.JARSCODE <> OLD.JARSCODE /*酒坛号不同*/ THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '酒坛号、酒度、实际重量、65度重量不允许修改!';
	END IF;
	-- 查询结存表主键
	SELECT IFNULL(B.ID,0) INTO IID FROM FR_RW_JARS_BALANCE_B B WHERE B.BILLAUTOID = NEW.AUTOID AND B.BILLCODE = NEW.ID;
	-- 查询结存主表数据 ILATEST
	SELECT IFNULL(H.ILATEST,0)  INTO IILATEST FROM FR_RW_JARS_BALANCE_H H WHERE H.ID = IID;
	-- 查询单据删除标识 IDR
	SELECT IFNULL(H.DR,0)  INTO IDR FROM FR_RW_RDS_FROUT_B H WHERE H.ID = NEW.ID;
	
	IF IILATEST = 0 and (NEW.ACTUAL_WEIGHT <> OLD.ACTUAL_WEIGHT/*重量不同*/ OR NEW.ACTUAL_STRENGTH <> OLD.ACTUAL_STRENGTH/*酒精度数不同*/ OR NEW.CONVERT_65_WEIGHT <> OLD.CONVERT_65_WEIGHT /*65度重量不同*/ OR NEW.JARSCODE <> OLD.JARSCODE /*酒坛号不同*/ ) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '当前为空坛，禁止修改出库单！';
	END IF;

	/*非空坛的情况下删除单据*/
	IF IILATEST = 1 AND NEW.DR = 1 AND OLD.DR = 0 THEN
		-- 计算结存原酒度数 
		SET IBALANCE_STRENGTH := (SELECT H.BALANCE_STRENGTH  FROM FR_RW_JARS_BALANCE_H H WHERE H.ID = IID);	
		-- 计算结存原酒重量	 
		SET IBALANCE_AQUANTITY := (SELECT H.AQUANTITY_BALANCE  FROM FR_RW_JARS_BALANCE_H H WHERE H.ID = IID);  
		-- 计算结存原酒65度折算重量  
		SET IBALANCE_QUANTITY := (SELECT H.QUANTITY_BALANCE  FROM FR_RW_JARS_BALANCE_H H WHERE H.ID = IID); 
		IF NEW.ACTUAL_WEIGHT < 0 THEN -- 删除红字出库单
			-- 判断实际重量、65度重量与结存数据是否可以删除
			IF IBALANCE_AQUANTITY < -1*NEW.ACTUAL_WEIGHT THEN 
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '出库实际重量超过结存实际重量了,不允许删除出库单!';
			ELSEIF IBALANCE_QUANTITY < -1*NEW.CONVERT_65_WEIGHT THEN 
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '出库65度重量超过结存65度重量了,不允许删除出库单!';
			ELSEIF IBALANCE_AQUANTITY = -1*NEW.ACTUAL_WEIGHT THEN
				IF IBALANCE_QUANTITY <> -1*NEW.CONVERT_65_WEIGHT THEN 
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '出库65度重量不等于结存65度重量,请修改出库65度重量!';
				ELSEIF IBALANCE_QUANTITY = -1*NEW.CONVERT_65_WEIGHT THEN
					UPDATE FR_RW_JARS_BALANCE_H	SET AQUANTITY_BALANCE = IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE = IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH	WHERE ID = IID;
				END IF;
			ELSEIF IBALANCE_STRENGTH = NEW.ACTUAL_STRENGTH AND IBALANCE_AQUANTITY > -1*NEW.ACTUAL_WEIGHT AND IBALANCE_QUANTITY > -1*NEW.CONVERT_65_WEIGHT THEN -- 出库酒精度数与结存酒精度数一致，不需要计算混合酒度和重量
				UPDATE FR_RW_JARS_BALANCE_H	SET AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE=IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH	WHERE ID = IID;
			ELSEIF IBALANCE_STRENGTH <> NEW.ACTUAL_STRENGTH AND IBALANCE_AQUANTITY > -1*NEW.ACTUAL_WEIGHT AND IBALANCE_QUANTITY > -1*NEW.CONVERT_65_WEIGHT THEN -- 出库酒精度数与结存酒精度数不一致,需要计算混合酒度;
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
				* 计算单据原酒密度 IBILL_DENSITY_NEW
				* 先计算向下取整的酒精度数对应的原酒密度 TEMP_DENSITY_FLOOR
				* 再计算向上取整的酒精度数对应的密度 TEMP_DENSITY_UP
				* IBILL_DENSITY_NEW = TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP)
				* */
				-- 计算原酒酒精度向下取整对应密度
					SET TEMP_DENSITY_FLOOR := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = FLOOR(NEW.ACTUAL_STRENGTH));
				-- 计算原酒酒精度向上取整对应密度
					SET TEMP_DENSITY_UP := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = CEIL(NEW.ACTUAL_STRENGTH));
				-- 计算单据原酒密度
					SET IBILL_DENSITY_NEW := TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP); 
				
				-- 计算混合后原酒度数
				SET IBALANCE_STRENGTH_NEW := ROUND((IBALANCE_STRENGTH*IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_STRENGTH*NEW.ACTUAL_WEIGHT/IBILL_DENSITY_NEW)/(IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_WEIGHT/IBILL_DENSITY_NEW),1);
				/*更新结存主表数据*/
				UPDATE FR_RW_JARS_BALANCE_H	SET   BALANCE_STRENGTH = IBALANCE_STRENGTH_NEW, AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE = IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH WHERE ID = IID;	-- 计算混合酒度的处理结束
			END IF;
		ELSEIF NEW.ACTUAL_WEIGHT > 0 THEN -- 删除蓝字出库单
				IF IBALANCE_STRENGTH = NEW.ACTUAL_STRENGTH THEN -- 出库酒精度数与结存酒精度数一致，不需要计算混合酒度和重量
					UPDATE FR_RW_JARS_BALANCE_H	SET AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE=IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH	WHERE ID = IID;
				ELSEIF IBALANCE_STRENGTH <> NEW.ACTUAL_STRENGTH  THEN -- 出库酒精度数与结存酒精度数不一致,需要计算混合酒度;
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
					* 计算单据原酒密度 IBILL_DENSITY_NEW
					* 先计算向下取整的酒精度数对应的原酒密度 TEMP_DENSITY_FLOOR
					* 再计算向上取整的酒精度数对应的密度 TEMP_DENSITY_UP
					* IBILL_DENSITY_NEW = TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP)
					* */
					-- 计算原酒酒精度向下取整对应密度
					SET TEMP_DENSITY_FLOOR := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = FLOOR(NEW.ACTUAL_STRENGTH));
					-- 计算原酒酒精度向上取整对应密度
					SET TEMP_DENSITY_UP := (SELECT FRD.DENSITY  FROM FR_RW_DENSITY FRD WHERE FRD.IDEGREE = CEIL(NEW.ACTUAL_STRENGTH));
					-- 计算单据原酒密度
					SET IBILL_DENSITY_NEW := TEMP_DENSITY_FLOOR - MOD(TRUNCATE(NEW.ACTUAL_STRENGTH, 1)*10 ,10)/10*(TEMP_DENSITY_FLOOR - TEMP_DENSITY_UP); 
					
					-- 计算混合后原酒度数
					SET IBALANCE_STRENGTH_NEW := ROUND((IBALANCE_STRENGTH*IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_STRENGTH*NEW.ACTUAL_WEIGHT/IBILL_DENSITY_NEW)/(IBALANCE_AQUANTITY/IBALANCE_DENSITY + NEW.ACTUAL_WEIGHT/IBILL_DENSITY_NEW),1);
					/*更新结存主表数据*/
					UPDATE FR_RW_JARS_BALANCE_H	SET   BALANCE_STRENGTH = IBALANCE_STRENGTH_NEW, AQUANTITY_BALANCE= IBALANCE_AQUANTITY + NEW.ACTUAL_WEIGHT, QUANTITY_BALANCE = IBALANCE_QUANTITY + NEW.CONVERT_65_WEIGHT, CBATCH= NEW.CBATCH WHERE ID = IID;
				END IF;
		END IF;
	END IF;
END