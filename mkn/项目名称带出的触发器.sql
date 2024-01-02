ALTER   TRIGGER trg_so_somain_update
ON so_somain
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @itemname NVARCHAR(120)

    SELECT @itemname = citemname
    FROM fitemss01 f 
    WHERE f.citemcode  = (SELECT cdefine11 FROM inserted);

    IF @itemname IS NOT NULL  -- AND (SELECT cdefine12 FROM inserted) IS null
    BEGIN
        UPDATE so_somain
        SET cdefine12 = @itemname
        WHERE id = (SELECT id FROM inserted);
    END
END


-- UPDATE SO_SOMain SET cDefine12 = '2' WHERE cSOCode = 'XSDD202401010002'

;

SELECT * FROM SO_SOMain WHERE cSOCode = 'XSDD202401010006'
;
SELECT * FROM SO_SOMain WHERE cDefine12 IS NULL;