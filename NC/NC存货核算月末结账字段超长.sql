-- ÔÂÄ©½áÕË×Ö¶Î³¬³¤
select lengthb(t.vdef11),t.vdef11,t.* from blbzs.ia_detailledger t
where lengthb(t.vdef11)>100
for update  
