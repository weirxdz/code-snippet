-- 参数为空查询全部
${if(len(是否完好) == 0,""," and ib.vdef24 = '" + 是否完好 + "'")}


	${if(len(材料级次) == 0,""," and i.cInvDefine1 = '" + 材料级次 + "'")}