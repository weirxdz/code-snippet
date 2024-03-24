-- 付款申请单参照销售出库单生成，查看付款申请单上来源单据的相关字段

SELECT t.PID ,t.cVouchID  ,t.dvouchDate ,t.cOperator ,t.dcreatesystime , t.cCheckMan ,t.dverifydate  ,t.dverifysystime  ,t.wxOaState ,t.wxOaSpNo ,t.wxOaDate, t.cSource ,t.cSource ,t.*--,t.iBVid ,t.iPOsID 
FROM AP_ApplyPayVouch t ;

SELECT h.cVouchID ,h.cSource ,b.cSource ,b.PID,b.cCoVouchID  ,b.iBVid ,b.iPOsID ,b.cInvCode,b.iBVid,b.iPOsID,b.cCoVouchType
FROM AP_ApplyPayVouchs b
INNER JOIN AP_ApplyPayVouch h ON b.PID = h.PID 
WHERE b.cCoVouchID = 'CGDD202401150061';

SELECT t.cPOID ,t.POID  FROM PO_Pomain t WHERE t.cPOID = 'CGDD202401150061';

付款申请单表头
cSource 来源，cPerson 业务员，cDigest 备注  ，表头自定义项

付款申请单表体
cSource 来源，cCoVouchID 来源单据号  ，cInvCode  存货编码 ， iBVid 订单/发票子表ID  ，iPOsID 发票订单字表ID  ，表体自定义项

