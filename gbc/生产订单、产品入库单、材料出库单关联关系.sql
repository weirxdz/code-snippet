select OD.Status ,OD.MoClass ,od.MoDId,o.MoId,o.MoCode,morder.StartDate,morder.DueDate,od.InvCode 产品编码 ,m.cInvName,od.Qty 生产订单数量  ,od.SortSeq
from mom_order o
inner join mom_morder morder on o.MoId = morder.MoId
left join mom_orderdetail od on o.MoId = od.MoId
inner join Inventory m on od.InvCode = m.cInvCode
where od.Status = 3 --and OD.MoDId = '${MoDId}'
	and morder.StartDate >='2023-01-01 00:00:00.000'
	--and CONVERT(decimal(26,6),od.QualifiedInQty) = 0.000000
	AND OD.MoClass = 2
	AND o.MoCode = '20240116002'
order by o.MoId desc
;
select moc.AllocateId ,o.MoId,o.MoCode,morder.StartDate,morder.DueDate,od.MoDId,od.InvCode 产品编码 ,od.Qty 生产订单数量 ,M.cInvCode 存货编码,M.cInvName 存货名称,ROUND(od.Qty*moc.BaseQtyN/moc.BaseQtyD,1) 领料数量,moc.IssQty 已领料量,moc.Qty 需求量
from mom_order o
inner join mom_morder morder on o.MoId = morder.MoId
left join mom_orderdetail od on o.MoId = od.MoId
inner join mom_moallocate moc on od.MoDId = moc.MoDId 
left join Inventory AS M ON moc.InvCode = M.cInvCode
inner join (SELECT ccode, cname, cunitcode, typename, shortname, Inventory_category, ICcode, s_strength   from openrowset ('MSDASQL','DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2049','SELECT ccode, cname, cunitcode, typename, shortname, Inventory_category, ICcode, s_strength
FROM fr_rw_rds_product t') where 1=1 ) p on M.cInvCode = p.ccode
where od.Status = 3  
	--and OD.MoDId = '${MoDId}'
	and morder.StartDate >='2023-01-01 00:00:00.000'
	AND OD.MoClass = 2
	AND o.MoCode = '20240116002'
order by o.MoId desc;

SELECT * FROM mom_orderdetail T WHERE T.MoDId = 1000156932
;
SELECT * FROM mom_moallocate T WHERE T.MoDId = 1000156932
;

SELECT r.ID ,R.cSource ,r.cBusType ,r.iMQuantity ,r.cPsPcode ,r.cMPoCode ,r.iproorderid  FROM rdrecord11 r WHERE R.cCode = '202401160014'
;
select t.AutoID ,t.ID ,t.iMPoIds ,t.cmocode ,t.invcode ,t.imoseq ,t.iopseq,t.ipesodid ,t.ipesotype ,t.cpesocode ,t.ipesoseq from rdrecords11 t where t.ID = 1000654251
;

