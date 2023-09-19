select substr(so_saleorder_b.dbilldate,1,10) saledate, so_saleorder_b.csaleorderbid, so_saleorder_b.csaleorderid,substr(pb.dbizdate,1,10) rk_date,pb.cgeneralbid pbbid, pb.cgeneralhid pbhid,b.cgeneralbid bid, substr(b.dbizdate,1,10) ck_date,b.cgeneralhid hid,po_order_b.pk_order, po_order_b.pk_order_b
from so_saleorder_b so_saleorder_b
left join ic_saleout_b b on so_saleorder_b.csaleorderbid = b.cfirstbillbid and nvl(b.dr,0) = 0 
left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid and nvl(h.dr,0) = 0 
left join po_order_b po_order_b on so_saleorder_b.csaleorderbid = po_order_b.csourcebid and nvl( po_order_b.dr,0) = 0 
left join ic_purchasein_b pb on po_order_b.pk_order_b = pb.cfirstbillbid and nvl(pb.dr,0) = 0
where nvl( so_saleorder_b.dr,0) = 0  and po_order_b.pk_order is not null

;
select h.vbillcode 
from ic_saleout_b b 
left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid
where b.cgeneralbid = '1001B31000000003A95M'
