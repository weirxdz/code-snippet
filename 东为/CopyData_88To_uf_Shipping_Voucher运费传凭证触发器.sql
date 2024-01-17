ALTER  TRIGGER [dbo].[CopyData_88To_uf_Shipping_Voucher]
ON [dbo].[formtable_main_88]
after UPDATE
AS
BEGIN
   -- 声明变量 
	DECLARE @oamainid INT; 
	DECLARE @COUNT INT;
	DECLARE @COUNT_cpqd INT;
	DECLARE @sqrq nvarchar(10);
	DECLARE @YNFlag nvarchar(10); 
	DECLARE @oldisapproved INT;
	DECLARE @newisapproved INT;
  
  IF UPDATE(isApproved) 
    BEGIN
      -- 主表数据ID
      set @oamainid = (select COALESCE(A.[id], 0) from [dbo].[formtable_main_88] A JOIN inserted I ON A.[id] = I.[id] );
     	-- 是否推送生成U8付款单标识
     	set @YNFlag = (select COALESCE(A.YNflag, 'N') from [dbo].[formtable_main_88] A JOIN inserted I ON A.[id] = I.[id] );
      -- 明细表中是否已经存在本流程数据
      set @COUNT = (select COUNT(A.[OAmainID]) from [dbo].[uf_Shipping_Voucher] A JOIN inserted I ON A.[OAmainID] = I.[id]);
      -- 申请日期大于等于1月1号
      set @sqrq = (select A.SQRQ from [dbo].[formtable_main_88] A  where A.[ID] = @oamainid);
     	SET @newisapproved = (SELECT isApproved FROM inserted);
      SET @oldisapproved = (SELECT isApproved FROM deleted);
      -- 查询fukuanshenqing主表记录插入底表记录
      IF @oamainid <> 0 AND @COUNT = 0 and @sqrq >= '2024-01-01' AND @YNFlag = 'Y'
        BEGIN
          INSERT INTO uf_Shipping_Voucher (requestId, iyear, iperiod, csign,  idoc, cbill, cdigest, ccode, cexchname, md, mc, mdf, mcf, nfrat, nds, ncs, csettle, cdeptid, cpersonid, ccusid, csupid, citemid, citemclass, cname, ccodeequal, dr, OA_BILLCODE, flag_dc, dbill_date, OAmainID)
					SELECT t.requestId as requestId,year(GETDATE()) as iyear,month(GETDATE()) as iperiod,'记' AS csign,1 AS idoc,'宋风华' AS cbill,'运费'AS cdigest,'660101' AS ccode,'人民币' AS cexchname,t.yf AS md,0 AS mc,0 AS mdf,0 AS mcf,NULL AS nfrat,0 AS nds,0 AS ncs,t.csettle AS csettle,NULL AS cdeptid, NULL AS cpersonid,NULL AS ccusid,NULL AS csupid,t.citemid AS citemid,'00' AS citemclass,NULL AS  cname,c.ccode AS ccodeequal,0 AS dr,t.id AS OA_BILLCODE,'D' flag_dc,t.sqrq dbill_date, t.id AS OAmainID
					FROM formtable_main_88 t 
					LEFT JOIN ufdata_001_2023.dbo.SettleStyle s ON t.csettle = s.cSSCode 
					LEFT JOIN ufdata_001_2023.dbo.Ap_SStyleCode c ON s.cSSCode = c.cSettleStyle AND c.cFlag = 'AP' AND c.iyear = YEAR(t.sqrq) 
          where t.[id] = @oamainid AND t.YNflag = 'Y' AND t.csettle IS NOT NULL 
          UNION 
          SELECT t.requestId as requestId,year(GETDATE()) as iyear,month(GETDATE()) as iperiod,'记' AS csign,1 AS idoc,'宋风华' AS cbill,'运费'AS cdigest,c.ccode AS ccode,'人民币' AS cexchname,0 AS md,t.yf AS mc,0 AS mdf,0 AS mcf,NULL AS nfrat,0 AS nds,0 AS ncs,t.csettle AS csettle,NULL AS cdeptid, NULL AS cpersonid,NULL AS ccusid,NULL AS csupid,NULL AS citemid,NULL AS citemclass,NULL AS  cname,'660101' AS ccodeequal,0 AS dr,t.id AS OA_BILLCODE,'C' flag_dc,t.sqrq dbill_date, t.id AS OAmainID
					FROM formtable_main_88 t 
					LEFT JOIN ufdata_001_2023.dbo.SettleStyle s ON t.csettle = s.cSSCode 
					LEFT JOIN ufdata_001_2023.dbo.Ap_SStyleCode c ON s.cSSCode = c.cSettleStyle AND c.cFlag = 'AP' AND c.iyear = YEAR(t.sqrq) 
          where t.[id] = @oamainid AND t.YNflag = 'Y' AND t.csettle IS NOT NULL
          
        END
    END   
END;