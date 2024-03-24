CREATE OR REPLACE TRIGGER so_saleorder_ddbmjy01--订单校验
  before insert
  on so_saleorder
  for each row
declare
  var_mjbm        integer;
  var_tybm        integer;
  v_vdef6 org_dept.def6%TYPE;
begin
   -- 校验销售部门，2023-11-21
   -- 1、停用部门不能使用(名称里包含"停用"、"禁用"字符)
   -- 2、非末级部门不能使用

   -- 查询部门是否末级,看部门主键是否存在于上级部门字段中
   select count(d.name) into var_mjbm from org_dept d where d.pk_fatherorg = :new.cdeptid and d.dr = 0 and d.enablestate = 2;
   -- 如果部门非末级,即 var_mjbm 大于等于1，弹出报错信息
   if var_mjbm >=1 then
     raise_application_error(-20002,'不允许使用非末级部门，请修改！');
   end if;
   -- 查询部门名称是否包含"停用"、"禁用"字符
   select count(d.name) into var_tybm from org_dept d where d.pk_dept = :new.cdeptid and d.dr = 0 and d.enablestate = 2 and (d.name like '%停用%' or d.name like '%禁用%' );
   -- 如果部门非末级 或者 部门名称包含"停用"、"禁用"字符，弹出报错信息
   if var_tybm >=1 then
     raise_application_error(-20002,'不允许使用已停用的部门，请修改！');
   end if;
   -- 获取pk_dept对应的部门表中的vdef6字段值
   SELECT def6 INTO v_vdef6 FROM org_dept WHERE pk_dept = :new.cdeptid and islastversion = 'Y';
   -- 检查vdef6字段值是否为'Y'
   IF v_vdef6 = 'N' or v_vdef6 = '~' THEN
    -- 如果vdef6为'N'，则抛出异常并回滚事务
    RAISE_APPLICATION_ERROR(-20001, '部门档案非法，请使用正确的销售部门！');
   END IF;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
    -- 如果找不到对应的部门记录，忽略错误
    NULL;
   

end ;