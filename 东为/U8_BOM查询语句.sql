SELECT b.BomId ,b.*
FROM Bom_opcomponent b
LEFT JOIN bom_bom h ON b.BomId = h.BomId 
LEFT JOIN bom_parent bp ON h.BomId = bp.BomId 
LEFT JOIN bas_part bp2 ON bp.ParentId = bp2.PartId 
WHERE bp2.InvCode in( '5102080202','5101010115')

;

SELECT * FROM bas_part bp 
;

-- UPDATE Bom_opcomponent SET FVFlag = 1 WHERE OpComponentId = 1000069138

--1、inventory 表与BOM_BOM之间联系为：inventory 表中cinvcode 与bas_part 表中 invcode关联。同一个存货，建立了不同的自由项，就会在bas_part表中建立不同的物料记录。bom_parent 表中   parentid 与 bas_part 表中 partid 关联，bom_parent 表中   bomid 与 bom_bom  表中 bomid 关联 
--2、BOM对应的表为：Bom_opcomponent是物料清单子件表，
--通过BomId与bom_bom表关联。
--通过ComponentId 与bas_part表的物料关联。
--通过OptionsId 与bom_opcomponentopt （子件选项资料表）关联。
--通过OpComponentId 与bom_opcomponentloc（子件定位符资料表）、bom_opcomponentrmk（子件备注资料表）、bom_opcomponentsub（子件替代料表）关联 
--查询错误的方法为：
--1、首先查询inventory 表与bas_part 表中的记录的对应关系，对应的语句为：select * from inventory where cinvcode notin (select  invcode from bas_part)--bas_part表中少记录select * from bas_part  where invcode not in (select cinvcode frominventory)--bas_part表中多记录 
--2、查询bas_part 表与bom_parent  表中的记录的对应关系 select * from bom_parent where parentid notin (select partid from bas_part )--bom_parent 多记录
--3、查询 bom_bom 表与  bom_parent表中的记录的对应关系  select * from bom_bom where bomid not in(select bomid from bom_parent where parentid not in (select partid frombas_part )) 
--4、查询Bom_opcomponent、bom_opcomponentopt、bom_opcomponentloc、bom_opcomponentrmk、bom_opcomponentsub中有没有对应的关系 
--5、查询BOM_BOM中有记录而在bom_parent中没有记录，通过4的关系，将Bom_opcomponent、bom_opcomponentopt、bom_opcomponentloc、bom_opcomponentrmk、bom_opcomponentsub中的对应记录删除将BOM_BOM中的记录也删除  select * from bom_bom where bomid not in(select bomid from bom_parent where parentid not in (select partid frombas_part )) 
--6、将bom_parent中有的记录而在bas_part中没有的记录，在bom_parent中删除select * from bom_parent where parentid notin (select partid from bas_part ) 
--7、将bas_part中有的记录而在inventory中没有的记录，在bas_part中删除select * from bas_part where invcode not in(select cinvcode from inventory)



--select  ccode as 科目编码,  cauth as 功能名称,  cuser as 用户名,  cmachine as 机器名  from GL_mccontrol;
--
--delete from GL_mccontrol

SELECT * FROM fitemss00 f ;
SELECT * FROM UFSUB_fitemss00 uf 