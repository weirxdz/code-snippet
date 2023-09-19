select b.cdelivbill_bid,ib.cbodywarehouseid warehouseid,ib.pk_org storeorgid
from dm_delivbill_b b
left join dm_delivbill h on b.cdelivbill_hid = h.cdelivbill_hid and h.dr = 0
left join so_delivery_b db on b.csrcbid = db.cdeliverybid and db.dr = 0
left join ic_saleout_b ib on db.cdeliverybid = ib.csourcebillbid and nvl(ib.dr,0) = 0
where b.dr = 0 and substr(h.dbilldate,1,4) >= '2022' and b.vsrctype = '4331'

union all
select b.cdelivbill_bid,b.csendstoreid warehouseid,b.csendstoreorgid storeorgid
from dm_delivbill_b b
left join dm_delivbill h on b.cdelivbill_hid = h.cdelivbill_hid and h.dr = 0
where b.dr = 0 and substr(h.dbilldate,1,4) >= '2022' and nvl(b.vsrctype,'~') <> '4331'
