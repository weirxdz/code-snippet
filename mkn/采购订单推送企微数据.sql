--需求描述：
--U8中的采购订单数据推送到企微进行审批，审批完成后返回审批结果
--推送到企微的数据，根据业务员档案上的WXID字段匹配企微中的人员的账号，如果为空，默认值是吴晓彤的企微账号
--返回结果的处理，如果审批通过，采购订单主表赋值如下：
--	cVerifier=cMaker,dverifydate=sysdate(),wxOaState=1
	

-- U8单据附件表
SELECT t.VoucherTypeID ,t.VoucherID ,t.FileID ,t.FileName ,t.FileContent ,t.Memo  FROM VoucherAccessories t
;
-- 以下为U8的采购订单查询语句
SELECT h.POID  ,h.cPOID  ,h.dPODate , v.cVenName  as cVenName,isnull(v.cVenDefine1,'其它') AS 供应商选项 ,d.cDepName AS deptname,p.cPersonName  as clerkname,hp.cPsnPostAddr AS 业务员账号,UU.cUserEmail AS 制单人账号,h.cDefine8 AS 是否外购,isnull(P.WXID,'XiaoTong') AS WXID,h.cMemo ,h.wxOaState,h.cMaker ,h.cVerifier ,h.cAuditDate ,h.cAuditTime ,h.iverifystateex ,b.cInvCode ,i.cInvName,i.cInvStd  ,b.iQuantity ,b.iTaxPrice AS 含税单价,b.iSum AS 价税合计,isnull(i.cInvDefine1,'其它') AS  表体存货采购分类
FROM PO_Pomain h
INNER JOIN PO_Podetails b ON h.POID  = b.POID  
LEFT JOIN Department d ON h.cDepCode = d.cDepCode 
LEFT JOIN Vendor v ON h.cVenCode  = v.cVenCode 
LEFT JOIN Person p ON h.cPersonCode = p.cPersonCode 
LEFT JOIN hr_hi_person hp ON h.cPersonCode = hp.cPsn_Num 
LEFT JOIN UA_User uu ON H.cMaker = UU.cUser_Name 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
WHERE 1=1-- h.iStatus = 0 
	-- AND convert(varchar(10),h.dDate,120) >= '2023-05-20' -- 开始同步日期，接口只处理此日期之后的记录
	AND (h.wxOaState IS NULL OR h.wxOaState = 0)
	
	
	SELECT * FROM v_po_main
-- 对U8数据库表需要增加的列
ALTER TABLE UFDATA_999_2014.dbo.PO_Pomain  ADD wxOaState int NULL;
EXEC UFDATA_999_2014.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaState';