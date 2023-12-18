-- T+单据附件表
select t.id,t.AssociateID,t.TemplateName,t.FileName,t.FileType,t.FileSize,t.UploadPath,t.FileContent from eap_attachmentinfo t
;
-- T+销售订单主表
-- voucherState 值为189 的记录是审核完的记录
select s.id,S.code,S.voucherdate ,project.Name as projectNmae,S.maker, d.name salesdeptname,cust.name as custname,p.name as clerkname,isnull(P.priuserdefnvc1,'XiaoTong') AS WXID,S.memo,s.voucherState ,s.wxOaState
from SA_SaleOrder s
left join AA_Project project on s.idproject = project.id
left join AA_Department d on S.iddepartment = d.id
left join AA_Partner cust on  S.idcustomer = cust.id
left join AA_Person p on S.idclerk = p.id
left join EAP_User u on s.makerid = u.id
where 1 =1
	and s.voucherState = '189' -- T+里已经审批完的单子
	and convert(varchar(10),s.voucherdate,120) >= '2023-05-20' -- 开始同步日期，接口只处理此日期之后的记录
	and (s.wxOaState is null or s.wxOaState = 0) -- 同步状态

;
select * from SA_SaleOrder s where s.wxOaState is null or s.wxOaState = ;
select t.uploadPath from eap_attachmentinfo t where t.TemplateName='SaleOrder'

select * from sys_config;

-- 对U8数据库表需要增加的列
ALTER TABLE UFDATA_999_2014.dbo.Person ADD WXID varchar(100) NULL;
EXEC UFDATA_999_2014.sys.sp_addextendedproperty 'MS_Description', N'微信号', 'schema', N'dbo', 'table', N'Person', 'column', N'WXID';
ALTER TABLE UFDATA_999_2014.dbo.SO_SOMain ADD wxOaState int NULL;
EXEC UFDATA_999_2014.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'SO_SOMain', 'column', N'wxOaState';


-- U8单据附件表
SELECT t.VoucherTypeID ,t.VoucherID ,t.FileID ,t.FileName ,t.FileContent ,t.Memo  FROM VoucherAccessories t
;
-- 以下为U8的销售订单查询语句
SELECT h.ID ,h.cSOCode ,h.dDate ,h.cDefine8 AS sfqk,h.cDefine11 AS projectcode ,h.cDefine12 AS projectname,d.cDepName AS salesdeptname,c.cCusName  as custname,p.cPersonName  as clerkname,isnull(P.WXID,'XiaoTong') AS WXID,h.cMemo ,h.iStatus  ,h.wxOaState
FROM SO_SOMain h
INNER JOIN SO_SODetails b ON h.ID = b.ID  
LEFT JOIN Department d ON h.cDepCode = d.cDepCode 
LEFT JOIN Customer c ON h.cCusCode = c.cCusCode 
LEFT JOIN Person p ON h.cPersonCode = p.cPersonCode 
WHERE h.iStatus = 1 
	-- AND convert(varchar(10),h.dDate,120) >= '2023-05-20' -- 开始同步日期，接口只处理此日期之后的记录
	AND (h.wxOaState IS NULL OR h.wxOaState = 0)



