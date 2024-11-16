ALTER  TRIGGER trg_PO_Pomain_update
ON PO_Pomain 
AFTER UPDATE
AS
BEGIN
    -- 检查是否更新了 cVerifier字段
    IF UPDATE(cVerifier)
    BEGIN
        DECLARE @Cvenname NVARCHAR(120) -- 供应商名称
        DECLARE @qwspflag NVARCHAR(20) -- 企微审批状态
        DECLARE @qwspflag0 NVARCHAR(20) -- 企微审批状态
        DECLARE @cVerifier NVARCHAR(20) -- U8单据审核人
        DECLARE @cVerifier0 NVARCHAR(20) -- U8单据原审核人
        DECLARE @cChanger  NVARCHAR(20) -- U8单据变更人
        

        -- 取供应商名称
        SELECT @Cvenname = V.cVenName
        FROM Vendor V 
        INNER JOIN inserted i ON V.cVenCode = i.cVenCode
        WHERE V.cVenCode = i.cVenCode;

        -- 取企微审核标识，需要注意空值的处理
        SELECT @qwspflag = CASE WHEN i.wxOaState = '审核通过'THEN '审核通过' ELSE 'X' END FROM inserted i;
        
			  -- 取审核人的新值
			  SELECT @cVerifier = COALESCE(i.cVerifier,'X') FROM inserted i;
			  -- 取原审核人的新值
			  SELECT @cVerifier0 = COALESCE(d.cVerifier,'X') FROM deleted d;
			 

        -- 不允许审核的，供应商不是迈凯诺且没有企微审核通过的标识
--        IF @Cvenname <> '山东迈凯诺安防科技有限公司' AND @qwspflag <> '审核通过'   AND @cVerifier <> @cVerifier0
--        BEGIN
--            RAISERROR('供应商不是迈凯诺的订单需要企业微信审批！', 16, 1);
--        END
			 -- 判断供应商
			 IF @Cvenname <> '山东迈凯诺安防科技有限公司'
			 		BEGIN 
			 			-- 判断审核人字段
				 		IF @cVerifier0 = 'X' AND @cVerifier <> 'X'-- 未审核到审核
				 			BEGIN 
				 				-- 判断微信审批状态
					 			IF @qwspflag <> '审核通过'
					 				BEGIN 
					 					RAISERROR('供应商不是迈凯诺的订单需要企业微信审批！', 16, 1);
					 				END
				 			END
				 		-- 已经审核的不允许变更
				 		-- 取变更人的值
			 			SELECT @cChanger = COALESCE(i.cChanger,'X') FROM inserted i;
				 		IF @cChanger <> 'X' AND @cChanger <> '' AND @cVerifier0 <> 'X' AND @cVerifier0 <> '' AND @cVerifier <> 'X' AND @cVerifier <> ''-- 已审核变更
				 			BEGIN 					 				
					 			-- 取企微审核标识，需要注意空值的处理
        				SELECT @qwspflag0 = CASE WHEN d.wxOaState = '审核通过'THEN '审核通过' ELSE 'X' END FROM deleted d;
					 			IF @qwspflag0 = '审核通过'
					 				RAISERROR('已在企业微信中审核的单据不允许变更！', 16, 1);
					 		END
				 		IF @cVerifier0 <> 'X' AND @cVerifier = 'X'-- 弃审
				 			BEGIN 
				 				-- 判断微信审批状态
					 			IF @qwspflag <> '审核通过'
					 				BEGIN 
					 					RAISERROR('供应商不是迈凯诺的订单需要企业微信审批！', 16, 1);
					 				END	
					 			IF @qwspflag = '审核通过'
					 				BEGIN 
					 					RAISERROR('已在企业微信中审核的单据不允许弃审！', 16, 1);
					 				END				 				
				 			END
			 		END			 		
    END
END;
-- 2024-09-29 10:23:48.073
SELECT i.cPOID ,v.cVenName,i.cAuditTime,i.cAuditDate  ,i.cChangAuditTime,i.cChanger , CASE WHEN i.wxOaState = '审核通过'THEN '审核通过' ELSE 'X' END  wxOaState,i.wxOaSpNo ,i.wxOaDate ,COALESCE(i.cVerifier,'X') cVerifier ,i.*
FROM PO_Pomain i 
LEFT JOIN Vendor v ON i.cVenCode = v.cVenCode 
WHERE i.cPOID = 'CGDD202409290005'
;
UPDATE PO_Pomain SET wxOaState = '审核通过' ,wxOaSpNo = '001',wxOaDate = '2024-09-29 10:36:02.897',cVerifier = 'demo' ,cAuditTime = '2024-09-29 10:36:02.897' ,cAuditDate ='2024-09-29 00:00:00.0' WHERE cPOID = 'CGDD202409290005'
;
UPDATE PO_Pomain SET cChangAuditTime = NULL  ,cChanger = NULL WHERE cPOID = 'CGDD202409290005'
;