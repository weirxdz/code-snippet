CREATE OR REPLACE TRIGGER trg_check_vdef6
BEFORE INSERT OR UPDATE ON so_saleorder
FOR EACH ROW
DECLARE
  v_vdef6 org_dept.def6%TYPE;
BEGIN
  -- 获取pk_dept对应的部门表中的vdef6字段值
  SELECT def6 INTO v_vdef6 FROM org_dept WHERE deptno = :NEW.pk_dept and islastversion = 'Y';

  -- 检查vdef6字段值是否为'Y'
  IF v_vdef6 = 'N' THEN
    -- 如果vdef6为'N'，则抛出异常并回滚事务
    RAISE_APPLICATION_ERROR(-20001, '部门档案已停用，不允许使用！');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- 如果找不到对应的部门记录，忽略错误
    NULL;
END trg_check_vdef6;