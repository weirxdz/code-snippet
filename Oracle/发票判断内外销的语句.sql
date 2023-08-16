select so_saleinvoice.vbillcode,so_saleinvoice.ccurrencyid,t.name,so_saleinvoice.vtrantypecode,case when  so_saleinvoice.vtrantypecode='32-Cxx-01'  then  '出口' when so_saleinvoice.vtrantypecode<>'32-Cxx-01' and so_saleinvoice.corigcurrencyid  <> '1002Z0100000000001K1' and so_saleinvoice.vtrantypecode<>'32-01'and so_saleinvoice.vtrantypecode<>'32-02'  then '出口'  else   '内销'  end ,
bd_billtype.billtypename,case fbuysellflag when 1 then '国内销售' when 3 then '出口' end 购销类型
from so_saleinvoice
left join bd_currtype t on so_saleinvoice.corigcurrencyid  = t.pk_currtype
left join bd_billtype on so_saleinvoice.ctrantypeid = bd_billtype.pk_billtypeid
--where so_saleinvoice.vbillcode = '202301013'
