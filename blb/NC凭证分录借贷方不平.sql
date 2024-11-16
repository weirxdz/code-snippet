select
pk_detail, 
detailindex 分录号,accountcode 科目,
creditamount 原币贷方金额,globalcreditamount 全局本币贷方,groupcreditamount 集团本币贷方,localcreditamount 组织本币贷方,
debitamount  原币借方金额,globaldebitamount  全局本币借方,groupdebitamount  集团本币借方,localdebitamount  组织本币借方,
gl_detail.*
from gl_detail gl_detail
where yearv='2023' and periodv='06' and /*accountcode='1122' and*/ nov='968'

--update gl_detail gl_detail
--       set gl_detail.debitamount='-21988.00000000' where gl_detail.pk_detail='1001B310000000089WNU' ;
--update gl_detail gl_detail
--       set gl_detail.creditamount='-21988.00000000' where gl_detail.pk_detail='1001B310000000089WNV' ;
--commit;
--
--update gl_detail gl_detail
--       set gl_detail.creditamount='0.00000000' where gl_detail.pk_detail='1001B310000000034HB2' ;
--commit;

--update gl_detail gl_detail
--       set gl_detail.creditamount='-76606.28' where gl_detail.pk_detail='1001B31000000025WKDW' AND gl_detail.creditamount='76606.28';
--commit;