USE ecology;
ALTER TRIGGER [dbo].[CopyData_84To_po_orderdetails]
ON [dbo].[formtable_main_84]
after UPDATE
AS
BEGIN
   -- 声明变量
   DECLARE @oamainid INT; 
   DECLARE @COUNT INT;
   DECLARE @COUNT_cpqd INT;
  IF UPDATE(isApproved)
    BEGIN
      -- 主表数据ID
      set @oamainid = (select COALESCE(A.[id], 0) from [dbo].[formtable_main_84] A JOIN inserted I ON A.[id] = I.[id] );
      -- 明细表中是否已经存在本合同数据
      set @COUNT = (select COUNT(A.[zbid]) from [dbo].[uf_saleorderdetails] A JOIN inserted I ON A.[zbid] = I.[id]);
      -- 产品列表中是否存在需要传递U8的数据
      set @COUNT_cpqd = (select count(A.[mainid]) from [dbo].[formtable_main_84_dt1] A  where A.[mainid] = @oamainid);
      -- 查询采购合同主表记录插入底表记录
      IF @oamainid <> 0 AND @COUNT = 0 and @COUNT_cpqd >=1
        BEGIN
          INSERT INTO uf_po_orderdetail (requestId, htid, sqr, sqbm, sqgs, cglx, gysbm, gysmc,  sfzsht, sfcdyf, htmc, htbh, qdrq, qddd, nsrsbh, gysdz, lxdh, khx, zh, bzyq, ysfs, jhfs, jhdd, jyfs, jhqx, jssj, jsfs, bz, szgs, u8tbzt, cmaker, cptcode, cbustype, ivtid,U8bmbm,U8ywybm)
          SELECT A.requestId as requestId,A.ID AS htid,a.sqr as sqr,a.sqbm as sqbm, A.sqgs, A.cglx,A.QYGYS AS gysbm, A.gysmc, A.sfzsht,case when A.[sfzt] = 0 then '否' when A.[sfzt] = 1 then '是' end AS sfcdyf, A.htmc, A.htbh, A.qdrq, A.qddd, A.nsrsbh,A.DZ AS gysdz, A.lxdh, A.khx, A.zh, A.bzyq, A.ysfs,A.whfs AS jhfs, A.jhdd, A.jyfs,A.qx as jhqx, A.jssj, A.jsfs, A.bz, A.szgs,1 as u8tbzt,IsNULL(A.cmaker,'demo') as cmaker,PT.cPTCode  as cptcode,CASE WHEN PT.cPTName = '固定资产采购' THEN '固定资产' WHEN PT.cPTName = '普通采购' OR PT.cPTName = '办公用品采购' THEN '普通采购' end as cbustype,8173 ivtid,V.cVenDepart AS U8bmbm,V.cVenPPerson  AS U8ywybm
          FROM ecology.dbo.formtable_main_84 A
          LEFT JOIN UFDATA_001_2023.dbo.PurchaseType pt ON A.cglx = PT.cPTName 
          LEFT JOIN UFDATA_001_2023.dbo.Vendor v ON A.qygys = V.cVenCode 
          where A.[id] = @oamainid ;

          -- 查询采购合同存货清单记录插入底表子表记录
          BEGIN
            INSERT INTO uf_po_orderdetail_dt1 (mainid, autoid, chbm, chmc, ggxh, cgjldwbm, cgsl, zjldwbm, zsl, hsdj, sl, jshj, shck, bz)
            SELECT [mainid] as [mainid]
                  ,[id] as [autoid]
                  ,[wlbm] as [chbm]
                  ,[wlmc] as [chmc]
                  ,[ggxh] as [ggxh]
                  ,fjldwbm as cgjldwbm
                  ,cgwlsl AS cgsl
                  ,[zjldwbm] as [zjldwbm]
                  ,ccwlsl  as [zsl]
                  ,[hsdj] as [hsdj]
                  ,sl AS sl
                  ,[hsje] as [jshj]
                  ,[shck] as [shck]
                  ,[bz] as [bz]
              FROM [dbo].[formtable_main_84_dt1]
              where [wlbm] is not null  and [wlbm] <> ''
              and [mainid] = @oamainid
              
          END
        END
    END   
END;