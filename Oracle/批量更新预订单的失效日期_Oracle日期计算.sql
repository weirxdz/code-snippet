select h.dabatedate ,to_char(to_date( h.dabatedate,'yyyy-mm-dd hh24:mi:ss')+30,'yyyy-mm-dd hh24:mi:ss') from so_preorder h 

-- update so_preorder set dabatedate = to_char(to_date( dabatedate,'yyyy-mm-dd hh24:mi:ss')+30,'yyyy-mm-dd hh24:mi:ss') where dabatedate is not null;
-- commit;
;
select distinct  t.zyx1,
       t.zyx10,
       t.zyx11,
       t.zyx12,
       t.zyx14,
       t.zyx15,
       t.zyx16,
       t.zyx17,
       t.zyx18,
       t.zyx19,
       t.zyx2,
       t.zyx20,
       t.zyx21,
       t.zyx22,
       t.zyx23,
       t.zyx24,
       t.zyx25,
       t.zyx26,
       t.zyx27,
       t.zyx3,
       t.zyx8,
       t.zyx9
from er_bxzb t
