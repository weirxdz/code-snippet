-- <往来单位性质> 枚举类别下枚举ID ID:226,编码:00,名称:供应商 ID:211,编码:01,名称:客户 ID:228,编码:02,名称:客户/供应商
select c.id, c.code,c.name,c.partnertype,c.idpartnerclass
from AA_Partner c
WHERE C.partnerType = 211 or c.partnerType = 228
;
-- 存货
SELECT m.id ,m.code ,m.name ,m.specification 
FROM AA_Inventory m
;
-- 客收款款明细
SELECT t.ID ,t.code 收款单号, c.code 客户编码,c.name 客户名称,t.amount 收款金额,t.idcurrency 币种,t.idbusitype 业务类型, t.isReceiveFlag 是否收款 ,CONVERT(varchar(50),t.voucherDate,23) 单据日期 
FROM ARAP_ReceivePayment t 
inner join AA_Partner c on t.idpartner = c.id 
where t.isReceiveFlag = 1
and CONVERT(varchar(50),t.voucherDate,23) >='${开始日期}'
order by t.voucherDate desc
--and c.code = '${客户编码}'
;
-- 客发货货明细
SELECT b.id,h.code,
	h.invoiceType 发类型型,
	h.isSaleOut 出库状态 ,-- <出库状态> 枚举类别下枚举ID ID:305,编码:00,名称:未出库 ID:15,编码:01,名称:已出库 
	h.voucherdate 销货单日期 ,
	h.taxAmount 主表含税金额 ,
	h.amount 主表金额 ,
	c.code 客编码码,c.name 客户名称,
	h.saleInvoiceNo 发票号,
	m.code 存货编码,m.name 存货名称,m.specification 规格型号,b.costPrice 成本价 ,b.quantity 数量, b.origDiscountPrice   单价,b.taxPrice  含税单价    ,b.taxAmount  含税金额 ,b.origSettleAmount 原币结算金额 ,
	b.sourceVoucherCode 来源单据编号  
FROM SA_SaleDelivery_b b
inner join SA_SaleDelivery h on b.idSaleDeliveryDTO = h.ID 
inner join AA_Inventory m on b.idinventory = m.id
inner join AA_Partner c on h.idsettlecustomer = c.id 
where cONVERT(varchar(50),h.voucherDate,23) >='${开始日期}'
and abs(b.taxAmount)>0.001
and c.code = '${客户编码}'
order by h.voucherDate desc


-- 余额表
SELECT t.ID ,t.code 收款单号, c.code 客户编码,c.name 客户名称,t.amount 收款金额,t.idcurrency 币种,t.idbusitype 业务类型, t.isReceiveFlag 是否收款 ,CONVERT(varchar(50),t.voucherDate,23) 单据日期 
FROM ARAP_ReceivePayment t 
inner join AA_Partner c on t.idpartner = c.id 
where t.isReceiveFlag = 1
and CONVERT(varchar(50),t.voucherDate,23) >='${开始日期}'
and c.code = '${客户编码}'
order by t.voucherDate desc