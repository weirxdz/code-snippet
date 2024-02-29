SELECT I.cInvCode ,I.cInvName ,I.cInvStd  ,cu.cComUnitName 
FROM Inventory i 
INNER JOIN ComputationUnit cu ON i.cComUnitCode = cu.cComunitCode 

;
CREATE TABLE barcodeinfo_h (
    ID NVARCHAR(32) PRIMARY KEY,
    日期 NVARCHAR(10) ,
    托数 INT,
    每托数量  DECIMAL(20,6),
    规格数量 INT
);
CREATE TABLE barcodeinfo_b (
    autoid INT PRIMARY KEY IDENTITY(1,1),
    ID NVARCHAR(32),
    产品编码 NVARCHAR(20),
    产品名称 NVARCHAR(60),
    规格型号 NVARCHAR(60),
    计量单位 NVARCHAR(10),
    数量  DECIMAL(20,6),
    FOREIGN KEY (ID) REFERENCES barcodeinfo_h(ID)
);

CREATE TABLE BARCODE_DETAILS (
    detailsID BIGINT IDENTITY(1,1) PRIMARY KEY,
    barcodeID NVARCHAR(32),
    ccode NVARCHAR(50),
    details NVARCHAR(120),
    FOREIGN KEY (barcodeID) REFERENCES barcodeinfo_h(ID)
);
