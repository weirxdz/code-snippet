-- 附件视图 v_file
CREATE VIEW v_file AS 
SELECT t.VoucherTypeID as voucherTypeID ,t.VoucherID as voucherID,t.FileID as fileId,t.FileName as fileName,t.FileContent as fileContent FROM VoucherAccessories t;
-- 推送企业微信的付款申请单主表视图
-- 100 迈凯诺
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624639923' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                  p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                  hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                  dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                  dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                  dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                  dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                  dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                  dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                  h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                  h.wxOaState = '')
  ;
 -- 110 浩阳
  CREATE  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624879501' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                  p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                  hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                  dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                  dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                  dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                  dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                  dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                  dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                  h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                  h.wxOaState = '')
  ;
 -- 120 精筑再生资源
  CREATE  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1731050095878' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                  p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                  hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                  dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                  dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                  dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                  dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                  dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                  dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                  h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                  h.wxOaState = '')
  ;
-- 400 华筑
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624812957' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 

-- 500 防火
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624825621' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 
-- 510 深圳防火
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1731034913150' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 

-- 600 耐火
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624832445' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 

-- 700 众诺
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624839413' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 

-- 800 江浙
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624846301' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 
                
                
                
-- 610 四川耐火
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1725949950875' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 
-- 900 西部
  ALTER  VIEW [dbo].[v_AP_ApplyPayVouch]
  AS
  SELECT   h.PID AS id,'option-1712624866525' company, h.cVouchID, h.dVouchDate, v.cVenName AS supplier, v.cVenBank cVenBank,v.cVenAccount cVenAccount, d.cDepName AS deptname, 
                p.cPersonName AS clerkname, ISNULL(uu.cUserEmail, N'XiaoTong') AS wxId, ISNULL(pp.cPsnPostAddr, N'XiaoTong') AS fkspr, uu.cUserEmail, 
                hp.cPsnPostAddr, h.cDigest, h.wxOaState, h.cOperator, h.cCheckMan, h.dverifydate, h.dverifysystime
                  ,CASE WHEN v.cVenName = '山东迈凯诺安防科技有限公司' THEN 'option-1726645432655' ELSE 'option-1726645432656' END cVenType
  FROM      dbo.AP_ApplyPayVouch AS h LEFT OUTER JOIN
                dbo.Department AS d ON h.cDepCode = d.cDepCode LEFT OUTER JOIN
                dbo.Vendor AS v ON h.cDwCode = v.cVenCode LEFT OUTER JOIN
                dbo.Person AS p ON h.cPerson = p.cPersonCode LEFT OUTER JOIN
                dbo.hr_hi_person AS hp ON h.cPerson = hp.cPsn_Num LEFT OUTER JOIN
                dbo.hr_hi_person AS pp ON h.cDefine9 = pp.cPsn_Num LEFT OUTER JOIN
                dbo.UA_User AS uu ON h.cOperator = uu.cUser_Name
  WHERE   (1 = 1) AND (h.cCheckMan IS NULL OR
                h.cCheckMan = '') AND (h.wxOaState IS NULL OR
                h.wxOaState = ''); 


 -- 子表视图
  CREATE VIEW v_AP_ApplyPayVouch_b AS 
  SELECT
    b.pid AS id,
    b.cInvCode ,
    i.cInvName,
    i.cInvStd  ,
    b.iApplyAmt 
  FROM
    AP_ApplyPayVouchs b
    left JOIN Inventory i ON b.cInvCode = i.cInvCode
    INNER JOIN AP_ApplyPayVouch h ON b.PID = h.PID --AND (h.cCheckMan IS NULL OR h.cCheckMan = '') 
    ;