-- exec dru8qtckd4 '其他出库','001'
--  select * from csszk.dbo.Tablecs
CREATE PROCEDURE [dbo].[dru8qtckd4]
@xmname varchar(20),
@ztcode varchar(3)
AS
BEGIN
  declare @targetDb varchar(100), @whcode varchar(100),@vencode varchar(100), @errmsg varchar(200)
  declare @invcode varchar(100),@outcode nvarchar(100),@outid varchar(100),@outsid varchar(100)
  DECLARE @taxrate float,@qty decimal(18,6),@num decimal(18,6),@isbatch int,@poscode varchar(100) --@batch varchar(100),
  declare @itemid varchar(100),@free1 varchar(100),@free2 varchar(100),@free3 varchar(100),@free4 varchar(100),@free5 varchar(100)
  declare @free6 varchar(100),@free7 varchar(100),@free8 varchar(100),@free9 varchar(100),@free10 varchar(100)
  declare @strlssql  varchar(max)
  DECLARE @iFatherId int,@icocode int,@iChildId int,@strFatherId varchar(10),@strChildId  varchar(10),@strcocode  varchar(30),@strlsId int,@strlscocode   varchar(30),@cBatch varchar(100)
  ,@idsub int,@strsubId varchar(10)
  DECLARE @id  varchar(20),@bInvBatch varchar(10)
  DECLARE @dDate varchar(12),@cBusType varchar(12),@billmaker varchar(12),@cWhCode varchar(10),@approver   varchar(12)
  DECLARE @error_notes varchar(200),@billmakername varchar(12),@approvername   varchar(12)
  DECLARE @crdcode varchar(5),@crdname  varchar(12),@cdepCode varchar(12),@VT_ID int,@DEPTCODE varchar(12),@VNOTES varchar(100)
  declare @u8id bigint
  set @error_notes=''
  DECLARE CursorDirectOrderInsert CURSOR FOR --定义游标
    select ID,ddate,cBusType,billmaker,cWhCode,billmaker,factorycode,VT_ID,DEPTCODE, isnull(u8id,0)  u8id ,VNOTES  from openrowset ('MSDASQL','DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2049',
    'select * from fr_rw_rds_othersout_h') where sync_status=1 order by id
  OPEN CursorDirectOrderInsert --打开游标
    FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id ,@VNOTES --抓取下一行游标数据
    WHILE @@FETCH_STATUS = 0
      BEGIN
        set @strlssql=''
          --判断数据正确性
        DECLARE @js int 
        set @js=0
        set @error_notes=''
          if (@u8id <>0 )     begin       set @error_notes='u8单据已生成，不能再次生成'    end
        select @crdcode=crdcode,@crdname=crdname ,@js=count (*) from  Rd_Style where crdcode=@cBusType  group by crdcode,crdname --crdcode=@cBusType
        if (@js=0) begin set @error_notes=@error_notes+'入库类型没有：'+@cBusType end
        select  @js=count (*),@billmakername=cuser_name from UA_User where (nState IS NULL OR nState=0) and cuser_id=@billmaker group by cuser_name 
        if (@js=0) begin set @error_notes=@error_notes+'制单人没有：'+@billmaker end
        --select @js=count (*)  from Department where cdepcode=@cWhCode
        select @js=count (*)  from Warehouse where cwhcode=@cWhCode--,cwhcode
        if (@js=0) begin set @error_notes=@error_notes+'仓库没有：'+@cWhCode end
        select @js=count (*)  from Department where cdepcode=@cdepCode--,cwhcode
        if (@js=0) begin set @error_notes=@error_notes+'部门没有：'+@cdepCode end
        select  @js=count (*),@approvername=cuser_name  from UA_User where (nState IS NULL OR nState=0) and cuser_id=@approver  group by cuser_name 
        if (@js=0) begin set @error_notes=@error_notes+'审核人没有：'+@approver  end
        --print '111'+@error_notes
        if (@error_notes<>'')
          begin
                set @strlssql='update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
            ''select * from fr_rw_rds_othersout_h  where id='''''+@id+''''''')  Set error_notes='''+@error_notes+''''
            print '@error_notes'+@error_notes+@strlssql
            exec(@strlssql)
          
            FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id,@VNOTES  --抓取下一行游标数据
          end 
        else
          begin
            print '更新数据库'
            declare @strsql  varchar(max),@strsqla varchar(max)
            begin try
              begin tran
                select @iFatherId=iFatherId, @icocode=iChildId from ufsystem..ua_identity where cAcc_Id =@ztcode and cVouchType ='rdrecord09'
                select @idsub=iFatherId,  @iChildId=iChildId from ufsystem..ua_identity where cAcc_Id =@ztcode and cVouchType ='rdrecords09'
                if isnull(@iFatherId,0)=0 
                  begin
                    set @iFatherId=1
                    set @strFatherId='1000000001' 
                  end
                else
                  begin
                    set @strFatherId=SUBSTRING('1000000000',0,11 - len(ltrim(str(@iFatherId))))+ltrim(str(@iFatherId))
                  end
                if isnull(@iChildId,0)=0 
                  begin
                    set @iChildId=1
                    set @strChildId='1000000001' 
                  end
                else
                  begin
                    set @strChildId=SUBSTRING('1000000000',0,11 - len(ltrim(str(@iChildId))))+ltrim(str(@iChildId))
                  end
                if isnull(@idsub,0)=0 
                  begin
                    set @idsub=1
                    set @strsubId='1000000001' 
                  end
                else
                  begin
                    set @strsubId=SUBSTRING('1000000000',0,11 - len(ltrim(str(@idsub))))+ltrim(str(@idsub))
                  end
                set @icocode=1
                select @strcocode=substring(replace(CONVERT(varchar,@dDate, 120 ),'-',''),0,9)+'0001'
                DECLARE @iPd int
                set @iPd=1
                while  @iPd=1
                  begin
                    select @strlscocode=ccode from rdrecord09  where ccode=@strcocode
                    if  isnull(@strlscocode,'')='' begin set @strlscocode='' end
                    if (@strlscocode <>@strcocode)
                    begin  set @iPd=2 end
                    else
                      begin
                        set @icocode=@icocode+1
                            set @strcocode=SUBSTRING(substring(replace(CONVERT(varchar,@dDate, 120 ),'-',''),0,9)+'0000',0,13 - len(ltrim(str(@icocode))))+ltrim(str(@icocode))
                    
                      end
                  end
                set @iPd=1
                while  @iPd=1
                  begin
                    select @strlsId=id from rdrecord09  where id=@strFatherId
                    if  isnull(@strlsId,0)=0 begin set @strlsId=0 end
                    if (@strlsId <>@strFatherId)
                    begin  set @iPd=2 end
                    else
                    begin
                      set @iFatherId=@iFatherId+1
                      set @strFatherId=SUBSTRING('1000000000',0,11 - len(ltrim(str(@iFatherId))))+ltrim(str(@iFatherId))
                    end
                  end    --  select * from  rdrecord09
                --'插入采购入库单主表（含审核）'
                insert into rdrecord09(id,cCode,bRdFlag,cVouchType,cbustype,cSource,cWhCode,dDate,cVenCode,bTransFlag,
                biafirst,VT_ID,bIsSTQc,bOMFirst,bredvouch,iExchRate,cExch_Name,dModifyDate,dnmaketime,dnmodifytime,
                cMaker,cHandler,dnverifytime,cRdCode,cdepcode,cdefine10,cMemo)--,csysbarcode) 
                select @strFatherId,@strcocode,'0','09',@crdname,'库存',@cWhCode,@dDate,@vencode,'',
                -- 20231024，修正模板ID的取值逻辑
                '',@VT_ID,0,null,null,null,null,GETDATE(),GETDATE(),GETDATE(),
                @billmakername,@approvername,GETDATE(),@cRdCode,@cdepcode,@DEPTCODE ,@VNOTES --,'||st09|'+@strcocode 
                --select @strFatherId,@strcocode,'1','01','普通采购','库存',rd.cWhCode,rd.dDate,@vencode,bTransFlag,rd.biafirst,'27',bIsSTQc,bOMFirst,bredvouch,dl.iExchRate,dl.cExch_Name,rd.cdefine1,rd.cdefine2,rd.cdefine3,rd.cdefine4,rd.cdefine5,rd.cdefine6,rd.cdefine7,rd.cdefine8,rd.cdefine9,rd.cdefine10,rd.cdefine11,rd.cdefine12,rd.cdefine13,rd.cdefine14,rd.cdefine15,rd.cdefine16,dModifyDate,dnmaketime,dnmodifytime,rd.cMaker,rd.cMaker,GETDATE(),'||st01|'+@strcocode 
                --有单据扩展自定义项插入rdrecord01_ExtraDefine
                DECLARE @autoid int,@lsposnr int
                DECLARE @productcode  varchar(12),@productname  varchar(20),@unitcode  varchar(12),@assunitcode varchar(12),@unitname  varchar(20),
                @changerate  decimal(18,6) ,@actual_strength decimal(18,2),@actual_weight  decimal(18,2) ,@convert_65_weight  decimal(18,2)
                set @lsposnr=1
                --          IF CURSOR_STATUS('global','CursorlsposnrInsert')>=-1
                --BEGIN
                -- DEALLOCATE CursorlsposnrInsert
                --END
                DECLARE CursorlsposnrInsert CURSOR FOR --定义游标
                  -- 20231024，修改实际重量、65度重量、换算率的取值计算逻辑
                  select autoid,productcode,productname,unitcode,unitname,actual_strength,case when unitname = '公斤' then convert_65_weight else actual_weight EnD as  actual_weight ,case when unitname = '公斤' then actual_weight else convert_65_weight EnD as convert_65_weight,isnull(cbatch,'') cbatch,assunitcode,round((case when unitname = '公斤' then actual_weight else convert_65_weight EnD)/(case when unitname = '公斤' then convert_65_weight else actual_weight EnD),3) as changerate  from  
                  openrowset ('MSDASQL','DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2049',
                  'select * from fr_rw_rds_othersout_b')   where id=@id order by autoid
                OPEN CursorlsposnrInsert --打开游标
                  FETCH NEXT FROM CursorlsposnrInsert INTO  @autoid,@productcode,@productname,@unitcode,@unitname,@actual_strength,@actual_weight,@convert_65_weight,@cbatch,@assunitcode,@changerate  --抓取下一行游标数据
                  WHILE @@FETCH_STATUS = 0
                    begin
                
                      set @js=0
                      select @js=count (*) from Inventory where cInvCode=@productcode
                      if (@js=0) begin set @error_notes=@error_notes+'产品没有：'+@productcode end
                      else begin select @isbatch=bInvBatch from Inventory where cInvCode=@productcode end
                      select @js=count (*) from Inventory where ccomunitCode=@unitcode
                      if (@js=0) begin set @error_notes=@error_notes+'单位不对：'+@unitcode end
                      if (@error_notes='' )
                      begin
                      print @strChildId
                        DECLARE @iPda int
                        set @iPda=1
                        while  @iPda=1
                        begin   
                          select @strlsId=autoid from  rdrecords09  where autoid=@strChildId
                          if  isnull(@strlsId,0)=0 begin set @strlsId=0 end
                          if (ltrim(str(@strlsId)) <>@strChildId)
                          begin  set @iPda=2 end
                          else
                          begin
                            set @iChildId=@iChildId+1
                            set @strChildId=SUBSTRING('1000000000',0,11 - len(ltrim(str(@iChildId))))+ltrim(str(@iChildId))
                          end
                        end  
                      --print '判断数据正确性'
                      insert into RdRecords09(autoid,id,cinvcode,inum,iinvexchrate,iQuantity,cAssUnit,
                          iFlag,bCosting,irowno,cBatch,cDefine33)--,                cbsysbarcode)
                        select @strChildId,@strFatherId,@productcode,@actual_weight,@changerate,@convert_65_weight,@assunitcode,
                          0,1,@lsposnr,@cBatch,null
                          --,                '||st09|'+@strChildId+'|'+ltrim(str(@lsposnr))
                                                set @iPda=1
                        while  @iPda=1
                        begin   
                          select @idsub=id from  rdrecords09sub  where id=@strsubId
                          if  isnull(@strlsId,0)=0 begin set @strlsId=0 end
                          if (ltrim(str(@strlsId)) <>@strChildId)
                          begin  set @iPda=2 end
                          else
                          begin
                            set @idsub=@idsub+1
                            set @strsubId=SUBSTRING('1000000000',0,11 - len(ltrim(str(@idsub))))+ltrim(str(@idsub))
                          end
                        end  
                        insert into RdRecords09sub(autoid,ID,iBG_Ctrl,iBGSTSum)
                          select @strChildId,@strsubId,0,0
                        --有单据扩展自定义项插入rdrecords01_ExtraDefine
                        --存货有货位需要插入存货货位记录表

                        --存货货位存量表InvPositionSum
                        --循环InvPosition表更新InvPositionSum
                        select @itemid=id from SCM_Item where cInvCode=@productcode 
                        if (isnull(@itemid,'')='')
                        begin
                          insert into SCM_Item(cInvCode) values(@productcode);select @itemid=@@IDENTITY;
                        end
                        if (@isbatch=1)
                        begin
                          if exists(select * from CurrentStock where cWhCode=@cWhCode and cInvCode=@productcode and cBatch=@cBatch and @isbatch=1)
                          --更新批次现存量
                            update CurrentStock set iQuantity=iQuantity-CONVERT(decimal(18,6), @convert_65_weight),inum=inum-CONVERT(decimal(18,6), @actual_weight)    where cWhCode=@cWhCode and cInvCode=@productcode and cBatch=@cBatch and @isbatch=1
                          else
                            insert into CurrentStock(cwhcode,cinvcode,itemid,cbatch,isotype,iSodid,iQuantity,inum) 
                              values(@cWhCode,@productcode,@itemid,@cBatch,'0','',@convert_65_weight,@actual_weight)
                          end
                        else
                          begin
                            if exists(select * from CurrentStock where cWhCode=@cWhCode and cInvCode=@productcode  and @isbatch=0)
                          --更新非批次现存量
                            update CurrentStock set iQuantity=iQuantity-CONVERT(decimal(18,6), @convert_65_weight),inum=inum-CONVERT(decimal(18,6), @actual_weight)    where cWhCode=@cWhCode and cInvCode=@productcode  and @isbatch=0
                          else
                            insert into CurrentStock(cwhcode,cinvcode,itemid,isotype,iSodid,iQuantity,inum)
                              values(@cWhCode,@productcode,@itemid,'0','',@convert_65_weight,@actual_weight)
                          end
                          --计算存量用临时表
                          exec ST_SaveForStock N'01',@strFatherId,0,0 ,1
                          exec ST_SaveForTrackStock N'01',@strFatherId, 0 ,1
                          exec Usp_SCM_CommitGeneralLedgerWithCheck N'ST',1,1,1,1,0,0,1,1,1,0,0,0,0 ,0,'spid_100'
                          set @lsposnr = @lsposnr + 1  
                        end
                      set @strlssql+=' update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
                      ''select * from fr_rw_rds_othersout_b'')  Set U8ID='+@strFatherId+',u8autoid='+@strChildId+' where autoid='+ltrim(str(@autoid))+' ;'
                      FETCH NEXT FROM CursorlsposnrInsert INTO  @autoid,@productcode,@productname,@unitcode,@unitname,@actual_strength,@actual_weight,@convert_65_weight,@cbatch,@assunitcode,@changerate  --抓取下一行游标数据
                    end
                CLOSE CursorlsposnrInsert --关闭游标
                DEALLOCATE CursorlsposnrInsert --释放游标  
                DECLARE @iPdua_identity int
                select @iPdua_identity=count(*) from ufsystem..ua_identity where cAcc_Id = @ztcode  and cVouchType ='rdrecord09'
                if @iPdua_identity=0 
                  begin
                    insert into ufsystem..ua_identity (ifatherid,iChildId,cAcc_Id,cVouchType) values (@iFatherId,@icocode,@ztcode,'rdrecord09')
                  end
                else
                  begin
                    update ufsystem..ua_identity set ifatherid=  @iFatherId  ,iChildId=  @icocode where cAcc_Id = @ztcode  and cVouchType ='rdrecord09'
                  end
                select @iPdua_identity=count(*) from ufsystem..ua_identity where cAcc_Id = @ztcode  and cVouchType ='rdrecords09'
                if @iPdua_identity=0 
                  begin
                    insert into ufsystem..ua_identity (ifatherid,iChildId,cAcc_Id,cVouchType) values (@idsub,@iChildId,@ztcode,'rdrecords09')
                  end
                else
                  begin
                    update ufsystem..ua_identity set ifatherid=  @idsub,iChildId=  @iChildId where cAcc_Id = @ztcode  and cVouchType ='rdrecords09'
                  end
                set @strlssql+='update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
                ''select * from fr_rw_rds_othersout_h'')  Set  error_notes='''',u8_billcode='''+@strcocode+''',u8id=CAST('''+@strFatherId+'''  as bigint),sync_status=3  where id='''+ltrim(@id)+''' ;'
                if @error_notes=''
                  begin
                    exec IA_SP_WriteUnAccountVouchForST @strFatherId,N'09'
                    commit tran
                    if (@strlssql<>'') begin exec(@strlssql) end
                  end
                else
                  begin
                    set @strlssql='update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
                    ''select * from fr_rw_rds_othersout_h  where id='''''+@id+''''''')  Set error_notes='''+@error_notes+''''
                    print '@error_notes'+@error_notes+@strlssql
                    exec(@strlssql)
                  end
                FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id ,@VNOTES --抓取下一行游标数据
            end try
            begin catch
              rollback tran
              print ERROR_MESSAGE()
              IF CURSOR_STATUS('global','CursorlsposnrInsert')>=-1
                BEGIN
                  CLOSE CursorlsposnrInsert --关闭游标
                  DEALLOCATE CursorlsposnrInsert --释放游标  
                END  
              FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id ,@VNOTES --抓取下一行游标数据
            END CATCH 
          end
      END
  CLOSE CursorDirectOrderInsert --关闭游标
  DEALLOCATE CursorDirectOrderInsert --释放游标

  --delete
  DECLARE CursorDirectOrderInsert CURSOR FOR --定义游标
    select ID,ddate,cBusType,billmaker,cWhCode,billmaker,factorycode,VT_ID,DEPTCODE, isnull(u8id,0)  u8id   from openrowset ('MSDASQL','DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2049',
    'select * from fr_rw_rds_othersout_h') where sync_status=9 order by id
  OPEN CursorDirectOrderInsert --打开游标
    FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id  --抓取下一行游标数据
    WHILE @@FETCH_STATUS = 0
      BEGIN
        set @strlssql=''
        set @error_notes=''
        DECLARE @jsa int 
        set @jsa=0
        select @jsa=count(*) from rdrecord09  where id=@u8id AND isnull(cHandler,'')<>''
        IF (@jsa = 1 )     begin       set @error_notes='u8单据已审核，不能删除！'    end
        select @jsa=count(*) from rdrecord09  where id=@u8id --AND isnull(cHandler,'')<>''
        IF (@jsa <>1 )     begin       set @error_notes='u8单据已删除，不能再次删除！'    end
        if (@error_notes<>'')
          begin
                set @strlssql='update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
            ''select * from fr_rw_rds_othersout_h  where id='''''+@id+''''''')  Set error_notes='''+@error_notes+''''
            print '@error_notes'+@error_notes+@strlssql
            exec(@strlssql)
          
            FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id  --抓取下一行游标数据
          end 
        else
          begin
            --更新数据库
            begin try
              begin tran
                DECLARE @u8autoid int
                set @lsposnr=1
                DECLARE CursorlsposnrInsert CURSOR FOR --定义游标
                  select autoid,productcode,productname,unitcode,unitname,actual_strength,case when unitname = '公斤' then convert_65_weight else actual_weight EnD as  actual_weight ,case when unitname = '公斤' then actual_weight else convert_65_weight EnD as convert_65_weight,isnull(cbatch,'') cbatch,assunitcode,round((case when unitname = '公斤' then actual_weight else convert_65_weight EnD)/(case when unitname = '公斤' then convert_65_weight else actual_weight EnD),3) as changerate,u8autoid  from  
                  openrowset ('MSDASQL','DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2049',
                  'select * from fr_rw_rds_othersout_b')   where id=@id order by autoid
                OPEN CursorlsposnrInsert --打开游标
                  FETCH NEXT FROM CursorlsposnrInsert INTO  @autoid,@productcode,@productname,@unitcode,@unitname,@actual_strength,@actual_weight,@convert_65_weight,@cbatch,@assunitcode,@changerate,@u8autoid  --抓取下一行游标数据

                  WHILE @@FETCH_STATUS = 0
                    begin
                      --判断数据正确性
                      set @js=0
                      if (@error_notes='' )
                        begin
                          --更新数据库
                          delete RdRecords09 where autoid=@u8autoid
                          delete RdRecords09sub where id=@u8autoid
                          select @itemid=id from SCM_Item where cInvCode=@productcode 
                          if (isnull(@itemid,'')='')
                            begin
                              insert into SCM_Item(cInvCode) values(@productcode);select @itemid=@@IDENTITY;
                            end
                          if (@isbatch=1)
                          begin
                            if exists(select * from CurrentStock where cWhCode=@cWhCode and cInvCode=@productcode and cBatch=@cBatch and @isbatch=1)
                            --更新批次现存量
                              update CurrentStock set iQuantity=iQuantity+CONVERT(decimal(18,6), @convert_65_weight),inum=inum+CONVERT(decimal(18,6), @actual_weight)   where cWhCode=@cWhCode and cInvCode=@productcode and cBatch=@cBatch and @isbatch=1
                            end
                          else
                            begin
                              if exists(select * from CurrentStock where cWhCode=@cWhCode and cInvCode=@productcode  and @isbatch=0)
                                --更新非批次现存量
                                update CurrentStock set iQuantity=iQuantity+CONVERT(decimal(18,6), @convert_65_weight) ,inum=inum+CONVERT(decimal(18,6), @actual_weight)  where cWhCode=@cWhCode and cInvCode=@productcode  and @isbatch=0
                            end
                          --计算存量用临时表
                          exec ST_SaveForStock N'01',@u8autoid,0,0 ,1
                          exec ST_SaveForTrackStock N'01',@u8autoid, 0 ,1
                          exec Usp_SCM_CommitGeneralLedgerWithCheck N'ST',1,1,1,1,0,0,1,1,1,0,0,0,0 ,0,'spid_100'
                      
                        end
                      SET @strlssql+=' update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
                      ''select * from fr_rw_rds_othersout_b'')  Set  U8ID=null,u8autoid=null   where autoid='+ltrim(str(@autoid))+' ;'
                      FETCH NEXT FROM CursorlsposnrInsert INTO  @autoid,@productcode,@productname,@unitcode,@unitname,@actual_strength,@actual_weight,@convert_65_weight,@cbatch,@assunitcode,@changerate,@u8autoid  --抓取下一行游标数据
                    end
                CLOSE CursorlsposnrInsert --关闭游标
                DEALLOCATE CursorlsposnrInsert --释放游标  
                set @strlssql+='update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
                ''select * from fr_rw_rds_othersout_h'')  Set error_notes=''删除'',u8_billcode=null, u8id=null,sync_status=99 where id='''+ltrim(@id)+''' ;'
                if @error_notes=''
                  begin
                    declare @strlssqla  varchar(max)
                    set @strlssqla='delete RdRecord09 where id='''+ltrim(str(@u8id))+''''
                    exec(@strlssqla)
                    set @strlssqla='exec IA_SP_WriteUnAccountVouchForST '''+ltrim(str(@u8id))+''',N''09'''
                    exec(@strlssqla)
                    commit tran
                    if (@strlssql<>'') begin exec(@strlssql) end
                  end
                else
                  begin
                    set @strlssql='update openrowset (''MSDASQL'',''DRIVER={MySQL ODBC 8.0 Ansi Driver};SERVER=192.168.1.241;PORT=3306;DATABASE=fr_dw_rds;USER=blog;PASSWORD=7eRO21jucizO;STMT=set names gb2312;OPTION=2051'',
                    ''select * from fr_rw_rds_othersout_h  where id='''''+@id+''''''')  Set error_notes='''+@error_notes+''''
                    print '@error_notes'+@error_notes+@strlssql
                    exec(@strlssql)
                  end
              FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id  --抓取下一行游标数据
            end try
            begin catch
              rollback tran
              print ERROR_MESSAGE()
              IF CURSOR_STATUS('global','CursorlsposnrInsert')>=-1
                BEGIN
                  CLOSE CursorlsposnrInsert --关闭游标
                  DEALLOCATE CursorlsposnrInsert --释放游标  
                END  
              FETCH NEXT FROM CursorDirectOrderInsert INTO  @id,@dDate,@cBusType,@billmaker,@cWhCode,@approver,@cdepCode,@VT_ID,@DEPTCODE,@u8id  --抓取下一行游标数据
            END CATCH 
          end
      END
  CLOSE CursorDirectOrderInsert --关闭游标
  DEALLOCATE CursorDirectOrderInsert --释放游标
END;