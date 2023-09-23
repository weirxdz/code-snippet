select * from so_saleorder_b where nvl(vdef21,'~')<>'~';

update so_saleorder_b set vdef23 = '~' where  nvl(vdef21,'~')<>'~';
commit;
