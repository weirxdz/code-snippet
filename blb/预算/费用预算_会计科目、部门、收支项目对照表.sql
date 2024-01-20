/*select a.pk_accasoa,
       a.pk_accchart,
       a.pk_account,a.dispname, a.name 
from bd_accasoa a
where a.pk_accchart = '0001Z01000ACCCHART01';
select t.pk_account,t.pk_accchart, t.code,t.name,1 from bd_account t
where t.pk_accchart = '0001Z01000ACCCHART01'
;
select t.code,
       t.name,
       t.pk_accchart,
       t.pk_org from bd_accchart t
       
;*/

-- 会计科目，用自定义项1 记录预算项目 ，用自定义项2 记录预算控制项目
select c.pk_account 科目主键,c.code 科目编码,a.name 科目名称,a.def1 预算项目,a.def2 预算控制项目
from bd_account c
left join bd_accasoa a on c.pk_account = a.pk_account
where c.pk_accchart = '0001Z01000ACCCHART01' and a.pk_accchart = '0001Z01000ACCCHART01'

;
-- 收支项目，用自定义项1 记录预算项目 ，用自定义项2 记录预算控制项目
select t.pk_inoutbusiclass, t.code, t.name,  t.def1 预算项目, t.def2 预算控制项目
from bd_inoutbusiclass t
order by t.code
;

-- 预算部门，取财务组织下的部门,用自定义项3记录预算部门
select s.code, s.name,d.code, d.name,d.def3 预算组织,d.def4 预算部门
from org_dept d
left join org_orgs s on d.pk_org = s.pk_org
where s.code = 'blb01'
