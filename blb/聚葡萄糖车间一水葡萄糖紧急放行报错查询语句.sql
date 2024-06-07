/*select h.vbillcode,b.pk_material,b.pk_srcmaterial
from po_arriveorder_b b
left join po_arriveorder h on b.pk_arriveorder = h.pk_arriveorder
left join po_arriveorder_bb bb on b.pk_arriveorder_b = bb.pk_arriveorder_b
where h.vbillcode in( '2020010003','2020010004');
*/
select o.name,
             st.dr,
              st.iscancelremain,
              st.martype,
              st.modifiedtime,
              st.modifier,
              st.outpriority,
              st.pk_marpuclass,
              st.pk_material,
              st.pk_materialstock,
              st.pk_org,
              st.remain,
              st.remainday,
              st.ts,
              st.wholemanaflag
from bd_materialstock st
left join bd_material m on st.pk_material = m.pk_material
left join org_stockorg o on st.pk_org = o.pk_stockorg

where m.code = '010010012' and o.name in ('果糖联产车间','聚葡萄糖车间');

select 
             st.dr,
              st.iscancelremain,
              st.martype,
              st.modifiedtime,
              st.modifier,
              st.outpriority,
              st.pk_marpuclass,
              st.pk_material,
              st.pk_materialstock,
              st.pk_org,
              st.remain,
              st.remainday,
              st.ts,
              st.wholemanaflag
from bd_materialstock st
where st.pk_materialstock in ('1001B31000000007KWAT','1001B310000000004G0Z','1001B3100000000DF81Z','1001B3100000000DF81Q','1001B3100000000YH35T','1001B3100000000YH37N')
for update

