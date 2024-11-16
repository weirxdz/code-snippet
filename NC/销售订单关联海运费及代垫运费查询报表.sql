select  h.cchanneltypeid,nvl(h.ctradewordid,'x') from so_saleorder h where h.vbillcode = '2024018179';

select  h.vbillcode,h.dbilldate,h.cchanneltypeid,nvl(h.ctradewordid,'x') from so_saleorder h where h.cchanneltypeid = '1001B31000000001FHQ0' and h.dbilldate >= '2024-01-01' and h.ctradewordid = '~' and h.dr = 0;
-- 2024083998

select h.vbillcode,h.dbilldate,h.cchanneltypeid,nvl(h.ctradewordid,'x'),b.vbdef18,bc.name,h.badvfeeflag ,h.ctradewordid,sdb.cdeliveryid,b.nnum,isb.nnum,ssb.nnum,dpb.nmny
from so_saleorder h 
inner join so_saleorder_b b on h.csaleorderid = b.csaleorderid and b.dr = 0
inner join bd_channeltype bc on h.cchanneltypeid = bc.pk_type
left join so_delivery_b sdb on b.csaleorderbid = sdb.csrcbid
left join ic_saleout_b isb on b.csaleorderbid = isb.cfirstbillbid and isb.dr = 0
left join so_saleinvoice_b ssb on isb.cgeneralbid = ssb.csrcbid and ssb.dr = 0
left join dm_prepaidinvoice_b dpb on h.csaleorderid = dpb.csrcid and dpb.dr = 0
where h.vbillcode = '2024083998' and h.dr = 0
;

select h.csaleorderid,b.csaleorderbid,sdb.dbilldate,isb.dbizdate,ssb.dbilldate,h.vbillcode,h.dbilldate,h.cchanneltypeid,nvl(h.ctradewordid,'x'),b.vbdef18,bc.name,h.badvfeeflag ,h.ctradewordid,sdb.cdeliveryid,b.nnum,isb.nnum,ssb.nnum
from so_saleorder h 
inner join so_saleorder_b b on h.csaleorderid = b.csaleorderid and b.dr = 0
inner join bd_channeltype bc on h.cchanneltypeid = bc.pk_type
left join so_delivery_b sdb on b.csaleorderbid = sdb.csrcbid
left join ic_saleout_b isb on b.csaleorderbid = isb.cfirstbillbid and isb.dr = 0
left join so_saleinvoice_b ssb on isb.cgeneralbid = ssb.csrcbid and ssb.dr = 0
where h.vbillcode = '2024083998' and h.dr = 0
;

select h.vbillcode,h.dbilldate,h.cchanneltypeid,nvl(h.ctradewordid,'x'),b.vbdef18,bc.name,h.badvfeeflag ,h.ctradewordid,dpb.nmny
from so_saleorder h 
inner join so_saleorder_b b on h.csaleorderid = b.csaleorderid and b.dr = 0
inner join bd_channeltype bc on h.cchanneltypeid = bc.pk_type
left join dm_prepaidinvoice_b dpb on h.csaleorderid = dpb.csrcid and dpb.dr = 0
where h.vbillcode = '2024083998' and h.dr = 0
;
