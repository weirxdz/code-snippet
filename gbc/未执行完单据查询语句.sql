select H.ID ,H.cCode ,H.dDate ,B.cInvCode ,i.cInvName ,i.cInvStd ,b.fQuantity 请购数量,b.iReceivedQTY 订单数量
from PU_AppVouch h
inner join PU_AppVouchs b on b.ID = h.ID 
INNER JOIN Inventory i on b.cInvCode = i.cInvCode 
left join PO_Podetails pp on b.AutoID = pp.iAppIds 
where b.cbcloser is null 
	--and b.fQuantity > b.iReceivedQTY 
;

select H.POID ,H.cPOID  ,H.dPODate ,v.cVenCode ,v.cVenName  ,B.cInvCode ,i.cInvName ,i.cInvStd ,b.iQuantity  订单数量,B.iArrQTY  累计到货数量--,b.fPoRetQuantity   退货数量,B.freceivedqty  合格品入库数量 ,  b.iInvQTY 累计发票数量   ,h.cCloser --,B.*
from PO_Pomain  h
inner join PO_Podetails  b on b.POID  = h.POID 
INNER JOIN Inventory i on b.cInvCode = i.cInvCode 
inner join Vendor v on h.cVenCode = v.cVenCode 
--left join PU_ArrivalVouchs pav on b.ID = pav.iPOsID  
where b.cbcloser is null and h.cCloser is null 
	--and b.fQuantity > b.iReceivedQTY 
;
select H.ID,h.iverifystate   ,H.cCode ,H.dDate ,v.cVenCode ,v.cVenName  ,B.cInvCode ,i.cInvName ,i.cInvStd ,b.iQuantity  到货单数量 ,b.fInspectQuantity   累计报检数量,b.fValidInQuan 合格品入库数量,b.fInValidInQuan  不合格品入库数量 , b.fRefuseQuantity  拒收数量 ,h.ccloser 
from PU_ArrivalVouchs b
inner join PU_ArrivalVouch h on b.ID = h.ID 
INNER JOIN Inventory i on b.cInvCode = i.cInvCode 
inner join Vendor v on h.cVenCode = v.cVenCode
where b.cbcloser is  null and b.iQuantity > (b.fValidInQuan+b.fInValidInQuan+b.fRefuseQuantity)
;
select H.ID,h.iverifystate ,H.cCode ,H.dDate ,v.cVenCode ,v.cVenName  ,B.cInvCode ,i.cInvName ,i.cInvStd ,b.iQuantity  入库单数量 ,h.cHandler 审核人,h.bpufirst,h.biafirst 
from RdRecords01  b
inner join RdRecord01 h on b.ID = h.ID 
INNER JOIN Inventory i on b.cInvCode = i.cInvCode 
inner join Vendor v on h.cVenCode = v.cVenCode
where h.cHandler  is  null and h.bpufirst <> 1
;
select distinct bIsSTQc,biafirst ,bpufirst from RdRecord01;
select H.ID,h.iverifystate ,H.cCode ,H.dDate ,B.cInvCode ,i.cInvName ,i.cInvStd ,b.iQuantity  入库单数量 ,h.cHandler 审核人
from RdRecords10  b
inner join RdRecord10 h on b.ID = h.ID 
INNER JOIN Inventory i on b.cInvCode = i.cInvCode 
where h.cHandler  is  null 
;
select b.MoDId ,b.MoId ,h.MoCode 生产订单号,b.SortSeq 行号  ,h.CreateDate ,i.cInvCode ,i.cInvName ,i.cInvStd ,b.Qty 生产订单数量,b.QualifiedInQty 入库数量  ,b.RelsUser 审核人 ,case b.Status when 1 then '开立' when 2 then '锁定' when 3 then '审核'  when 4 then '关闭' END 状态 
from mom_orderdetail b
inner join Inventory i on b.InvCode = i.cInvCode 
inner join mom_order h on b.MoId = h.MoId 
where b.CloseUser is null and b.Status <> 4
;
select b.MoDId ,b.MoId ,h.MoCode ,h.CreateDate ,i.cInvCode ,i.cInvName ,i.cInvStd ,b.Qty 生产订单数量,b.QualifiedInQty 入库数量  ,b.RelsUser 审核人 ,case b.Status when 1 then '开立' when 2 then '锁定' when 3 then '审核'  else '关闭' END 状态
from mom_orderdetail b
inner join Inventory i on b.InvCode = i.cInvCode 
inner join mom_order h on b.MoId = h.MoId 
where h.MoCode = '20130403001'
;
select distinct b.Status
from mom_orderdetail b
inner join Inventory i on b.InvCode = i.cInvCode 
inner join mom_order h on b.MoId = h.MoId 
;

select H.ID  ,H.cSOCode  ,H.dDate  ,c.cCusCode  ,c.cCusName  ,B.cInvCode ,i.cInvName ,i.cInvStd ,b.iQuantity  订单数量,b.iFHQuantity 发货数量,1
from SO_SOMain h
inner join SO_SODetails b on b.ID  = h.ID  
INNER JOIN Inventory i on b.cInvCode = i.cInvCode 
inner join Customer c on h.cCusCode  = c.cCusCode  
where b.cSCloser  is null and h.cCloser is null 
	and b.iQuantity > b.iFHQuantity 