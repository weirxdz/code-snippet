select  CURRDIGIT, unitcurrdigit from bd_currtype where NAME='越南盾';

update bd_currtype set CURRDIGIT=2, unitcurrdigit=6 where NAME='越南盾';

update bd_currtype set CURRDIGIT='0',modifiedtime=to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),ts=to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') where name = '越南盾';
update bd_cachetabversion set CACHETABVERSION=to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') where cachetabname='bd_currtype';


select CACHETABVERSION from bd_cachetabversion  where cachetabname='bd_currtype';;