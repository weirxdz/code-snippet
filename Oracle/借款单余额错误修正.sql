/**/
select er_busitem.pk_busitem,er_jkzb.djbh,er_jkzb.bbye,er_busitem.bbye,er_busitem.ybye,er_busitem.yjye,er_busitem.cjkbbje,er_jkzb.* from er_busitem er_busitem 
left join er_jkzb er_jkzb on er_jkzb.pk_jkbx=er_busitem.pk_jkbx where er_jkzb.djbh='263X2017120900001161'
;
/*update er_busitem set ybye = '5880.15',bbye = '5880.15',yjye = '5880.15' where pk_busitem = '1001B3100000000NCVSS';
commit;
*/

;

/**/
select er_busitem.pk_busitem,er_jkzb.djbh,er_jkzb.bbye,er_busitem.bbye,er_busitem.ybye,er_busitem.yjye,er_busitem.cjkbbje,er_jkzb.* from er_busitem er_busitem 
left join er_jkzb er_jkzb on er_jkzb.pk_jkbx=er_busitem.pk_jkbx where er_jkzb.djbh='263X2024042600000175'
;
--update er_busitem set ybye = '342',bbye = '342',yjye = '342' where pk_busitem = '1001B3100000002GN4G1';
--commit;
