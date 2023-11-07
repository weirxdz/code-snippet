USE [ecology]
GO
/****** Object:  Trigger [dbo].[CopyData_84To_po_orderdetails]    Script Date: 2023-11-02 11:37:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[CopyData_84To_po_orderdetails]
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
          SELECT A.requestId as requestId,A.ID AS htid,a.sqr as sqr,a.sqbm as sqbm, sqgs, cglx,A.QYGYS AS gysbm, gysmc, sfzsht,A.sfzt AS sfcdyf, htmc, htbh, qdrq, qddd, nsrsbh,A.DZ AS gysdz, lxdh, khx, zh, bzyq, ysfs,A.whfs AS jhfs, jhdd, jyfs,A.qx as jhqx, jssj, jsfs, bz, szgs,1 as u8tbzt,'' as cmaker,'10' as cptcode,'普通采购' as cbustype,8173 ivtid,'' AS U8bmbm,'' AS U8ywybm
          FROM ecology.dbo.formtable_main_84 A
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