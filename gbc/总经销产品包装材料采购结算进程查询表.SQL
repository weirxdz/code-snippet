select OD.Status ,OD.MoClass ,od.MoDId,o.MoId,o.MoCode,morder.StartDate,morder.DueDate,od.InvCode 产品编码 ,m.cInvName,COALESCE(od.Qty,0) 生产订单数量  ,od.SortSeq
from mom_order o
inner join mom_morder morder on o.MoId = morder.MoId
left join mom_orderdetail od on o.MoId = od.MoId
inner join Inventory m on od.InvCode = m.cInvCode
where 
--od.Status = 3 --and OD.MoDId = '${MoDId}'	and morder.StartDate >='2023-01-01 00:00:00.000'
	--and CONVERT(decimal(26,6),od.QualifiedInQty) = 0.000000
--	AND OD.MoClass = 2
--	AND
	OD.Define28 IS NOT NULL
--	AND o.MoCode = '20240116002'
order by o.MoId desc

;
-- moc.Qty 需求量 是考虑了损耗率的量
select OD.DEFINE28 生产计划号,p.cInvCode 产品编码,p.cInvName 产品名称,p.cInvStd 产品规格,O.MoCode 生产订单号,od.Status ,CASE od.Status WHEN 1 THEN '未审核' WHEN 2 THEN '锁定' WHEN 3 THEN '审核' WHEN 4 THEN '关闭' ELSE '' end 订单状态 ,COALESCE(od.Qty,0) 计划生产数量,COALESCE(od.QualifiedInQty,0) 生产入库数量,m.cInvCode 包材编码,m.cInvName 包材名称,m.cInvStd 包材规格,m.cInvCCode --ROUND(od.Qty*moc.BaseQtyN/moc.BaseQtyD,1) 应领料数量,moc.IssQty 已领料量,moc.Qty 需求量,moc.CompScrap 
from mom_order o
inner join mom_morder morder on o.MoId = morder.MoId
left join mom_orderdetail od on o.MoId = od.MoId
inner join Inventory p on od.InvCode = p.cInvCode
left join mom_moallocate moc on od.MoDId = moc.MoDId
left join Inventory AS M ON moc.InvCode = M.cInvCode
left join InventoryClass ic on m.cInvCCode = ic.cInvCCode 
WHERE 1=1
	--and OD.DEFINE28 IS NOT NULL
	and O.MoCode = '20240410001'
	and LEFT(m.cInvCCode,2) = '02'
;
-- 请购
select b.cDefine28 ,h.cCode ,b.cInvCode ,COALESCE(b.fQuantity,0)  请购数量,COALESCE(iReceivedQTY,0) 累计订货数量  
from PU_AppVouchs b
inner join PU_AppVouch h on b.ID = h.ID 
where 1=1
	and b.cDefine28 is not null
;
-- 采购订单
select b.cDefine28 ,h.cPOID ,v.cVenCode ,v.cVenName ,COALESCE(b.iQuantity,0) 采购订单数量,COALESCE(b.freceivedqty,0)  合格品入库数量 ,COALESCE(b.fPoValidQuantity,0) 合格数量,COALESCE(b.iArrQTY,0)  到货数量  ,COALESCE(b.fPoArrQuantity,0)  到货数量,COALESCE(b.iReceivedQTY,0) 累计到货数量    ,COALESCE(b.fPoRefuseQuantity,0)  拒收数量,COALESCE(b.iInvQTY,0)  累计发票数量  
from PO_Podetails b
inner join PO_Pomain h on b.POID = h.POID 
inner join Vendor v on h.cVenCode = v.cVenCode 
inner join Inventory i on b.cInvCode = i.cInvCode
where 1=1 
	and b.cDefine28 is not null
;
