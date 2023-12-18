--需求描述：
--U8中的销售订单数据推送到企微进行审批，审批完成后返回审批结果
--推送到企微的数据，根据业务员档案上的WXID字段匹配企微中的人员的账号，如果为空，默认值是吴晓彤的企微账号
--返回结果的处理，如果审批通过，销售订单主表赋值如下：
--	iStatus=1,cVerifier=cMaker,dverifydate=sysdate(),wxOaState=1
	

-- U8单据附件表
SELECT t.VoucherTypeID ,t.VoucherID ,t.FileID ,t.FileName ,t.FileContent ,t.Memo  FROM VoucherAccessories t
;
-- 以下为U8的销售订单查询语句
SELECT h.ID ,h.cSOCode ,h.dDate ,h.cDefine8 AS sfqk,h.cDefine11 AS projectcode ,h.cDefine12 AS projectname,d.cDepName AS salesdeptname,c.cCusName  as custname,p.cPersonName  as clerkname,isnull(P.WXID,'XiaoTong') AS WXID,h.cMemo ,h.iStatus  ,h.wxOaState,h.cMaker ,h.cVerifier ,h.dverifydate ,b.cInvCode ,i.cInvName ,b.iQuantity ,b.iSum AS 价税合计
FROM SO_SOMain h
INNER JOIN SO_SODetails b ON h.ID = b.ID  
LEFT JOIN Department d ON h.cDepCode = d.cDepCode 
LEFT JOIN Customer c ON h.cCusCode = c.cCusCode 
LEFT JOIN Person p ON h.cPersonCode = p.cPersonCode 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
WHERE 1=1 AND h.iStatus = 0 
	-- AND convert(varchar(10),h.dDate,120) >= '2023-05-20' -- 开始同步日期，接口只处理此日期之后的记录
	AND (h.wxOaState IS NULL OR h.wxOaState = 0)
	
	
-- 对U8数据库表需要增加的列
ALTER TABLE UFDATA_999_2014.dbo.Person ADD WXID varchar(100) NULL;
EXEC UFDATA_999_2014.sys.sp_addextendedproperty 'MS_Description', N'微信号', 'schema', N'dbo', 'table', N'Person', 'column', N'WXID';
ALTER TABLE UFDATA_999_2014.dbo.SO_SOMain ADD wxOaState int NULL;
EXEC UFDATA_999_2014.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'SO_SOMain', 'column', N'wxOaState';