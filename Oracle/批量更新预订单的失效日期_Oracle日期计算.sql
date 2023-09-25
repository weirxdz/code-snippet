select h.dabatedate ,to_char(to_date( h.dabatedate,'yyyy-mm-dd hh24:mi:ss')+30,'yyyy-mm-dd hh24:mi:ss') from so_preorder h 

-- update so_preorder set dabatedate = to_char(to_date( dabatedate,'yyyy-mm-dd hh24:mi:ss')+30,'yyyy-mm-dd hh24:mi:ss') where dabatedate is not null;
-- commit;
