
ALTER TRIGGER [dbo].[CopyData_83To_saleorderdetails]
ON [dbo].[formtable_main_83]
AFTER UPDATE
AS
BEGIN
   -- 声明变量
   DECLARE @oamainid INT;
   DECLARE @COUNT INT;
   DECLARE @COUNT_cpqd INT;
  IF UPDATE(shwc) 
    BEGIN
      set @oamainid = (select COALESCE(A.[id], 0) from [dbo].[formtable_main_83] A JOIN inserted I ON A.[id] = I.[id] where A.[sfdxht] = 1);
      set @COUNT = (select COUNT(A.[zbid]) from [dbo].[uf_saleorderdetails] A JOIN inserted I ON A.[zbid] = I.[id]);
      set @COUNT_cpqd = (select count(A.[mainid]) from [dbo].[formtable_main_83_dt2] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid)
                      + (select count(A.[mainid]) from [dbo].[formtable_main_83_dt4] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid)
                      + (select count(A.[mainid]) from [dbo].[formtable_main_83_dt6] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid)
                      + (select count(A.[mainid]) from [dbo].[formtable_main_83_dt8] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid)
                      + (select count(A.[mainid]) from [dbo].[formtable_main_83_dt10] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid)
                      + (select count(A.[mainid]) from [dbo].[formtable_main_83_dt12] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid)
                      + (select count(A.[mainid]) from [dbo].[formtable_main_83_dt14] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid)
                      + (select count(A.[mainid]) from [dbo].[formtable_main_83_dt16] A  where A.[sfdx] = 1 AND A.[mainid] = @oamainid);
      -- 查询销售合同主表记录插入底表记录
      IF @oamainid <> 0 AND @COUNT = 0 and @COUNT_cpqd >=1
        BEGIN
          INSERT INTO uf_saleorderdetails ([zbid] ,[requestId] ,[sqr] ,[sqrq] ,[sqbm] ,[sqgs] ,[htlx] ,[headsl] ,[htbh] ,[htmc] ,[qykh] ,[khmc] ,[u8khbmbm] ,[u8khywybm] ,[nbkh]  ,[xmbm] ,[xmmc] ,[htqdrq] ,[htqddd] ,[htksrq] ,[htjsrq] ,[jhrq] ,[mpxq],[sfzsht] ,[sfkp] ,[sfwl] , [sfcdyf] , [u8tbzt] , [dr] , cMaker, cSTCode, cBusType, iVTid, xmclass, shdz)
          SELECT A.[id] as [id] ,A.[requestId] as [requestId] ,A.[sqr] as [sqr] ,A.[sqrq] as [sqrq] ,A.[sqbm] as [sqbm] ,A.[sqgs] as [sqgs] ,A.[htlx] as [htlx] ,A.[headsl] as [headsl] ,A.[htbh] as [htbh] ,A.[htmc] as [htmc] ,A.[qykh] as [qykh] ,A.[khmc] as [khmc] ,A.[u8bm] as [u8khbmbm] ,A.[u8ywy] as [u8khywybm] ,x.name as [nbkh] ,A.[xmbm] as [xmbm] ,A.[xmmc] as [xmmc] ,A.[htqdrq] ,A.[htqddd] ,A.[htksrq] ,A.[htjsrq] ,A.[jhrq] ,A.[mpxq] as [mpxq],A.[sfzsht] as [sfzsht] ,A.[sfkp] as [sfkp] ,case when A.[sfwl] = 1 then '否' when A.[sfwl] = 0 then '是' end as [sfwl] ,case when A.[sfwfcdyf] = 1 then '否' when A.[sfwfcdyf] = 0 then '是' end  as [sfcdyf] ,0 as [u8tbzt] ,0 as [dr] ,case when A.cmaker IS null or A.cmaker = '' then ' demo'else A.cmaker end as cMaker,A.xsddlx as cSTCode,ST.cSTName AS cBusType,95 as iVTid,'00' as xmclass,A.shdz AS shdz 
          FROM [dbo].[formtable_main_83] A
		  left join mode_selectitempagedetail x on x.mainid = 27 and x.disorder = A.nbkh
		  LEFT JOIN UFDATA_001_2023.dbo.SaleType st ON A.xsddlx = ST.cSTCode 
          where A.[sfdxht] = 1 AND A.[id] = @oamainid;

          -- 查询销售合同产品清单记录插入底表子表记录
          BEGIN
            INSERT INTO uf_saleorderdetails_dt2 ([mainid],[htzbid],[cplb],[cpqdzbid],[u8cpbm],[cpmc],[ggxh],[jldwbm],[iQuantity],[hsdj],[sl],[je],[sm],[sfdx],[khcpmc],[khcpgg],[tbbs],[dr])
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplx] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt2]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplx],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh])
              union all 
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplb] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt4]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplb],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh])
              union all
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplb] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt6]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplb],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh])
              union all 
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplb] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt8]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplb],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh])
              union all 
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplb] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt10]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplb],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh])
              union all 
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplx] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt12]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplx],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh])
              union all 
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplb] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt14]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplb],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh])
              union all 
						SELECT [mainid] as [mainid]
								,max([id]) as [htzbid]
								,[cplb] as [cplb]
								,CONCAT('1','-',max([id])) as [cpqdzbid]
								,[u8cpbm] as [u8cpbm]
								,[cpmc] as [cpmc]
								,[ggxh] as [ggxh]
								,[dw] as [jldwbm]
								,sum([nnum]) as [iQuantity]
								,[hsdj] as [hsdj]
								,[sl] as [sl]
								,sum([je]) as [je]
								,[sm] as [sm]
								,[sfdx] as [sfdx]
								,isnull([khcpmc],[cpmc]) as [khcpmc]
								,isnull([khcpgg],[ggxh]) as [khcpgg]
								,0 as [tbbs]
								,0 as [dr]
						FROM [dbo].[formtable_main_83_dt16]
						where [sfdx] = 1 -- 0,是;1,否 
						and [u8cpbm] is not null  and [u8cpbm] <> ''
						and [mainid] = @oamainid
						GROUP BY  [mainid],[cplb],[u8cpbm] ,[cpmc],[ggxh],[dw] ,[hsdj] ,[sl] ,[sm] ,[sfdx],isnull([khcpmc],[cpmc]) ,isnull([khcpgg],[ggxh]);
          END
        END
    END   
END;

