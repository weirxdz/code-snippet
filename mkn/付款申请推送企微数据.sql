--需求描述：
--U8中的采购请购单数据推送到企微进行审批，审批完成后返回审批结果
--推送到企微的数据，根据业务员档案上的WXID字段匹配企微中的人员的账号，如果为空，默认值是吴晓彤的企微账号
--返回结果的处理，如果审批通过，采购订单主表赋值如下：
--	cVerifier=cMaker,dverifydate=sysdate(),wxOaState=1
	

-- U8单据附件表
SELECT t.VoucherTypeID ,t.VoucherID ,t.FileID ,t.FileName ,t.FileContent ,t.Memo  FROM VoucherAccessories t
;
-- 以下为U8的付款申请单查询语句
SELECT h.pID  ,h.cVouchID ,h.dVouchDate   ,d.cDepName AS deptname,p.cPersonName  as clerkname,hp.cPsnPostAddr AS 业务员账号,UU.cUserEmail AS 制单人账号 ,isnull(P.WXID,'XiaoTong') AS WXID,h.cDigest  AS 备注,h.wxOaState,h.cOperator  ,h.cCheckMan  ,h.dverifydate  ,h.dverifysystime  ,b.cInvCode ,i.cInvName,i.cInvStd  ,b.iApplyAmt  表体付款金额  
FROM AP_ApplyPayVouch h
INNER JOIN AP_ApplyPayVouchs  b ON h.pID  = b.pID 
LEFT JOIN Department d ON h.cDepCode = d.cDepCode 
LEFT JOIN Person p ON h.cPerson = p.cPersonCode
LEFT JOIN hr_hi_person hp ON h.cPerson = hp.cPsn_Num 
LEFT JOIN UA_User uu ON H.cOperator = UU.cUser_Name 
LEFT JOIN Inventory i ON b.cInvCode = i.cInvCode 
WHERE 1=1-- h.iStatus = 0 
	-- AND convert(varchar(10),h.dVouchDate,120) >= '2023-05-20' -- 开始同步日期，接口只处理此日期之后的记录
	AND (h.wxOaState IS NULL OR h.wxOaState = 0)
	
;
SELECT * FROM AP_ApplyPayVouch T WHERE T.cVouchID = '0000000039'
	
-- 对U8数据库表需要增加的列
ALTER TABLE UFDATA_999_2014.dbo.AP_ApplyPayVouch  ADD wxOaState int NULL;
EXEC UFDATA_999_2014.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaState';

;
SELECT * FROM hr_hi_person hhp ;
SELECT * FROM UA_User t  