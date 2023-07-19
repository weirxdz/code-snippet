select t.cPzID ,t.cPZNum ,t.doutbilldate,t.cDefine1 
from Ap_CloseBill t
;
-- 启用收付款单据表头自定义项2，记录是否统计，值为N胡不统计
select distinct t.cDefine2
from Ap_CloseBill t
;
 
-- 启用应收应付单据表头自定义项2，记录是否统计，值为N胡不统计
select distinct t.cDefine2
from Ap_Vouch t
;
select *
from Ap_Vouch t
where t.cPZNum = '15-0094' 