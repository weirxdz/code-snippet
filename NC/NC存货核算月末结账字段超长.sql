-- ��ĩ�����ֶγ���
select lengthb(t.vdef11),t.vdef11,t.* from blbzs.ia_detailledger t
where lengthb(t.vdef11)>100
for update  
;


-- ��ĩ�����ֶγ���
select lengthb(t.vbdef3),t.vbdef3,t.* from blbzs.ia_detailledger t
where lengthb(t.vbdef3)>100
for update  
