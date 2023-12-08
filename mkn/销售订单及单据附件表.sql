-- 单据附件表
select t.id,t.AssociateID,t.TemplateName,t.FileName,t.FileType,t.FileSize,t.UploadPath,t.FileContent from eap_attachmentinfo t
;
-- 销售订单主表
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