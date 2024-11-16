-- AS2024092600003264
select g.rowid,s.name,g.*
from purp_supquotelog g
left join purp_askbill h on h.pk_askbill=g.pk_askbill
left join bd_supplier s on g.pk_supplier = s.pk_supplier
where h.vbillcode='AS2024092700003264'
order by g.pk_supplier
for update
  ;-- AS20240492600003261
select g.rowid,s.name,g.*
from purp_supquotelog g
left join purp_askbill h on h.pk_askbill=g.pk_askbill
left join bd_supplier s on g.pk_supplier = s.pk_supplier
where h.vbillcode='AS2024092600003261'
order by g.pk_supplier
for update
  ;
  
  -- AS2024042400002780
select g.rowid,s.name,g.*
from purp_supquotelog g
left join purp_askbill h on h.pk_askbill=g.pk_askbill
left join bd_supplier s on g.pk_supplier = s.pk_supplier
where h.vbillcode='AS2024042400002780'
order by g.pk_supplier
for update
  ;

select g.rowid,s.name,g.*
from purp_supquotelog g
left join purp_askbill h on h.pk_askbill=g.pk_askbill
left join bd_supplier s on g.pk_supplier = s.pk_supplier
where h.vbillcode='AS2023072000001702'
order by g.pk_supplier
for update
  ;



select g.rowid,h.vbillcode,s.name,g.price,g.memo,g.quotetime,h.daskdate,g.quotetime,
                                                                        g.pk_askbill,
                                                                        g.pk_askbill_b,
                                                                        g.ts
from purp_supquotelog g
left join purp_askbill h on h.pk_askbill=g.pk_askbill
left join purp_askbill_b b on b.pk_askbill_b = g.pk_askbill_b
left join bd_supplier s on g.pk_supplier = s.pk_supplier
left join purp_priceaudit_b pb on pb.csrcbid = b.pk_askbill_b
inner join purp_priceaudit ph on pb.pk_priceaudit = ph.pk_priceaudit
where h.vbillcode='AS2023052200001526'
      and h.vdef3 = 3
order by g.pk_supplier

;


select 
from purp_supquotelog g
where g.pk_askbill_b = 



select b.csrcbid 
from purp_priceaudit_b b
inner join purp_priceaudit h on b.pk_priceaudit = h.pk_priceaudit
where h.vbillcode = '282023052300000588'
;

select distinct h.dr,h.vbillcode, h.vdef3,h.pk_askbill,h.* from purp_askbill h where h.vbillcode in( 'AS2023052400001542','AS2023052300001529','AS2023052200001526')
