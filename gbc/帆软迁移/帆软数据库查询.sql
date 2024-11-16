-- 用户表
select fu.id,fu.enable,fu.realAlias,fu.realName,fu.userAlias,fu.userName
from fine_user fu 
left join on fu.

;
-- 部门表
select fd.id ,fd.name ,fd.parentId ,fd.fullPath 
from  FINE_DEPARTMENT fd
;
-- 职位表
select fp.id ,fp.name
from fine_post fp 
;
-- 部门职位的中间表
select fdr.id ,fdr.departmentId ,fdr.postId ,fd.name ,fp.name 
from fine_dep_role fdr 
left join fine_department fd on fdr.departmentId = fd.id 
left join fine_post fp on fdr.postId = fp.id 
;
-- FINE_CUSTOM_ROLE  自定义角色表
select fcr.id ,fcr.name 
from fine_custom_role fcr 
;
-- FINE_USER_ROLE_MIDDLE  用户角色的中间表
select fur.id ,fur.userId ,fur.roleId ,case when fur.roleType = 1 then '部门职位'   when fur.roleType = 2 then '自定义角色'  end roleType,fu.realName ,fd.name ,fp.name 
from fine_user_role_middle fur 
left join fine_user fu on fur.userId = fu.id 
left join fine_dep_role fdr on fur.roleId = fdr.id 
left join fine_department fd on fdr.departmentId = fd.id 
left join fine_post fp on fdr.postId = fp.id 

;
-- FINE_AUTHORITY 权限表
select fa.id,case fa.AUTHORITYENTITYTYPE  when 0 then '目录权限'  end AUTHORITYENTITYTYPE,case AUTHORITYTYPE when 1 then '查看权限' end AUTHORITYTYPE ,case when fa.authority = 1 then '拒绝' when fa.authority = 2 then '允许' end authority,fa.authority ,case fao.EXPANDTYPE when 1 then '平台管理系统节点'  when 2 then '首页'  when 3 then '目录'  when 5 then '链接'  when 6 then '文件'  when 102 then 'FineReport报表' end EXPANDTYPE,fao.displayName ,fu.realName,case when fur.roleType = 1 then '部门职位'   when fur.roleType = 2 then '自定义角色'  end roleType,fu1.realName ,fd.name ,fp.name 
from fine_authority fa 
left join fine_authority_object fao on fa.authorityEntityId = fao.id 
left join fine_user fu on fa.roleId = fu.id 
left join fine_user_role_middle fur on fa.roleId = fur.roleId 
left join fine_user fu1 on fur.userId = fu1.id 
left join fine_dep_role fdr on fur.roleId = fdr.id 
left join fine_department fd on fdr.departmentId = fd.id 
left join fine_post fp on fdr.postId = fp.id 

where fa.AUTHORITYENTITYTYPE = 0 and fa.AUTHORITYTYPE = 1

;
-- FINE_AUTHORITY_OBJECT  权限实体表
select fao.id ,fao.*
from fine_authority_object fao 