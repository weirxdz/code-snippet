select o.name,w.name,m.name,sum(nonhandnum )
from ic_onhanddim d
left join ic_onhandnum h on d.pk_onhanddim = h.pk_onhanddim
left join bd_stordoc w on d.cwarehouseid = w.pk_stordoc
left join bd_material m on d.cmaterialoid = m.pk_material
left join org_stockorg o on d.pk_org = o.pk_stockorg
where w.name like '%³ÉÆ·%'
group by o.name,w.name,m.name
