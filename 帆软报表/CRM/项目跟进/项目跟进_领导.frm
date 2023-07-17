<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20211223" releaseVersion="11.0.0">
<TableDataMap>
<TableData name="ds2跟进中" class="com.fr.data.impl.DBTableData">
<Desensitizations desensitizeOpen="false"/>
<Parameters>
<Parameter>
<Attributes name="fine_username"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CRM]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT P.projectno ,P.ProjectName ,P.Billdate 报备日期,p.ProprietorName 业主名称,p.DesigningInstitute 设计院名称,p.CoveredArea 建筑面积,p.PiperNnum 风管数量,p.EstimatedFieldTime 预计到场时间,isnull(f.maxDate,P.Billdate) 最近跟进日期,f.maxID 最近跟进ID, D.cname 销售部门,R.cname  经销商,PS.cname  最新阶段,X.follewdetails 跟进详情,U1.cname 跟进提交人,datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23)) diffdays
FROM FR_CRM_PROJECT_SUBMIT P 
LEFT JOIN (select t.projectno ,MAX(t.dDate) maxDate ,max(t.ID) maxID
						from FR_CRM_PROJECT_FOLLOWUP t
						group by t.projectno) F ON P.projectno = F.projectno
LEFT JOIN FR_CRM_USERS U ON P.UserID = U.ID 
LEFT JOIN FR_CRM_PROJECT_FOLLOWUP X ON f.maxID = X.ID 
LEFT JOIN FR_CRM_DEPT D ON  p.saledeptid = D.ID 
LEFT JOIN FR_CRM_RESELLER R ON X.RESELLERID = R.ID 
LEFT JOIN FR_CRM_PROJECT_STAGES PS ON  X.project_stagesID = PS.ID 
LEFT JOIN FR_CRM_USERS U1 ON X.userID = U1.ID 
WHERE P.DR = 0 
	and P.approve_status > 0
	and (
		-- 部门编码，内部人员
		d.ccode = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and (fcu.RESELLERID = 9999 or fcu.RESELLERID is null)
									and fcu.ccode = '${fine_username}')
		-- 上级部门编码，内部人员
		or d.parentcode  = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and (fcu.RESELLERID = 9999 or fcu.RESELLERID is null)
									and fcu.ccode = '${fine_username}')
		-- 部门编码，经销商
		or d.ccode = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and fcu.RESELLERID <> 9999 and fcu.RESELLERID is not null
									and fcu.ccode = '${fine_username}')
		-- 上级部门编码，经销商
		or d.parentcode  = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and fcu.RESELLERID <> 9999 and fcu.RESELLERID is not null
									and fcu.ccode = '${fine_username}')
	)
	
order by P.projectno desc,x.ID desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds2跟进超30天" class="com.fr.data.impl.DBTableData">
<Desensitizations desensitizeOpen="false"/>
<Parameters>
<Parameter>
<Attributes name="fine_username"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CRM]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT P.projectno ,P.ProjectName ,P.Billdate 报备日期,p.ProprietorName 业主名称,p.DesigningInstitute 设计院名称,p.CoveredArea 建筑面积,p.PiperNnum 风管数量,p.EstimatedFieldTime 预计到场时间,isnull(f.maxDate,P.Billdate) 最近跟进日期,f.maxID 最近跟进ID, D.cname 销售部门,R.cname  经销商,PS.cname  最新阶段,X.follewdetails 跟进详情,U1.cname 跟进提交人,datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23)) diffdays
FROM FR_CRM_PROJECT_SUBMIT P 
LEFT JOIN (select t.projectno ,MAX(t.dDate) maxDate ,max(t.ID) maxID
						from FR_CRM_PROJECT_FOLLOWUP t
						group by t.projectno) F ON P.projectno = F.projectno
LEFT JOIN FR_CRM_USERS U ON P.UserID = U.ID 
LEFT JOIN FR_CRM_PROJECT_FOLLOWUP X ON f.maxID = X.ID 
LEFT JOIN FR_CRM_DEPT D ON  p.saledeptid = D.ID 
LEFT JOIN FR_CRM_RESELLER R ON X.RESELLERID = R.ID 
LEFT JOIN FR_CRM_PROJECT_STAGES PS ON  X.project_stagesID = PS.ID 
LEFT JOIN FR_CRM_USERS U1 ON X.userID = U1.ID 
WHERE P.DR = 0 
	and P.approve_status >= 0
	and datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23))>=30
	and (
		-- 部门编码，内部人员
		d.ccode = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and (fcu.RESELLERID = 9999 or fcu.RESELLERID is null)
									and fcu.ccode = '${fine_username}')
		-- 上级部门编码，内部人员
		or d.parentcode  = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and (fcu.RESELLERID = 9999 or fcu.RESELLERID is null)
									and fcu.ccode = '${fine_username}')
		-- 部门编码，经销商
		or d.ccode = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and fcu.RESELLERID <> 9999 and fcu.RESELLERID is not null
									and fcu.ccode = '${fine_username}')
		-- 上级部门编码，经销商
		or d.parentcode  = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and fcu.RESELLERID <> 9999 and fcu.RESELLERID is not null
									and fcu.ccode = '${fine_username}')
	)
order by P.projectno desc,x.ID desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds2跟进超85天" class="com.fr.data.impl.DBTableData">
<Desensitizations desensitizeOpen="false"/>
<Parameters>
<Parameter>
<Attributes name="fine_username"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CRM]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT P.projectno ,P.ProjectName ,P.Billdate 报备日期,p.ProprietorName 业主名称,p.DesigningInstitute 设计院名称,p.CoveredArea 建筑面积,p.PiperNnum 风管数量,p.EstimatedFieldTime 预计到场时间,isnull(f.maxDate,P.Billdate) 最近跟进日期,f.maxID 最近跟进ID, D.cname 销售部门,R.cname  经销商,PS.cname  最新阶段,X.follewdetails 跟进详情,U1.cname 跟进提交人,datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23)) diffdays
FROM FR_CRM_PROJECT_SUBMIT P 
LEFT JOIN (select t.projectno ,MAX(t.dDate) maxDate ,max(t.ID) maxID
						from FR_CRM_PROJECT_FOLLOWUP t
						group by t.projectno) F ON P.projectno = F.projectno
LEFT JOIN FR_CRM_USERS U ON P.UserID = U.ID 
LEFT JOIN FR_CRM_PROJECT_FOLLOWUP X ON f.maxID = X.ID 
LEFT JOIN FR_CRM_DEPT D ON  p.saledeptid = D.ID 
LEFT JOIN FR_CRM_RESELLER R ON X.RESELLERID = R.ID 
LEFT JOIN FR_CRM_PROJECT_STAGES PS ON  X.project_stagesID = PS.ID 
LEFT JOIN FR_CRM_USERS U1 ON X.userID = U1.ID 
WHERE P.DR = 0 
	and P.approve_status >= 0
	and datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23))>=85
	and (
		-- 部门编码，内部人员
		d.ccode = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and (fcu.RESELLERID = 9999 or fcu.RESELLERID is null)
									and fcu.ccode = '${fine_username}')
		-- 上级部门编码，内部人员
		or d.parentcode  = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and (fcu.RESELLERID = 9999 or fcu.RESELLERID is null)
									and fcu.ccode = '${fine_username}')
		-- 部门编码，经销商
		or d.ccode = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and fcu.RESELLERID <> 9999 and fcu.RESELLERID is not null
									and fcu.ccode = '${fine_username}')
		-- 上级部门编码，经销商
		or d.parentcode  = (select distinct fcd.ccode  
								from FR_CRM_USERS fcu
								inner join FR_CRM_DEPT fcd on fcu.DEPTID = fcd.ID and fcd.dr = 0
								where fcu.dr = 0 and fcu.RESELLERID <> 9999 and fcu.RESELLERID is not null
									and fcu.ccode = '${fine_username}')
	)
order by P.projectno desc,x.ID desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="false" isAdaptivePropertyAutoMatch="false" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="true"/>
</FormMobileAttr>
<Parameters/>
<Layout class="com.fr.form.ui.container.WBorderLayout">
<WidgetName name="form"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="false"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<Center class="com.fr.form.ui.container.WFitLayout">
<WidgetName name="body"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ColorBackground">
<color>
<FineColor color="-1" hor="-1" ver="-1"/>
</color>
</Background>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="b7e92b22-f40b-4178-bc8d-657605f476d2"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.DateEditor">
<WidgetName name="enddate"/>
<LabelName name="enddate"/>
<WidgetID widgetID="9694008d-694d-435f-b7c8-72914f192a35"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="dateEditor1" frozen="false" index="-1" oldWidgetName="dateEditor1"/>
<PrivilegeControl/>
</WidgetAttr>
<fontSize>
<![CDATA[11]]></fontSize>
<DateAttr/>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=""]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="375" y="2" width="100" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="截至日期"/>
<WidgetID widgetID="5f01fab5-4c5e-4763-88a6-d9057e155669"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="label1" frozen="false" index="-1" oldWidgetName="label1"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[截至日期]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="SimSun" style="0" size="88"/>
<border style="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
</InnerWidget>
<BoundsAttr x="275" y="2" width="100" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.DateEditor">
<WidgetName name="startdate"/>
<LabelName name="startdate"/>
<WidgetID widgetID="9de60fb5-bbfa-4b0c-bbbf-76b5c351f38c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="dateEditor0" frozen="false" index="-1" oldWidgetName="dateEditor0"/>
<PrivilegeControl/>
</WidgetAttr>
<fontSize>
<![CDATA[11]]></fontSize>
<DateAttr/>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=""]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="145" y="2" width="100" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="开始日期"/>
<WidgetID widgetID="c2da6900-8038-4265-9a82-b581906d0720"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="label0" frozen="false" index="-1" oldWidgetName="label0"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[开始日期]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="SimSun" style="0" size="88"/>
<border style="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
</InnerWidget>
<BoundsAttr x="45" y="2" width="100" height="30"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="开始日期"/>
<Widget widgetName="startdate"/>
<Widget widgetName="截至日期"/>
<Widget widgetName="enddate"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="35"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.cardlayout.WCardMainBorderLayout">
<WidgetName name="tablayout0"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="tablayout0" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="false"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" borderRadius="0" type="1" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
<Background name="ColorBackground">
<color>
<FineColor color="-13400848" hor="-1" ver="-1"/>
</color>
</Background>
<BackgroundOpacity opacity="1.0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<NorthAttr size="36"/>
<North class="com.fr.form.ui.container.cardlayout.WCardTitleLayout">
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="false"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<EastAttr size="25"/>
<East class="com.fr.form.ui.CardAddButton">
<WidgetName name="Add"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<AddTagAttr layoutName="cardlayout0"/>
</East>
<Center class="com.fr.form.ui.container.cardlayout.WCardTagLayout">
<WidgetName name="tabpane0"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="false"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="1" compInterval="0"/>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="688d8c07-a725-4b11-a9a2-73e4ca9e1d43"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[跟进中]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="b1b2d080-96c1-4c03-851e-db77fd2733d3"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[30天未跟进]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0" index="1"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="bcc3571c-e119-4a1b-ba18-0f261b16d43d"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[即将中止]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0" index="2"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<DisplayPosition type="0"/>
<FLAttr alignment="0"/>
<ColumnWidth defaultValue="80">
<![CDATA[80,80,80,80,80,80,80,80,80,80,80]]></ColumnWidth>
<FRFont name="SimSun" style="0" size="72"/>
<TextDirection type="0"/>
<TemplateStyle class="com.fr.general.cardtag.DefaultTemplateStyle"/>
<TitleFitConfig titleFitByFont="true"/>
<MobileTemplateStyle class="com.fr.general.cardtag.mobile.DefaultMobileTemplateStyle">
<initialColor>
<color>
<FineColor color="-13072146" hor="-1" ver="-1"/>
</color>
</initialColor>
<TabCommonConfig showTitle="true" showDotIndicator="false" canSlide="false" dotIndicatorPositionType="0">
<indicatorInitialColor>
<FineColor color="-1381654" hor="-1" ver="-1"/>
</indicatorInitialColor>
<indicatorSelectColor>
<FineColor color="-3355444" hor="-1" ver="-1"/>
</indicatorSelectColor>
</TabCommonConfig>
<tabFontConfig>
<FRFont name="宋体" style="0" size="112"/>
<selectFontColor>
<FineColor color="-16777216" hor="-1" ver="-1"/>
</selectFontColor>
</tabFontConfig>
<custom custom="false"/>
</MobileTemplateStyle>
</Center>
<CardTitleLayout layoutName="cardlayout0"/>
</North>
<Center class="com.fr.form.ui.container.WCardLayout">
<WidgetName name="cardlayout0"/>
<WidgetID widgetID="5f94dfa3-e1fa-49e4-9514-c53f613e90dd"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" borderRadius="0" type="1" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
<Background name="ColorBackground">
<color>
<FineColor color="-13400848" hor="-1" ver="-1"/>
</color>
</Background>
<BackgroundOpacity opacity="1.0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab20"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0_c_c_c_c_c_c_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="false"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0_c_c_c_c_c_c_c"/>
<WidgetID widgetID="53acc9d1-594a-4229-865e-64e84a870861"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="11" bottom="11" right="11"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="simhei" style="1" size="128"/>
<Position pos="2"/>
<Background name="ColorBackground">
<color>
<FineColor color="-10243346" hor="-1" ver="-1"/>
</color>
</Background>
<BackgroundOpacity opacity="0.04"/>
<InsetImage padding="4" insetRelativeTextLeft="true" insetRelativeTextRight="false" name="ImageBackground" layout="3">
<FineImage fm="png" imageId="__ImageCache__9BDAD1A694F2AE09931BEB5B979DA1F5">
<IM>
<![CDATA[lO<9(kN.ld@UNU%p%320!n&&RXMhpZ,a0ckg]Ag[)Sh?$H'm#O$mX9@nDg03/<C4dC'hs7\:U
CrUFIA*cmN+n1!@hUKFS0]AXkEO<r!!~
]]></IM>
</FineImage>
</InsetImage>
</WidgetTitle>
<Background name="ColorBackground">
<color>
<FineColor color="-10243346" hor="-1" ver="-1"/>
</color>
</Background>
<Alpha alpha="0.04"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
<USE REPEAT="false" PAGE="false" WRITE="false"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1257300,2286000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3810000,11430000,4572000,4572000,4572000,6858000,3810000,3810000,3810000,3810000,3810000,3810000,4572000,3810000,5715000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目名称]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[最近跟进日期]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[最新阶段]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[跟进详情]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[销售部门]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[经销商]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="8" r="0" s="0">
<O>
<![CDATA[业主姓名]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="9" r="0" s="0">
<O>
<![CDATA[设计院名称]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="10" r="0" s="0">
<O>
<![CDATA[建筑面积]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="11" r="0" s="0">
<O>
<![CDATA[风管数量]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="12" r="0" s="0">
<O>
<![CDATA[预计到场时间]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="projectno"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="查看跟进详情">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="projectno"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=A2]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="op"/>
<O>
<![CDATA[view]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_dialog]]></TargetFrame>
<Features width="1024" height="900"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/CRM/项目跟进/项目跟进_详情.cpt]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="ProjectName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="报备日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="最近跟进日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="最新阶段"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="跟进详情"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="销售部门"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="经销商"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="8" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="业主名称"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="9" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="设计院名称"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="10" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="建筑面积"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="11" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="风管数量"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="12" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="预计到场时间"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<FollowingTheme background="true"/>
<Background name="ColorBackground">
<color>
<FineColor color="-1" hor="-1" ver="-1"/>
</color>
</Background>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="1" size="96"/>
<Background name="ColorBackground">
<color>
<FineColor color="-1838337" hor="1" ver="1"/>
</color>
</Background>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="0" size="88" underline="1">
<foreground>
<FineColor color="-16776961" hor="-1" ver="-1"/>
</foreground>
</FRFont>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="4" imageLayout="1" paddingRight="4">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[jSMqV>Yk,HMIJl'6a-QM97feBmZQKR3'k._&@?Fjgg,L:LCd!!&1"aikf/2f>T7@hJ]A=DBnG
D[&cFm^PhD+HA^$DfOW`l1K=5U)>kGkOa?#;IYVpCuE?sjP\IA?]AM!s=l#!sAEX547GOKr:.
e(`3k/Dj;(0IIds>$/7TP9TDKHDMK*6L<qTARIRO1n6*)Vg:MW>@KngQg#^tV=]AsX\ju@m35
$Fo"O"4rEWjbkR/<Ki_eg(KbRDIiiCV,I;lF]AU;(\C>V*luuNk=LKbNa-dNXZjg^5X&Kob`A
0Pq>WfRn!hZcrT_4IX8N"/^1'1#FIjW4IXANB1RWn#[d&!1-(a82Ut99X2BlC`V->0?GGp9h
c+&u;=!?=PaKu:)^#k=(7ImVH[J&o0T>rk,>&sjas$t>S!jG\G^@nOD-gT`]Agc,']AWFbMJa#
6;ZerZ[,UZR&[?"d+89DRn`#2hkW901M-1n^@fMe=O!YiYndq,mD]A+&6*unc*[$T&NN5\ikA
\]AmBAHC3`$>_C_Hmg4k0j*?DMNru1ig)"O]AhmU+mi*i^oD`VU:b'pPX_IepHA!>j$^G`VFnp
O5f:lP^DkYi?=GQBHU4FOMc7'C[\Ae+k:]AAj(GqH1cPHp7\`pGjt]A#V!G&W/7N?nZg2GBX(0
Ugq>O%A,QV!Gk7prD.4Nt]A@1`.:.=f%hqJc3`H@%$d^AiM"f]AD)QCf'%rlhp0(o'Uno)MWW!
rK2pnl8i8ulpU>*>VYW7G?ml/f%aV"4H`Nb*l7&NeCAPaVf>4.XA6Qn!$]A/h'lZuF3[/PURN
0O#Zelsn[rVDmnnmm(c9k@C9`j9a]Ag.@b8n2UjCaZ`i3q25!D?V^cK/DdM(st'qF$!rYmpF(
u@Zm%]AfNml'e:K*X7!G]Ajh%Q@UmR)RUrU1;`%i=UL7]AtjjJ(:leJtCl?VYG@4-Oaj#A!7'B_
-ISe6LAG55L7n*%KY196KH&2WY+$&l8%;3nmVB,6+!6Bn/;nO48T,cI.k5CM19$H/cAf+4i]A
0ajh="Y?\6:6qsh-;q*b4@_<A.ZN1`l[!=bg,25gkNjQs'BQ?brNa#2#D6(0hC+r)=3AO3GT
=PgNX9q#5I>Fb')-D?&)1]AY?nG/<u)QP2Ca5__b>jE9)OXl(V\0gaJek8e+&nlSu6UsBe+?H
pFM0211!gI.NGnP=W$-\jlqUG=ZZP$e5UYG\]A,<=@u"?#V$W_#)"G85!eW"u"5jpu&3Jm_[f
%p40fF]Afn&_+do)=0"rjh"2gE!`1&W\#J3jRL@b!6bGqnDbPS(.fh>#9B4oGTJJ)73e#-u`'
3aATU16uCiYt]AsSYr]AYOIC^<`de_#bN2m%O?fc+2MocY=mce,Hlrp#o:fj)#)&jV]At8Y)4BB
s3k&<0M`/eTQIK-3U_URAq"NrAN./[IT@`e<%hJN[W5,!7^fIKA1]ACOf@00#qgkFn5J:a'e4
f-/AE$6WQVfK.###u&CYjW7_mjE9<bY("Fe$UX&>m,_j/[N7Hqo<A#kp'XU-6uaaci`2%Lnp
T_84.Ch46q*/_3-/@NCG=L=@@!3"@KV%*:np,L"jd%[e.I=PETH5Z05!.j(Imi>H(CDK86/p
m=C?Z%`5>&KE;^U";;4I:JJn+38#u:_nTq@Re[?Xp>F8I?Z:Wulrp!Y7hK=j=7/?;h]A=Im*3
IegGZ>n:&:i*t^oPC34Z9PMG"+V@hLA-AWc-LRI6DDcH/_Ucp9SIpGqZ>2hCB<YSi"q0bCH\
WYF'-eMWRJWp+OfWjfn[C1FMD2AQA+EXRt)iEiUTS]Ak*?R*_H7JMA?0MIr_&b)/$Y;d3sha-
rEp*lDd'`FP[!j0..i4jRFum;-T6rTi'e*3/\5J<Y6)`i:1<aH[tWFZ_a!kR6I&$#kabNA3M
6UuFo%]Ar^0d_>P9a4gQReDI1I=oiKLqSi,q8$N5u*K9_a,;WT\0/%%A!Vo#t]A:=k,ZsVV"j)
*RXUsf2.Oo!Xd#;ciPU5d90?)4C/?`sjhB5mFFg)[j%^A7"[3%Rngk^n.2^D'?:LjD#Ngh21
\MsH3l+3<`\F^/BRY')5`ORD5j8eIc-9YT>CkAkMbd!-*j$d,RM3[]A=b^k$?"[.02qFjJ?4^
+0Vr'<11(%J6d:nI(\,bH'e;A*cmhI;bn%j1dYOftne,Zc)Z,=Jp)U3Mi]Am!cSQ>1s,mki't
#o,K3ms6Ckr!rR"*b8-@ecq\+9LIAX9<lRnDnbDVD2p3sCs>iZKHF.8Ta2Znq.@D'>+S[<TU
P;'3bH=67NlfH]A"7=eKjiKgV,6nf@pPMZ!I`Z>1@Ib^Z-^>`8S)fFZ.0['Eebn44H),BHjlV
*h&VSO!5tP7=70-JP3Zl8A)"Q,TX/qW@a29=^/$*HXR71(b'FT6q);MhP1I/6EH11o<64Z*R
S:UCgSMS?SqdV/m]A^\r"b">^i3]AfIFWsgf;'#&uDUBuR.PC,_Ap@a*n:ar8I3()sash+QX7U
qA$PcsGd<2_8UsX>@(7`'YRjqKFOS0i,=mHTlGMg8UZbJ(pL&PkjLjZ?J;Ns@9faT*W]A^>Kf
,ri@4MIEF!\Wc@G>l_YkI!39PM10=[O6L8sF#`t:FRJ=&^i6r]AGOTUA3dK!OYm8C-Slo#"na
Q@)#3q5PLQC$8WdPabT\m=F0#/frrHe'V+>&8oftEaIFVSsjaK,RA]Aj-kW+(G8Fgr"gl,ktA
P;>D0WFm0$oJZSaX_&IHjD+BRd]A(l)Q"0N9'3AcS^pV]A1i#7-oi5X#-o@Y(.1%`b(#Ei&A$F
,jioKn]ANq`U1#'Z9>qIrFg$SkCUM+J7K'@b`GbF4#I@bl8s3PTI5^Y&%]AtTV&)=3XPWETJ,S
5K!\Qm)</d!\`c*W*8$XJNc(+DeOp[i7$TrHie63IV>#oHiq/k;)8TcaAq!8of$R8r_M<Cp=
8FBq`)FOa.rbQnMleHdA5"Mj%,tU^S+BAQQb+>`Ol\@JM-i,0piiB=0a]AnChFX>/N6"oNU&F
$N2[Ru8=;=1doduK^XMQF0&d9XrJ6NO761p_[r&&5h3e@-0sRUbj?(sLW/r18JD3XrFH]A-lQ
J,Vms#\*<;u'HE$rJQ>52M[\HtL)Oa[U^2p1D+`<ZZBi1>P56CA85tiUWgROGSS)_NAT.U3r
"'[cNBp]A%B,:3)8$WOa'&CqbSE+BnjAe`<@oY,D+KO]AuK]A[A,YGH3T'ec_:g,d,b:1<'i)^6
t7p3G'r=8mKV\gg8=p#$KG+f+M)WHLsVEdQ5+KL\XE2laO;BDhhT2YVl*PQ<P\k;1OQ_E`Jm
JV=QY)oRJ:0i2Tb7)&-caL*Y!Em=o&9r]A]A64+Halq-BU>F!b3BPc\Xu(r8ZXhK[peNt$Ea0*
GI#S^G8Noq"5gceu8J%\N6[r*F7D",@3Ar^LPk?`[kP0tNK:'G\L!Ee]A.4DSkML-P[<o@ers
_=ED!,i?V!0@Q>Tel[[D0?.#N&FW&('($EG5a"m"m04$6[ZKh.Y4iFTMDp<s#9CGpW+^3H6C
[urO!WS*LLe!:m-!=j]A+Et(HS)0.JSbIr>?(E*:akJr-8!qNo>9$&V-LB9i_iUh`6]A$O<$k%
uJn95Wqf)khM/Xbu.kViu&)^pRZA'iTFg"4=7$]Aka4o&PHq7nP3,8OK8h<?W^CI`h::"fO*A
V4Vb<gu2ne'DCTW2_ApA.]A:UD0?+:MUX9Yue<4<"gMu]As]AMQO"2RcNo9>;b=B2!5_<c9u&5'
S["gNdMVpeo"P\jEVU8,_O-/B5@j+cNX.bN$6\\G1rM=&#!9L$[/LGu&TSOIhtN[$@p=#q2H
N+o,%:Ed,8`;IGit>DN=-4g..@,=>,D)gc?++<B&6PN5#*mP0=X%jP,Q0?aE&F6gV/VXT\_0
a[>8j)s(FNuKi<*F&=ffjn_6TRB".Z>:b1'OtiN*:GIs_Wk,_.sUfL7Wl\`nE]AN>bnCR3oKZ
Lp?:tm^ib+sT#PVuHT?W=L!3j9<)E(>UYdBr7?XRO^2e1O`Vm`C_g2Njn;=,G483@k^GmItm
WI4TVZcu7J#_emf)0C<kZau@/'^X=kME6Y)E\:pIl=ctCA7%<]A]AHlp$f%uW8W&TNb2ZjIc7'
*H-;!/%e[HMl/Z,f1-hkN)XYeH22nm`m`7t+"TVX;QU>5G9uo;.@e@`f2(/D9?Y*FNn2,/#@
8qc2J*5(_nPT]A69ue>kb`_5#=0i0gaS]A;E'iRIR:!jl^\e()TGV(Z?Un2nak"Va3nNm6bC`=
AEEJ9KY\YQ_Xp`LH^j.p[)eP&m160`bQcO\Y"X(2A./93GkjDkGe<8_Xs.0OrT`W9_de4Z3l
.0?AfCn0rrW>5Ct:ro:=.T>i02j;**#rJjNFp,jU?(MLnkQ66)7ZQ6o_(U0H6bGP%+"iG=uJ
<,(ZgJW[5m-Ucom#Z]A+V_')*FhZW8tSph[/.p(We3!ZlKL=OL><C&,nTElq"8Pn8OHMl')B1
RjK:4.4kZ-gi\Ng)1^1'HiTVENWLjun05Mr,MRWLB8/Q?;"RZ2:[87aQMJ`jtdd1#^Qp[!"+
h/OL'+JiXoco=5<cl3rUX2)k09%i!VdGF6s[(6Vo;FJC\c%cq)^I[JTY%'"e4OC3d)g]AC^Kj
p^L@`nR80(8ljZM\iX%LL!B3_ucbqm1$)1h6&!6MJDS>]Aes_2lEeG*NK%r4#):9d.6mI5]AY+
kAnHQ87hjXH7ZZe8XEq(G+`(49G!qOdcU_rU^+(-YB.ERpk5.a@9Zp/&Z)BFY;(1%'F.[99J
%p0Q#a-dQ.meH(`7Z%]An_E)Mg4`O)haaY1/%4"6Z5Mn>pJ_*eHrk9q(J"hd@P+r3r1)t%!)m
(%G%M-WJ6iZ;F.?dT(A>cEb3[UAm0+lXQA715jir9Yi.;:^4!R,Ltjmq#`Q>e3QLudX-!O8i
:TlZPj`)OaY6"Wu16uUGN>aS#C*dt3cR#L]A(>jYHGdEgmk3%B378M`I+8q>%WJ[lK1jgRVGM
3"X&=/o%/RmG:o5ut6B_g\.j)u8XN]A(fjF',ZhnWGiHV6OjPFV=BU5I]A/X2Id>fr(c6\=:fg
Sip,8m\q5!+H:lGE%Np_o;=X^cB<q@n:;/cr+[oD)8KeK3+-U27*^p1:sf(?t>S[LWW%rafa
[*]Ar9*a)b.7QklYiOnhNm7c5dCdg_=AR780h!jCK+ajjW.@.dS$6Y-7VBg@p(&IRhdacuG:r
hu=<bs41!"Vc_@-s:@[H-\d1MSY-$i-e*An*^/dU3h$F`l6mOsU(-[/HE>%=mZFnMZcI5uHf
P)Bk$tXK"?tnjI0o%E81IiLp/+_Q#E4.i__lo=neI?X`3N";_K3cR3ta@C<)W':F(@&'jg9T
AItmXgt"RpT`?GD1"GMDAZ/d-C"="d,*!jOn;Zh37AY[G+dEDIBOMBnUG`Ed7"O,MAG%GmSb
K,aNc]Ah<;%Op1A)(=Dij;99hP2BO>DD%2`ms0'&Cmh`PhhUALCM5WkO@mfRE"nVbIF]A@^9mc
$n!/-a,/eO)lBGP64&gq<u&>=$Xq$sW":sC?oNIobj9qrfoQ[[s10<F%,6"sF+JV&EAh8(IN
toZLVMu[GSd'BVh;^m6)Sl!Da)nYU/YW_.3&t(L+(b\0]A,X:6>%GF@lk?cWL(;9HAL5sru33
nNjg"^'8dYWMf0stRNtF>0*M\5^AS]A:hIpnZ*S+3@Qn$/c<pnk(Rj:NId$$&j9OT8'8rs(e[
7#iB#`Fb8(V;/CCG($4pCZu^:4;_2Pk'noHltMe8i8mW?+bCZ+aiXmT_oS)rm`a-JB6i&Q.$
^Cr5VA,ME%I+HeDr<R)\!sjq"`C8J3EgjQDmep"@4XeDo=T31IbqYT#dT)*gBkd\f*V&rmTp
,T4=U(i\fZB_mm,]A,q?UXdr(n^S^M.$&Hd/=Wd)a*qI+p_;X.<hb",9jl4nSo-C$Q!B[d6*I
nQ<O(l.`r0#('8,@5/dGtc1VWY5fIRI:0"P*,bEE^jrdA^=:G\WK"oOqZUN?ltiNW>qA1,TM
\@W%V8`:1BXStEh9UG<'3'c[4H0mcY@$!^#a'&@mLh\kn1OE"YD1Cce`GppEH/ntjFpZUL,a
/e")H1_aP!kpl/(b^1j.c?QQ:OK"#(MlgF6A;2keb<R-e"$?CkJAJN,.$HV?#`Uc)7>4*jZL
I&*onYlI3A"Z`N)BPTW:P<kqbOS='_*49gC'K4'W20GGF%bS343'"`f*^']A(^G#+JA1$C48M
,'?\2*2%,E&ls]AUmq^$CS&7]AUpH+1?-:go(lGiU]A4V.BTe89IR$7F66i<H&5J%Auf!9d_dX>
*3J9%$P4h[`crqRhm#baGDIEhf20;!RZ>lRM-BpY[el&RVLX.t0!Xj`WI:L)#3h]A=NKQcRJp
'9)DEm!s[0DR+bBq!"EK*'lq&HR%6B$M(fH'Q^!oR3Sa>,_"#EF_9]AAE"_2L]AE#VrbALS4lL
C0?"mJP;Vp5;72FFBRpX##T$.L1>.qW/%WC0tbjlNue,<;oV.?r^@]A</oj[H1kruNF#bXK7)
Jp^TIq+=3/@c=tR%,JO_6'N`!&/\4uUM1R^k+#YUV%Dn2Q!HAsOO%[Vf=@:f3iQnsH;79V9"
1\[X4RPXH,m8*=*hLnN=0p/cg6o+;ehUM%fT"-+b-/B45i#u.;$?DlH6fA&G6X<D6+a70F5P
,^%r8tD.T33N/b9$2`fO8AsmAs$AQ>ccZ#*`G;9Mg\k]A_cr.;K'TtO@%Q@rZ^aT5cV%2(a*)
^jbOuP]AgJ(_%ZBi0#&S-T/;D/5bH1*iE;$f!Q8:ck2"feS#]AF$,cA>C\&i.Mj?0]AUH9oZ@fH
<KW'GuLaWQf>O73jdGdi,&M:Jur8(m[>)WaTS8YKV:8t82Z/fhiaWK!V^54CuT+)oYdZhTj#
!L*&6Zs^A*k"p3[6cCW<J"4fqO%3Ru-=T`BLi-n^J?!1@Mr,97ar]AT>]AYp`ZF+LF=J=3@$0;
:s8!h2tQ.3]A\=_WcEEZY1`-7);.2aQHmp_]A3HBWIX,69<FJpJ&mks@?1=BKJW0+5P)Em+X#N
Lu;hAVfBLC'fKKH]A"QjQ5C%>dkqC`+j(t=+TOJ@T<o!+pReJPFY$[rnTp,BF:9^bJ$_AT!D`
4'(/VcZJ(cqHo?"E@16Ag`;.<%h`=N9RFR9m)8QX'cfSYKhZnC+)Fk;;=@XbGDL]A#fM28r>d
Q;ji/Pp)HU%SN\%M:YtK!_\<+J>O^+W(GLTFF>qqi9Mk='mP;)ndr"Zo,5Z8sOj_,6R@/SYg
q!rNaN_S,*>e"b&:2P]AL:kX?!0Bkj.GRYo-tATc$k*GX(/.-FNF@#G`RTFfMoXBcIsec[[B5
TStcc*N'dT]A)*`h@F:BgC:NlbPN(*p_9HuCS"%?[Z59eD7oMk:WuL^68OumfBAWQ]ADVJGJYR
HDDQp.MP7jsrBpkI9V8:2,B+OntFLtP^CI:W:WifZGoi=G-E%==RM86a#o)>f//bf$#lO@]A:
>0?Md\U:O>GFCZU*cY)GL;GU3jm'.u<fZEagd]AFZJXJZBH>BXc#9shUL,cs+dej;U0<LAjO.
7+eU"_b.'JW(ah%\BhdN=f!b6e]AsA52c2Kpfj5YAG>%C;&eN#)?l8;odZhYW4]A.;dAD7`R[4
u@hC&Ra*k4(J)@tT&PdVNDK87?aW"j$SL8/TDTN:M:<PDD[O(:NG28i*%E4GWl+L+uEoUg,<
M/[edTRVk4D8*WJr52sejd=iWef>h0]A".%D\U5JcoLbKYk?-2tG(a^gOYTIpC-er<qRDJ$[T
Q+pSuEUJc-\nPSoC]A+5Au@KG/.W]A9qlhd-_?#X8#ZrjHt050>GV!9m2RG'9qc<8UJ-&fdE@'
\XZ\cXKFg0D>@/"/Pgbac5Cq1u.P=!Hg!Z_I;+oa7$`aRlqXQ5j(kkmi@>$Hab3cg#jWl8S,
Lgt?6"^qm-CpQ'69)?[79`5S6&S#J"D41ln'`M^,YK:%"1!r)EY3H*8Qq*=&c4]Ai`i[R6d^a
5P(cp&bMWY8&[G68,i%oRh9AA^ZE+X12rV2\&hN\hE.ej%C6WR:I(=mu)ST8J]A8LcnJ-nD"i
:Nq*h(E-MOU]Ak=c&p.co@Z"V2mPdmgQ_X6N?e]Ah0Og+Wk$Km+fYddOdFcmX`7\3rRO)-:Xd+
:j(@fX=?WHg>i,m.Yp(2:RTa:*m3>`9rNh^Y$b,RIRt`fo.68S8FiIpGd3/M=?C.7@'_$Ac^
AUHA-Q:oMNpI1,;^TN3`Ii/E:eB?"g^)$le*0iF:Id^"_QM)f_^J`d`p=OnHSI.j8ZQ3-s[J
*$UUM3GrY#(t![Z2VD_DJp1)n98;=7FaKS;2%=u5VI(47]ABt@nco/*8q=ofm^pIlR*^9b1B&
[Omq\l=-mPbNgF7c@1;PJ:Bh:T%c(LO`e*h\9n,Le1RZ(UZT;Hl'5.\^E<giFM)id$L)g,Fi
&Q*2J<eQ1T=C8o1,tmH'G@\W%n3"W5$h<-CV0!m=I?+M5&OjJ03Blf,JD/]A;>3knh:[V;Vqe
qM"M5;f1H=Anm-jUj3T,`K*Z1LCsaAK,EM\Z$s^XL'iaj9T'Q#od(MF8JYMlFW4O":(TBu?r
.dd1+t4R^[kU..Ar[r_6VUpX/3QaNl?/Pk[WY"=btJPL.Siq@(P5uUV!8oiGuUiui!BfUks'
"g_ZB]A0*qBC^(WF?VK=n0M\&fQ*0q#?=QpQp#Vmr:71KmYd,,8m)`l)dmjRo?n.qF?Se"X80
R5hWcG1^\Hs4GT,t)X/<@[:mTjXA;sC(FLk9XK0J7?5-51LV%S.<Q,7#E26umTnE^rt1Hus1
JioULLO/eeFN[%ReA[qCEYiP[4f%Q?aqAWm%u:&^K3IU9r>4T?W['4Ur#qtC:>-%6A$rb.!k
qMaFfCTQ4V61h4:WrXi-W68RA$fCGjb)X-:AWpoU/K3=lK%B+2BO`kG%6EXN!7Ic2%<oY"4@
l>C2;-Futt:-]ATf#%N0DKeWaL0e17ZiZrD9<eP]A>SreBV4CSBaTT!fjkpcU)t3;uMgMI!)<0
YS^)7hQV24pL.<8Vb\So.X.BrH6U'aa?UUfkkdkbT>X6JY!L8o0$shM;O:\cL]ANob+urS,d%
(O<4p=,Z>YGhCFMfm3=0\EYNU7BC\;N7=9r+nXWlAhT*OOY=Tq2hN&:9XQ,5!P"`ECLYIR1`
Pm0qi#*&Yp$A'%CRl!18h)4*UilU.D^GaXe[hZc,5ppT]Ah,2qE)sVhnjUnfpcK3]A[r,8j%<^
N>cr2N.Y4O$8rK7HM=,!sbhZeV9Pe?CD#G41)Z)#FJ:O/$='5!=6aQ`mhM6(h(LR>a9l>J7t
Hn9`8$BikHY?O4Z8/h'RFeA-V6PH]A.K9g=3<cIRoQ`H::$C+LD\pEO@E7<^Z^1=]A$E/KB]A_4
`DPBh7DKOp(f;jPb#OZcb?;_N^6NX0LG[X=I4%[Z*,8LB&%$O2Umn`o)**Fm`*%3I7u1=&2;
soo/W^*UC<nU1<%dsXZb).OU*s<To>U:r[:/aV,=K():$b3TPLiARP<$C?VV0J?"@$Wel.X+
,+,-tPLn812XgC%Vo^'LqA&lTB./dN5o(IQU=\?QJqA)j'`X_>'E6<5`cNp6nLgl:,k0U*pe
3?DIEZ7n;6-:sW`p#e_7LG+`J]AP?iN5OF2.Bh=8t<=OpML;X9BR%[[j]A]A#3\<m6"u2'?*q<t
E)ir%U.kO^X+:`1;mkFEtn^-69T1BoA@`8Bdik)TZLr^+;4J/D.'qh$tZ=+/eiIT^$.c?jGn
Wi=p:0u(U8I*:='[6L<R#QX3U`s<Z>QK,@;Rp5_O0)*g+L3]Am]A+o]ADeWq:u:GF!Y=:8,I.`/
.]Amt47\c)s17JT)sumg5=G0!`,f="kjZ^<9I(Br&T\Q*3I79=CB^=&q\0_6/[_r;Iei(&*#E
%R!>tf>p3\s%b(4.TZi+>.)[:L=H(kJ1A'Vblj]As0[a&?mlj+2_[(="SMOIVgriH@RMgoiRm
S)_&=7?M;[!!p29>bXMl>$p$m2)d%.hfG;b>1IpD4;B80r;MMIa5uNd@UK3T6Ys\!:E957[A
eR=+3,)uQ3./hd($'3hr+RuT<)K+GFN/pBAC*LHe*hkP#,VBauAhrSfi`?9Z,01;AR'a<a]Aj
*`Lf>NE/qP[2fZ?/J[2g,<Ue^]A!kS:Aq[-XY5]A/DN)W(`uDEUD-m(Q=K:0'F`H1(33ea:U*i
tR`tA\h8%-'gIHudB&]A4&<`ean2kp&53jqsIaF`gV,f.$m&P&JQ)Jf@l_"CJEZ6sIeB[#]A;M
)ft^P]A"%ACGp<#D#nt^'$6pkj)8>1@Od./@qOHfN`bD\3l/pOM&f+6*,qbpS!WHD2'"WROrl
)2WLt]AtlXVhnk\rXRkZmAnj,DrNZ"P6iPmn7\<8rj2o(_AuO.L1TLh\@ISWLPDJekb,N7[GZ
19;1q-kX-<F'&9&,SRUZNEVTN8_tpkO&*1]A89.mA97><EO0;LpA5lH?n9s2C68uof#=rd:<]A
h+2o?G48U;d^f\M2t"1AnRLbn__\dDIi]Am(o)RDYeG_#i6sD%<Dc1\o]APQ)>sBU#T2@@;J%u
6i>2/US8+cfU0I-9H7r96(/j]A\2Jl5S,61@2>''?-hrMTLT[!Q7Q,%n@K$/_?jbsn<S$0h]Ak
:@/NC)n>Gjl#HjP[ohMSrM%9f#I).4*p7sO(B+%3gAo>`_&kCe&l5PZ=S2Mj(ka6CaR)^MXb
?bV4Wkc)h3$VXoLX*\r[/S=gCRAS1eG'@RGZd0>A>s^(iBk``BHWUqsaWYm#Rl-]AQ#NuS+`7
km`=D4Xo!CL6;5G93's)"MCS7iQC_skpqHuTM*_^LpU9a8a%[W?'X)ubMTKNHo&8!+&Vd%('
Ca_NY6hkDS0f+-?U=k4RMq@(@5q<T,gNWWs4T<4H4K'%n^utVD%;TP:tsZ:G$Q3P6Xi-$4Xs
.GhQ7HF1IF4N`(nJ02-oZQH/Gc'h/eD?,u5W@o2YeX.Q]A%Q)('H8eh40I[oG\A!m-inc24<L
Kk+`'TBM1X2!t1-W_=mQ'>)pn)N-7>?DNYf%=]AbF.;['tLlMAG/:j=7GgK0dJ+?7O.u*!$B<
K_M*1s,<!HC1lE?sh!X37%XEFCn?)g?<"F"<[cRtNijeM*,u7Y]Ag4DO_;InJjX9oE7BYU!%J
X2Mn36'FK.7g!+1%24kU#F7!VcEPnbL"B$V7kWY1D=o2@`?ijZRZ2nanLY`Wp=XofoE:$4^-
S8G=Le^__fYfdA]AF5OqZ%.[uYNgN7FDn6Gjl8(.4d0b35Zl3@[>>qJ#k<p[=j);O#QYQ,5kI
Y3h<rqKGr%"f6l^Cf,q@=!ne'S2Yi%"tDQ*QL_*XjO,c2DP.F5qM:Ca2''`+So+SjdCd!<da
\n$UtH(.N4<&dbq5h@7+mU3E>/"?\6.l9jc:R9++P+":r,FD75);buR(PiJ\0-l(+W@FgW\J
IES*[GNR$'KUfX^?CcUlcpTIf:]AF'PD'9H-HF=[6"r7I`#$J/G;48CdV>S?Eqpr46]A=d--p-
K?fo/0FYhqE)bok-,;[@$0OUc%;$4j=G^Lesl=L13L2p=<,-GqVNoKLSHGKmo*l@c]Akb0``O
Mh;E@E2aFGe)1bk?PT29\\Mc@DgFC9>Buc2b=Mp4lHull`:!U%*q4Ej[JAEA<19po;%%:k"A
/uq]A;Ac7-G2U@3nNlM!q[`,.2*Db(\U:s(FW_GiKbQ'?LEo[j#n*="8.\HQ7dV#7<hCYOX1E
%7Nt2dWJAE(1;=5'6No&aCt\PStYbe54'Bh,G@@pqNj,o\e8):h0r.u$mnjlTk)V`FJf!ool
/j!qW6Mjg^GdCo5/D]Akcj7SMt#FmADgZ_EF=[Q5>P`O/M"+c$OluIZRTZ.Bi$(8Et1st0=?s
NpDR:G;khD]AqlGJMSHO<q)g^U]A1$GHV3;$9.XbQ@AVAjt8#`c(0q&kc.(LAa_4\B+nC%,lN9
ee.UijIona`m"63!*#6"ji"WEt-NQ3R,lD'GLD4_pR;uc'^;dr91E"\m3MaiFOnr$=HHB2Z`
$q%:Y^5gm'\.IJ&)U#h3eGiaj!^\:;l:!QSt(<>C`MYs5e1kF#B,D$>CH_8Y_4j_-/NX)OlT
I[@Ckpa&H+_():.6N<2':/WK1PnHFNR@I83;f$/I=e*#8<(?n^#&#MlEBd9a"\1.sr3D4tc`
(qSqBu;SO>S^noWb_WY_+ifXOt\9$(Z"gM+ks&_:.^_M3B#p$er)(GtoOV8OhLD,8<IZ.70$
*J%;#NlhX_#Uhoqilr'm!G<mQg`.Ymt3.H.4YYsWF8u`M60G4=.i<+BPo_&Br]Au%2Yn'jkHd
6/\(Rd(0b!aupQqU`-,qN>qP\p</F0qhEGb9&]Ag7]A`g;J4h'O-K#!br(=j?#'uAra/Bqmh[m
76'716JrE!,''#jtIGcYMEI@ES"B0gkfL8nhsK*!)rk68(k4c2>0BC=SG,H1HP.g]A:i^r!FR
n&>QXd=KKo+%04GL*b?iMkbbNJDL++pX1\(JYC_:Z<beoW6]A$_DVp,0I:B#]Apuop;m[=dn(k
JKd":,"G,"]A/*7F]ATN^C\MhI;s$Qk0jp$1H1E0),%%j>kB:uja`#898ajh8SFoM)PdC@,IDe
Er#Nm8l`(W%pQmAQ%'X&;OtWOZ\=-55J,6$7FU^%-qLW;$]A>2[gp1=4s8:hf`';p9),tsjD.
VM,h'mSXoWK6q'+*FT-OZ\CBc(#D9)S\`C'_?d)%Yq<i1"05II@/$bX;?RlA!L-OmRS`F.]A0
-`R)oLsoEqJGd?#ModNO>YgAJJXYCUguNmB?6VJfcZ8dfilNenl62Gj:iI)L[jq-nGhB!UX0
!SE3ITcYe.GYl?T@;Rrk]A]A51o3`aTk&<fC7O9M^0EG3<SHVkG.!n\'pj"JLE.""+pG31_B,n
t4&694gu!Htj$FQqEs5@K;q\80.QV_$&5'5q9m6nc!2"N&$mF]AKX'>+TGG4Fu),C3u-=B2SG
+Qe,]Ac[TFfJ:9M,VLB7Sh0Z'8pgMC[8Y9A.OI#1N*4=NQtB?TcR#aVU-K;WbU:+O>>7VFBnN
0a#EhT*p'l$<10I>9pr<lR!kJl1aj^3FO2!dMiOTEk7sHYX$d_::=tWOQE-^7n,j/[Wso1]AH
46S./ij:M:-"mH6V)qN=ZiHkR_Es!>&R?GWJ0.?!8df<Mlpk"_9]AA\V5$)on+Da+"FAL6io9
e9Z^LDR?MEN!$2P?Cm83atemGiT<jkYP/ftFS[M[pG0cd(^N,A4doD,&r3^H!VS[_NKBa!DH
_<+/,Y-\+TadG*7`a_>IpkgG;$mAI$(gaKFX-(KH5kUk__-KUH((d$p<r\0Gtde/U\eq_t%G
)_+_F&b3OPplFq+=lq\^Qk.7"K<n11lInqe81P]AB;;&]AeUcP#Qs9S;TW1d-/CDaBhl_kt1'i
@Lam$Q@K*rP"*nA)Q&o#?d,UW0s*JFT%4P_Ohle/7TbOU[N6=J>j>[*R?&Jh00J^6^J#Je8U
Qr/@PG-2.eA$&m7VuJjp'k'46f7:X@1/>R70W3?.T]A&n8ZX6*G8&`qQA]ATJ%Jh*5:BGFe5!q
);2C37tu^O&aC@$m7aPHSV!kF9&h3JcnAiIJ5#:\)c:NujZ1LVnYm=6+Q#?Y_#nL^eEbfSNd
9I]A8A/$6(!9/56;$Dle5pP%k<D@r".r1TbHUdhIc`hP*PcoaMp(%t/\gV/>I=Q(,VUg&pe'+
l[.K]AR?NP4\kP&*n(NW-We/^Wk*1tRp_%&j@Y4I)^l[d.SN>(t?F[Jh,jQaOXT?[NlX=[3jY
N*Al6/TT6k&g#0h;>Dgc]ATO)9IJ>/!o>=Ul4f5/MaY]AH<]AkU[^(gNf9A\]AK[N<bf^(T6TZlL
HBq`]AN:7=2obpi;'$e*756ILR7R9sBQ%kZC8[n:CmdJ\^suog5k<UEUs@<Mo8aP2ER4b&W;^
*gG3B0]AP,We^`hqr\_2%QrH,TVa.bB%kEKU%FgDE-Jp;q*bL&N^&Pc6cOol@r="E[Ye.F45_
i47-TF1SQ;BjQLGU8/>]A]Aus?"Nh67F2ejr!XdORelG^8Ph]Ar*kBiKmVd+TG7CA_NgE/nT[pj
#EQi^jaJ(%rhZmt\'(r52P0P?-hq83/JcuI`^%;%=\g4EH;U5/+bd_VQ-H0gK_c]Aq@fB5W%e
I8;mSD9kf)qOuD^:(?B1keej5O4qd<b?paZcTU%)mp;"Zql-m_"Xa)(@Pg*919^,[3Bq1aS+
gQM)'ocGVQbWiq=#q3fO@RT1bT9RMJ&N-=Cr#&OhF^:r'?"#:2U&>/\$T^B^opT27p==7pCm
iq12-K[WEL'L(3G=k*le:4N%;.rU]AhH^1.')c5Ee+tP,fmO+2`a.9W3q@P[RF3nK$V)*o/mI
SC[K,0oF-@:]A]AW;lR[8g"gQ;>6&=.cLs@mT`[Y9(XgRe\@SY6i%6fptW1PI=sS&=")51S^SM
IomW"H)>c!kqZ!-#0]A,CbNFGq9:KUYYU'gkSXF4K!&^&+q(A3irnqOKE]A`uifFt'@[nAdl:^
/eJn$gY+tk>qo8K:#'$>>2u6IJA@[*j+!E=\a.j9-mXVkCMc;mgBNF7Tu8>^Wk./VF=XhKPo
HJ=5^nm!f!E]A[TZW^b&'G4'@cTlB"Y)BSZP<n_0NnHLu5!hZ)QKq\:JmY+-@UQJP[OWqV,B0
^,R`NmY!r6po/$)S@gemA`#*2OSuAmT@0LD!thtOFf54Vr[@B<O$-ti"70KA8]A!?m[BI8e-b
aA5I@q0,@Yg>A1OHAlipD*nIPr\*D;D-pR)gh20'*NWM*VG!86':#b-dXWAKT>8(4d7]ARgO?
;aa@fU0<f"2J9Z/g2fUYO@!$B3_-GkD>HdO8.g\=omN>)HCg:aDbE&WfmD>pE"Y)?^IZ]A+^I
(?"^]AfJ<X2"A/Q_<?7:'dHI]A[TS9HgboIsSFBd_^j>_jD'1g!?;<aG4`$n"p?(&q:JKl`,9&
oJO<DI!<B:'-PV[ps`cZ97Ekb9O,nJ23BZI9T3"s-Cg/GHJbhF/M:=4(dp=U>0Up?aCU=t(F
iRB#$aYUuF=J'6?3EPoO=#OVGft^"-JL%T=;E(Z^31ebBIjA^cmrhn(:#5An,/odi\Y-7YKa
-ubGdaZu$q@46OhYcH4jl(Jhrqco<r2dU@PNh/4JXNR"(e[@R;=_tLMrW!V8&n.KMPp5pis@
MPJ*57>I"R1$F^?KA,Q$ah'>ZB#'71bdO1*R4\E6*,76&ZCQ@/DI^8oRs#*jUMID=cgS%l'&
!W1Jjm@$9^?,su%)J,g1,":c-rnliRtt(SA\ai?*cCERH5f#4Y*g"]AlsW;M[_kM/X#UD9,3i
_]A_Gb'r^UMTZd7.WCXn[f'iYV_C/-ANqh0dOo8?&g^.`K+5j\9'$Erg!aBJkX@5R)XE0l+Kl
hH$rOe/:185pi@s*:#3QUbtI:CsAmn40g+;3J>CEg3o5ek=Rd-1&^q1ml=t=']ARMJ$aiuHZ\
55E)B^UjChujAafR()5AHqAJUc=hZ3)ht6S4*K5]A8RtG;f[""BuW4Ye6N;7?,ri'1g;4X!4^
08d[E_`0u+MZ.T)M1#/-BO+_^ihRn*5EppE(oDTKn""!_!15>P*=:Lli#'_rUZc(?N2>?@O_
"dFBHhp]Aqkc((Nc`3B$=Z(3"na"p/[$QKD,4F:CmCk)%-W^4?9]AtF^0a74p``)5-NC`EHc,M
u1^1cFGG$iFNJ,U7N0+*8B\im)dG\aqrQjOnKIHs@RVS&mILa4]Ah&6DVPe8Do,@FTUg*@*es
DK-j1YYj/Sb8Z!-]A'^/)"7n0'ZT,4c1oKg63UfUkZgYcknecCVNM(nBf+dn5mH`?oT/GB&V3
uca_GTY[X\,9^3dH$<Gi+[b^YY/%Q1U:%1n_h/c"$7@UQdN;3$bgb!;#\`XH+o>m[hA[s(@i
oSl%?(N7pQ:B[m;FP@sOU]AXMJ*c)_u7DqW58j7Zn5*t!V5<HQ8^5.0@,Ab%ph6<16>f#QIH;
fG]A:_VYIX"\CV`>pM"7\$o!(QuH=0(kT?g%f5]Ag=:<q:kqAL;?+LL,?#X-1f=:q-??s;a*,)
M.g%f2n@SX2.VMG]AYjd1U=)]AQeRc:3pYXlTBmA98"7-D8@8U50YDW3+7PU@_?f>`VJA'+>6i
_+%tjmkQAPTu?7l1]Ae+#*ThP)\(%1@o8^3[A!&;kUU80U<pfhg9Kf5m0953G=T@I$=K1Fk5N
!U&8als2raJaCZgrVR/NiV8CM]AB0&a17PD@76n>6(pd9[T(S@O\N[Gh\1]AVn=CRi)=V1&o_q
\>_.kZs0QEG:4@Q[.]A.:IS6Oso8F_.,n<knU[;$Ma>Ke6N._J(V4&pLA:a(d#<gINjF2q3;R
Ik]ARc:IHZ;ksrp"a4>[`LoNl#T!i9IINN'>SU3>S0fV5Bo.YO_AN$:bAIaHb?URA[Qea!qb+
"WaDII8erciq-nM7kB>!tRh*[T-kr;rGI0lf#624S=')?Zcd>N).IP8Q-@=;U3:DoB5./$)q
.9tc0RAa/M._AuNDr:+^ZQqM!JLZWtQ\dMj+aILmRors\,3c/5<bRPVWtIu%q"^j=mXq=^nH
R(6Xh_&r[*DRciD,4)'Ra;27$\4e8QUr#!!TRb0[@\g>Ajt#`C79uV"Xlq1$;79,)L9""@ah
sZrVpDIgCjGK:ef8mMW\h(5\Up3NOK9`_-h?s*;Lf,EN/^%/Mb>OKJ)(OEArq,>uBs;-eWXL
S%2<S`C"7ojm,4:=Lh?i;]A@(!TcFSK,+mjF0R#9W`JVa<RPS3Uge[pWM3^Zb&\=Te@U(,JW:
Z48n\mWLOD[O.A9M0F1?[C5qEA<ogaSLlMi!U[*[+3YHRI"-$_=Z@F*[GjQle?RG,0;l72$*
KUe.XFI>qH3[1CQ@ftCMDjc=Q2IQU2okr=@^/'>UoDULrbVB(n[LU9>'8Bj(#)lOrW0npa4f
OtUWlluh6n,r&p#G?-'tp%I<J7gs!,^hlcqVZZOPo.mT:Ik,LeLk):=Yi[>^l:b0L3poe=k)
>lP>OL'W^OpgCWu,4OhPKI3PXIJ@)^r$"?D:Nu[*RN13->PeKh2:B1XZP^oC[/Ac@Q36nHl@
El@oc5M`tc&s-_>k0k[Cg]A@:?[1PSN2as-;VOg7U=J3rn^[0:<k#[*MlYX@_p;Jk<NS1CK^h
92Y4lre1tqgM&\l&R]AUUQaJ(uQ]Aos(Iq@a9loUC5Gh@D']A)gam-[Indb;5EO_:+7[rBOJqk%
>E%H4mENW_VjL&Z"+uFdZlW8T'i-'"@#[MsR?MDgbfim,7o^dNL,?WE'jg18fYHm2Q>2f3eB
@!bn0El8X]AGG*f^mD&\S!2Gm2le?7oZEhI+@ntj@Qbc_-_T-)0=aCN`s*1Z$LnjEhaT%B2ho
3q['ahi=IK]A$*=hBC/.(H+*B%pSrbiVOVJ*Uk3+O.7Zdo15?5fNY(bdi2M%Y8$qQ'WZUl@n)
?)N-J<$&F*hTl;ZK'j'8q*d$m^i7u2;n/QT<B]AK1?8pI"Bm\U96F6O<9$!Y=Nr9%.c$d*V2'
77RSSX/F(a\@-fSmfALc2(45f^B5^u(([(cB6>W*4d*_MmU#BN+60UKW<@p[Btk>\Y;ouaU*
T@I]Ak(DXkk?ne\+IsXqJ)[J4\J&9m=,N\DD*gAE3;ASQ9\[h:Y\+W>e/03$<3?bQ5N/`PN5<
;XJkll?C#.=M-`kWRT8>T`s5Y`@Vc-8bHMV%t2&ZUqFlGfJ"Q8+mT88*"5K$nk^9mn*NYo^N
r3^A^<\uKA/m8\M_$>[TlkfZ8rE2dj!&CUK1o2d".i\+qfX3ZnUe6Q3Fi`NCdXg$5;0[QC%'
!0+0WC%j6\``^rD?n%/H(W<(UWM%4l@"lgidn38q7&Cr^Dr#b$Fdb?SE@/Um@j/'W^mK30*#
d-3XIp@3(jNY]A-Rb]AB/n?Nm!K57=!MdTjAgh[$V[JJ@JI=<riS`cT3KhuC<:*EQLae8j]AY?m
WjDS()^Q)!AR3"n/1^La[.;W?f0XsCpruO-5R7_;>iJ!dP'9NVlR=s-e@6Fbip*\gCTr5!Ie
0i1SZ''dgb3TO2NYYM.:=!V8!C)Wc)\0eoY7^8f"a.'l]Alb\B>$uImi?,=_E=oNWV1BLJ31I
kqX"B!]A7@*\Zd*YfqO_3'QT#OAgVj(q?g?cIUgik/<^!1(X3OID97o#=m&AiaX$VAKT^d^[C
&DM%C$t7kT(i@oCerF\mt_0N9([+<h`=iCVC8(IYgK3J&]Af&NXY,50h"h^&=bIJ'E,;p,r2n
pWgXmC+YUab^LP&A$)WnfNmTaa2o^RQ$*T_kfD`e1+SrO'=iM"XaLE&$YoUajn[`gAc>%<tU
n,-.([_-&%,!NO`1=_Cd#M952LfN8Zb"^p:$"P_7=e;8"GVcoqX+lVq\tj=e?^+tJ8_K32V=
afFB*A6!mrT&EC!?V3jV^D_%_3M>G'hju-C_RCs.pcc%&[]A?\ljIO&IEDE_6NqLK\$cp#@RM
k^QQY0\C@E0dq]A0K28KfE;HhI>;C/Q!+eMP7D=$LEVc4ur1ef)C;ErtSbG<U^:NZ\*_#Ej?F
>$4pC7c_J?aK&GZ$LB<3e':7o09FKWl[@r3cs[4hrXB#OqpNf*7j""\SKtGY,qUBL>1gdatD
T.8cpV-okrV/On!\`RAG'Z7LQ@DQQc636+)S?blK;aWbOJ-3j=V`,E6nYn>%T-I(!SM3X+1,
A.a3RgN,qTBs2fc^f(hW*fN9Q,1.G/EiVE55De.fYH'OaAWOI.CX@QE3fi/[#@+^>U*kO(#+
\+NTJF?TMlNRKj*F'bIb^`'`R=#:2ZJ3LWtbbL`I;s5^[r%=k``GJ?h\*6$h<+i%04#tK0Bo
VeB)2WU*Fj+j15.2_VH2IQL?W!^A=AU(LWUjV;>9[qR!qVS:"/tG(?GR;0-S2\LCdfHS)RlE
]A1808j<_SjJCZK?!^,oGOGDh.i.fC?^m.]AYFWXn)#A)0%mQGIHeQPT$.kh>aY</VZ0$[:d6K
b=-*rldO'YK/-Es*Pj5A]Ao43^CD4dRE<PM/46@5M._'A@B-I."E7ZYAN5rrqZ%%uUh1*?S+s
d/\["m_D7FN3V\]AJC1h+'Je$W.JLC#60IX__]A87Cru+Y,M1QVYn65PcHT^2,-heDh74\7L7S
:.NL"G$3Wt]AE!f*U5Bb4f'/lfqX_\d]A(<dX$l_6=.?j\R%Tk]Al%3'a(#H9?=aDV40eFKb$@$
Vn6,IRD(F'"A6YVY3$"Rt4JuOX-4L_\+8doFIqZRQp(XId+H[G(R?QnE4=S@744ElsP.#0?6
e`cHRCOqWXsV-u^b4A]AHqg'1N`SgEJ;:0]A]A8j&5,sT#m>:iqLXp,_N2j_N.>P;[Yk?HD4PNC
&KM-ZNEa#`a.5,iX]AKirq!)F/%,>S`A2Y^F(`<E^m8!rjgtc]AfHaXKa=@SWIT.(l$O^mT32*
G:WTCk.Zt8hdss9%(]A2r4R/2?D"?#*/I)PTS7@aT+8:TV^h!(]ARX^gBS/7(@ND:/Fj>"cOd5
J["a?f3'G+-`OJWTsqiI*%rq<'DMnUq;1a+!J>k%0-,b^"XE>TT8h[-S,dF1nnjS<\OJ<)Jq
pqAGF.i7t\es8A\M]Am//.H-YZ?L"f^m`-/T)9M`gD@nk!lkGf?-jVCYJ45'n,b#2K65tUbLQ
)rlM!:^D<,fut(f;HZpUj_%QiQ40hO93p-*m;!M"\6+@1p(er7i6BJeNd"3i1b#G4eE/#ej<
Vt+qeV:%rjm&?V`"UhRd/ZAfkCA975WIe$ND0ArK^4b$^T=hWqr*fFYgYrQF<SBZ@nVREj8F
ashuilH<=]A.&@JCqkW>M4SZF!f@BXD-4[/fWYJ%PM)_(\$2sD[Re=>:eNsY@fr"`5h*OZ:J>
4dg)]AiL8kJ,b0Pg,N@Vs?<:b/[=/OgmVF3D^*,3)KhIeGEUh]AoXI2.D4Er6=SnSh3k"6*n.b
X(hWNV%'G#_gH=5pdnEFiW`4#n*RZ<g]A-.Z<#8BXeKCLQWQdCjdMnbI>UaiD'(Fq+TLRl,%@
]AKO.LR!q2cM)mJc:qsgjHW2^d?C_SX/!X7YPih.lY>kRdCMWhgcO-.alh.`+hq4q?uc&c.Sb
d8*`53O9_!V-@Z'c,:nd#Q(#\7Z8-=1hl3O2Q+d"c(n'^pV0Jf>R7m`5>&9:E-X+>:FpdhFV
.AQ:?9kb*?T`00QLTjqd%%m3.Mh\'deJ"lS>?NXqG7T(tQI5Y""^g'H@?-(G^W36Jk"G2*J.
?c>>9Wn^TPI&/[psX\b:Z<Uhk$4H`jsI^3L?kkD'0nI<GqA7U`=U,ZG5GEGoKZ9e\N'T3nqK
3*dY:Eb`R)+Od8'm+=meE(m&j=:oIEFjj+Z):7Y0Pr,@o%jm"P_Iud/pWs`Eb$p2`0"F(,RZ
eN-*X9CD14be%?QB9M7nM1!/9AgRTZX=?l_'2#7HGS\&^aTuk9HbGr*!>]A!f!EjA)5bPA%]A-
`Hg(M!]AFZJ`0%f&6_jYIcB2^8unFrW;@=\XCr#Y_*P)[1jTUMB7Y0Gj"#5Q+cNrdWr(T)HF6
deG!7@<%^_Q[Y"AIU''V_\dffBHY-FcXETS[g+tKmnCj(I+N.BJ6Ts9gR8%u0PVUICo<3Xk4
P[Zc?;kBGmol,B2_B"hd#LI0V?thHQ>K<b9*U!+niU0ZcbOu2_Dbtiu=J%;hYDCl8OsepK)!
im:6)inCGk1B+QqtI)&pd4)hnGQ3fk>G>?p[Lg\b=ZF(ACnY_D[3@8H\9XudOcPpO\9@JVk]A
rGEb*PR`CP>=Eu.iY_18dfrND"7hB.kFm'/S?4`roPg9%=d,?n;1VnXd9kbI/_&]Ao&rki>n\
"LmM!t4'U\l?!dmQcku(lM,h5d&f=n+5g:")CVaVeRRl1*iO*:#]AX$tQHLZU\CqmSZ3`OIKN
SkEEgGFGSn\4Io4oaW!;_O9iC]AW^`V]A,lFr/jTu$L4$E6BM&knXoWKmqD0c?Mq`s=cF/:&h8
^\$QjCiSmF'c?W'YF;mdd^]A@U]AUnOUP*1"JS_-LjNLd?A&g7L$$&??^sjrR+)8e5FCm3N_\?
JS4FH:\cE%F_fF46k;A7Z7._Qs7\=:&q=3Iu2Cm[bqc1=TKEJ<]AmGd/>pP39Dl]AGD$QiKI]A4
GWa9d"1)mD&\jQkee%rC)JXrpPS^>npJmFs4,tMIl4WVm>=e05XZ))dM*B`RXgW!"U.;_W:[
*`=%R'K1dOuBU=(2!$Qt%C.09N<#S;<E:5"^^*[*ckU"jn<qgRGujc93C>h1QDn*Dd$OgXA@
o6KJ%CEu815NW>S>B7DQXA8_sJEJG2bd]A-T,*q*r\]A2UN'pWI#hjVIY'eB+HYr6i=C,U2ma$
itEL60:NZJsa&?E[Gf6.lDfT5DAjKkSG^.gIiKZ?<`?aa&]AWkicHFP$MQghns0WgPf#lhRi*
Jp5QbC9,J:BcfJ:[G(l<uC.9HM$sr[8arWK^@uU,'kRkMm7+G^EFc)`604n$A,<,iP40(e\L
QQt^.[>5C"B"Y7W_cS3@]A^feT7&s\YV/5la.Q&$P[aCtCV6rP#H'TQV2!.h-FNEV1n7'Ih4'
^e,Zj8IQj3K2\l='?Nq3)G&k=SQkVBt^Q(pL)4*;<bCk,9h&@d@dIc5`0SH-2N>fDIZhBL6/
C%8uH1Q"VIfCC;1m=ShMLFJ8O+It-jq"-84DrX=S:ere/\q)(XX2Ybh>RM+gmmC$$g"+ST/P
?T7\tG>`+Tn-b)2ZeQq4It@EMo,sO[fYpUV/]AW%r0@<.Z0-6+OKkn1!*O/$#Fj[/+S>hAicd
=lWcKJp'T'fepjDm>;>9$Wk/]AhH2>S)b)NJOW9uKGB^UA.Vfjt-A!<nX#@X>>Os(DL=2ZB_9
'(cih!:`GGq,SB\I>K/*cVjP:Bu$.7(b"U>nH`?'G#i.%]AP0,7O55t[0u7tV*O%``hK"4*QY
.cE1Fk0(c7u\a]ABK,O_'q4chtm_?E]AO6FIePPcN%GG4s(TGf\G0rl:j9)HknAF/;,,.ZM964
"k$V-#2USqR_I5K`>>:0QQSLlBXRT3%+ke20eO`#k=^9/YTeDb<(4*TS+6Eq=._Djm\erf0\
k\&0aR=cEP5dfcUsQ.?tq,0"9N[p?Wl""fj%84-qju1,etco'Ik$l;uPrFh5VS/1oRn)mX@a
#2Bj23ec"aaE!Z.tEofbH6WM\`XAAtc5=onJ08nt<SM:(X``T"f_<eV()soue$Y4P84-@dlM
qTRtX2R,F%ASJu77L$qVIP(/fceO-A9haLC8GXfM$QUcp4*^M?6a`&Or`-S>2Za;P;;'WH(F
md%1u?<b1/h$Cs5okXukR=T'r=j8Hs,ll-F=/-adW#=u#o.^sg0/M]AKZnLr:t3p3.PHr9g;M
+G3?<doO=0\r^m`Xg"DY&p7bR&=N#\a,kGrct+198$oC!Y;do;AgO*hq7l/r_Y.nR+`eT(Z&
+qXbF&jRJNjO5ocH),StIB.NbW.%Z>Z$jH0oEo!\$ZE5uhCS(=dj3$E+A*2"JV@Q#q4:Pt'i
(qKe%P@ICb3X=@,X4lk)a$(*&'I4LpYqQ<WsWR!dW;j4\X8ZL:C=X-U"LHI:R?cScM$joiIq
$ksqQ]AD7BpRj9?R1qP[pCFsBj6Ya.I=0@CDq-F<0d^J_;5(Sd90o)9F%Ym$iXl[B6K<(0'H1
CrGT+6b'M8nd"H<t]AaKn^%X`T'rN@O5`pA)29c;fr*?7milFNe!AMlcksYhl>Y1k\S7I9)3#
&bVgrVaE:WWW3N]A?<aD07l([B^f9h.,r]A"nP%`Qq`C$I9A8'Oi*P&!nI<:h_.u'&[gBMnn(9
hIe*q7X[CW\TAe]AB50XN3koRtrl-bSO\;(l.4O*`mOXcHSnl2d6i.OW5:Q;V>(OqLN9*Lk#O
;)>HXP;^faEi[hN(:<Kf^`>NNL#+-sB-%\f(fW"sLP?VXN_ag2?b,mV6QITBK76M9hVqn5"&
DY[n'%I&8R_->/2;bp6'X#<#[JZX&ri\pNY>aJAQK,H8km$.oD,dq>]AjG(J_Du#t+iAkV8n4
`536'Wue';H2T%Ct@qbT]A:p7b3CqT`B*jM_c>jZ+cAp8+&@`E.hlHbNq)Yskg&6W)Q@nSD7p
r32$_YtlH*.UfaY9!JAsak6>dm;>N6M#fao2jN6[4qdM'mN]A+J%Tf.^@[<&F1\@@AX"`(tZE
Nmu4)-k;>6KT1-I'Q2U,ShXnG,9%&)"'h,X=);pG`m0$A6j/PD$"9UPu3EVldEZ,Pos4qqoS
<q/.4P8,#^WiPg[FRb#qSGrJ..<`D/o?]AhLk;Q]Anq=3f0Ee-IpQj!-*jba&&G<j?27:,VrB^
<p\MP.cX>Ku$"g.d^Z4)J6($lW/3]AFgDAY9oS5e%"<L=^:akkq<B`qHXqj>W-2REp3mjnj*R
B1^`UN"8[60V&+1O4'Uri.IB#dA6m?2'X`+4UPNK#c31/RfoYM&tKLhCannaDq+&$=!P@\]Ah
-6G7'r_m'&I)f5l8=o]A1pIJ,t6#`.*9E?e^`<WLB4RaR.pE5h-%u5nd=b9OR3)*Y+Ks%6l*f
cO(/#VOra!c?E_Aa6"MS8P+IW.gn>OKfT_'0fTc`cb8C)VmgLMmg+8NMeWLoD%?;;B8h-pML
&i#@$[DH_3j4TEo4S\8AM7&]AN"2JI<>Wg-57@h6ne$lKHe$X1N<N3qS54-r;sVH-;'-c2j,3
eT8Yb8`AQ;tJ^QlDoF"`2AtlLX&#+_2m1s^<>H6G+;(D)e.>L>fFG'N<BtAgg9#r%MkJp,V(
FG4(&,ZlKr6G=)nVi`\1C>lPasqaD1m$JJ1#4^$Q-M/TVN\S81c52,ih@C8HI)S:84F0(;E>
\=;_anWS>R"Tl^b[W<EJb3"itJ(>gQJM2_oG9-0Ld,hO8b*oGQD21R&*(PFoNsAXtll=[-$F
,Jqhkg5N"MNq^4ik?VEJdd[4<4'13!(:>BPdUL"=r::VnT\o:hrL`[EhI7<lXPK[$U+aI>h:
\"O]AnTs18>)Ac4Q%F/a^?"XjSVe0Q0(fNaT$C%iP9qjQ->V).U/Dr%3G]A'dJ5h4)Y9C!9[]AS
O;uDDM(#CGk0V-\(oR:$:?DN6bb[(GlCQAjV9j1,XoWm$g7AL,UIVWa/-jg<C8q*6O1MGkS\
EmeJ#0):*^d8ORDbl0@5Jk<F"#[I_@S^FQ\F&oqFjiaE.CBIku$!C#8/p/fAgV8U-fuBcjRM
Vis+Q62kE\Oa7RDAp5&*^h2Ch<u0p=6Cr-J1^PNrQXK`Of<RV>S#A,94;/0jdpO?m)j?=UU-
:_V,Rfe29nZaR(nFJACef;6rCG*%<\([Uhp>Qk8_%!S*-T3TAZ/3e.lf]A\hGLc%"a]A<*6H#/
GOW-!`Ol6lNCmWYHeL^WcQiu=SP8)!VJ%q7S['GFlVPE6YBos&M6=D1,P'7:-6A5pYd87-k_
Wr;T1%8app;(fS2-RHFnC?[N@[Z"t5u.^mq_hsgQKQMp%qR#Q8t)#$^aQY_OjHA.oj<D_bsE
4jWlJ96dl_c#a0;gLgkGO.Z1G/N;6$rA2)jW`,!b,PI3quJZX8>ZQa%OtHc:7eocVo/!#URT
hCia$@WDAsh<aHC062qTLP8Tt&3#uSe+cS#X#`]A:(+HCe4j,9rgDDt!`[]A'?:%YCi7]A7X`:H
]ARnoU'g0DR'*OTX)9BkBn9rgtaAFNg8XnOKIV(&CrpN&Ko-@k2)7g;-%>d>Ku:lIhlB.r25s
M7f3T<6s\&NFf6/=cg"2SXn8iieMN`0H5m+uUor6WU)t^M>%H>4g$T$t,*P=]Ap=ZNXVM0%MD
]A6`Ab]AW:LU_<0\Ru*DBaC8Wt'-p;Bn:*]AH]A)D>CgoW2>[J5$@JN]An:NoXOI]A$J6nCBL9qc3#
H]Ap!!Y:pGP5`5Rs:bk&!24(<`=\=0DKlUS%RIH6_LMR=A1Olu0cQns?2JUhpB=.R4nP68bIC
Kg$jHe%c($Pl`Z;\m#>Ioh@?@Yd!!"C?JYEkmVAjfU%RMagQ<%;\4tTO::J-';F(PkDs3O5G
1[dA/,ZVKUj%4L4UE*V1p2lOSl;IhtM'\B4Is]AdYVg0-0MCV>Wk"Jrq?7W"t@a=XnLOsZhF-
erOmU8eV!33&TH(P_cL&jWK1u2gJlEIXhF)`G;0E8%N&\rC?4N`0C=PV<OrI(@KE^'E83P%^
m!Np]A_?0OX)I7NX'!72Y&#mrq3g>O3,SUK6P@WZ)d/QU$;?W\E1=-#ck26CBMLaUA_u[1^.%
)T9=S%8n$%Be!VWka!Rop]A@FXNV2c':=Vi6u<:@";h2R+ga/ZWq&pl2,LXOG?mJ0WZqLTXsA
ikBBG5&=%h;=%@6[@^_E_^4;==X)VaJkBr<l/KCL47Pon#[u0:#OH+L?,r=<F]A_<&np7K="F
\('h=Jnmnu2kVa1s^PT:S>8,2C;D-9(qNKC%^(Hs#OCdLZAZT[HB*9o%jgPXf6`WV^1K10>8
f9+56qcW@2=P5't\n>N"8$RAD\Ch^XSUVm]A"UlI=0?-/nC_Bs53q'=9MSX=Eq,";7P=p5^:X
1XjD@A[$WZFRq[@n(>Vc-/Yp3S^EQ/*X.OXiUROJ7aQV!@H5Gk$3&5:[2VD_Y\<#2TmN#9<B
W1C8PNu\CsDHj\JYe7J%.=J@c?+/9GXGIh&qLCL(BLNojrYMg0QGe/+O#32g4k"iJL2Q.X%X
9<-moXQJMDg-2;Dj50WQ(:s's#up?U87cL_#dm3sV+B"6f\)>O?$BuplEamei;SIEdUXQXSR
_K\luKAaQ[c]A)p:UF<L^2,"?eLm3b\#eiHd`Wt"PY4S(>d-V5E)tA28K&iFWEZp1V<b_<M"k
>XV/^S<$'[QN6,jr"XKB->RN=tWFPns/bIC>?h`UK+dElV#-iBX)G-20O65RdYE'oLP6nK*B
,sPW)c`ee-gt*Y3r;g;gV5Q5*uY$`Aj;fqKDr-AVE^OqkLSqG9/q.)`VcP-R/38`$2(`7eZ&
feYI(*[VMs9&COS?sH1]A3^m#1`N!A(`HWFW]ArqgpWXIsrr1G(]A@h>0,/aIe7eNY2j^f_+/j^
#NVXc23QR?d=[62.a?M(N=M5)H\=fB*dAl,H')X`dCB:W\,Gi6T@,G\kNX"31C4;sX`;k`($
tG0\YCBdjG1`TTj5n.`<ml7Fg-$sB)1;Dr3"Nj!2FN-cWFN-OhralGYm(J1nD5Hs0EeDm3(]A
CCq,aOY.CI&.mJ)[5+4"PAC1oEbK")0AA\CQd!&j3ScdALM6a=6pX[p,SCLe`1<8tX[b8F9n
t1IN.[=%=1>M5lbqKZ"P3C/W\B$a+/g+c.a=0_+;W2BUCTH-jb+]ALh#/5qr6[S\T22*7:Esm
gO.q`;I'-\f$g3k+jC%bC2L6R!2^q`lSNPgJ#4.0LeZi25Qp'MkfH=P@bYibp)qiOtS6s4pI
KWCq*l[>V3QP%X\HM6Sh(-WA%J)E.(6h1-DL<'<&n4qTA_M?<ER2/S6I-,(HFcGm;gPA^%,7
1?o4V>.1>,f]AMAgR<=s0@?#U$Br<Mh1B.8]AdIcb@dBhc)D>]AM8&bhdu5jd`85QI+JSHX-Dp@
OF.tWTa_U)XVYQ*pA>ii#XF#NA'fc)""^3NX:M`Yt,n>@mIXP(_Wj]An+P4l8NID(?%l*BL"g
iK*Ri>]Ac2E:g?p1J?iQ`^<+70n.^%6K[R90CGjP[;HYfphU^r#*iZQ:O:T:_pi%qPlitn>6]A
#!i(\,Kei&hK6f0.7SqRQG0,#N[S,cmAh:#3Unb^e-[`EOX4b7+[$Pg,.P]A$eWCS:o#5*WQf
1DGQ->I25o$*PV@j^k9c5Y%^@[[UR<qnLf!^<ETa9>p`r0L@&0Pt!,NFJR=.UP>0u.,aH&%2
8":c?%nM#a*dpE)#F$B!d]A2(IU<f38D@Ig84@lR+."#jkr`!4;i]A]A+X9D"*^8m<kb>>=QOYh
L`EbC9>^YuK0VqQbDt\X=QVh?N#K:L4XRIbd%-Yon6R/epn?(.`MS,[$\*>c,]A6=(mh[l@Dn
L=<9Rt.L@&M"6-YMk)a_.]Ah%IGKuGQO"UGAdddH#QI(1Tr!CG%1dYHJb<V'c;V,J\O1X8)"H
JI[GFYL82.)CD@ZM:2jZ0`qYp0:JCQ+,$kMq'Mqma[3ObZJC#3V,`*h)Z8$5Q/Y>Hi&5CN,Z
M+T&Ho.Y#IqIeX9j'j)?)_r4HW\6!6`=`+C"7IL,UEjdB@&?VcRr25b)comlfk+HOi5MUMqQ
]A5=A,^cflXdc^_!]AP\\/%rGB<3D:;<8]AV<Q0TkoKhFA-?nRF4loJ*V_>p+SWlD)$?QO1a2_`
qC2?2aolK@_f\V6liZl'7Wk(B)_/*!R.pKYD9:[@Rh-]AggF&1o6GrMG)j%s2`o,E(VRLm/6,
IfMQEZtT@3mQ.s??R2f6(WEPFI;3n>DT:MWmJ@:1_!&j`@&hI8l=)Qa'<CIAHM`s)=e:q*,0
.LpmQMcVg3DV7palO<$Kl.\ZU*\A2-6*phciaLl:%6mMGq![@>98^(.&f=W>L)aA,>q1IdPp
#+oMVlf:>2C]AM"V<_3/d=MOQLeikDqrHuG":_g=g=1]A.E(*Q,N0pi;:gWXQPp8@PJM`Nie0H
U,L3PAigd$ZZX$pd13f+5X%gZG:@]AbEt@D<pZSY8i5+jC0T8g1.4DA\3[4$Pe09r(mX>o[\?
>V<OfhSaFnRH"jgXMJ:\Wj<XQ1Fh?N-XOo<tp8sB1TA?KGD,Mb-;*6AW]AWSKm]AlgkepO7@TF
C<4`?JQIY4A"T'^9Fu\TEGsYLtd:0onI2JobLo;V(2W568gbR+$9Ju<(]Ab3$cRtUB^hP2V%m
TA!_IY@_:!sJiBCh]A.gO6VZ#8Ue\V*JL02MY$D-b(L_eLL/G*=&9`&&C0qR"#t.`NF)ZM[:K
nA+((!_1pkCF4"8/_=*Aj%',:79g=EIIBVb44!cYhR*Y[Vl-!0=L#3"[E<.D-CK>Wg'/^qO7
o$Jn3^+3j^uB,,e^0dj7;ABNT<YcJVR`mhgS%&FutoujnR+3lZN/X]AnK4Zc)skL/'blT$H^F
/]AbeDP0oE*PO<85PI&kZu<,.2!(ci8kdFLje8RJpSD5;Jro(60sU$G?hkQs>!C.XeR_N)O'f
Gi!q$.osbY+`;1+.bN&=-[>s3<8#jO'`7\==h^ba`7R063oAsDsi&OcCCElgFiSS7lHLZ5V8
II`.Rqe<_?&)[oDRY7-EOhi-t>D3kH2@7@*([Z1'"*[;TR:cR<(.\bh(qY1mcW`)61rAE5Cl
dge%3Xc`6mFK/>D/uMt?]A/X;7pZmlU/-2:$D6g#g1"Ra5M"pHr'Q6@oK/-2.T%&OI=/(.K^Y
XP7P$f4LgR7VL/h=#i8>9e`cZl-oI@A?O%CJ))dStBLqdu>U%m[_B&]A]A=-95/6Aosb3k6-X1
IK-M%Q=0H4IVQ"S!@e[5a?hRet#au`t9C]ABp5YQ"q[TLTWc$LVEY?eeqiu0TMG&FL6j>0uXQ
#KN4mW=S4S!k`62oc[j2Voq([,l2Pe`._CWP2/tBKfp-6`Xt>df@T8&ntIirn:=fUWiOkc$e
@b6q^+2,b.BDlZTbtLVdi>!l%`u;3>BAfU.nqYl%r*]AR1XO7:YXe<%:*j,cWSCe1*Wc?&,1J
8=QOg"*2g_K&dsnK_"s#VLs[#-MWbK8g-A@[C(,?GMi5S*8frMLQRRL`=4-ps+.G:#a;DGh$
9L=qm/kYrR>M)$29&:+HaA)kd^Tp"$r5FbF.Mpi3fauiK74&-Cr0l!M*$B22(NpMc3e%-M<l
+H:1rAKTXO\__Y7649uV!"Qj6f(]A$P]ALW$bKFh^&:8oD&=_UHUCf<-h[f.M!3g#qI8dpO5I^
1`[&h)cUMQg.Kb)-+6naMk0V.Q&3-$Z>-2$;)Tf%HBfu;PRY^nD9-$pe@?eNu;"d>DL%G^gX
$0\`-K&cW<^Zc='K]A3-.Vdo&fN\qi]AUCg8Z3ohbtsiF!g;B!s%lJ6Y(,RjpYVO%Ap2BLJ`qG
Goc+KB;XtmQ.+nlC%OGHh\#86K!aoB#elkKJi0ZOcNdm>T+*TM:;q1gXsBg_aGJ<=87aoX6H
dD7hH3^\=g"'CF[UY!>LB:mV=:\>(Q"elK\(@#L;L<t"Dnl*VAL4H#[RJiM<aPon-]A`>RhIo
Yfl3'WeiD%A#M%b'M(a"Q]AR)(\aGZ$%K[Q\sR**`B,*^T$`dpWp]AaiA?c7%uOFdMS*.[O2<M
[Ne`g9NBF%fp?0&DXS8Y,pHuqe,f1g'Y(f93L)7S;qUj)(!3=,2$nc)V!0Fr?jLL!@pe.VmM
t<Hmdu3_h\(fM>K'riII0j:>W'#a!#_I;2ri<2]AlCJ$MpFmAaY,kD1'jEEl;RJce`tE1\HB(
7n6Wr9at5NadZk9V.QGhop[_39d+u,[.$ZA>USgBI2&E]AkN>X#[dik!IC@Q/]AG;W(b!UTVer
M?e^^m,Xl%QfaG)]Ad&jbETuea]A0`[n7S/_pV3YJeOaF0gcc=pfL*nHmRtLP"\&AWl7-EU9*^
aQ'A_Mah2be?4Yf:15DXWS$bDpY#.*XZ'*=FC"4G3E1-as'65<I\\&W/k@P#OD.Qs*n,AiVA
mptdr8YBdeuU=9.R(N!9[L7$/^,?pL%'HXe@pk:#Oais)Ya\L!,T&%bJ,Pr(qSPbHuei-%\7
[TAK)A?4(=dp[7AfP!DN\;XrZnQX4`.&9gg&Ce`7(?HZ$k1cr3^"Za0r#A9uN*nh5kP3/12<
Y"3g*'Ohcb]A.T5n'TZn:<)fIM4XGjJp.uqd;?'5)W4EV!pu..jmQ"B.\Rqh'B)tT8]AfgOB&m
&RP2)_k!#dri\Lm!I2l&3_Th/t<j5[o>801/Op*V&S7'I4c@<Ss)A\io:DONRL-30#7.\%q3
X)%25dEQ%8NmOo-8PK8j"b.)'.XX2nr/O>/&H-nftR6Ye%M'k/;S>=+g9ZBI?XfS22qACh0P
0kW;3m'VTF2(>`8md'X(SsZq/cqLn'4WQ7)lA=T6`\_J@*:?Uj7Cu?S<,[eQqtOng^4"$#SC
X[E+m=2.I3m<m'le<n_U'=kp[:b,B,r4[t"49cRX9\S<rocK4LkkVrg)^,g$Z)QVOCO9p0]A(
DYGOZMV[[N85fYqVGaU<mX*&>2Ot&[O,lRAX)aVcHZ>4J*&WD;Y2EVI(Q\0V.dFHFl1O3f@Y
fkqE6<.fiR1Gs@^(MMlWDm^5Y&7qBg'1r3MD)$<n_%>dscktlPiUagCI"F>d[14OHa7Ym=Ds
>Lm9-.?@+SL>)NQHK<$\3.?[t3;[7MPi9059$C^[00E`>*o"RVGe,t/MU`ici/in>:#9_i1S
(Q3t3/^<W'+c6M%qpY@#1Q85Ud2\#IVou\@')M_Zn%_OjbL7-PZ*e*ID1As`Tp69#Wed@@=&
sE/)e&Q&-]A$/<lQtW1&KGL;1@?f'd:Bk5U3[cXnZkjbAptbB-AJX!c%mZK?D\>plkELkWPUR
K3M^N>-Wq%'s:g&g=]AP\BL&ZQTLuo1>=QT@@BW-daqIh$Xkflejg]AXg-TN=.EA3YBLV&R]A\"
6cgo&*\J0t&FA/WWQ@`$R7FIL[i;`*TkSe["B/$cmE$>^g%1EF?7^37K)#&lu;,U)u&00gc.
QQ%Dj"9UirEP`j>slt%p9U`"A^*aR_:UjKpYIhc)_YC7T1I`[$:o6WB-[E9kZ.l\i1Vl^@o,
,`174aD#kj=P(2n,b$[oV2$K@X#Y$%]Ap_a^+"iX]AJs'9gFEFj+%V4+\(7//]AZ]AG?1Dbop4LA
5a:L+8p]AWn]ATY?5%M`BV/0_9ZgT#li)[B<5H1YaTd,S^)+Y!QtRPZ@K/;A<<#?*mi*@aV^H9
IQh^4D(Sn[BV%]A+aWQlF!dF@17K"O(e<TuMMiZP(GM!Sgd6g'PVq!!dPKXX2J-ST($l[A(QX
EIBG=i#"%S]AX_$)W)X-65eG/bXcQ)t28`3oP-o3U<Pd0dL"W>i>5=btO9_q\/cs^8En0(P!a
5Y&.ep<Zr>fC0g^Yis8C*4+muWN*%h^]AAHQpJf7=OPb0?Pp%C%!3cFe!9@$%en^h>;)iiO`A
,OMFIGTRi1':YYg$lX^@><eQM(4ZMY]ABKej%MSq7A';!*X0RpXLGa??X;JGNE5!'/4=>^()#
^0SFVf,b7ph-6nBo8_DW9uPUAO#`,5lH%Fg&C^=1]A=hYNVEnU[G.bYV&ljFNg$4]A;iim#10B
-YSgj;9)q\g5tTJ?%'Jk"09n#BRVO!Z'HLbh2pspof?U]AOb4DR95.c43=_/QLBDPmV(@5;o<
?f+[WaA7NTDP97Gc,#2WDu2A?!?P\#O,t4kEK8]AP5fLjlb#+B4"@LDQ@ptQuCYrE]A2W#kV\"
e&j<AA9O[mR^O@$@GNk'$YUf/O)7IRn.g7+<[fHW>lIctW>ShH)QpfP[?UE%,B@15^U8h55G
/b*%bAbb<T@8S4OefJaYN"kp@Rcq'ZH[mcQqN!3]A`XT<2T[i>VV!n+c&IcbT/T<?o:HN,f:B
2@=:$ps=WtCg:4Hd$Zf6hGCZ-*X`&tRUAlWNkhUQ$4IULRP]A;[(h$aMEQ)f>8_qhhn1o\GEa
OKMq5HfWJ"gYlESV]A3#`jT;aMfAbCOF`4,O`@8M,Dp.>KikKPVlB"NJ$2j;O^L!p^Be3HH*U
1V4fW84Ede#UiqYTY-YS@^SJ6An^(s>h_381pG]A76rp6A8aF:)*/47+7C1.l*iZm7mNlQ\lq
=`h2:73%tEkOruM^%Rk]ATSY)DGh$ZEL;>(O^INr\g00I"\,aq)^I0I>^YSntHX`F!j.59`Sf
=Z:AcBoW#7lo0[OM<A/0]A66%ELCNM^]AZE`c$J?s:\28</t>7\<Y.QFiS._s-:"oZn^o=Z\Vo
9aDqg-:XL.G#p=O+CYFW!A+El+X5V=$$f"4gd!b(r,f)i2;jT_Has*.c$\*II\e\abWSn5h?
[+(7:i/GMR8RLha,-O.A-`hJL1L.U0F4s%e7]A`kg'T0]Ao.L/S42'Ig58d1SRkHq?EqioKf8M
W&<?2;hB7.4;(b`#?8Q@L*/r54eJhNCFb.*Te<a7u@:elKpeLaHN+EkV^7OC,KlP"DZ;UG52
m19bbsos<2iM34sY9(5aACGuR#>'G+&j]AQ(uj5jE3^\$&-%C;/HAERBo^g#fgE^IGN!*lK)C
OHl@Ba,._]Ag$MQ\Ynifo]AO#[Pr!9&TREKJmbUsS/C6e6n<&djREeH=W;@gpR1QP1H.7(7+A6
o`IRZZ$2jdBGD"s'gq\^PfEpJD83A'dL7"(L##.8!ai*Jsoa-dp@k*t[[L.H:40ELLi?(#'b
<DmkZL.N,P;1HrA0A"Y.eG(]AMrEQ[`%O4ff-f=SdCJ%amNsgE`n@u[\2Qj#;'I3Ku?Q3\NqW
rDi=#)MeS&QrtKLCoUh6_@<Os0;-(qtEi[Wt)TEO+_eN#sP`,Gr^@?q=WU9\Qo3rh:0$Botl
bA$_u4S*U6"L!i)<=GFefb!^4*X&1e:><]Aa?9)-gc5MrIO[0R(Qo0+d_cj*_e<'FmA'B'0_]A
G>NYD6==T!t+P]A9#C6,,Vt,h._SeqTA4\T1X\1>oa%39\<.6okTgj=]A_BiD,F\DNA+BaL.Jo
75=IBS/n-(*;r)cVIM\,UkrG?_!iT]AMLReOa?2:h_\U@Po\:L@6)MNR9$J*g+Z[`B@el6_u.
5NGi-lmKau?:QMA)6K"[?JY"=4&j\IXJ"ZI]AMu[Jd2nj6ITAJ<PJNB)%rOmDlD6-co2-!1_!
%,CWt$V%Lpk@DAY[f9_ShceH?fskIRY>u!2fHK&7s=n@U`ZWk]A3(CV^jCef:N*(h\M)$,`m3
F,pq&gZVa!k58[cj.H[upX(3,i-a9_+jP/;d_05V.C3g+_1T$oG0Pg:Gq-W1M-i1E2"RB5Si
s@tl`7]AKn[%l;R$r>GVDA![$8jq)XT>$[ZpI!@!lPka4.4ToA$aQZ>L5`8@rs!^R59).l8,(
4Y4tKTUj6.(fIpqmV'S(G]A>VR=IptEUC;603.[YfF8Rs!#]AA78]A,Kf!+5Y)DE2+CeJ<_@*Cp
od,p!E9eoiZjI"Ykt"MCJ")s.WlRWfIt&T_./!%Yo\mGZI?*?;g)FPB!UYA"<dCR]Ao"Rs\QK
XBhO,]A3[O,]A3[O,a13`c$kk3<JA>d+W3Vd3Kgo8Vn+@>1P)#DCe.&s6_IGF8t(*6rj9YJGUS
/hgP;HWPA=$#'[Yn0-p"lr7rG^*((]A5*((]A5*((]A5*((]A5*((]A5*((]A5*((]A5*((]A5*((]A5*
(0XR"E>'RX;[I=Pf31V:1)'::8t[3eGfO~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" foldedHint="" unfoldedHint="" defaultState="0">
<color>
<FineColor color="-6710887" hor="-1" ver="-1"/>
</color>
</collapseButton>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="469"/>
<tabFitAttr index="0" tabNameIndex="2"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab30"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0_c_c_c_c_c_c_c_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="false"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0_c_c_c_c_c_c_c_c"/>
<WidgetID widgetID="53acc9d1-594a-4229-865e-64e84a870861"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="11" bottom="11" right="11"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="simhei" style="1" size="128"/>
<Position pos="2"/>
<Background name="ColorBackground">
<color>
<FineColor color="-10243346" hor="-1" ver="-1"/>
</color>
</Background>
<BackgroundOpacity opacity="0.04"/>
<InsetImage padding="4" insetRelativeTextLeft="true" insetRelativeTextRight="false" name="ImageBackground" layout="3">
<FineImage fm="png" imageId="__ImageCache__9BDAD1A694F2AE09931BEB5B979DA1F5">
<IM>
<![CDATA[lO<9(kN.ld@UNU%p%320!n&&RXMhpZ,a0ckg]Ag[)Sh?$H'm#O$mX9@nDg03/<C4dC'hs7\:U
CrUFIA*cmN+n1!@hUKFS0]AXkEO<r!!~
]]></IM>
</FineImage>
</InsetImage>
</WidgetTitle>
<Background name="ColorBackground">
<color>
<FineColor color="-10243346" hor="-1" ver="-1"/>
</color>
</Background>
<Alpha alpha="0.04"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
<USE REPEAT="false" PAGE="false" WRITE="false"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1257300,2286000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3810000,11430000,4572000,4572000,4572000,6858000,3810000,3810000,3810000,3810000,3810000,3810000,4572000,3810000,5715000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目名称]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[最近跟进日期]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[最新阶段]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[跟进详情]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[销售部门]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[经销商]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="8" r="0" s="0">
<O>
<![CDATA[业主姓名]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="9" r="0" s="0">
<O>
<![CDATA[设计院名称]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="10" r="0" s="0">
<O>
<![CDATA[建筑面积]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="11" r="0" s="0">
<O>
<![CDATA[风管数量]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="12" r="0" s="0">
<O>
<![CDATA[预计到场时间]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="projectno"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="查看跟进详情">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="projectno"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=A2]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="op"/>
<O>
<![CDATA[view]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_dialog]]></TargetFrame>
<Features width="1024" height="900"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/CRM/项目跟进/项目跟进_详情.cpt]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="ProjectName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="报备日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="最近跟进日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="最新阶段"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="跟进详情"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="销售部门"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="经销商"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="8" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="业主名称"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="9" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="设计院名称"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="10" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="建筑面积"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="11" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="风管数量"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="12" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="预计到场时间"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="0"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<FollowingTheme background="true"/>
<Background name="ColorBackground">
<color>
<FineColor color="-1" hor="-1" ver="-1"/>
</color>
</Background>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="1" size="96"/>
<Background name="ColorBackground">
<color>
<FineColor color="-1838337" hor="1" ver="1"/>
</color>
</Background>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="0" size="88" underline="1">
<foreground>
<FineColor color="-16776961" hor="-1" ver="-1"/>
</foreground>
</FRFont>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="4" imageLayout="1" paddingRight="4">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m!E;?>Mn$bmR<"e,/LZHL#B,QV.aiU'R*8j%p#>oK0r"g;CGiWg*"AB5`6>6;kO7$G58g0oD
[XXpZ)3mmps_6R58"CXL7bJT(VGuc:QI9<I[F/KEqY^j,p3nMBN0.*Z+t]A>ClkDiQ<HFc3X\
E;n8c_U2_mRTTHDFV+JbIYX5/&j$%LbpfJ[ZC`FG65&C98AhSGDEi^,Z->oG##s_A,6E<BsK
ff+&T;i(=S%Eq]AF$"[3p".Va/cPS;cShs'Xbb`nMqce907R$2&&O@\0+L1<Y&%Ie?Q=_=SUE
Wt(hETj]AlBFGGMO4V5ap("hbR1Khq;pc<b'94]AgG'oC"?.Z26Zk#QeascGE:\TjdO56<e;II
4^>LCf,CZH(<1G34]A?7c*@aPY#PEWO`^H7lDRt!i^$(FkVq54&0\pqugaU!'XIC9b]A5-on9u
l7i_641'&,4qS#'IZrLEX[sB3HBNV$_1%-N7N5g&GsdH!RoS8`/rg\"U=lo`^E7?D#hH*Y5,
^SA!O's4sUQ0V*6&Rt8W[^D>+j9'FNN`-qU`d2L.2n)"@QFQo=K*fE:'Xm[%_LJH]Agh(6G?V
FANI?-$;d/?C`TErUgN%jL$\+BMnJ8T5N+gj+?-e%%"4mF=p9I/.R:F>`(O&/Z3N.OfF[a*=
tDDO"1rrOHY-'t/);D_P9]A^2fdt%63VClo[r4*hlJ,+G8I>Yh2(!\F3WefFZ24S_]AKQg_Cmd
]A*.#gFp!Y?`oT.GO4s$TY0La>cmrilX$G?rLukA[R#&BHj1BE;aN^hpKX@lZo'5>J4B^Qr%9
aPLTd[K?Y!2-4^UUj0/S=j$1sp`Aj*b59&c?YALFfn2qWg9f]A^p'DpE*Yo1IpA@5Y+RAki(<
Gh]A4lo6daH$4d/)4p=J*fM]A%n]A_IqFI\X6GG^Ysk\EiABbRd`hGi!]AJ[Vt[[&o!]A!a[t9D)n
l0E"OhO"a=KgJ!e;aGWd;;tRa_Eltm[IK8"@)V7a7bSjH6IY1pN[EYWY8H<kn&Kog0m83h9G
a!"QZstjtK2E]AU8HEWU98[>@0*o4%?M.5?FN$f4.7Q)DObuEE0[Nbd:$G(@c1^%ZGo/l>"7J
^!kKn`sg)oJ#S,m()ag9B8X4oI,&]AgOWa0=Ho\BQctmGAAJK'+H+ApUT(!VDFb=mf/9q22o@
g5C:HXR5rHW0;f65MbYA"6?XCGeKPWP63MXJ^.`s\=(ou^gP`u-(CgWrs;S4<rnh+,WdLjNP
(.G/P2QAfAI*klBJGcuH8f<AtX^_i^b]AND2j,YQ^[j-OIV*-)jHa&$)L*/\'-O&D=.h>-Jj7
>ECknKiV,:J-CYKmpuX=#KVeO'+nkpRbEgiSRq-!-$$2UH21P4pAJ+q2Tq'M"%'u0gb/tNX!
*_=l<p/`O?X8X%$`fao97WPNBGln%:,eMpuk9muf>gl!8i:h@V-G2NNa!hKdN:mFg:O9dJMW
f#r`G$M;s&%$Z"eG$['J=/Q<D\k!(NmOH,X\)_Hq_N06Ar*7HLUC6g?McKs6IJ4Y^/fA/iS@
>^/U6-8>D9HGH91=Fqd;o61#`fkJ/3Jg]AeF*50)`-chh'InQ8aRhucRfJd#?1n*RZ?[=qQ2+
Z%O]A0e6e@8B<I:34P6o;(+7\ILo!S;t/[GK6#Z05-5KMJD>F0gHGO09l>D2\@?_+?S?@]A6)#
mG/sV!qE4Y?t=:fJ2SBLP>lk+lR9nHE4?3V6B%m?AdjRHu4Smr$^6rgLgfHBb3[X3,]ALVi2!
h+2S/6YA^;6'cb-F'/S6Up"Ms5c+fAlFRkJ88<n7S3NodA:`/ot4E*Nc6rSbLrfM2oZYB9A)
J@t;Nm!]ABh>tMetq&:u:\^>URs6<"YZDme1Bcm?[[\DA[;dI0+k<LAJ#j>>l`)[0$l,AA[\A
TY/[Q31$mj>.\SJfQS&/F*A%j1-k7b<:q:DoF8CC@U]APMURWQ$B+J]A^goXfLmP,*.F\54Do/
EGNV*"lF_FAYj^8mr&`!.8Uf^?W?8S([bg;MjdTHm-HIb0;P+E(0i`f]AUf"q$kUI>kjp.eI9
6W]AYr$>^SlZ<9Lla7#e;>nH%`uM`ooXYRJeqpnQnXf'>57KVFDVdU#OMP6pke6i)crF7#01K
7BBAtnIY,1($.:"a)RT?f4ASS^T,"6_Nk4I$rc=moM\Gj-h)WiVj6PM>iEfFI6rV.WWX/hJ#
iQ&oJn\roS\,(G`\5+jeiEg$Sn8pnt4e9dkQrMYg5[^#2Na45JW^NESVK[<>N`0jbUc*#n\@
Hu!^:#*.e9Sg3BC*6sQG#/oqEYt[Fa$#_[sZg`nN1gCNWa<.-o)^&_?>s8^Mi%^_+m:/cfdV
OOY(!?[>S)ehsKE!_dV<fjUhPl&C'_QG+e3`N\fQg2iuOObB-ER/0Q<P/<:D@\!l#rYB'2G.
AMl)bq[\mjs[X6hC<.tHJ%PGeD6@\>\5otW8V2&3C.DW'[f9CAhJ[dNVrp?/GeH/]AXhhAHB8
g:p&9c2X5aDt#[s.9Mqu:QK]A>[S3,JsImD&2#5+-e6'8kq0q,;a<W#)?9)O.irRFhXPaX/ut
R!4j-eAF-[f\F,NEh'j4roi(E^5h#V]Ah,^p)la)KXd'EVmEdD2aKn;@KUOInEM+6\cfD+2R&
j"/m$W)ZnA3f@l`cutYi5pPeA/Y-0nY.W'kt$'..@pqlPdFPhg/^P?UQ5J0Hk\bK,*!-k!su
C$5Y/f0&a%"k#(pM30nd=G:EQ]AoJAtH'*%F"C4-o%<T@,q'o6$PoIF:k@=e5ho_m%ab6q4`5
21!KRJl1:F@PuSP,!/3ACTZ!$/s]As'?K\=W.DQfVo]Aaii_/pkc),2Ko_?MYi6/p.ZJ>ghOq-
H#pf8KMo4h*U0SBauFI2bCFBj#>JUqnX6stl-fokZ(Ru#C_%"_:M>Ol0JYATk]AU[J]AYhJ5?%
kCL-PY/GfiVAT!L$L\Q-c6!bQeqKgt*E!m3$;Z3uS=uRCS0!_[586XYF(+U\7P:M-4!Z!LlD
/6$MC)q_MS<j$P$DAP9Ro3%rMc#H\s-Z\eE&&9^N`)me>&u,=9ZhQr"2h!%\bnP;Gd3,kdCS
dmM>liT4Po<K%+8Dc1Z\]A*4pXa:Qtd+>qlXefU35JMsN/]ABDNUTfPJI]AHYJ?.'-C-k6)2X<%
2pLIOg?t3YS4"H5TF5R[3tO[=<^Yd/=k1Lf9+>5!7g-5W+CYN&U)C=\:pW8L`]A3?'<Wf50Z?
\Y:OW?i&[hJaBaj9n")V4"[b'$uigEdPL_pe`jn`Kah0[A@W)C$WFgEMf[c"\,A$TXSJX0lR
qTEX`M8:DGFQ/<h4Rn?4()ujHEiem9:(3<^n\J2P.&f!r<`Bac;TjkqQ@nKbO4J4mKHn]A5f+
]AZJ',M-.NWT.1Dl(l_X]A8[OAM.e-cZuh&:+.@4R_s]AI(m<Z?(=$<8m+51o7&ek_Wp+B>]Ac59
F;Ep(fb'`gu3^G]AFJ!7GSa=qonX!,k"O0$):Q)@:P9S2Fhmo"'C^Q=QVL]AN.4S&hbZ-#j7+O
\p=alhT+b%6^\'YYGnt/qaY']AnQc'%o&]Apc2?W"[(@SMT]A]AkJ@lG,Cb88Fq^r/OA7B$B#;dQ
gjM4\NH-!Or-dDYe/e<B.Jagb]Ae"[F=`[[YoeWE`V+k*>q>N%pjlp.Yo1c>2Gmh0:AR@?K?b
<&X'WP[\Mr`ToUV%Z4d*(N7s=4XWJ*4")67/(W]Ad@&h`_I-E'9Xr(4^PHSI-#:7[jW)ue!@=
$GZIN+WRO-!.1d;;'g=e_1EPhR1+%%uEF:kAOnKdgj9h!So=riqRn'B+,^m.p9.bkC9D+XrM
q>PuCb?aj.rRMS+K+&?ke$;ctC%gSEOSJT\jN'NTJn-N6+B^Xk]A!k\u0oUki5ag7\V!bJ-ZT
H;'3.I7]A#!4$:C]A^CNH4NI?';o-lYEdHl(^XkCkorcoPPIPYq1o&0:hn#V(:1T>OX8%Zj^Ys
PV>(#G"l;?If(A,TsV^nJ(8$D-fM;on_<s(.m0H@SoHrbX$R"'`C_7$d1=!K\En"r6r2ro7)
##0CEArCm"C4nWUj[eZcl+L1lP+bRB>34K>%rp/KXm/G?gBhJ(e4Z+L_B6I3Mn%-Gh:CNKc^
`juc5-2jb-(R=q976&M8);gF_Ap^j2`&U;NV`,Aj>KX-qZ,E>8$ac[OW[X*3ODcD'hIMd*I#
k@n]As#:JlpGPR(bG2mNgVS_f3JlH_uX$B8=D;5n7+^S=@>\#[3:<ha[+nSVlQqATp.#FSE#!
i:s,"*da.jU-#$@Q9U<B[Tm]AQnZ+N\nCqDXtE\XTICnhA_D@L?G]Abdqs;:L.RM[U<0]AP!L(2
<GP<'RAQl+9cA$9PC]AV^gV48.adM(58r"/h7G"W_1FV*MPN0/f+YP(ffcTUEU`7SQG0<`QF%
Ccj9@ICd2@$:#9'LoEW..9j)3?+@sWYRXC^;p#PXq+ZM*1E/.mBF2\Gi8__9Z<*7Q^6W8R>G
fMB`\qL[F3_?E[O#bY_h8.XB1CVIJL9u!>!h8,BWZoEhi-6Ag$'lpSRN4kV9iq53VhJbON&u
XSIALnZHHaW`T!jc.NKQ6;&IX(qpaL?4d_(HK[Yc]A,Y]A:iGVZc_muP;Ak9on@)q`eC=K^3(S
,3`3R>AeZE'7W5jLA)jhsLZ(9:1qVS0mu)6DV,co=<QoZhkb_fkQ3N1/\]At-WHO&0_-JpnIZ
S`G/gcI'/?X5XGpkJUYiP1aBEeV7PInPa^EoBKZ)dFL]An/QaV6Wt_k\86I3T_=amt;#AFeoB
$j.2uR@/p-a*S6:ER:?'1I%BEOb%)PF-@gR0dH^31Qu3MmCZ.GR:jkcefIk2/@/pU=#A#_"$
J7FHFacT)X3PX%!Yj8!)a1IDb8[S$m;=GF00A=c,S2<Usnr*oHb4a^F^)-q_N((pU%MB(8O`
3m_Q:Ng2oSba8g>S?ZRL]AN_3F&8%*-P0fu)N';N^.r<Up$^I;'d#9ZZbm^NhN-Dg=P97g*Q$
d.K%r'RUD'GWu:d$R;;?O]ACgN]A&:r0S"u$hus]AA2j,qKNQbRHI\WEQo!Ft2,C?D*9c:uLj.j
:Q;S)'!'h5KBS7LD).Yo6\cN.[]A[pH"Ek'l.(B:_>XM)!SBE&?sN9C.@,A9#!akFmU7DYB>F
Bbp#r\[nn'f902M8jSMr5/,'8;K*k6<77l<q3S>8=>,sLAhn7$HtTSkkR$Yo%q3_>8ip_VE/
*!<FUTd!$543q(bYAm*,"?Y$ZE39ol:`u(1H@7]A7UbL^H::r(k,.K]AO?&,UH;^JIZAJtVA>>
eWFHBOADTY=3=D8Q%6]A3IZNOq[kb9r9%Bku%"Uq5,2d\B`EHkP'jE3004]A*OSo&dJ.B@Fspa
Rk1`AKk#?^uW'A6:h&DRL,4>Yp(D*?U;MmrL$Q,=fXb<d?dV/3]Arsd?gDKD09XWDY?H5c9l%
9s^^\0N'i(l,ORHjJV*Fs\!I:B+BeimX'#a_t\O`![pJ]Asn(K1I&1;h'9qaiqU"!!7S*@Ssc
jUq-OhcYK]A846L*:QXC/HJID<C"$`+F5BC;m-I=X*"k&X'ug*=^bM!r!^8l\?2g)M4-,[ui8
7/pf1%%2`sOfc3'rr8YXa3XG42E'7$ZC->-QC=:%<FBjuEV()W5N;bRbfLY4K9^6IMD&P3o7
>F/7=Y0S-q8&Ul[XTmh6Dekp.k>p>%0:cWF:O>ZMdag@"=OqLc+2gT7^+nQibMf0%\.j1'^^
FEirbIorj6H?4V=]A,hdFtDZ8D_\fmnAI5qWPGP1ea2?54Wo/#`[5IY3*J-[K8uit\C5*u#(T
D[nd#lmJFL+R4eNK?#dS=(N9@*A,1KBK?^\sQe"gDmY(>5jrJijig]AS9AXCauDX#Cj4g?TAd
I@!XBY')j#&2q,=AU?6u+1/?@p[t]A^RNY2X),^updWh`cEFbnHIpg*YE%mIX\T/0Z+T$Huh.
H"OT1Tm`6Zr(WNQ6b&kYl1LTR/j%(q=-u=np%qL$rZoJO,3a"Ts1$PEclS_B?*h`B\ZX<";?
mG&O#[S.)C`R-XbXb)8(p<iP4\g?!G!TfjQf_I%C#>O%T$d(ZE*_'J'",=Z#TT@><Cq&WkcU
!4-Y5P/9i3LXY.BDN#?Q_jF`XQb;W0?;7*0nOQ(Et<<9oq\$(4jBH!?>/Z$12>'`FccKaJ50
lf!$7Hu!/&88BcE9m+c6,BB0R[3V(KR[I3j5+6S<oVh>60<n*;]A%nTS>o)eXlmq"XJ65!0^2
Th88JANYp7]AS2aX<8>K/V70SfO5fVU4/S4c$n;m,m2hqP*Gl43Pj=%6'snTt"UqY&Q\naTa7
WZu8:btsZ<tl=3AU9:J+,%4b[mXF-FkUOqSf8^D#3e(%XJg[*aqBJjKH^fl*K"KfNXqJY9*6
tYFQ"c]A6H#Q^2/>S0MRjm07?O#cB#n'/fFZfaN&Hp88A]A<41ulOH0'li2Xs4\LS66D1S$'0K
;2f,\pKIfe3GPa1,&PeVaW'/oqQAA/ZpW?/FI@B?HfT5RQ2F>TMDhF57<8062i\NA+b[14m)
\m!m4(k9lF0*jO+sima@*)%L9>4.<>0m:&n6M%#bQbYR-IdTV&'lP81]A8=>&<r9M&]Aco0>ug
#,J,:IGJ0,D(#f5Gl"@$8:f0&eM$7FBH7W08k)9[1\,?]A>a(eIc?^,=)F!*jkTuA;aTZ`4;f
P@<m'iP;;q]AdmoGe#]A#QHlcefR_rPFTiOD0W!a+fMG@pPg/"?YCb#<N+If89d)JYV#<6rECK
9EPF)t`>$[Po<EGF&U0\dF4#_#l_AKedqlEpXnpMi6e,>O;+eI`9uSCPY#bpHJccu.L-7>^@
YrE\Opc'J^JNkml[dr!AQ3rI*H@A_h3phO7Cp"Y-)n7Z@YPDADQ88m2=V:#-:a$gS+(1)jQp
@AA>Yi/97qd(f+#.8C_R@iV`*tAP4$*50C*cE`W/Ici=YaGi&o/0_-eVG-cl3Td`JX;Mqed$
A+2*STWh+q`4Zi;L?+6$6,GSR@2`&/qmtr8QPb85[UQB#Am_p'/.YFN!C8\B=h%[S-!5l=5;
=Sl$WcL-I8@7Ai\>$&jP=1[b:"8W6BTYGV^64.P]A6%]A[k"L[I@A/)S+q3SLP-(b^Y\[l^#k.
L1@d8(&1iBS*RX\UrV4rCE?#'5N2I[:h1S9lGA<sU4>40$)XKaMXQ$1&!^rthZ:YC@Y7]Aic]A
Z#,DagdIV.Q'.lmV9'QenoY,5E<e"Napg+K!K_a@*Wd-.V.CQ)BooT/!KU!cb$uj0RDka2\d
r<F^]AFbaa:Kp`ehE':.\W%/9Lj9G<T:TmN&WnW'#-Y."ls0.qHcC0<h4-GeCSoaUW'/0gM\c
oAO'i9.FZ!Fc4>;-eSFSJH0SHm7o:OLkN$Ylamh,<?nmnB%,B_fYB(sPK,\%SKNc`=l)M4o#
QO#BJ8=tkC]A;^Yu]A:SL/,JoqFIUgS3P65h6.kC;VIbPYdF24%(KGhr<m,f"?jo/]A@9t.&0]A@
!0U["#_JKjUM+I'_P,aIACQlP-FTSJKB:QPMUKI:!4?,c4mCoJ[W23[/^ZCE,C9e2RAgn<R,
F.a^oWU5^@)%f2+F#E``6R1-'G[D?c&nf/K/V[;(A?M9len`q;F69+?'C$kR#+VlZ#J3%)Ip
l^GAuc;,RX'D!hc"$_OQnN\>+`\J/j!'!.\"iCT=]A2TLg.0[<`P+n'\]ALTBrjZVt:;d6nDK4
TsETcKJnr`^4Je4Z9gos,]Aq1NOk)!T!)`Dk?f`l-7GD?Ef_[*WZ[af2]AkVIufapZT8Xc^Rgt
]A%f*YGk-8.*rn9a"eAB3=WlKR'N4`q@r';k"2UP&)rTM^nSp8k__c^`j^6gZ/08(@9o_=J);
Hgt3WfA)(m5<o_sqi>fLrd>Vg<YlQB2<<J!U!#9dTENP?Fae[-(O^)q'+5K)`_O=0<<]A7*c\
o!]Aa8<QG]AFMRQQB:fH>96tKHbFVTH98]AI'7?O9ooq82!Hcgpq!79O*Q%Fb+A:E/RGuipBGrM
INp#`K6'NeKG&.0TUB0="hnZm8Y45V7Mip&Hm7!(.T`'-.k'<%P03B-Pa/ai'e7_C=<_McI4
$A:Bd8m+'i'64sO6X`'%%e!*]AcDW+>]A>b,22/7\YIV8,6+*6UmZqjo<)d76p%3/EK@n74B*S
ZQFHh5hQgKBegVnnP!6!$%JK5Los'W+\'D!&)>H0Su;T7K+Ii.cpb!&Ljn5$)JXe1SDs>oR`
f*NdEg-gQ3A:?c]AdHY$A)ARqE*Ob8&[jB,h_=#';@qT'`b_ge+]A-D"#di)!m&g:$Ol.17KQW
"L(\F&nS.6RQq=!<THLWkbK'd*JpP&;i=!,HptQ0$W++&W,<Erh*ec>;`1,EE'HAZ^p*Sl5m
Y7`kH\eZ4]A*rQ8UPF)`B=DD#%7))2j#.Ck,:E=Dj=k61.h$)crs#LXbhc[i3KG(s@'n*iA+j
JM2(6N,T(X]A8CK'INgQmW$]A<L.5B7ElJ2i+,Q;\a[&CV9.uV6.*mlT_lJ)%YLQ-ITRUcX`TT
,oWj70Kt>H@&dBj..\67Y7K6L\=h4<*5Xhj1u0hF>VP.%j`%A;q5"oURHj8ZP5Z[l@3pBeLW
QOiM2Dlu=W[^Y_/_6O#lh&d)$\?fm;%bW@(KpW#hl@IY_W@p%Rh"o73J&&gG-UqLRW8<Ql>H
hQ7!>Wa>TknJ"7L0`!HTX:l_09M),5u,p,/L@7n/9(XiW7kb%'15F_g*bXB,*,kd]A4TS!T>$
h]A6RU9-SO(dq=HXY?@4X>p[CelU?$=O]AS2K*hhYS:V_ePn3dNMiF/@.W:_1cHh<S*`f(b]A%P
[5SWXA;\)<9dM_Sq$DO+e^ou\-XV'bq#^]AFPFdLR_A4L[gl@F=L(52Y'3?Y85-fUDQ)TW$Rn
n)&PT(V,qdl(AZ#ZAKl_bO\<9NT:cr-:ZOm,YK:4+K"/qoURm"A\CB.>2@ANADOM(&9LJ-^V
qla$]AO.b_e&8W@^"EVC[_C,E9URT/86(ti]Atk\]A`ADF$Xh4F(@nTd]A;2@:Yp2NTKWk`(bTUM
Y`P+XdQKZ!*Ab;WROp`[6eD:@u,,%X4AsB;IoZIPV3gFV;MR*l=3-Nij)GD=a'g7GmBG+#7_
GH7=<"S>_Y?_988A>\FuRVq"DZs(6KS(6&,B^%"V3mp\+5uL)Y]A1cV%RHfc$spG'RsS<m,]A0
JWVYn7l4Q;2Pq3u4i8_^q0n!QCj5R):\46@3+GfVdDH)X57Dfu'\_S'+;:mP_.JsNkd'@I''
!'-,?qT%pf%,faU9Rt1<U>IGuA#)mj#!Vmo+68gOT#SB>b[#V`dK&ifd7Qa-I,]A3s@f1HB'O
<o_"XKnYLT'jf2iqN6rl1C]A2K2a>[>R@b&F@chC0/p__`LhU+5.Bn[E9V*Y3PNuXR/P[dE,*
j)D"oU:\K6Dkg&VCq)B5X2+fs8C4Vr5u[cI(eXcAauB%Q_p'J8(3SiMF[e(Al.hGBHhe*mB+
_bq'n;_>@.W9DmJ%WQ-\kSE*XH,L0A!'4MRKIdA7bpA-r0";eIcoH@#^/q5V8l8G"^k0V3@Y
p.bR5#p@CAN)<@AE'e#B*I[)h1pp/4hQ[g76O]AK,k>/c5qiK'XYVKhqDRYZ#Y>aLg]AjXhFFC
dECQ<0Gt(gT(Dk;XbMG.i!0J;Q"RH:XeqB,p#@S,M2YE[:LNLkR^N3*[jjKn^ECZMa,Lg!Du
RSiq<U6jSsKZg:@nfN$HRDL1AW\n9J0qHIc$]AX/H19!LF/<f:%Q[6*90XV.hO$0RU1q7=am/
[S^?cCGW22/_nK@R0V^BP[Qa:"k[%Z`jAJ,e[27_#BFpdYsS)cibi%74S->7(5?Ol9Lk-Y[4
B?4CQs$[-a.PA\^6XPqg4Ig'VQ?#M;PEKpIm>-nFN%ph2NmWW`$GAeO-nN3R\b5<<<88WQ&U
b.XHfE3bOI9f;A3T-\gqT&_kfhMF_k>q_;KZ18R?GE=*Idb2%d9R!#V-?`!n?9dPe?D#sdFs
7Y]Al5\"#nE<F1*X)oNoG;a[eJ+TB>.,'4XF]AEZf_Pd[;`L13ieCD`BZ\VD!Dpr[n^uNmB0TN
lVJ7[.D\3<6A*Ok+iC<O/'3/@emW$iZDW^CtlD$;Zi?"V%=pn(i@^G2qQL!i\H,Zmd`gBGJ6
Z,W]A9K(Xjmf.Y<i!PEPC2+K/>nK2q9<aWHWA6pAa=*p#Mee6gahiR"Z&/:!asm3!m@5=`O.[
]AZYHCMRY@q^*bSl91O$AcnHLn;7hfd1s2'e%*^s`]AKUD2*28C5D%jO<</"(0S8:J%eNZ&4Ss
&s.,(geD+6Y4,i9d:VdX6P3C,r[=C3?,n$7DVh?'"FB:qH(DnP6T:Z?fu*m0l7k1r:3GIGhU
X*:ki*=?^??am+O327[<EGan'5>SjlodR:NTQUOR79dclbB?"QK$i$18u;-POZ7-C!6RO1m8
En%B40*?)5n35H:ap<u+]AEmb->D%DPGG9k!'Qt2e(3\m3oS@g'!5C=k4E*1(DcSjEH0fTLkp
Q`9H0WX7l`Hd[X0G6%[S909S\nPVqrdu56lMZO\i=em(2/s-&]APCQ^W`Tq%n@0:jc*n:!2^n
F*Z3]A;H>?Z(mI\g07'PNMQ8J5hjXKY`I]AIZsBRsHg^"DC]A]A/@3(X^*-uk'"ateq0M0#irrR)
%G\<]Ak6.W:QVGFXEbt6Zc+gZG?,BBL_Hq,>!CaPu0QPddNt4@<)tu\"B?"'#r>p7SVEYkZ@P
PsW.k[[;[H,km+r>XsAb[!=.lLKn!1ePH*ZRJ*TU%3X(>)"^E1.qXG;37ZpP>79=Rs\NiCFY
K36F[O$&2%dEkN0qSl&ihZ2Q(f1AL16mMCaNaTEl&JO<YfgW.4-gJoH(&WEdq1tSu2@9<9J/
VVpeGa77t(K6$&BIt,do"Gi\W2c_L-IgRhdT`>gP"M^#Pq6i]A,9npaOu0ROW@Pur4)YC6GV*
DSMAk=f]AEJQOR$iVn\mn@2+5,7Pjfid.*V,e$5*MUED=X!c\?Ui)r]AQs'Y4@aR>_SoiQSW]A:
hO1p3o*_Uf6WL6gcC)YTl'KrG27)8C>3'Uj;BN5mj\llsJ]AS!C1oOqF0lpN=8tn&Ar6q-E0e
hi1)P_`?4CEE6$\S>[Ne,i1h&MuC&XSPiSpN`Y,OM'GoJ6:gK@GeNk;>"N^@Qn+/H6nOXqRL
ISL.oIQrP7#`g1aW'Y@"tD@j_@9,'TLHF-R]A`BKUD0_I>,A$G$>GI0.0VSq6,:>t05J1%6*$
N35uAl;DOj7.J?#Bk!CdFOXg6'RSNGI8g;9)B6EAuXG7"+D]A8D:(a/XNrqj(+Msl*FGR6<kA
5!??Q^/^lpduOMiW<SLDITiZrK&5o7&S7nFHs%\U.896lUAPUt8.E4(@,@s5?ZZ'l?H_%8qQ
>jX_Ug`kV:o$_mHM*e:GUJ6!"LkL&S628&'RP0^sT;d[D!`9^A]A-gA[$`?AAh_@"4,`Ddrnf
:"+[VlWG+!Y2s:MLmSOCN.6a81L11<Le:o&Yk'gKOS7,b/Eh.X"@kY5e'RJ5^@6Ig'lPf^6^
fA:ZhDZ:s8E93c,hoA#i1f?`mYK5<-aM2>L$P%PDTBUsJlepdH+Y%MbhC!hirB9nG>?ATm`p
GGn4/uu4"PC-4bAD!A"YM76Da?.S6KBLL&dK;M^Z"9&P;(Yr0RLuA.jL(j5dcsm<\2[cFA[h
3Uai4r5G:%A;HST-S:,FOs!mi2Q?;lIO.I2)iT31?YDHK]A<*s25/OS?DFL'>FOaA(sJR!,=T
Qgf"?$IlEJ@/dJ%Aa_PZH\UT!GZC['6D7ZR$Nh1M('6%r9Ijn,CP<@o`!jH,FI9,CGNs9sZM
rV;Ot)+:=O9SFis;<H7(f\#28F-.E\Fg&9%F8i*/[gF?'b@:;lMFTEsq;:fV74Ik;to*UZ@S
eM)Wrd81dtgSQI!6ZLWpQ8!'q@.A[*s1C:O;?2tq%pTkOj@X/]AoiN]ASKOg,sW``cJO9Rkl?W
:DmDNe&l\Lf&$\T/de-k7k!/lN1M/go_hf'GSYPfS'F.,?n[8GHiOl-Bk=..aQ1;,]AtU[;eI
1+c&b8F`WT_a4kN`qAL-_V0qaECLS/?K-2SVN%rT2=\"1CbEm^WH^G2Z\P$#ejjY'pW1MR(c
_oXYYGX"\J`Z-["pfM<pBCMIk3Lj@P6jCnK0E-5A#/Z0d%Q1h+WbH)3crp#md<2ZW;JO#NA+
l,8@JhfW"#t-T"S5.*%2jVf:mB((rKY<lM0c.'C&;CA<%R(jRg^'8R1>:`.VGd4P#1J[<7_D
fD@"=V@a>=!SirDTI3pDECHJN#>Pn3?0oMeW1q(<a2+jM/#m55R`5*Bui?hqC<U3[%08G[,c
kI6W\2sg`j/:ps4l`goQTFNX\NQZdT4]Arp8Zo21^*M%GjS;W/qq_?K(B837PXJ<4GVn$4gC6
k`QQB^sP]A;!?Z"EO6:9j5)B=SKih;urU.)jJ6_&$uB2/s6>"^iX:nKQTtVh,_#Z"d8;!;KC9
gO(f6P#)Bj?^EfuR0YR@<RBV^Hud%E'$EaTaYGK]Ajh>Gb`:##eL_=+bRNjtm*,aGl-ITt@&*
MLqVL%Gi=ELR/P3jF.V/1"WOmEbX,,4slLc:^YPJe!M\daf"VgM?BPEE8a0`K\p8C`cuN]A4?
NEj(b%QVOHAg_S_q#u-oC8;[j^3p,.#daXuD.)Z.UoS4I,2)mt+./(q"7*;4V`@e(T^]A]AGLo
)tm7"7O:^RF7Gb0>PDsn<=t&,b:Y8&RKiQVMW=`O8EE>FH!GJgOj_sTGlO%:85DpBKg%<']A@
p2J7i=<I"[8W0@YpfU.[C!@&lKIXJ/%*/%fc`A#hZMlFZ/aBAg_R8nGmolD)#D<3N'6Ksf':
Cnk!0H0EeJaW7&R@uh<#ECM(99VPUPMnf7;)Bt,Al?5KDISuQ&]AU7;R<BM8uVb_CP^e]A>1Y*
hbjAl[:9;fM:Qa,3jQoVn4f^%HY(2;i05D9_ROU<-<#=']AoG#@aum.da[naSM-AC`5iFajd?
7LT;LK'!5o17$Fs8WH,X%"hb*HZY)*=@`u.2orA=*:so?5)>p1koITij.YJr$do`;GSkI(:A
+L4YFJ'oZ)>g*3Cob]A8TtaP[Mk<BE^X#TS)j60A@Q4DI;]AM!N9`@CN+6g]A0;TD5#`LnhrqsM
R3h,;54LGlCL;ut#7C??d22-)a&\LC<P"p!r#/5(SEC&"?@7\mXjBKJ_.qo_0CTDI&_7YNNW
#i2KbZr>aWK4SA:ceBG*8e(#/Nd%4eW+J583-\aX2\^3r\Z$YVT/\J!)CNbE7f.$._eZ:=[m
Kle+Wk+[W@Rth:rU:11M67_^!tfR`Hun94?UiXe,E,hq\"-mZLG^Y[t)#sE_s6l?fZHZj(%&
bpE;:s[]Ag?FVgV5[mmP94_?VBX?C<IuhnG`oPDdEn/^\Za_6/F4ffgf,ZUs6`OVBck;,ZcC_
7N;#aQ,>QiaN6KH)1TB*5S`b*90%kQlfT=E23O`7hd^j\=SC-/0ZEb:J(`WKh/Mn@ihV]A[:q
DpQ4UmCiI!Y:P<_Nn[2<N%go<(p!=2Uee]AXK!Q_sC$Lsgb^B8'<D)Ru,p"KM[u8<2Rg5)kp1
,5?f=f]A5gj:<HBC_K&:H6#j\_+gqeg3DB67bU?cIjj/6jLQeSfj^L%<`abt(5aZ]A:G\N"J;$
'Z\aAI;N6#tCrOEHYZ7kkcGn!l+1>('G%E>pFfF#Yg@Y7k*5$cN"fLL&9tlKJ`E\*-Gl^/k,
gh`n/L;%@ku'F+r`Q+B4;_6n9io\=>=[.3pdQV:31FEW:"\0^/lA>Uu*6nQ5]A&'G<?ibrKWO
-Mjg-e-J"X;Fj\%&,)Ri(aCUM.O/%7^euP&R-Qd+<SrKY;122Ms5kc2S0=9XsD+f)G&b'baX
J1:O_lFO.DSa<CVTA1&pT\T;aUjeVOQ=Wmh;M_)$DYM4M..#pO"B(0H%eL5]Ao:L'Z4?;D*8?
/Y.2f+2l^A)r:Se:e5o3DIj;Ir1Z`c(=Jh?Nm8==>=AC7DgCV6GU@H&XbaI4X2,QH+\jZ.]Ar
o-\4Sl9lkZ!K,Zi=/V2u8pY]A.Z]Abo!*D"0\P^&Wn&q)E:E#A>aqhSQt%a;=q6g7%7SQ)j_OF
<2AuaE=Z-OpjMEOQ[o\nC521+hIcH"t$P6=JnJG%6VH#k!SDE_pcu;9g3qYo;TtN9H<@4Yl;
W7T#9:,]Ati"g9:cjr8RXS!>f1Q@k?0HVK&;Ecl4^cb#W4nDO3CeWmpL"-MrXIK?^H>E"M?L&
Jl<H$`(["a.AjLks?P6(e85S`\5f1I;-AJ)FMc1k64NB[CiS1M4,\c#a+>^oF$:PnEs/Nu@?
kKlu:U8CUEM+YHE%W<c0.TY+?_.pXIVpnUUh72o?6_0'W-4=?kGHkunWV5s'7?P\cW]AcJ@6l
I6fQ8%toZcu!FcNHG*iQ<uCkW7'2M--_("YPp?a$g`H._+.<_&LD,d%+k\AknrfE$)BJ/-Ar
N-&U!Re&[ZZ$rsm6D&Ln/o?Y8b+:M$m`LZ`g&u37]A-R?b*eXb1$!6MVZWk\-<b"pK*A^)cK_
>*CNgcC5F#_YGpoUgtfD8QT<C9%A]AF0!2Ib+=@Zm9$@C+Z1D]A\j-t%is1Z$R,(-<i&jd/04/
30lL*7,W"Tp6!`6X`gTI?mi)1TeXi,OGKH-3,\]A+Mtg?"qS'iP&=K5qDo\;!Nsj0_XshBX08
\Aim$,UE6H:Sj6dV/h[!*B6.r=W)T-h@ua853;#Wcdr%0ZZt]AqNe&FQIH'10]AMVp*4%e3]AG`
YLf^-\I`cgZ!=_/S*mlE$*lkr=^j'B%bTYXdFI>,ts0FtHr=1t-)]AZ.H.ZOX28RNJ67.W=lq
Q:6K1+9W_'!Ech$`Z?,]AcF.Z-JjlHtgDkcUZrJ88ZdiP:B:3lFb'VGC5,k&]A/g;21V2uS);*
CbH]AVkpr+9)`H\;KjCqG^<jNV<#5u`;B2J:Q_JMUraral9N6T`7Zce<RYT,PHtLY0YP!$UT(
"-l)\fZ=\^p^fHcTR_g.P$'(VN&N[Dj]ApIW38/^[K2n*a&+)3RWIj&;7*o9U@Ha>qZZ;jLAQ
fh67NeSpnQ1fa8#.S]AlV5atc`S$egmTpRlelgr\\K/Fu3CuKkpe_"@D<0&-.8ZtdA>!Fs#_J
\,2;N_<YL%gD02nl_b'iUK3`SQHK&hf-j0"Qr)d$`lApcs(nffQ786K:cB0BG!"oLO^e,+4Y
F.A%5p8]Ae*"3IJhfFP/.WV".53_[J%(@qeYL*>D8Z`1"r6VsFUd-AXLSEfc7XX2QZV9S9C_O
I:CbG@l582'G$3.*aJ90h,OC5%un:[#-/(,Xjp`5KSEcc.r,daSW`\k(n5Y[g:8KjgDOfMb4
j"Tm$[4ZUsgR6s[t#4$)$A'mtP34XJZoLtKV[#H`\@b+ZqmaqQPF+ci:ng'\:EmV9ltj]ASqA
hlHW-%o$YA7q_=j8CRj6[@GX;6(sks1oDS=\8nIAV&O`r.6tt\>-1F9*1s)\J,^JYK^r6-?5
0\b51!&P:Ee%G6I(lj+7m"!#Fi)&"J.eaXUujoTo0:i)VR-Pqr0F-,YhmKeJGn'W"f/kmbl1
El@3Vn6AmZaW+*S>,%_M%J.oPQ+r7<\H$e-)88N*PoP$/30SX*F#rm'LZ\=uH?Y5OKJFqNIC
/h7"("5;0.]A+uQHU/"Vf(sVEUo>-#ibM<<`+=ou8Be=sAGlkD-q#nu$O9nZYK:RTD^ap#A,:
>.dXC0f&J8anS6e3]ArDS?&+9bMelN']AY(iI;BS8)D/h+'*r15XX04-5!=K)Vskf.Pt1%Y[L`
V>)Mh(C.\hSA/%q<-T#>#tj\FoDr8^oAq]A^2Y"mkr8h/4$"^ta3DeR1SL>N5^nB?I1f9dpSI
-9Q;:1VpX<me/N;_oU,[/q>*tlV'',:MqS&31kq(m'J]A7!]ABSrm[W[A<%CdN7Pn2O%_pp,89
pMI9BqKtCn&"8F'phtJs/,@bh*75Z]AD&;o:9K3pjKcmd(Ej;VCn(`a9aV_pZia(pfSP&?\YC
#V%/d[68.F"q(f'o;_)<pI,(*qQ-F)^/pS#uA*/p>_Ea7_D]A^Y<FrafK59=2K7_,H>HK9)=!
!EVTFdd$+ZHSCSM1NahP_?Fk1`<deQ1Ll=e"Bm^f5=OZu3\7(P6eH:pQN[)r(IV0kB,\)<BU
)r]AS:dP9.ZXW%aR)ii.+8`*.i.'[cGFS":RY!-7E`3#0*OhYcYor9=Bpo72'&LX(b/j8B#Y"
GSJ2-G-dWC6;Jm9?/OBd2Cr*H-^U<]ANkZ^=EE.[uTbBV[R&B&sq)^iJ-R/:4oC^qW:9b9&p[
MJ7$u>0g2`t>h/mOr$fWH:E0ir[)qQgD,;PAbeeh"/h2/d?HF-X"&uHZMTmSC(Ldj5rS05^;
WSbr!Jpn0*7U?-a?.HXQ*9SmQ1VPf&B&C*PA&WZb00-7X'EMLDH9k#(5?YR$g")C<P<D-Ciq
ejbXZFYSbV_Kk:@NDVK6.jA83PTp,=O&5Jp;i^g6"IUFQn>?lqfq<]A\[FbaRqHR,E4*OH_I]A
,Z%g)",;9_re(%UqP',:i"Rc<,_8pILcT>!l+\??UYAcFM;M5f?(3/E?+!`3M3Jn:LlX%70I
%16MTMrlPApILicOa"pA"_]AdJO.Y;-heLUOS'3Z3-77c)cr2lksUQ,;PgZSg%P(V&mo#c=X<
2PG`D6X\>/:VbCY?lR]Afp;6jJR2$@;"3nTD,N-`:bm_nXVNi@'aa\;.cHcN+)>'94;QBu"pP
[^L>?KV7b;.6/=i:8@Ejha<24:R&4E%Z2JeOCW)BIM"HB/TPFX'<.Ajt1'kcOO!2d,7TF[aE
n'qTrVMZ?nb&Q@mPB2W1PIg4O5p6p67g3,AnEDR?F2<aO"-s/Y32H.@HnL;u+p.I6TP>LiH(
+.h?<+"E=DS7h,@B9E(G)*DK.N[S(_._ZC^T*N;g:OoD,,U4F)7sCk.>N,\8RHbl!*eo5(\5
d=.ak\C/0:f\ZSM1AJNJ.1LSa\=RMB(r>b-l(pWQ/@-Z6??JUbmj-5^''#T.(b`rKEX7IMjj
C"LYsaijQA51er4t+6dNGd[Wj"3m9Dhr*W=9lJT@(f:l67+\IK]AUm3ISa^L%M_5JDt;['\jA
s?&s[3QU:cpMQ2q0!04Q35*i6&mBcU>'Yu3/ar]AKDW=-(ljM/$S2H$)g2Pa-U.Pq)muOH$eu
&3UhJ,=if(7<EQW$QDELlPLnL>YhbMe,'Ua@IF"\L&%f1W0^+Tr@UollB1EF+?)N5CE4$+H"
rKrh@1T'\g:gm3=:kGG`$;JtT.HWK8+O?eia*@hO$=8p&Hps[uk"jOcARq[B_"<^t'Xt-eKM
ZmG#2j0@6R[V@LOe&,?K>P^`=Ifp<*=nn>pTfAG13>ZYi\YqJ/-!>Dd0W_3GK0c#Unt=E204
,^F(MVZ>kd&Eh]A]ArBWQq@g$H]A+%eaniANplCK=1H&]ATPp!F2F<%F1NMk-,@c@;4(<qY,L:Mf
1PF.?!D'FZHR2@,B,S=MfC_bJaEQlL?)H)d]A*-UXeockQ^atNk7j:'eEa!4cZ(qn":99+fJ)
hfN8$;^-O&C6lYd4K,u1ZVAR2]A+FeE.lnr6pQj6?A=XJV!]A1DrgZM-Y3P'0mRYG!+M7@1pF_
fXqs]A[55T)`W_i16i_9!;LTc1%<:,hk_Zk:>D8^)k20&*r;k]ATpC#_8IC->K3bsmJ%1rHmP6
<^S2Q)X1m9kp:q.`p]AiermB9m;Ka+tCF.(N.R10q`j5,Ge1\O`-VO0kKPgJep(dQ;^>Mfd\9
gEZ5dpZ`3H(Bk6L3F8^rE^)qHR,]AV[%f)=k+Dd1T2,'\[OW,3,+CEOEM=uheKNE1]A:'CN5E]A
27Y[8bUWcNJ>*;':kn<oMOJ!"l8SF/"<*S9*J'(2+++'9Q@M7PVp2N^>9DP4kD]A0*$>-r.W/
I"VY$?+BX(N,L3eTjnh+VimC!&$AZ*e8&k.I#7.GY-^mDeDXqO\*H&>i@3UHRE.*2/ZF5ZFq
o31mdM@N2EC3?43Je8H.]Aj9_1;8j]AD)S4_VIed0-BcOF(2T)cK/*p#II%'Ah;cgH)=57M<]A\
t`u#N%c]A1-C-,e\@0GfI>9`?'Mhbno^9iTg"L"_9N7cCi'W&!,?GQl*o$oC?fWCT=Z$BWW3!
HhZ&RS:t";%q-iAL-eWS^V/lsk+2Jnq\)!!-ULkRMU5328ci2bpJ&5gIM8%XAT>(?[f6c@n]A
gqCeLN0o0[S?e>pP5tie?d_Dg]A+2?&#Lu=kX%:1:\<od@i7h'JQ,pZkK;jM,'Xr4@>[3-ioC
&pi1C#W;DIe)aC";(Vg+1"?^M`Wo$dIB(l@A&d8//Ba^79t7%Wh:92#3;.#QlC\UVB[5KOEI
,CFSii>9176OHnmgVNsm"!6k<g#4@[ahjFn)Cge%i-Mptk@5,2A7(,;4['r2f("%2QNb:ggB
2NklcFZeGBugsK%:>9fPPihlF5Q%M-'HESgQJqc=96UC<P4(D;>(73.n3i#-Sbt+"#9epg:>
/?[`77Xc\Ft<Z=)h"%QnSGMf"`9q'W@:7BV2U\Fa#U%b-2QnekF-DZjA'5%)HJ"[o]Apc:H7$
;<MSBop!a4PS.+rjetS(;lK&U9HiNik9@CNFhJTkae'AS^QWb_7]AhSTGYSE`E2B]ADqqkBMLg
lUgMZPHDL^9]ARY1L!)s_+mE7X?2OC%0(mXAr_[q#5u&C9e$?g:=<5t;r5Qb/5PlUb@#,XG3X
W/<VG>E0GGDcc./3.iLQB;;XX-G3@=9oV0?>,C7$.a[rtB=99+&NTqF[B]AP\LRKI+7IRp93,
Yt9!Nm11+0/'"a#-_8l6>/:"`9`qDg-!h?D7,9Zu*CocK8"2jQ)ngb!"6@=i-+BQ-1hF$^E9
\Zb]A%s>Wj@jdTAjdQquispbIcJW%XmrP*UsRdQ(UA:NZ,EG=lmAp--.6I+cr3mS<45ibsP5H
JH>b5+SjT'e%#pd\BlcSfuVFo#5mm*e.rVrXhK.1O$4QDk+',bPg8%-VT,m#_;F%/mQ/D(R)
;-0%=_?8;iZ[qsR#_kom7oPcdcmcACUPmtq@_)!&Tbr=<m:S`=Qf_RtIJHLVZ/%bdI,'/n`N
-cI?X'hJ\f>U$?J\kEa7&(CMDY0"FZEdW9u+uBnF[ul`5ig;H+OO\M:@L>1Vd0<S"b5lg&/.
3"e*u&MuXifps?DI8io+@Z4@7br[[pa_0i3U$<LE4L#!D65YfsnI"=DGu8k`uHVRRG9jONS`
bk$gN9nG9<ZACMUNd@,0FRj^8Sebf3.GIoa-cKMs9J#;<+X2Mq<$,IM.,<p/=i7^X\h+%DHX
?o36C'gEAl!'AM"qf5)RI-^(RK!&3]A_[6s0=3i8r5[4(pG+[ho*Af0h-sHINd&s@2^ZWC^^N
p]A".N;iJG]AbI',Z[Kcn.d3Q$sX#3cE]A4Y?[T:d2BWIdHY%qGpF?uqXVLh-Of'5'IM3&2,1"!
CMBM3@PEHB/b@@qY=P&Jk4s9jWlL6`LW-+8q>G<+b&6.q6OM:ertWQaN[eP;\_SNa</lLSD+
I+/Vs?Qu`>RTNOS!pE(n>cHg8XV#G_K4tD'Sq"`mi2,]ARKbZA8jEu*]AP6m[]A6:XeO.TpN-Kr
`;^;,U*)NkH,Dud0hX9a%X?Z33/<$o?R1c[j\$KBe+2<l2S%**n!c'&5bHE0fEft)@==W?*V
Feh_XD+jC[<U*jrGGL*?Q"?Eela>VVktCTni"3*q(apPK@m4gei:E_N"2"_kte#e=:EkHeiS
@/ecm2p/'Klu6C69M*%TC?&,;8P'0c#qV(;=_XT(J,[;ai(*c99Tb\5An;u!$mPlE8cpDomN
Z-Xd0U#u1n%e.@m&),Y?Y6R5[b1OT8Ibqc,l\AkBW)7ViPi.(<@"I;KC@67ZV^?rs]Asj8[#d
o%eJ+rGNVWd[E+s?B+>Gq='7?YW;6H,[ed[5@R$fqTE;7<HXceS@$4h>%;4o?VZ9.e?W&^;N
FWm/J%Z94C/kWPC/K*'Z2n@mo6o^I]A2p%WhUf`1N!=dr7_o).%fQ#ok+jDkqJ58G;<5Io,KG
KOuN6SSum^'Tt!5B(81_m4>icWSU*MNr9pQc#Y0@@62<rTWMD2RV+p9U6-h1.?nhc/[P!%t=
_L#2<h<m"l]AmXQ,/51u;Fh,8NK%l%cHe5q#eq+lH!&kq`8l%M'RYrEjnnD!>i^27PX<`biH`
WblYQ@HJZ)'X/S)r.`r.24)7BRaY2`W1O<j3PM\0\pa:oHbIa@\H"uhI`?J=!]A>a=[+3]A^!=
mJYW402fX'[l<5h4[+52HA#\c)`u<ouS2Dsr8).!BAo+!CFM,4=h#(0,0WB(+5k&#8:451Z?
iLPMW7/fu!C$Bo@nE(SJO3IH%!8!rB'Y%YRNf$=c:0-kGe!m<oGBsQaWB;`^Z61G5\f!o:8b
+aa)$,3j%i5SkT5H[GgOl\Sa!JaY,_>OlWUSfon?@HfW@F4Fs,Z+LHlH8Y&Cu9ZUhX.XmS5t
!?/.#c^4W%FG4H`qDkRdP:9u?N"i&JF"CT?No#ilmd!Ecujjd7IGLsPjA3oY05odr@Qiam`*
L]A;5A.0Y5(/B[7e(*:oSn:78a%@a!Yit1E;4bI5>`<YtFGc8.X^A1l<;SVcf?LR>]A)\R`BlS
,[MD2mrEj*AKog&k\_e;rpik#OS80;'"IB6/e$_gh6$C?bsL9hiAFQB[G+VR$2bOcYD1N)Wc
E:l[2&"eUlu4EeC#H<olZMBZj5rN4t&ToPMa\bdRnK!4@jQU;\4S(grg`JC\.?,+A+r:ShJV
C-!:qls.lbPRC]AR,`k=qmrKmiB*N&X7!UkjaR-5_iP\c*_%_aIm#a5:MJ&9VrkHbm@=,ViVg
Z!$!^u.c&X[U#<J)/<h"*u.ITF&".D&pa-YTH+%=DOEW>q=GYi#Ws/PKZ3tNDRAbH(VoM,>>
04a;d7#,=d!pqpVl?kNbj"8<gMjq+Y,;000Y^:n/=BW<bdr(.Zo;!he"7o/]ARHd)8U"4V6+7
$&t\D>64_\X@u6D^PRF(oi5(-;GUq'ihe+BqRN."m7[IM3?/p,qdk9*k*#105`b"8j;F]A=OS
aFn;E#IH$iV_OWBm\2djPdaqjb7m1UF_e0#n_WK+p:Kr<2Af>OFi`L`s(,#qqdM,C[VE=sq/
\pM<5ddda+1mP\nVJ[:\Wte"rX0SrO?)Q6<#7J]ArGf8ZDnXmrQ_jKkH?4,NFnf>BDpfElN6;
X+'E;"a#491X5!/dB5:.ci/HmapkcVXl>&Z>8,`-$j$%1V#iIA-"Q=3WK>l1^\dO@dI$IU@D
d^Q$&!fD(-6T5G00m(I_W-!Z6G7<:Z_b`]A/2+)2mTBH1AGK4^IQhbf1/'`;:eu\\O55_#Pam
@"5*=;3:nJ$5Qq=sa']AnDR#7ZU_[s&a!;YYoT)Y$bVp7H^GQZTh&D.n%GWZ(oRoX]AjfS*f;K
YLC40oRl1>u[;_LWOS`B+6[q2kiU6]AM+!9M:<[[10GjYe"]AFV&ICl.oHV[@Nj=V0Z[VuPYI.
TRIgm8Z+B#k0s2QG#Ziq]AYqKCqH2tT(+98T*g4^*d`Khl9#!M9S47/>%kgL;K'#C=gXY:f[1
,n9<h*:!g+>(TuNC\e*>ca*/aF@Bp7@Vl\VU>gt/s=/4o&W]A5#rpl(S6eeG&jp';dZ;iBKm]A
o,W%*VP/a-0?'%Jn$Ndp=;)'d?XFL!e,6%m?b+CiqhLU5m5M>`28J=RE"a3S/Dg*8hR)=WJD
k-MMoY&t2eJp$a4K-qdKq@p\[!mg[ACGeC;JZ!\#U_q*ldY!\V"Q(G7h"X8\rJOOh(Cc>BS4
JVjHeq@I;"e$`$\.e[i9I'@.!cgm#;mq:4FfE^*.@0RHj:0`+L\V4(+EAV0t[$rb/4rc_qll
nT7$[IGucdkZ[2O"THhmP-L/*C#lgH"L^ZBcST0EhE#%/X@L/66)_@jhZlU[K!BnUS4GuPPQ
BE(]AA%Cp:bc?1CMJcqktXKI]A7m"(nAml!rAa$j'k/qAaq%)g]Ar<V#ouj8<<<>g$S=u%37lN-
)lD.D_6K/t5+F%ZLLASYb=@H<`J$3;]AChU<SWH7XDEgS>Fpm:/:c,g^mTqj<BIq#qJs.mgF&
7Z3kNW=_^4BQBZ/61J`?\MrdM^VBb\aMPLnC_QUPh^\#+9f"a*?pYo"quW9%4//#_3,m[pD[
4?Q(9*9<d'?#gR]AjMEK0(4hO2#Y)t7*X`mVtL(a@[a2QVf6>Oj[&m+3+KP2.491u(,.rT`!U
$+!*;3fgHJ^aVC?)/(lZ0S7?j[cqkUiQ_nOedQc/8tcRc#mq0R:97O%OtZMPQ%8FWrDSZZsh
Y5S%dPlN`XAq7>9ME._2kG@LTeqo`j@H-L1Q53GsZ4jE>O?*Kk''")7FMqKkfqoK;I?iVN6<
25diYOrE>XJCD.0B/X.en*abkjiRuo2FG9))?O_FB6sfemJ:c\BX[f,<)UVpMTYI972pKG7j
u`uY`e^UXt:&_WqC$L9)L4_]A9A\<^bs'3c=<H:M_"0mp.Ch7c..oK,hjt0AeD8q<2j;*0H,!
3q4l40XV/6d&4Z(o[PE#QSPe7RLAW"C;?$?6YFYKon0D*bTfI-8+_M'C,Da2m.#/!oVKK3'_
4["l^XD=/Bl55=SRXq%oO_OqDB4dWo&O1)DTmbV@q!";!1bgrSb%ugCl?lT5bK?%;ROTZXL<
+W-D,fUHD@2<o!i8Chq$EKg!Up?j]A%1X_>CtWPqsmP[')pb3QoY.EgU8m!>1-hjo-8hE>Umb
^e^;MaV'00H;Ht5H&o:%k^i.W1roK-p<atkEO-G<I/V&C@_9uekE`m8TV2@+kK+eGoXjBR/F
'NH(E2?_\>3gE_Fut7WI<$dE!]AkG%_ihAdu_N-P]AKWiHm^'E'd]A80"-BOChQ,fF=ARm.54H`
6H3lE&IU=Usco&N+0&_HPFhN;cNf-/NNpfha5G?$-#aV"H2p]AK9^qRmE^#'XUZL@$P-oQhuQ
-Qh+NO!ouT7sp17m:LCfB#$I#U6nd'tFjV,F"cs[\pmb73/kQf5L`_D%KXbs4.E?dBLReaP)
jSW0abb;m^24L9^W&;SSW.iuXYY+OeCk"_co6Md9=pAh1EPrsB.4p?R7d<c[Jsg=SR1l2)7<
c$)G.?7B;uPba/HaU@%G-".r43b"DirB1ul]A:f`iX87nqOt\f8P7s,(\KsA7"!9tU*r3peQk
WRCYj[o*5&/-h6e\;I,57uS+^q.(gA.!o[tPLt$EAi`mJN\B!s=Do+MpY.hqJj<5_"H0Y7+S
H+0GnZ9,a!A^p#BnL$C'n$!*jDg#VAJ"\6p(3*jk/e[4^/Feu'E675aNHmaX%M=%+I_G=W),
^/4:]Ak19QN8j3tF6[F?+"'F4?=%REk]ADSP2m;+EKt2!t<eD0M91du\+]As!tVF]AV+rE[7hooW
`m.t0oT14Eo8R9BLt&NKia.HEQKn1Y\X-?>4;P6`"J2k%VY_hW;!m)2$Xk"T"2lc^0+/9G!*
caXe>rZgYIVdb';?Q#WH;4d?>Fhc':WCUqblr"S+Ge&`$AM!^p@#'?kikH%8A.8o^Zn=4T_%
HZj:icLTPVun!hL#+cs"%=Me\GtS1E>W&ng,K?@d)Zd>#mW9ae%;MDd*S]Af7+V>qA*o2%4)F
&<`I@p#I%r5rAAXHm9X`_4f/57Z)BLMf)GP(7&M7N<iYA9?@[$[+)\mh:%\TF;q4]A2&u+u"C
o/<S#/\uIoAVQ*XJ!Via%*qp7p(@@Q*B>s^[`Qiqf,B<QQA0=#Fi^>90*1pCbD^X+!qkX-Q=
)IY!b8]A71[shade<PMQV[c]A+-7(O5u'<No#*Xdln\JGgl.d2JBG`b84k?Qa'W)emST`At*c1
7E5EI^TO+>\F$l#,H!iRGR@XmJGJ8U;jCY]APAP+C[8D^QEA@7U,>ZRc![DZ/o8K"*#'>nAPn
-<U--5)SJ'_#N.OVWRBOQd.`YIV\jMV-]A-TGX&[X68p-G7e,UQ7rC:@HODbXI@oCHC7/V5Ja
GB&s0ki0FnY7<0;"N%'k+;trmLmsF;#bBZ^/'tE-0!VfJGi4NhJr;,,^mEsA:XrnL/r08[GY
Np+BmeYV>iR3OWk9UcKci:=,r3W4T_#**0Bt$ZI$8W,D2XWeH760HuIAF2qY:f/;^fP?hJlZ
Olhq'\Z0K?d(SLeQ?Bg^i#pGYp`d&!%_6,pjL3kWE%@Wn.cdM_9$]AqP6%;=?_'>")J\BArMA
o=fI=6/MHEYTc;G[d2"9m'MEprMiGV(V6n09tA8PGXB!BX6"kSRi`>Di.7f?jL97ddP3@Lc^
9YI!=bX-?7/Wd*BaO7iaa@:@fP"_9Zg^HOS;8eV>ts6N)]AeJ(p`XHmRh]AG<'&Mh\$(Q`lB\)
SI<SHB_V&726c7nr6$m48f'P/p!r5cO/@\=k4?AK<`9[H<<eD2or@jt=4hW#+QM1;+042*6^
LM=k,J\9"lI-^fT5CTJ\c+G[lRE"D./M<a\s3gA-\b/R&5UT4(K'gtX2JIcf?fX%5:M`P2q<
/"VUbm>CTQ`&qu5]AK,#h")Dl%'r:GQK,:Z-:.Z.e.dFNG9`eP1KP#9QD6F7SskH?sPcOl,?.
PmFpr"c:CcbKAPPo]Am5n/3:S0W;X$8+)9JIkJ*l")jm2E-9kC3?MLV>&X6iX/0L)?7(2keo_
`Hb<2.-R_kF;PU1gHCbo;+UKhKR.h;Ys#J(Lsj[X?#&CJ+SL8<]A40_^V%*D5uc2SG`#!Rf,J
EU_d=Xd6GWB#jDZ6:Q#2=4$NodB$9ltL23Z++q"hZd;AWgZ2CoDKdbqR/J8MuiHZ<hrg[[!D
I*j'@79k&POqh55mc"!]A:>V\'ng#cJN_t"Sjf?k1BjTPh(=7E>Z0'8?N-iS5isMu-?qkUarq
j2OrY#&`ZgB_=n/A?Ie1Oa0+B$IX7l+HB'sD*!W;\_k_-EM1't;3X5j6EMoQZ*.$'T.KRAhl
r#H_/D\Id.?0Z<<a#SlnH53H2dB"<M)e3hn_)?]AmD6H71Yo3Rg4,Yosm%.obA$3\Up]AZ7`SH
D#Tp^_)$RVTh$7C69MPc_>VS)fNE-`-9.n;`:)/`>NCAf)Edl`=Ydn*uX#?c[J`q;t;F.mJf
N_kUS'h[<ctP5m#[/]A0\R4"bjK#V&Ro6,jj!1%_YU(pqpJf!*Z+k$oBGP'EK+`o1qqD+kb?4
9$C#q1(\jL;B4[POC+]A4V`X-Q+C3SF^L@>2F"ca,O&i9N:]A+P'Cm+?hf%p&j#^NOGOIf!`lP
33nOihHf%G#r@futS?=Go9F*@`)^)rXcld6fNLs5Z6#F9&iou4<;JWJ?04I)<I#uJHOg<\@^
#Ip-Sq7PaTZB0oEh:'r`e_bI\-ETLU(2-E<F/Xm@IK_Wrs7"uBk@<5/Vo]AI=plee=nu*_nM:
7bLJ(GWa?,K,6WA/&B+%n(Jj*,:[PO1@;d]Ab/WfMdp@.iCkAoZ\I>h-J8%$,!F]A04-MM%o;m
5rpO;Wj2/7-c#?JIf$unP56S3HbDBE2Vd*RFjQ"&O'6PW7)Lun@T<)%oEYEfp@(*^+e)(f9D
#\,XNSmBuIeYW5\s=Yq=/FBb2\T4CYG7NVHPtK]A?`*,fZS7oQ?AGp@>Y:qBTJ/Tr.0L_pI,L
N<0d:lt?4G3doJ_B+r_#1/;E43*?Giij[hjPK/CW036b\raVr4jpX@,f@l4re3n6^7h*La?(
VH<PD^&:00&E<Pec;?%9DhCsUUm+`"^L>*7WPUnZah?K&qZ[3lGdc[lW`8<mZF:C?g[!;uZ&
9L%NZT,mmJHf:eZeI6c'^6Fl[Q(H@ippfrT:5tJU]Ar8%HFC*jL,,'@;23O\74BbBf3.Wk<8h
#H>i:o;X"T^e]A)f>fUPVbm!jA+ml['W'^PY`Y?;p[n&SY8K.t9%4'`F=[q/l&VW+.Y2cS>VY
OS^0^Cs3*ISA]AjE;icB<7LPdX3^iB$hOYUKs%UKjb095U&=83]AQpl<@Ygt)g`*.J0OktHp/M
`4f&<AYNkRR$/U76-OYNbRI*#He`m7GA]Anh;'oD,('%E@sFA>^fCSK'uJpYkP?UZE5GC#PYe
hA17_UDZ5Wc_r0Ei?C*V1saI9KPkTWlr6P4qlAP[=p]AZFVa"7E/<6L(IB_58@@kNHiD#=1-)
o'c16MKYj5tQn]A%ONSU=UF8\tgei6<FVcfA?]A<X]A%=Z;tm]A$%^.0\;R(Qs:Y15`\a8W48Rgc
1n)%%HYP+b<i-AXuA0L?)iA4(U=ti#=jriMbU4#(\LIT*hop-gQiD'f0T;1!CLXiBl=e(8MZ
lM3h?fesmnTbuAFB`V1Z*h7o8=:e^*iS!:X=bKDY02>bM7@IEN>Kp_p#6X2r8/L1s!=/Qr-e
PrhVod?38</JW?Rl?boPo.-n:a4CQ/5GmH<bO$e`jFf$t*i*aUlL/MeoO_A0cj.no^I)0d6/
oFT8Z]A1:np]A)F5uYbWfG8<NDmFUr&_$)>a'762RNBG&P.a72p5J&oli1),fA(`1h19Z0\L-h
F^[i,<El^X6J"T8Y6%o!9"aR:I'GhC.8;UY7]A0>?]ARpqe:lN(cEE5?WnRD86Y-"7q4'/[m0u
4UEF[mBc3)cg>[o[=a65X&6UGdpp04C6e&2$LI@4dfHb8%WW2R7HHXG#@VYc[l5%J_<]A.cb4
76F:?TDCJ?klO%\q[b?LS"]Aul\LM&9qWIt]A[P3Eb`0Gf_Ctd[FJP?,2!j`.h5i.e3h"I:AIj
!7#nVR;N3iO"$I+k4p`O:oo5,$OAA$%%?W5u4@RF3"%(!,YS4O1nNq>U_gY"*irB0fGaS+pj
eAY4K8aF55n^'e^AdU+[Vdk!:l/!]A)s',>4fa=BSnn6X=GDPM';cE`DX[d-7iJkR>()At2p=
I)8V#r1*bR0A*aeN@eCTidof_7dcB%5]A<C,X,(nY`4+1R\IF%J:6:0]A%9CnGGGu:;77rD.A2
X)e-)'M1!/B=9m_.QnE%`0^eMEQ9)>KK"9[]AZKZUCO*@f.e\,7jiS?g$L4%%L4uP$bEQRUFr
Iq&rHRl8X>4RZt;^=.V-L<ZaQK<?_s"q=52V!+Pp1X)oO:L-ro4Sa#.9$^4Z`9eTRHKOdYk+
O-'K;REn(%8rD^O;4\#ZQ406,%6*UDFFT=:+sHcm_Qh18Q2c8RrtJm=k.Ka[;;=WFQod(jL1
Fb1*[bCu-_I<U&fr<<aOiaI4:WM?uhH-7t=LN*\L\Vr7<-IadSKRqts_"X2\W/PU4jS`%F@:
>>gW[o>LKo8.DZKdAs/`V!qIIRf.U=8T/OFhDAe?A0dk+(tY#U;@V]AD7')[KYQgD$cmlIgBb
6df6#C-\tUi>-.M1pQ=@ST<7.9[)1Qpa5qC.K!:;bRC@K6+sIb/Y8YeZ[YS/8T+V-Y$NYK1E
OdmX]A&&/C3*/,YaS]A]A"GH&/QLAAWog#`Xh)VpiZPZ4L+GEf;(Z)`mXRUjNeR+jrf0?5TIKFj
"dC>=<LGt-aWgq4ZPh+?g[nHM#25b8V6.*.#0+MHbF^bq,X:LZJ4_u-@'MPOSY+_,OXrT.\$
n"Jr#?m9#&KZJD5ODd,K+&S(UOU4B:W!WQj;Omp72B%4i,:\UW1Y`2E@o;@"5-JXV']A]AdG+%
CG^R=Bd)=)T/A0oGA9h)`^bG-d;,fpClAL\WU!0&-A<$HTcd'5qMSGTZl9gP,iDbKNZao9S;
)Z+%NY%b497ZgcZpf[90k?E.GI%*afn_eZ+'8,>9?r_;lN]Ah[qgMpR'n.u$3VQ"dt0WOENE0
RM5l=]A@sTDN5`"PEWi2oG%ZB1bJlKT1P\!1Hq9[9LjFgUSRtJ]AKm'l-%q.e6cE#=l-TCh-a,
,g#^IuG(N8S8!iV+jis^eoK(-q`f"<?J1?0:D,3CkP4BdjsPEWue^Mq!+VFOmGVLSh;NMb*#
:No%N-Co*46Cbcu(U#V_NQsPi<j:Jd5P$YWIL9$FA=QUd.Kf3n7!1k&O5qSr1<]AH\e2.PL@\
/a0l`,&k\1;D-*H,naY@TS&Y.mqJ>n\$N[ir+q`h'/i7;8$9C(4q:%pd&f0,P8GZI]A@^`-X+
/B/2Yj^$pm4KAU/13d"=Jk9<BWDL-MWenr6J^$_G^J@7c'[of8am;i<kqet&!n"7#9Fg$m9J
=6XVD1;DZ]ALJ6,1^)b2Zt4HAGGq.Srm)8FjW%-1Mql6+%Uo+2<mT"k@cE\=!\kfg+LZeRW1i
?PlX)u=akMr7'*/ke$?ST)Z!UpkBU$>=E]An#?B$U7H,I"!"_Ifmr^(!24HmJ@7[uLsL?g):K
8U]AUh6mXRZhBIQPmFG1YCFa*`>*4XrSe]AdG1`XUb-\?m%L^;J-"@#M!]A\)rFq=P;YT%8@"h.
t#r&DT4.;uDLV*I09:ZS"(d5G2@?7jQlPBq8E))dL7qIU:(Qp)giXhA0955rYYiWqca*!@3.
Sf#AQW?;g9eU%M,+DUNOVL<$.&h9t>'.8i8$$9<>GI!b_u?$_')V*4K3:2Kl5+m^#D/uHlc;
=<Uc!8X@!&ha`[?:Rlr)6E5.Um#;hG1)qLq#@DZO,-q_.*9SK64A^u0?/[b$8q]A@6G1&crg"
!\!oNP1K0G9u7p,"h*WNLIMS4Y*o8.k*G=%>HSu$Vc%N$/0S8&F%?5#_.9gRV_.lK0a1'oRq
M!WoZg'L@>."M8?UdbNEK#UgMR/^(/CMj"*=M)at]A<c>9=Mjg8EM[e4BZ+>h*Ejbo'POEf1.
R$3HueRgdjJ0`OoQHjC#6g*D/9=C.@W7q'c1tfGJ^=_4@$[.eGO%6@KZ,Q(JbQ^&%gFoUWYm
)I8I)p8C-/]A,K8)PGp(S*9nO-0Y$0@Tf'r5;PK^s9i)AlP_9h-u*1FJW&u2/>2'+gCgK)gC&
kq,QM(7^^nZ0GTL.h`q[S:J^`gNCjY%%J`@!^aW7Uo1ZoMQiOVC0kO$Z1IqfW(8:``X(ii_k
ndA"n02J''I`dsHsWRW#s2n2+AWLaL7?B;)jcZQ$6=n1HsoJrNCh.tSaFYeSj]AjeD(M0^p>c
@geT\23:!2I0BL>R9?WVTL7H)3r;#"8N\=?hUTfNQCYcTs0/W9cV+PkH<O50:Lc-f)^Y,bP@
1>Kg3hsR,>Z3TJLiKVJ?9S&)5#EtaC;q&fBs!S//KSWp=`*5/@(9#g3PVDDdk92$sumnT>a5
#UQ`SZ\d`C1BTO9Hm]A[V^%P']ALoZ/?"2_$!Deh3@#m;F9@mi1\_ZmQc44'$DT)eWRBCIX4ho
T)m]AV:eKIl`*BX4[i(uZ6UksqM:D%Rg%%!MA3sLp)+((?XHDRd4lQe=C!Y!73n:2A!l:g^3E
s_WUJVa(RA51TjpCkh+iZ:5K0tQqt,A=^N9B'ZL="5.0*[sh/\@*\FUbB+Uj^ahnqB)Bu]A??
I'YK26Dp/<;iPDcdn.ItA6oao#j.-8,Y_@_V%I"+OL*9oEX`ICJIPB(7`l?i<q)>6Xgj%aj=
h@Vb*HR??k@^:FLZk%c]A39;))q2$\JnQg-GaRrCLTUo)MV(Ps!#;6+hjbJhCc;\.]AD0Rks]AB
G<Wnef[3:kZa=E01AIo`\W4qJ0R.F!tDfY,tGhAcKb;RIY*pgNoUG[>\Wq($b5?Z)kR^B^K`
QrKi/hHN;f?,,*`/"7MA07dqMo/#BrRXG92b6rm"cc#93CHN,KS'0j/JDqm?I)Dj?um0el-]A
p!1*lBfn#.q%"F>eqG)=D?Y]AaEhrV.Gi3A#Mia_K/sbA[:*'?s_D5N]A9lBn:.7:%X''AsDE^
oiAMRpe)MloF[_d::5S;QbW)MO3J/Ys74oK/E6Of#!HUjpg[K$37eW*acKW5Vt7%J#&TNG$S
DZO4l>'+T\L>#`#CiZYFYO&/$jI;DXF@M`.C]AmH+M<B^;"l=q&CPO:kEDS7%.?O,@pmVl`^,
T7u,oGNbup,S\;C&VlNu^b+e4Ba/;]AUca6n5T^Y6-R@+W3ki@nfQ>*c=;S4b[Nr9VLZ%b0;Y
2FhF\laORf>g>NqOFbGWOKtZR`Jm3Zi!Ki&^i7t_ksKaQjJ/d7ZHRUldp`'.t"Y1pVLUL:?#
^ZY->1g*4g7BLs6(/&'C'"dso&;]A>U6>4NXU<B'#JiQ8ndV\\1SM8Qo=KpjpX6F3M+A29W[2
%5_LRp26i?FQJ9!8=#'!r7kfY"p!I`;Z;>2r=$\JU:piW$W>NgMgE5g[t,q$:S".LfN$`j?h
G0akX_QGBOBBjkrt0#E)o%d8`eja(r=QJYRLgoLl?$l_:n,!q_S$b85YdXk4!T!gNJO;Utj0
irPmunUKU/5d:tZ`@.1("gNT[L78I#V=@XY,jMWe-#UI"P>I`^j_q]A#o(<$sn#PJM#[nX\kE
Qc8(g*OBDQma<I<tV*;Dh%*!L"?g^?YAfbJ7(e.7WV1R.[uEo3;_>@_iepW2/`TpTCG*%@mI
F=#Ydm8ZO,ZUCB1($11075'%\bqMoF[g5,:l5E\o4,rW9O^hJ7u:C*X8tn:95t/0^8B[`pS+
ra+^<<#/7)rbl)@F$M,-!VPs<i'56KBV`*MK*G@iR(1`JTZe319R2.Uph/#$h*'Wbh.,&kE[
Mf;NY]AiiSq-"P/'D;<2Z+BFT;pG4Hd9MULT!jLd^>`#.)2GA.h(ld9e(:SK!9jHO&RFjfQ1]A
_fC.OsfKC-6B=1>ur>O:OWY;PJ5(3fG!TV;lEZAArZQR\T'3F_q\Bg,WC#JF#cINh'S7p)Vl
c;*3Ys]A',6^gFQ)"DHMhTu<>k01$GCXLPN8o>j]AAiZn!6rc)7&[4dDBe3+/55hfr<;:s'$b"
&l[O=i\%0^]AR<.EAHgPbnH"W!$rLV<q\%(URV_1)W+)-?C/LY6;EZULl7g^D]A&pj(KhkSSon
RZ311CN.q1Jp)5N/J@/(V&QlO9_EYW1>cTKC$WpDT>JmM]A.tWf2g]A?+;]AYFC9^dr"C"<rPHK
Y8^JZL1>2BAi^c<X2*,g@>%FM@*A<cQ28LO;FRW6r#60Re'3iN,6#Fbn%tHC%X<*]AD-JHRL)
oD&.-q=0+5[T7-Ab7uCKp0^KCcr]AP"<ad&<]A*[`IM$#nQM,F).T\p:;q.K@C^74?dGNj0sdo
LT?skKH<Q%GpfMe$I;nW2WtsM]An)>$2K=G*a4r;QjTN2-D^,fJ>q"/;6tq[.qm#)@lkd$07.
LMpLm1#edj._UDH3f3^Qeo&AU7j5_:X>?diQSl6IST0DGOF@Wc;)`6G>Vag2Qi]A$OL&qpFY^
@di\?DJ[*BVe`g$C^>*MnekY]A8?t27alakLb35bLqa1GAi1NXpk^ED+qPp6Zch\-_jMfSG4O
HtnMp.JD1Qb`!CGRDrNQI+cU"pc4.k5ko:Rhe('Matfq&l5BeFFs-%YI%&[OE`sl#QWpbbkC
',+G3on(rki8Dj(ZE<(&10iHu9IfAG\T4/?`-mO4H%=J$@`;mPf;aSfj_MG7jg^eY71UPh[M
0d>]A]AK;!&eZo.4k==+Iq#i$Y_65oj.4^Q?99KDQ]A#a,UNm*[Za2A4hih/Wa&-<=rZVE$#ml"
dCg7f+71<%e\LKiKPVk,iu?p@'I+>5qVg(r:<3/_0RKp.f:En6HiPfI1p]A4=VA<@oJSe7_(K
$&OCu!p<oYM<^N\=4YMiDE6#hA5E0lTXiY"1([-?amDn.+d]A[J8N\jo[?$JC.AQNq&I`<FHC
sC.b;[eRg91gMAE&&&<PR?U<90\oiO+"tgapQu(S4`GSl5Qb@p*`LFa@'&);_70#ug%6]ACVA
f)`YfGZT03WV&WfB>>bCYWi2)&iYYL?13t(G#A/egd(OLY"6W^!8-mS?3Db.-$7-+MT&2r;m
eqLL`cO3!)Lm3Bk$a8q$3>7Z:</.g4AsqTn/p985tDA=Vl9k[b"XR@D)-+8s'9b*0Rr`RN05
j1d)s\M,WC>%,`#c<(P`at=:JX/[!'^I/Ca=/C+FjSj_5YG[CQj\iid;j_>K`o,?l]Aur2VNs
TECebIL;Fs6A/A`bV=,mlrrCKNYu$@n9^5g7HR8:->bC]AI>Ni/ab4WtGGfXKa"poaGDq,if1
ZNH[`mI]ALC*c)QZ--[!pn5_%_hct/fl4'1:FQ4fVY#<eD$Ni>qt*N(B$HtSB-n_NCZ#>KSTV
PMs$#J^lt`@noV`ldFj\cq#eL1[P'023(F#Xf]AGXB?c7`8V<MbUjl=B/4AQZJBf<jm:#s^c:
+J/#:0Osa=@PDE4C"?F?+0G>rZ3X@"uN8CC-]A*FfQkHm]Ae-Td/L`B2b-J9<W_Bn*hf5d^mN@
7ap-Zp41On:&@8"g]ALr@<umG!"m!sg5o6Q&WSl"e!mXcn]AA3#Hf.cVjt/Ip1l#L_,_mX.3!%
]AFPL.Z3cnLSUXW`Y\NFGOAm8/8>\HDTMa32Fk&H_GUN(cSm"%jruPCu3-+C]A--GU?l@-Q+G4
kG7r0J4ZJF\_@%r-1?lT7@@@E72DJ&48dD2gs"7@h$L$$n7aqm)aro+*&6*;!V<^jdF[%K/D
ecDBl(7aobrE?FhX%jl)eqJ"jm2ESL`kVsHkDGO3=@e%CQB:[1$Q82hhE\ZKM>=XslZs]A=Oq
%)+06ljEk(394\F(mU^m6b=\i:J'\M7j$FMsfBp]Ab03<j-Md=CqtWT6rD]A/\`MKT'u+'NXa/
60["q<nIW$Dd#GC)`3rcou,>]AXd(p)M*KVHfClP_9ecE2s0ooN@9)GksZm^4qa'^A0!H_p^A
5Fr=mQ%\.l3JtcRKYZRgcmU.`'@cNOQG4]A9Bb\Y-('f/3^#`aE<`V$b`J>\u=a+"S<R-b<\&
J7*=i0lF[?uV2Hod\I`.gC:U@IVl2*LZ*FhEh'Uu%?9=P0o,4g/6#l)W,W,np:HKR\g[#Fi;
o!!AS\on-j%m&fY<L``g"X(""')Z9bMqGSr,0,YdmLO]AK-,@c>8o$@h6o?so8h.)DXb7Y^66
ugfuM:AdMghmr@!,!l88<`$D0\oitp^*&@n_**?!tPeepdZ9$Q<S4@jn(T3(G7o$`fOY!o1A
iiaFCZ3MN5d(GOd?$5"q(\.A)hCT&ZLYgttVLWOeH)(b\V1kAINK/e)m''\VmbGp(;>NQAKE
U#UHH+J26i:&C6g4)>3*lZfR#J@AQn4DP6H:!hM6YAak);_CSk\e#6XWKs+IUFaOS6)#9_F@
Kt12l*SOU)_iP;u)\Zh>!dZWH5EAs*Z.\D"RHmBR%Z)'dE8Y?#MFja?%;oV/U-JaYT?k]Ar<g
4HtJp02Rao#)7ch@a-A:DVU2,Zq:Q(Bk$5@(JBe#P')1u+3i5$(9Gg;sMp4;C@Ho7B<5V^q\
l+SI3u#GsdB\ga.nd-9Wo0R`95a'I,N1@M;"Bad`M&%+7lDi"77!uY;>!)_Pt]AW+]A7eeLoX(
J668([S8*A!7rs=/UH=t$[1uquc(ViVTL*>!IRQ!\28ZNj#1K/l+ccrPck+!.co^93d\dW/A
RAg9-HBG#onN^"_2.0SgCK=Pe;"C)j@84G9\:&OZ#nbX,A'B/7J[^7K.t,h?k]A<a$Or4q).H
Xt@h.J5(B0:)u\b?#\QN5fgi2E6-ULB-^I'SXGPg>G924k:7LI9'rV$a7fJMTO2k,N8er]A4[
OlDo$#JKACHZSr/H3E"mCTf:o=c%-Ern#2Jb-A@lDd4/j.MV0KriEo(#DL\WG[1fCJNs*;I%
'dMNXlDU/IPj)jbNm_%]A>-dgk[BE9%Ij%7=b;3kUqSAs$_1^Rme9h1eLT6(nV>4LT[X=*-&.
cH]AQ96%9%T[r\Pf$68sRo]A(uR!c4JrNbUC9mVM;eB>c5(&mnY=Qo8l--,0i8,Sl>Kb05qWGX
B?;mm5CE&,RU[hOS@6I713&LjYCZ<H=<r>m(Kc,.O2atN3Cet+>6X1)eaA#Lo9kWlU9dk3#L
;kgb*K!0>4DbRGM*2PrnInB%s=5Fmk^Q>2l^X/BFBH4m<(#iN&SE8)>HO<=8UW\=FpV`MP2_
E;;f/T/E`t&P%X`&"1)cic?KV__=\&gDdXg+&2LOL9N1;dGDO^a^;AQ^r]AD3,F8DHN`#/4ZE
/@7I^'rBVFa3h/U\D&*S/=tZ%`IY[Q-[@CqknXVBoFk(paY0aJkiUk7ma[C.lUu7Kb5J6>^X
&4Q*NaF4IqnGp!3-,KGe>fiQ'_C\DW;bUF`=Wr<U*nY0!uF'OpTMBL_4fGUg1%;;Q1=<&,'U
Qa/fq/NWV2@rM4kH+mUY_;JX=#DQt&+5^l;D<CaZ>*l)Ona>Y$f^r*gCpLTl>eH"[X0t=1[*
>niGZlX:"='WrI`6suBlTir85_8rccX2$COmc"bYR"+%P!9JhoCbjC51kqj3B0Td665^*cpC
P!?)GL`L"X&XcYBD_b'E9kqNmoe'cJ@D9'X5,`09!pRq]A\<]A)Q$Z!opGdX(?ZpLoN:$]A9I/k
LiMM)B!u%ccI$O@,cUP>pW60qKQoOLD">T5OT7hDn6$tP(s[VXcI\H9cYrE0`HSOO#]AMo!Fc
EQ's_bQ)LmH#1ko'E3SF--ef',4eUfpQ94]Au</q!mLF26%1\"=baMXQ'PdnLDYJncK-5:u)h
EAh>XEdVmmep7/_9I"n),Go`lU:5$:O,fs/601\Mf`0g"mBI=^Co#1f+$s`f%/cq.7_<W#\U
(gONf1jLH1mb8IOA6W+\:CrI,aNlnJ_7FLPA`CdVq4%je:_gE;.VsjJGu+]AZL*sk>gV!WJRC
J5XcEbD)s[(3_b*/VJV"$+EQr:;k02eXqDZ%Dl)RfL`H_%N!S"_^hZuRWTTR]AI!,*lV2fCok
_H3C:ph5A+LL`^<[H_;r^D$/MU_*Q6MocV@FIR%5-Nk!n1+CT0dAtRY\LTt?L\>E0_TTaZ3]A
iNdN`8se5[=X92R>^D/3_oPhSnaNr`P!6;-1\le>oF#,tman+`A&W4&nR,88(sr2\pA?R!U-
E5c>=aZW+7q=`c$LJM2<2kO/qI&,<.,G/f'UDM+Nq=Qfo^24u.]A9]A&Fffh).ARPUDXZE"5*?
>!T(#qde-X'kJp5>EA2iV543PJA+:X1HbqJ>$PUDC:OJb!FI!e=oU`1lDDo6CV>3n^82(\PW
>/R224<C+">qI/r%kXWXq;m3^'DJb)$Tm930!q3,IYtLdh:Knk7<-3=bRu!]A!8nqaSI2Cs<1
9Ii,:YN9eqPBss2pno'3/&m1%J5kUJ\`c,C,QGF^"1^o#=9hNU_h$hFdGiW=jS96SQ]Am2i^#
6bYSEt?9Y#IB$`;4fVX%7j7Xpj?G!q]Abo%_jHG3t8&Eao2@-h]AZ.Z=]AXs5X>i13b96"*(N^a
<)E$"LrKeToB?836&)cF_ArqQUR@@;lBLV?C9-(0:=4`&Ks:s6hq1rU/CU]Ac*YcQfe+VkT@u
$Lmn7us*?.(,6`Jo5:Y&VelWqa'CM98dXArcK]A6eXt%X`TPZkb/irh4/*sZW>8b4nSE[,XLq
um_9C3Y9l09<-7S?DLU116=SYln#e1m8*c7mD<-,]A7(S&n,d6S9F(mLFOfHR0MQiX_Eh2`t0
VR<aXCS'BI@XtE=aN8.*CH!]AP6"$&9n`Ptl$2<cG5[_pLa%\uM:S/+jjhu*5$>fP<NMF\c_#
sRDY-AB]At-2nR^U]A8iQXBo6FI<sTl."tD+gU<!#d^n]A5**SgNOZ8g?:QZNi3"XDuQp!nF8s&
^A#R2r>S4Hb>[rD=m=?mipUD<fgoW+65s$4Crs6bdF*pE\O5G7Kup145@o;Kls4:CUY'2'G+
feE'tk\Lar3%$N>/!DhD<Q4j@:e?-MMZ:8)(lga-r%AQD,=;K.-RGGfZh'"HAY-bG0gJXdh&
aONXN):s5bkeWuMF7hMP@!8j(79>N<idKG#>9RA9[nVQJ3jfpuI:K-$Nq=7BC3)o\UW(P5MQ
F,6TCu^`2+u'P+]AUX4Ofbhs*\^MD>F[LI?c0eeJ?-X`>3E3uC=pjja%_r$]A\d^*(]AU6IVLZ4
QiB/[0Nm&^f%STXTiSrA;\NKSHp[l4TMcDi"o\SA4?")$N0^Y%]A4;,nP[,:!4($]A5/[$7_bV
Kl,]Aa)Z`u^dQ7&5i*@dQbXKH\-a9!us35'gj":5QVoP\56-kHRd?m51Ws*nC4(aRFh5NjjJZ
[.B+tK1[r/`?Kb^8WL77.O@q?PDA=VM^##I]AnCX!&MZlo37o;ejbuGql]Ajs6"JZ4?]AeF;f[1
+SUs"S)KAe2?,VQ=XrCa-pS76LeGD2.W6/U3cRk&oBDZtABJDhLGD-\J>C$BY&MtUHjGP,r$
Z.2n;.PPV-asEMZm2Kk6cpVKHZ3V#E)/gq<O/j$XdT7o'!Ian.dCB9&:XMW_Pt5kY]Ao"uYg:
Hi]Ao<^T7Z'9-XDqm[mV2Xj=1qJ$pn5*i6^%c(=.A'Z<V/uK4,ak<a<1!>mnJj4&!$(ao._Ue
2OQN4VBSDZZKm3*Gfu%XjJ9(u4(<!KIZV72V]A!VqTalnI)ht@0Xd+jF?)!/MK@O_R:P@&mF-
Mk`dn)R(J]AJs*Q1ajR#%"`ej;5N,jg\6'0N6oS;t#/T&669LO^)b0=%L-;J^(h^Hdg+M5X&<
6lZ+-U_TCP(0\-*@gFB7JZJ#bl6KGOAO#u^F.,n1LTPTM6d*AOlrj@k5;TV]A8I,C9fX[Yh"o
Q(r_^R0Lo<VsX_Uu5LG-G3tYa0g/jfcj1Sb]ACUdC=#iQY'R^`eaJVcp(Scdm%lq<>Q\QQjab
FGeq(PlG9mpsrJ&E4quge4mBSj+E$@qcY29O#c!,udV(1FI=JIO1nZbC/`l1^C1A*>)$!YH7
b.6@5MA-LMe^4g#"<YTf2KmC<Q)Os$oSVDXUa94jJSNmF@olfQ(654B%R>c[QNd^)C;,F[>Q
6.5o'<OSR:!Yp:%+l2@BLJOS*&$#KC8eb03>>:W;+8&"rutbZNJk@Kbf?`5D9_PC=`c([Gtl
u_9PsaH%.5rGNXK:J5b1fPsNlb3cjfUWUJX9cGqEaJml$NmB8i<N-)utIc$`f=>__!7`0I@d
\pjSBfhe)HhkO&35P&d)Eqk1D&HH;*3+hj&j>>W6H9WCh@cu`&Z&YAKkrB/"\ddL^$!Lg[D(
-[GnhA[lhW2?)QJs%:9Nc)A7G-H/?Ep?NSO79ob;ur_m;3n5,)-Yl6JD57oK[I<.43WUP,?7
%aE>4X#[FYDC=.QS_A^(T'0.n,pjMQ7t1c[E+#l@("D-Ij_`ULBO1(p\m2;mBR2kB]A>U!G3+
iW4X*`+4KDG-#0B"$=QH1!j53h=q!hOX9Is=%RObT+fk%&1MB?aKi,1'3!3F!.@O&*FZXY]A?
[?,BTEY_FI,1K#NTCs,BH)?+nDNH1kikL)&ILdEZ#i*2X+OqAR!0c!&)<d>*)#i0[m"nq<?6
6XO9DqKMFk%h#Khu5t;^Ff$R-3'Olq`lrP5oH;>qIkjNSk&EiQ'(>?2`1+TmuNthh&+%Q@M&
Z5$T*<Q[s=0/kqAYS**GR58u81RDc,fG4O8CfELlM";IZL46&U\63o;`oXit939g@e\7A,?8
IsZq.10<i(koggT'7+Ms'*$5Mkk!+r;a`;DQYtIJA*[9`@K`Wd5a9iH'hW@A5%J'.*VK:"$Y
p6%#?U"%^*7OMV%E`3AAjgUYTYYj?!\c7hs1\73r/d0ClV;]AKn3Y3G.72M/;(S@$<_R**#DB
BRLG<H%.eGoN\<5Opf6qak'iP0Z1l&Hb*NKp23U/u)<^HSS)t*]AEQ_o("%?u7!_`mr7HL9#a
>G<7?=Ro4:tKR%e#$0QFM&S<dBuW9>fB]AY^'R1OM(P"PKfld&r;\?X$Uo]AP09n\9RDVt&g?8
fV$s/+)@c,_;Y7#of_`(;KBS_?W]A_D8XR)ES70B-1/DiIH+"_p!g^tunN`kfg]AGmYGk[:=E.
J4Z*<i^,_7BMN]AZlHW6^c+1t_2,@`EMIl+]A:_!Z+FRHNPOS>*+`T5B-SE#uHM'(V4SsRC@d2
$iMVX4:qmKVpB*p3+3Jq3i4!IY;+*\1t:#ou0,22F2ip,t"oTS+JS+UZX=Xk6DtM!<*d0UCQ
*3o;KLB>UD-pq_^XkL?J!rR5h27580TJK!22'((Ks,mFu*TD@%4/UU0#-C?]A8Pil=VGJ2-B*
mq;GoHOIK!Err'Kl*D:o-*TOUZY/TUKeqjo(><fCAAm9)(FVrK@e/(L;t+VW`d77j`U,Jcfh
_]Ahd$-cT)JjC$!strI\E>]ANq9cIVU)8@jj_'Y6odXMh4^9O:JDkSp[mZ9O&?jKo;FI:GWU(o
pF_\!)Qts>?lfg)O78Xh7GsrFYTCSshQbT:aTM/BrH4fWZ$r/ba#O]Aj@?kYp/"W4@7HMpKYi
(>9)UD49"(>e#gNa"DDAb_AJc,Efo(#m`<j/`1Q!R<7L]A3Ges2nN3a3'kF.m/us1l:bU-akt
KDADX=%A>!/XkW:0,*oj9UZ:BDYu6$7!rPk\BGNGjl3qg]AjVULX3e0,\7#W1!EXg(g"h1_(E
VI9;1%;>_n)<^/k0FCr-Le!g.aO#hL+M-S=Y^PqT'me>mj[(#;rZd*HVi)"Pt)O7Kc'AHN6[
Y@`8#Q<]A53:QDPA5RUEfBM<fW\DU4@5;*.?/1->^*q!&HF6)->/$F5&O]A]AGI&R)Z]AdEfHaVL
Fa$`G9u=*I"!Sl)s%J)*[3W20fHZMZ6HC28k)PWnEs[comust@JtC#`03ef@)MdjjqC8r1HW
93I:p@GsU?n4C[E0(-]A@Gq3ZYJL[YlJ(/fAR3O_Ho?[@gWOK`Esg\GV((&5pD3;M+EWfkIlR
8p(^s7nBPgg$<p!u['JG)(5"]APDk-&D<>XTWe1LemdtqG!9jT[C4^V208XtRVR^Ol2>4AWH^
BMck,t2/I.NHP>J/WW;eHZ6Q.7#;$<fQm)TM@+:/[sup5$k9?mqD:548CCN47BCGbLn,Mbm)
=QZ&c@Qe)D<L5_%iV9`q8N-6>NR=[T>,4j\iD_(oqf<o^bQ(PDLL)K%D+n:9rGh/_]ACELKU]A
Hh)3#!dr'/?sOfa"T/SpCDS>A&c>'^*l1B"jmM&02l<UqQcDf,MnR9S2m!pi3G:0idEWq!*b
[JUhab`u\p&#@=QsBUE9TUa$,tq^]A"9%Y05J)kn[$8L*=2]AcL,l/rE#me_%/&&hN:s2P/]A24
_%!.2uLnLBDbW=',YMAeiT!`BIHCn(+cn[1a9uNX9RK"8;SOh?&;[,$r@Z8s4cVsEQ5I'pS;
-ofEG*/@c9CIX>Id?h"m>*uj/4!;6kFS43e1nllT!T3T;aXWfQgcnK;Q1HGGu@-jn-]AtYi"@
=MAVprPHY)%87dh%00_0B%/h,VS;sEU/W'e<E\)qhq\m>[[#`tao<h2TGd.i?Zg`9`.H=Hu]A
(4[BuMICk0nR;l?'b8sk2-MT_GY%#?9DJW2JkaACp.U@KlFi+pm6>VImaLVKKDP<b;st^KQm
odp[7+08@U+1LeW_'BS8S.Dp1+[WCa#Wn$'bi!fXh5DP=R#Q#g/OH4s4)?MUeJ\GM;*sHMSb
iCi_*oestK,D[Cktoi`,M]A%RHHH2HI_)Rs^'85QHmRRXKaX83+U7D++;3R0St2,DAf3(Q._[
!N@J(o=qSV`S'tiBdt/jFBPpc"-kilfE=N$MN"aN4Z,L2[9[-Y"V)+IN=(_'biLnY2md&SJ@
^_%u4*6bV/4+iPl^H:@M.bLIPkL$ZnIJ/P(:l8Ut9B489/%Q-M-B9^pV4G=\_;1H9tFQUIjo
N`C_#;oXhla.kqbeSVRm(!`'8<rPr570UpjdI3cO$^bQ"Ykt5ESH2<%O=]A;4%,:1:-MlO5q_
iti^e=9Nn[""-EQ,0DdXZWA)h,qsheJf<b;.8<rQG!edr.&Bo4ckKH)Ok"lp#oj[Hn7.Mb97
lfA]Ak.*5;$WGBIrL3YYRtTg^P@Kq:02nVV34.(8EH]A^:-:,A[Y#+#d82AobuM<`n<%J(V%h4
>:'=KA*GRSb($Ta*FRej>1A!2,Ap%q2;GOc:<QDL*34IEP/$kE]Ac"9E)-4%Sjj6DRms`n$q(
DVDgKBm\lSsARQ#_3Sl4j)C,1U-AR=aE7sXC/-sipI<!";2a83C"UlM89:n/r@'0_5riE2%"
gP?m^WRMUETs@n#'>#WYbW[\WMoj(T@qF>ZZk*2)]AB.B&[SpHcSp4NA*RcME&Fk>]AN/P=(H9
U_`7!0c0hGLVNjB6C]A>/!'DS-N.L<_7^T1gaF\f.ldm6^O@%UlD3ej'Q$iFtL8U&Rm9Rf8=<
On[_go^P^/GJ5l?E5=gG4%BfL8[lB@c=u4jnLRI(?qf.aTY*-c$1'&mp>ULi\;@#aMb?(8"o
ZgeWm/I!`]ANn0pB/7BI(&RUa=kg7/mR7(>*?A+'[KtJ;h1sjXR`!BO*JU:kqrL.CQ43(BBkM
pElb`8dXFQB5kNgm>S@4!=?qK4:%k>[M#?^hEQk-jE)G9\r,j$<=n'tqYh/)gV,U"lq%n8CO
;t9(AflL7bHYss#[^ibe;(.^kJb#C2;$HK6--r>?MYVa;J,k)u.Co:r?Qpf-h^VnEBBKQ06@
:XUkOU_ZTQ50YT=XNAYQ>ue,s\!GO[TXm'AoA^l]A3OS"&2#Zk@4n1nVsu:Lc9DTF#2_5gk"b
-j4UFr*eWsj@-";RLk55DJSUL2,n[R4S15h.<>)q8a3fp+WHdhGZE@m$!0Qr%#>f8%0n7qsm
rHjhVWT-?F$:5f1<BUgG(TO>&/J+",@O4%C3F`Gn.Vr)s%dVGZ:EHH:7rKPl9VMW,e1=e`:>
YEK*?VQ#T1X;WG&91_q-XaAS<g?(HX(bmb%>VRnJG"VjJIqV4.<]An1Tg(Sq(LBC3QcWKcS#>
1@Ah$<kF*8BmGs7AMB6a7E7X_p;TTK<m_^r6j<hIXmL;f?+F@CZK/H,Q>8aTaa^G"Q$C_aG`
:Y1`c/-\!EcZSDZ\%Bq")b$gY8dpV88<mkr)(P1+g9`b>"E`fW&J:F"B:6p8/Gn8kP>\h=i_
mTNZP9(W*?<kAu?X7In\RG:ddXFo)08-q(/\gMdOlPlT'26bE;g2c8OTW4UG.(4YALG21-\J
mnQYg&"cM`9W'Z?nKc1iadT;YoHYY"H.I%UUG5dPr?b44lm>5Yeij%0'k^HIcroH;cno4eTK
0e>p*+l1<Po3EUPFGJ14d+R+IH(B(WL`,s%iiV)WI%SV>##Y?efc_j7n\?F&:6#fI"6hpt'J
a-cS!;&`QK5l-9eT"?[i;02U?/!P)1qfjRVec*=+j`+8a*+*]AH\^".oKh+hT(&6)5!4Bu[g(
j<PZtfJNX=aJ%=e.H:X9G2IpYPpVRq*+,ZlqFJs1)c?#ab';4*L+.]A`/67/^`-`9iQNonVCk
qeOfD1a71d.dW5%$Qo?bp"1(VC[d.rum#3m26n2)C`Yt%'.VG.BibjEbPaG2N;=#>]AdP;-b3
NTsrAORXS=\g_;,@Xb$/ieE>Ju<7"Y#]A=0j6[Yff&mt=7VEp]A1g4%qXiJscYmU@L=l1!4/q$
1oaR7oom]Ath:'f%"SA__3,Uiaj!q5MYu^ZA&U.LS9D[k?ZtIU_4']AgrF1(s8<gkpbHng9RJd
3kQe=d8>J@V9"2G&YVG2M(e\$cM>:7"/&r$Sk8,i?5g.WATdO]ASg5'"mCh=e/MU0YLs(\W4>
:_\UUtp#krQ"t[=7OE)CenGYGr8E!ch^XGl.X<K;>Leq=uC&D!;=]A6+Lm?90FSo?T_,4L;iH
e?P0gN$p26%2r08"k64nW*S+1#&**tn4X.%%3<QYFL[1]ACTQ/Fp<8&BN;1YLAhhr=0BU88"&
/f\I+:-_tKatL>N"JcL0!a!TEA(81HD8U1\WTi1)Zu:m)!ip>\U,G:TR;uK'U)08lfN,F'ZY
,0bCB5k`GGr0IP%bP+R[\7X?j64:*8\AQmr<YEQ;!NkJIg*1C@j*C\j^&OZ`:epFOM-U.ORn
\)e7-0M1d]AHRXWhDO+H(,RZ4$GdaRpAbO!l2:H-sU'CW1mOg]AM`1(5I_(`o*1"Y*dieR_S9!
!3[b,IaUi\nNe7Io04!]ADW=;5^Li+:E]ABlq2?W\3Nk\843ECH)V"A;9;/_dB*/<s$P(ON>3Y
XdGN@JZ7ZTcqtLfUG7f2DnLR55q:u>BF=2fCh9cV2p2MStaVQ[-(N%B^*[C_GTm(:HY8KZ,#
"5:h]ADZ^MY[#3(jB.,LJK"94gek8^4T5K-e[#*d+"1-VkX3f6BF(pjMM89i3LTOf0:&%[!?Z
)28_8\#$Is']A%#]AO984&TV668T+N&b_BY[5/`,V=52Y9Cs-DfFo7p=UYcl'6Sr32W!k7O"u*
B[\`WF4[Xi87@)=cYrKp#72`1V_BF&`pp.68_i(S'u-aAZ,?hO1<Z7:YqW'K\Q2?i;EJdrpb
c?PP^-PYlK5b^4$)#*^n2@'eBWX<TDuLjT^g[Bb]AU/GpB@fJc.L.OJ,$a7Q0N'Dj8l\i*-X$
(,SdA-hEJ<)H5$.#TKc\,*1E>WmA36lOsYfJ`l%</7q/:i&LHk5/pIuO"77WHK^N&YcLnDAP
<o]Ai?Hdt+,f[#li:jq=\P%-?TTkC#36gY-/>n?bC3<_P+?2ddlHrdJa(lRfq.*haT3b>t9D#
t&V&!b"L,jbK#6:h?U9ogP/-L(NgLa1Ieqp^lk$BkcX?o'^\!uZ<n79@bs$5^Al6i!M>5H"f
3VU:aZLs:13292,Z^Y-).P#Wg1T)uC'dl_RS'HtXk-_SeMK_KTUe+3P`G'?j;^&Q,BkjS4MF
a%*Ar9Y$:rk.8!\"2f(-#@d_`?n,rdaGJmaq<oZhJdJpKHlccX+r(Ib;77lX2C0:B_A'.,!1
E:>_3/YcNP:QMIV^fLKn/pZ!)@W@U#(O<JA\Vh3b>;,SZ^U`D:4ph&kMJ!NJ)i,Mt2ZRg#A'
"&5FVT:*H[X@Bn/U?pD+JYaPHY&'2q-O$?0e^/8d,S@Ceaf`tS/*4QX+BpB(sd@@OORlC+2V
o*<cV7XCnP:'n&]A,n;d!j<&I)^D.j8Acgh1RHia@LiN54",5CorS^Y9je<h?EBhL6Jjn4D,^
UMP3is#A;oZntRpYu$GB)tdV;GN'*E3=G90=U!=TNk/]AmitK[tpa_?JNB8H7WF%DKDW_Qkmb
-etp%^L>Uh?4<[is>)^k@uuLSSTAGe='.XL=./=1=6\nMfgLrpm>hoI[':7RZLG1XBdCMgu_
Na*>``AO!)X(nR\cM@29kZs/$rmYktNgKAZ88%H*8bgU)qk9\)<:QU\O9'+!P4?,dmc+'#6&
_1k)7Yj4"3e]A"Q_Ik=bn,#N[bI5e0?##nj-&;+R'$2Tj8#!.T`K031@&75#:+(B=VQb?SK;F
F?bpL-/:$@`4T!\:W0J/[+:&dT]AY`8Hta>pD&FAi'31e-+LUbur@Wl?^S!2\&q>lKtM<`*Ym
1&`:[bkMJb&Od-cW!R:Ze\@Ja1Ad;\Yl$8WLXQfsNGDF*0`*D2pIL5mDq\E[*WbZ7eIQFE7O
huj!drsMq==g0aD,nD8FNb:JVceFR#Wc>UMV/'1<\gQEXAWoXcb398ck(k1',UF;I_'F4jQ4
D%a4^![_ea+ZD5b,F*)bIo4PRg[cOpURdQ:oUl]AoRN!945<T?B)TFN$Ylda%noP,*<6OP'8+
[DjrkKhQ\mka#jn\P$@q,pmVl-h?rN`.ir)"%E15fRr.rS$Uf%qV<c_dVf:h/fb^n[/1t[N]A
_"7YCn#Wmlpq8:QlUK;BJjOr'Qe"VuHkoh$XQdqg#KB^QBhbF^.>KB:9niCjdEln(n4LAp+]A
+,eq&@Z1U@]At=`GL^'o;bntmW!iM#N8+#8EjE'%KT,*=K>?!DRnI6T%UJ!l4H:2s89+npNMi
gr^0*:8fBpXHDJu&/.ZpSoDRS4'ldn4&)$BA6"#g8!dgpTbc9H>('g"U8NC^[mR1^!#=2$ml
u`d/"3dqbTP/Z"+YTl<MB(S.L$pS2rl@nWYrMk$=(`e:[^44`)[on^Ebp#f0oFJt^,X4Q$>[
8rb2++iiJDN);`CDIKH$&E<LD8/o*;u<O51/(E^50br"r@O'+F2]AJc]A/G*V'?,@qfY[>dJj[
:1[D(mTAn87(E;(Bu<b%V*d=,XPM\J'(%3r7YETP7mAi]A%o!?1rK5^:j"5e'O&2bP>s4gVHc
B=;@YHkrZhfHC[[=%b^cAKt1,ab>Q87lmQ`M#tS2^PGkCVLF/pV"TLu]AG(4J]Af*ncl^+WLI7
a9OG%"[f?p_rb[=gY_431md[.fm@?8_dX/=Gj,'2Z4'&+S2m&PL76L0Hi<H4)75[F`%7+O=W
NAtXO]AH2Z2j)h]A)dnF2sr_e2']A98;,*5!'iQ+q3dr^M+OZ[ATsBbQn4Br,=7t$I#>c\)d'Ha
ORuEkUb$7pm">c,T5NK6J%KbL[/=(a1.g$$XoCCb,J_r0(\[.ob*/.Ep0&q]ASc/@g0i"Bo:*
NR0!4hlo::g^;S]AfOa.(0&lDnW,7'@if`Jmh;8p'dNZ+0B\e1Kjk%HuX$K+toZ7VQCA2H.NA
.oMn`gh%/&=&N'XOaGVg]A`?bCK;Dcf$qW1'n"+;>G+.S:K$i;d4*CkcEdfMgmnd1K('It@kd
bW*_$"sk/ic`kH\gesV;L8r.q2N\N8*,<6TbTZcB?[7l,+\aI(-jf;2)'SC9hlo.&O)H)]As2
JdSdYtaUa\Yp[M4`CHL$qY%s;)g184&K$Y]A1Dn8)BqN6r/,99Pt?,u\Q??e$C,QlF:_aT>SF
n/6]A.oKkBm8C`+B&u`/bYnLlQf3G'S54s[P4fp:%*=)&&QpnjG2K+@<\6k,J^0Ce\M?P3U%H
dhNQ3r=Hg%1[UITr@Ob&+@o^"_,c7^_j3hgh8'En?H\-+qC?2$7TWql%B'BAR=UJ?dsqBeV+
T'+VLQ]ABSLDI2^/F#i#_@O3[1!ZacMrH<,(Pt!?B7iA;Z8CLM9gI/[JX<H`K8_Wt!,HK3%Yp
ZT/$VB'+5?:-,Kgh//!gC7:0)ak$Q52S6<3UST0@=p>^VkSP.*DFChj%T-,^(UHc[t\?dKo&
nAr5?beKdQlGDe3'HE7b'R+u^!p<)"0;iPjJZ)O!um+@QdGH=O,(/5)'+XEeK'>lB3!B6Qa_
1:aj>CjPK/V?4e(N38Url#t\-nX+HI9s_*@Ein".<g]ArDoVnKiO&l8jBNAa_+kOnZ&%%Z4h!
Yj.4#YPM_a'sG?5Vd';:T#:e%s-qY4StoYlW/llLaN=]A?!&`;VQ/<aVLfh/0"'Ma*F#GM"hr
Ct1>=I03pR<nk1!p,!**3#QOrH?YK*#.hjh$+K/IQj3VT^c#=fGWI8HLr4d,.BiA0O"Wjj2U
i'29Dj_ualOH]A0d1!"YB".!5\TSXrA$PTXa;mS*tqVUc[lqX=:DO$M7*]As'j7=fpBflq.q,S
5eG+'bUGr2Mr6lo(/he#-RnR;I&\jmW#n,ng>j\:M^(t$J8*RDEm-]A>H+6q]ACg(GsL*P4:%2
-N(sGc/.erN:4V4*qUC'#Z_[O-.=.Y(^CL6RO[PF\RIFB@QPpVZ4AOb(e1?^4^NVBVrgpm@9
,e8(P!HiW\3(=^*,*?h'7I]A7`"#4Kn..6$,@cgIL%17dauKXJ?4iWVN#.(bgm(3sl$PKq[2R
d>."=roO4^C%(:S;ONiIZYe*<UbLduc%'sjp*a;jk=,munp\Rd@4I(l2'[n>mGNQP1Efu[er
[aFdbkL&+/3o\+g)h8>u_Hark\`:$1\De,5pLlLG@JO0)q71H7#Qf2Ci8XO_"H?pHm6D5sh\
;]AN!'LP.o5WTB`?3a4?9[qF`jiWb&9g%nga!e:LHD;8UDO>:G[f')_t<_c,);]A\u'"pEH/78
a)ArU3EI;C(n@rkNUZ;I5"5(9@fgUiLYciBE/MHe=nt2>$*tu8d\:V^GY3p76mG]AH2X6a;rS
!>%C#AeQX=2VNVm0Y06SEgdD]AsCG'YT0E\8`$2^EKCA"7ANZ/0l8W(7-)4ouaRPr4!Y@&DHQ
WR79Pl,))1$(%R-2<Te@kAmeIoU>4N"p3(DCDU%TUq(((cTejWd;:mT4PP3U$b-3pZPg>N^o
B055%'q>(CJW2Pm.R!,V)4uI@AAQiai.602S[[*gCSU0QBe4N#IG.rNNE"0:1?3*C]AF;pLDp
_HCpT%DJ9t;S9fn53muY+Q25HMS_kXp2Mj($&m@(kg%%*5#9G%Ng4j6n4,0Z_0Rs\<0Lk#0?
knPk2%>:ZA$r<UZd^.l8-BK71_X>Al_=@\YmP%B+gEZd%qb.iq'SZ7U7Dn4(4+up/RlLK)64
<[*Xl&"C/b\iOWSB(1!NW-,kKTWqFEG*!iTA2MsMOJ<kJd3j%'\#W3>`NqAB93_!F3d>Bhkk
-&/_h8l7aRrk`T>T12mdNJ?&<]A!E7VGY@Se^PY6%Tf*)1/"uH_b\qOcY3"`KNfE-Qoju7WSH
!>bmCN)pN9/30>g+E\_5Q-_e.sV3>uY^4OPIPMMD!?'"t[&)W\5t_duG*40.]AVT]A:1A&cMLd
]AhG%8d3R&p:CQ'#9#cnp1'1D<V]AuTY(2h*=R/)%q0chW9V&nEH*eBkjE4bG<&d_%TsZg#j!)
GP>/n!W'MW"G%`]ArT$1fH^c5qms1k=(_>]A8)f/khT`5KoqYQTM8+bh%_+=blM-:'=3k@P,FY
imnX]A#SM_%e/$7h\[@^c6*f/oS=G"GbsI=D6#`SDk2,U&tA]AfS5m&sX_6(uGo)(qidt`m`!k
JjLZ4b8s4PP-+jtane,e15Q^KI?af`=XAA[X>l+DqeWLL;[IA%1936Y6B"tN"DP;]AB$RI.I:
dB$-:Q,j27,<F*N;j*Fdt:o36DSn8ej_dR=Q=F'O?oEdnULGI<)P$VQ@p\G\?rJ=9_irdC6"
O[LY@c'U+_3^6$etU1M7RGV=,d?J)F_dDd9LI4o7las0RqX=&(u^NI[l2rb&(jh^H;[;]Aekr
8n9,N%-[j1D3M9T%lD7LOkQJZZZ1U:DG/('$;<1"9s3ee.>-5jrs!_gB(Q.]AB'U+.+)bp8*R
@g]A:\g86k5i=![XX9Rh`"P54I7>]A%;SQ84b8-+=W$2@3sCu:@3krqWg^?IY1Fb?TsC$badMp
)AORa*QQf8<-9RM:d9aLc02dY<g.s0bn^2KOh7TD)5_>mk%D"0qG@R2hi(s4hrXu*9)*@6i.
1-]AY3hH'n*t^4/-Zr?>"K/r'C.d+mk]A%!hY&'ScR5RlA*,/$QUB3L*$NW>nW'4nUAsZC7hu<
b/JUqeC41[H4kGNTk'sg1_o,oF+@YIb:Q&`:9QT_icoedrcgH7YMG9W_GiL\%EuHb$Nr\WQO
H$F;7IRV[P6M4ec?\J(T9Obt(UM]A6hg9V,Hh^;LeLb9QE2=g+s*QG+H"kfa[uq(kERj76pA]A
^C4bbc,8O!(3!_%haqYoes([jD^Da_\%1%G@LmujDQ]AiG9,#`$E:A^UE6BM$S@e;L=FZRV#B
&kPW[(MU'GG#;1AF,E@k4rI"EOH>-i^o$r%5D&QfelGVbp53tu;!7/:DOMr6H3B2L[J^_.rT
cU3@VO0qS"t32V]A$*C^dn8eH.W:uAuJp=So=1))j9k>h0u4I#'"I[I)6"Lfp3TCeEOCQ&N`i
$`-@lrJegd:B,5^;^N%(@>lg,['7aYTW3S#sQ4Z1\IP+9Y!=ILhk;obdR.?Eg^;EN.c@0VX"
(S@2>DK_,^,+"tekQs:W)T;Yp,WgHEe5pj<.Ac^?[Du-S@^(JMVh55WmC`/1uM'gr[JB"3#'
6BrR)t22ucn0I,&<"r=`<=6\sW"+M^rt(-/p[nil-.!#*V!OUBbkNTCi(I9>(I,[;fqA<t8"
Vf+/,o3MfGonr'+iY5%JbeCSXit8e_fP:eS>1DLoqeQYM+cKWW1c,iYBh?i?Jlm[p]A'je\R6
Qco3("PM0m5+fP8?Q.Dtm-8?(iR/PFApCc1>U_4VGL8JGbTP/)mQJ7/'(<R*G2)qm^["$qp;
_NAC!.."b1X4W'G,loe(V?kT\'cM'8!.M8(tn&QcmV]AiOK#9]Au`lk.W7Hd&OD@S9!V<X6U?G
UnS=?N8c&cJGkQjIg/ugu7/WL/s3G7<a_rRQ$A)a4'<g[=PWZ6KJ[bmC%(;1;UhF&cuke;I&
5T%$ll10WGd%ZBqH@\(U6`b!]Aa-99)o!ccoeYbo_$=5$S&B6nBH\_^`dG!B]A#X1/X+TA1XuG
4JZ&Y.<oU#kK_q'e)&!?=32>TB_'hmj[Z$V@PK"bV_Xeuk50VKM5GHbj"]A5Z-Fg`%Ssf<+_J
>K2&63<]A/q^$caE_:0d!kKtT]Ap&a%kp&=k6c9Y4r:7tn=b;f-#GfIC@2;A,Ee3;l$s..<2Kj
cF$dBM^@TIU(F\FMcu'=K<8A9ogKPRKePNkgJFiQAEHi;BJ+%>^Zul\Nl]Ant#\>AP[bk"o!q
1Gr9D6[XBZ"-/2_<deuU<R*@mPcnIcZ%FhV-qK!:crGV;P'V\Td=o/dI7*P1J)4nf7N8_)@L
<<o4Fi/7]A#V7MU%k1),*q0*Q9'Je?o2Hg4Rds/s>u)]AeQ;E,GEtf]AT)1I7*kqmJ@"^c!$MU@
U9qK#HN\6#K32d[h+?jaab,2.Si(]AGroh+?kGK9+<A4&%/&1lTnle5h@[rB(/NbpmN%L[0q1
Jmb]AWc):FCWed1J`6<!J>b+CUub-#j.@42b"+:k98pb)!-Nb"JDPZ0""2%c0#.db7jC7N?;,
F0$4)P6$&M'5cluUpiR()D<B!T:34i]A>p]AlJ+*R9m=Lphna,^rrcVtd8AVMl`8.#ZmQX6Ri?
OR`-+LcoQ4S&X[P0KrlpHXGPO#)I$4WF]A+(B(qOo^6b6J4sK?pq09515`k"O(XEe6j40`9T0
TCX9u$,pE90iP=-i_9RG;9BH$\G]A)hO!*I_mVh(CaXg;t8G%srmg3[nc$,eKTB:AdMHk0$_B
EIA8=Xu?V#-W6dD\<s(nk"'+REaEnbg"0)sRiQmK!7pqkE+)N[0/`O.ne,E;E4`@"3c*RN%B
dfdnd2r%s"'k!qh!6#e:pZsD?&:JiC*^3o3[2khpHDnQRh#0h\H)i%b[.]AIM!'jO+4:Fr_8j
[f=LG%+MN`@S)dqqem/Za^BbJXY1a]A^lh)<Y0B1rj(!m;$"ge>7!NglQ5V&KBcjFFiZiXD3X
ajG;/"lnGHEE(#TL(h,pf8@@d3Sb)G1H99dpK^H[-O@8lAr[QnG;uGNHP6uVZX?@YCj@Gn.1
$I0E6u>"gS24JZM+;+=iNga9q#./S*>aMRf(CY'NQe^,pVWeZ&E?V&TF9~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" foldedHint="" unfoldedHint="" defaultState="0">
<color>
<FineColor color="-6710887" hor="-1" ver="-1"/>
</color>
</collapseButton>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="469"/>
<tabFitAttr index="1" tabNameIndex="3"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab40"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0_c_c_c_c_c_c_c_c_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="false"/>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0">
<color>
<FineColor color="-723724" hor="-1" ver="-1"/>
</color>
</border>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0_c_c_c_c_c_c_c_c_c"/>
<WidgetID widgetID="53acc9d1-594a-4229-865e-64e84a870861"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<FollowingTheme borderStyle="true"/>
<Margin top="0" left="11" bottom="11" right="11"/>
<Border>
<border style="0" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="simhei" style="1" size="128"/>
<Position pos="2"/>
<Background name="ColorBackground">
<color>
<FineColor color="-10243346" hor="-1" ver="-1"/>
</color>
</Background>
<BackgroundOpacity opacity="0.04"/>
<InsetImage padding="4" insetRelativeTextLeft="true" insetRelativeTextRight="false" name="ImageBackground" layout="3">
<FineImage fm="png" imageId="__ImageCache__9BDAD1A694F2AE09931BEB5B979DA1F5">
<IM>
<![CDATA[lO<9(kN.ld@UNU%p%320!n&&RXMhpZ,a0ckg]Ag[)Sh?$H'm#O$mX9@nDg03/<C4dC'hs7\:U
CrUFIA*cmN+n1!@hUKFS0]AXkEO<r!!~
]]></IM>
</FineImage>
</InsetImage>
</WidgetTitle>
<Background name="ColorBackground">
<color>
<FineColor color="-10243346" hor="-1" ver="-1"/>
</color>
</Background>
<Alpha alpha="0.04"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
<USE REPEAT="false" PAGE="false" WRITE="false"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1257300,2286000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3810000,11430000,4572000,4572000,4572000,6858000,3810000,3810000,3810000,3810000,3810000,3810000,4572000,3810000,5715000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目名称]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[最近跟进日期]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[最新阶段]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[跟进详情]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[销售部门]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[经销商]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="8" r="0" s="0">
<O>
<![CDATA[业主姓名]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="9" r="0" s="0">
<O>
<![CDATA[设计院名称]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="10" r="0" s="0">
<O>
<![CDATA[建筑面积]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="11" r="0" s="0">
<O>
<![CDATA[风管数量]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="12" r="0" s="0">
<O>
<![CDATA[预计到场时间]]></O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="projectno"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="查看跟进详情">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="projectno"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=A2]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="op"/>
<O>
<![CDATA[view]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_dialog]]></TargetFrame>
<Features width="1024" height="900"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/CRM/项目跟进/项目跟进_详情.cpt]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="ProjectName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="报备日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="最近跟进日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="最新阶段"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="跟进详情"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="销售部门"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="经销商"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="8" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="业主名称"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="9" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="设计院名称"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="10" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="建筑面积"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="11" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="风管数量"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="12" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="预计到场时间"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellGUIAttr adjustmode="2"/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<FollowingTheme background="true"/>
<Background name="ColorBackground">
<color>
<FineColor color="-1" hor="-1" ver="-1"/>
</color>
</Background>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="1" size="96"/>
<Background name="ColorBackground">
<color>
<FineColor color="-1838337" hor="1" ver="1"/>
</color>
</Background>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="0" size="88" underline="1">
<foreground>
<FineColor color="-16776961" hor="-1" ver="-1"/>
</foreground>
</FRFont>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="4" imageLayout="1" paddingRight="4">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m(7C>RnpXSMJJ(`$Q>g#'Pel%HQ0&?!lYK\BM3=m\.dZR]AnMar/ZoCV>Y?LYTXYXX"?ZP<GC
O8-rU.)nrVefiAS"$2An>Rl\ZYhDBC\a'/k#X=#m1JL(=iR^%2F:B/-748(9RcP_0li_-1)N
WX'o427Ic(UmTpt)GI*W"(P<&\@?9mXGf'kS=B<pr`*uamTaFYuemZ<AYd*F7?un`4cK]An*6
_d8!s7mS`+'i0L<O;NpX)UUE-G@"\eaJ0gVT.GG:?^-^8B^E%FL:'Pheu1`q@K*Fk;JWU@=D
m1ke#M-aHcAU+VS!h0@Ca9*tN&%o,aGa61?t+MYiDc3cO7Dn_B.eLoKN^B8feJhVm*iaAe#,
ZgT_",f-s:>>GMU]A7XIarXB/_@-H:XT)sX0>*o2\_W`!Pj`j!HSu_b2XaL@Q8XIWkhhOsSpc
_[iiTpqaM@TtVXa/[5^$l%2c$<,_=/'t^qte&SrpN4H0HQmefQ(-9,"jIfY,h#&&nckKh[eP
NJ(Q)4pYTQYYG!0Qda32+s'J^fGpu'-s/Ili1N]AXMrng&V/NJP"8DN&SoGG[,bTu%qY"QdOr
n?Hi*r)fZo/j''omC]A!io<Q3:XV9q\8tr(dHJgbR8q";Zpc+&gf^&oH=uD`*[h)V>Ya4'e9#
F(eB&.HkW;nUKK1.cj%(l$?+QDbB/sc-(bfOTdiAahO[DP^,+sNH2mF-Bk+($^FgkZZB8;j,
7*h:>*Q3;)kjIt]A^a9aPdbK[c[r@d*h&qDh^TC'[hc0fBK@&h>hW<MX9?!t-gC<^X#9oJ7fZ
rG1Tq8[RlQ!?k9fWURDhHDXkXhkp"1uk/k+96'91sA%_+gj!d*GRP9lk59Mt<`p$jlg"T=)[
\kL(l78#X`!Mo7Iq:WLSIr2:/*'E2GWqF$F!0.%([>B'!0pO+4%:Ca4MH.[s6mK@>23lj+l7
nH&m6`&di0V$_V$No[t[0%f(!UHNs`.!KDJ`!Y\1Qn9)Ed-B&?X=\GEh.*.m)fmmYch8@LYg
5>-V]AYu,!KBN`&SZ)(n%ooU3eNpGUf;V:6lcG*kB^h\NkA"h/Tf1G'860l[F4\=iTloFIL<p
^?)hkR6tiMrGEgAKnjR<(u8W1Oc?tJ&*d?Ec<ZqQNf+Je*B0Z^d:7C#EX9+DA&dh'q7F0jLM
en"3>"4%dS%VR\]A\$ERL(2$M:g???P^\1>+[0!G?tD^1]A*IB7A^QH"-46K:'5CnrT%NjYO8u
+QU'a*LI"GtJc<&):Hdus@,.;NW.C+<D)05A24oHG\ZmgslJ%l^((bdJ/N-4E+b)Z$L4DK.i
&O^5%2C:YEqDLu3\'=QRJ_dEB>:upXLm5:]AbHqiO^W>ng[F?^5@A]A;me)"#r*[Tu@Y<nBAh0
WteD[:\me68+`J^4-p;I@o<+X;*%9)--MPQK\cIJD(K&6j55G5XU\Xq(#C[(=(bZr3-'P1qG
cVa;8T1:tb,$U!`jrQ_CrMga,NHqWfW1ka)mU6+=/I$=oPabZg=Q9$:lSXgknMJLO,AB8ho6
bRZ,)0[WeIKcVID4(Qnj@!*eHPJ*;-P4pM`YXNd=dj4RC.L%N4l28ik%UX4Wc,rE`>0!EBP.
),4Y5j%;j;E6.HM^+t1jp@E73X&(akF:"@Egb(Y"2CB;3W^Vtj#YGspU1V[upr[bS6BK[2Hc
=hFrf`n2FV3fDS6#boSkI9Et<88&nG=SsP[+-+jbBbTIlMalMSNp7ZlTAs'3DBISVte*@g6)
-/oJ2u8H,B^&Vn;oh\u/@4e8!!]ACl,qpa$UVD5tC-,9cXN`PIng_s*UUW14A,#3;dG:_`[7l
hi-ubSkCFq\'oYZ_[3Xtch$+u,XK-o<BS19CTYsEF_`8oa3.gj#Ao>H`2hii+o/p?[fP+Bj:
1Pk>0`>Uj-M,iP[Q1heo7d]ATL80"Z,$!!lON%!!bj%$bdQp0d,4"`,mg6C(M5lcaa\E3f06%
]A0mUZ<gWp,jIN[)c)K3]A)kB?ZMMBBGgYDl8I;EC/.HfLNY9[Q)<RuZHgFCoBF`<sU@2YN/WK
"jK":hEjqJn=<A*Y""-jV;-*Jlg=]A<sKU<S]AH^8L0AXO2n?j"\,2P.i)n?[Q#ju\@iaS:q/b
*K/$\D!56WPqrRDl4PEK&t!]AUNr%uUlbn,,,R"'Jk:%WBt^Y?>m;4*q;R2W]AUHRVN2O'V)T9
T3fU4#D6pr0l_u<:EW5%)3/@u@GsIGMsKHN?8cqW&_egZ(u/GN(0)6X%,GdfRBE"DBp#q)fE
&Z.":]A3k?a4!FE)mt242_LP1FV-df*+u0q/l)=B$k.D#9>H*p:d]Aa$8+r]A!e&g-cUCg`%<`W
L2_:,0NfMZ_P)1K'Y0#<NhRIF7E,YO;S4qif>\fZ$`MmZ/C\q"?$9LqI$:EdiIg-,<]AJYj_)
K&))BpWf1Edta$0fG"2P<7W66cbm<,>Km+FnkmUEJd0V&`0HrDSgYaY]AZ7<Qa_$g*TJBba4i
pW1&pp":("PdH(j`K]ACiF-a,k4rXi*K$pe5\JT8JYqF?2?>M-!o1is%r:UL2-:X):*)$=cUL
)%f>cN7)2+Ck.(.a*(dRea'FG@?-"6gmSJhf(5")coeI?/cDJ`ST<fUA-M\KET"mX%%rs>jE
9!r+plbWTlO=<cD-G)"\1XgHrlA$FWd*hCkUX:9W_qDGJ\4+:!s0PJVWMAK:?srl<pGQO["X
UU2oleHOHF?kKJ5?Nl(RW>qnRaG."IoA?ZK$d@#9+Hs[tagK8e'hJUE-=a9eF"97f[VKl=gr
_l.pe+'?mGcA/Lrh1?pTg1prIlTor4Q;6>5tq7CaKaq-.!0V+mc6&uo$Q$d%fq/b.a1ZcGS8
!RS"5qc0:0&Cl\M_\3#GOB"Jg1dV"0TloL7.Nf-5io_<"6E$"GsNnse:39,i-6H$A$@Ot-b1
AUYkZ>gM#bMh.=0e93rF@0Nr1(]AbFeF8-m/AW,*jKb+:CI'o]Aa.D&-VE_0rZ(u_WmrmmU'!Y
X5_ZmN)tF;*FB7umOLs"G_:)a.n`>"OEL*D.[%DO2e7KkB:h:A!W"X)Lj:YF*k6\G*U+T=8)
'"CM(.FeMGHS9LUp-?\J07"A$a"ijC"%NQ018_@OZ3AMe.gI%)g6lnYH6Wg8O30`FGg3\s)[
O=("2_gg$JkE:ZfS5'J"rn?j0"ng2e)F4W7/?@qCkuDspV?O0-GKYEX'hE#`3m"5[f_;Ypb6
kA,WO+En('N^flJ1h_[V*P_-*_XEu@uf642W_L$c:>_bCHk#pU;2,-=kKoK%FE4ErceeT`+t
=?Q:;g6jup[Q05Qko[Z`Rh)M@p/_j((]Aq;b!fhQq[QSeQ<ONl4%?;;I>_pMTKf7LV:7b:VrC
A*ba3+dR8O"-e9R"8Q=-OcuVgh$=*gc+Xi&WggF/RA0SFs``%XD^2J4e?"[N423'!25PWmb"
(/^H\,1gJVnB_CS(X5_^$'anr^#"&e8pD3*hO?*n^]AD-AtR3Ne5&-Y.ZT-FBsEpL?I),/_BK
ER\@S7Tifl0W3JP7o[&%9\p%#buA0(:-34C.j-(;E1fuG'j>OVJLcr?JF(;8OdT:edBp$5LF
;4aZl!t'HB.)LO]A4%bNK4]A9RSmE/^-Q]Ab$(#,bQRtcNdS<mP^:'/d6PUL>I*943mAV/oHVnK
kr?5Hd(&'BG0bJThj*XJ9YkV?T!jTfU.nnf64Ka-->o/GEFlXCjPJ]ARCjtVLb`1f\*R[5gs*
ikBAbHc2b2p$Xc"FuU5>5^r9CM_[EDb;P7CA)tE*0l%&AH9G[E>NiP)]Ae"D'=SEk,o[Q@b[a
W(0hL;b&A_`*Cs=TeS<5OF+u_l04Z_<k)T-(#;6!Pom18=_(::1I=<eT4SZ`J%rnq:JR6EId
C$l,W&RUI,WM'&P/\$RF6h\nQ>aT'iU.D+Fh/7$N,,kb@b^iqX7K,H.K+:*=laKur2+*m%oO
B+Aq-(]AWjt]A+)UA3l%5Z1(RB&d_S^:]ARnFU'9G3Icl(?>pf+3EH&RJRuQ>R&2^rW^UTG3"QT
e2m7KIPON>Guc>NE0*>ka<]AH@-Ed4(\!,.m]A\I8PCaNO:04!%#Z9&AU%(pSkF]Ai/4[0>mr?A
tH9Hl;X6fZsS^a,i>#DNs:[MgH#FP0=-.`NtCs$;XhL,_(dB^*r]AL83&Nfbs/'WAmPkYVkZS
%"2!&%/t=:o$@:r]AC@4_1n-;<-?U3`F(-*O8dH4@j'='<K:*lJE!A]AIDQskH\.:GY&qnD`84
-Qs%jnV:=,G:k5ob62Fe:nn-cVY3"TaQiZ)F)nRklpRL.<t9\h^[PO/JHAk5Dt>6-f1f+neW
cMTRe^0hR\']Ami78pn\TuA3ak#E_!&Y"*^4?cb2r+Rc&W2^#k4U.l69CifJ:hYd3kM;Vj>ea
NbsgM<!fr]AF^6P5&HQ+WVDYI7O*9h@^,&QDKuT2C3oO3Xg96)Z?)L%WMM7H3j?jsKO_+6MEE
`Oc^s8FJqiV`g.Q:7Y@')`en[*Vr=m/5?>@PW?Ba5_H>F`IZf;_04E?BEt:s[I00J$c2oiaV
$eM?jbY`Isjmc(5N,i\kdP"l6t8M"MU@\&T.`=HrQ+,"+h?utN%ZP5d1iS/HtDRZsBFUgY)V
A$E"<RRcp1.eV8f^t7R^YBN2A@.kQ_-b25*W79Z%a@e#W,.cdXG_aboP3N-jp8ON1nlZJ-.Q
j?SV]A1masQmCg[jg(gHkAh"cs#YAIr9HT^^TrHp#5Rj=thBJ%@okbig0XpleuJJREno^*Gio
%m?LY;*Y"0Oq7fDXINtadM5YmrE>ia#`LX47i]AMa7(T<m3M!k'S&J#Boo'es"0RT^B2L<BN@
0th6L"E`%GTUpPQF]AReg%?,\:;:pnoUKN,>is06$eN7o_GF0]AR5!^CY12M-;g$TQ%?199uHs
7dtBPk;9i>nN%>dL.WIkm1^)%$U*tEo_@^cW\WM#Q\JP^0,lQ/"9_mK*'Oj&;64'r$g'h'uP
PJfe,niTs=l?%?$'?r1QJc=J*.EZbEsuc*A+t?1\?:&I,Q.JqEI?k#9&oPJl27;-8I&T4Euq
s/F)Vgub(V@+Ec0o1oV&KU.5VLh'-lB]A38,!/<YF]Aq3-a<A/e#H]AH=W*q:hgb-'J8$!@&8o3
\P"3PX7f>8h:f=%V=<X)[$;M=,LlGBG-@Ap'!u(Na0sf+fsAd8kpVeW[!J1e6c\!i28Oe)W7
trJZ*oZ"eLBt4;OCf:3EVX;:VBb;ATOCIae#Pl>1c_UNinf'Nj4>ehr+=KIkj<*8_Z+VkRN:
h-CkoE(IB94T5u*>53<m6":]A+\ZUgNaeZ+H%;g[A]A=8RZh@#j982,Q<_@slXm;MPoorV-\]A8
M@btnt'N0308&e2+oQnYHet(7C3e.WYVFl8romuH`X<:G*l7)>*UQ7$d8WSg7"C7opd@7)lY
>V2rKk'V$P#t%/o+Q7Eb5Na-`YFam]A`e^@AE0%=sI`6UmA=CN;'/Qn$Z(XMQ(,?i0bEoCVrr
Iioh<3f2:Y*s4.1lC&Z#[(Zf\Wu?^=f/LVN@?ZH:pTuL10>74/RJI<UT?<!<Xf;\_FAT#!`Z
P:5;-ac9";WHDYcX,Y*b39SU5k7kSZ:S"[`dAmI`o!+1F_Lb)JBik2cj;"Pie"F$OjAL++.W
I:Tq:;H*\\lbT,Z=[k4(!"Sf"&@9knm>-"hb=#$26="gQjA[dV$0M,@V:g&Ipd,PR[nU(O2S
I?W)j<mZ4m>@-'GR4cMd4^AdolgR.0SL=p&S\*#Xg.p5X$;<`NboX<_C8SIn=N*nnRYXQMFk
)O<@oEO>d5`:'4L@A5eb6^FU6>I0*W*m9BY7dO]A1$[*t-m\@4OTjUne@SmNU<C6nXDl)Qj*G
<gEdJ2%O!jgbsD^=A4LM_uWE<8bgbF4gY)m'K=aJ)u0a<rIr.mO&Ie:A(H/hQ,s]AuXp)!p)'
o+(a4S9!m"#Xup`ifbimd%)&i*Fq^"9'N;mJbo+$E!<Y?F_t84]Ab9(0\mVj#LZU%UOs@&]AI?
&rDgI^lLp7l9<J`TlhBPbd[3nj=Y0Mn_J[YR@D.8lRX-Q-N&q7%-ZoAbp8J73PVCkXe3`U8/
0iDB=+c#3J@;>2-lK]A.ap$%19h^ALCn++Y2&<ltN%;K?=[Dph0QslhB"R?/nmICM0]AGQG=X8
L!KSg\-43"\Om`@7VrY>H;^@\;!H>K/;@r<D4rIZtq)k%6PC&d_[nP6;l3WhLkp@#HFbL$(M
JRVRu?^@3fmV,@3_m8klA]A?@h&dq;ba2*2PL/1F?eV<E(BV!V^UpUW`1s<O)6Bm&r9!jPn__
8'f,3>CXW5WIgLud^fd:mmsemfp;abT.UBjdI:"j99s"2&-=1_E`_5"b[1Ok?B<6"jtkJDD&
pBgoo*D"e!j+6G5bi6J75SZO_X+tW;$fHLK-"JFh0j"Og[MfSe?KGDs*(HOTcZ#t69,[F98o
eTN4=.6GEk_-cCa'tL)qISjb@Wt[qp)qu-AIiojB>'[nE'_F.D$RFt$rls6=h9Wu-d@)9CgA
mJ?L^1,ccR.:s3;Y;@kuu10i]A&cmQ!rqN*<W*:cKln<Bn"UZj)>DV0,MZp?PfTT"8[4WpkiP
b1iGhG!X%>1nFTu`5WDD<orcf^+-dIB6h!Li:/'i8..FhT^$to(Hnai_K@>jhL;D/Z%eicBN
+j+4"[noCn0gDd\s^r"I/luciK@F<*T0U?#W8."ge&=\cq#DKtir:6eY1ROgLk#lusslU_aT
b,6DO.VRb*\AOgcm_cJ]A6Sl!DoT#ns-lSthj7S3PG.qZ:"AWt9ei))dd@+:IilXEV:RHK[Yn
'_dq;c)&FV3;_Ebus,T,Xuu"fir%qBYaC?&[U./2N/>UOYYXm6]At'D`T&7XKZrbfShSJA\T-
oX9[t4`(YrFa5P`)*7F$VUqUNYAr1-c!^JcLf,)nr+(HGEVP"Cu`S&eL.>i&bf`LKO2aUYE6
N7u0@_/.mMpj:Y?s#4UqIk@u*kYemE".N%&Gn>/9<E4[>oY&:DH8MUFF,jT,cFP#W$dfkW!U
TPMX.uJm[?=#!Bpi<@8-#Y;7BF&!Yj(mSCo@Wpluga?QE2%$%UVqbncU]AkNgqhsGgkGK$m^K
GS8^4IAY!')-["Y#6m0`8^mW$MlOf2tq_*dM@qR3FIHsb_S9WI<Q#l4PUilj</!V&V]AIpl2E
FHeka8rfre58.&4T+4g^MP@h6^OM[Q=9)8&6pZN-Fo-jjifB[,1NPAjjbed"oTDof^)RAO.u
Dn'd(f%L%b8G!0]AdURgW<V>tk1@.S=W5r8d)kDEW4r;UfNd6M@Ba`U8ePf8L81Ga*tYXo_qt
&=Hp7MLGKYg)pG6GLPK$^+`DP^gN;>EgfKK]Ab!fe[P*YFG"),GWg6+FcbXiN&hHKl#ro?dGE
bAA\p\f&&0eW)ZP=jO!+j;l$Zen+Je"V1YI%oMg+^6L[*ro.H7:O+W#.`f0d!`\(XMq00oO!
:OsT0t5M^M-YF8>k55R#uWps/sS!g(8SXpD>AF]AS%;3$DD2rM0o"0)h@q?*.H<aDPI)k>dmf
HcUc.$4j@cBNudDC]AFV9\*$j[i1jSKjjC%"73mjRdCE'm5;CQmaJ!!/>/X:-$BI8-Tp*NPVJ
9<U0s^[qXEoH'YUpR4+j\#d6W)s2#<>\"P%7';Ad:EFX%]A;TH9#J2mYOuM0,X'\qECl]A6nM]A
@f'deCC5(G;_T7M,@CKW9nRURh-Q*&_cF1U9FN:scsk#q-!:s_3B!QPk)Xeio]Ag?Ar.S:FS5
!EgI<^Ubp]Acd`9FL`c<&o+-do@;&R83*EA_(RU-oM5en?-RR.BH(j=ElsFO^;"RKi@cEIAgi
<mM&>oJ*\g^J'b.(T(A:KWUd+7Roh7nR<t[B\W1T#81!+*H/VpnPYKG[IfK=C0j9rm7u#`A<
;!P0-0f/#TQmo=(<a#$J2r-c>jkN5<A<IN^*;F*%P8=)cVO3XNu,ecHSZ7d]Af3C1X(K-36s5
&<04]A\8O4]AB"8Q3<E$UX!WI\d`IF^,Fa"['KU6]AbCcC,2-SJEoLa2.lGE"4SX"^&_h6KOkM*
S2,hfrIKk2.4WqMJ9]AkVeIq9VX7U^pY\Pi`A^;Z0KaK55]Aulnc%IZX^*4">#:&Ag,"#f*@!P
,*d#aj2CgTJLiHH,=LD$@LF6AY\>5Ki'82aZm.!o:EG1)OD3&I6.K2me!:F,kVWGH(&N=`..
#[j74%ULd2//DimBL[bcD$6m2lU4c(S(f-<^<<!c+SJ+)%esZn@U8VVQe?7V=.U;"G:O#G"3
/)-HEq*13n-;sRSt]AZ"f>Z+<Pgr7h-ZK#Tqn.@*74(h\S''PZ54J=[?G@]A"Ai<X4^gCjFR/!
+cnA#+ufLFXR\&iUGD1hhsrd0BT$EWh=UHu^4Ciq6uPas8LpeBXgJtWW'3/ZA'4uRk+XdAgo
>Q#b<:P3?HCp0QU--NO*U-B5jmLo1aUN=`4abA:`J-(_U8X\W#Dp)1"8_@pW5+$ZaCK]A7ZT+
FielIeG4VLOfW&S2N"*1mie8OKFFJ&o^CSG]AK1JAT<uUm$HY[V%1qE3AJ2)g8oXm\=\JJH/O
hY0>Kr^TZC)I8cmO7G77j+#2X!al7%P.W.4j'o6<_:@9WE0JqMW'lhkVEi!f&lkOk\:/b3F)
CI<tdLSQf9LYNC8?XCq`/uauW)@!%'&[\pQW[F"IU=r&i/h[%[mfQ$QB]AC2iC+Qr^<)`<"`3
@A:dU:\nmGo2K=@_8:SQlfe`tL<2`esHcYdSkbt3/A/[YJL&qQVkfM`b9dNi"_U&$Ar>o!<7
mAqH%Yi;iKWn>-b:3ra!"OJ#-aP?ZmR]A/j(Pl&ld`^u"=jX>h6h]AZs']A0:,!Z@g1p-&cuL17
'_MErid*T2&B8cl:qjc"&O!60h$Lf8t2Q1-BO?5sM>#[B7;NDd='brejGs>`LZ-S_r_H+p$s
:l9%hXm+l'p2d-@1;?`K`YDqC2e/*"9(U$s$(?,MCaK*W;q]AnmZ?Umm?OkCGhMgR'3?KA.cI
7/;%$B<dS/"fV;ec)O*m;RJ+[e"#SD5?6gmA3j6E4VhWBe!+o=!50g3o)k79l3O"`)W%C6f6
)\T#22V>#12ep_u=\]Acu]A[Bk(r.^YA,O+K6j@(C>ab\d+^ukn_'a=1kt9E*ciOPKp29Fg_t1
/C2!`=A1LLc/-m9(A9M"LcJj"=8Sr?7[cKA0gJaUT'T%_K05$2j%6u]A/8dSj"slMB(LsTR[o
c$0;N*bJ//m@TKrPbB()Iki-@fcr7/ef+L_r8R*!o(?kLE`=I4?@%\#Bn0r=Q]AT)PoV&e+R2
t<F#6X$PN[\D)1_[$6N0Yi5,X0=G`n>0e1Ya))a@O1GM?/N;RE`I/`,LXM2AB+0-&*DA<h3>
Dsem:s=R>jCfJL=%QB3(q:NQSt:agFGp);@ZG7!N#;ES^nn!WnPQ?9H5r6.2c_ll*l=iQR<X
/4AH\H5lUr_fR`RkC#JSNNOTGlKb3D]AN?Y`KlM%&&"mZ;g%CU0"BKn"en2@-=r4''V.@Ap,Z
KVnOd^_+kGcPW$S5OaTY;KsGI,Wd>Ahk36T:Je<DDY<gf.8bP$7]AEVe)l,PY=ND,h%qdS)f5
%Qm-<t$3ZWNDk]ATLLf$.A('?aFSD>#+9QOW3^qa4/'U;8Ht.W(p'\T_@^P'g4(^:V5DG*uZ4
+%4[S[<JP\p)#Uck]A<3=<MCE[YD8k1%T&Hk\CEg4#.C<4O[<p<"3+KGo'T+e=VlqTm=7JRAo
9#AE[`VV%3UZDaP#+!FSe`&mH/@OS;^.e7HI`(P@F0gW<;g3t:BL^;+U#`n;7=__9V9;[;9a
/49cXNRifPi>Xaq-eWW*$@#t(i[CT7;)G90!\:'^sG+Q`]A?4YAiim7D$F6S*:k=kp/E<ZcTj
gR<]Ak<#j6@2is8j"9=to_H@VjP]AN[m#PJ@g0ME*2TX:[ib6SZa2B;FeS68s?=cE$Ln]A\0Xl*
6gZ<W4H(TYe%O+c%T>CCo7[2gOQ4$,g`*Hk^#0jW?G1+pGq`@[^fmRn2.GKj1Q`VLW/rc&H&
2.QYFfIu;-N*<Vdi<CCLjom'"6nD@D*<'+!L;_1@;X11QfA)6Uq6,t>E-^4kE_TF&5pN8^&6
llegr<a(.V+)hOq^Wji@=+Fa7t7V<P(JfX7neSa-A0H>GnD4VWL+?n@XL>f>]A.N@b&f'A+(>
k?_u;o>.MPY%CZ[@4I;pm3HAJsh";IanUc3ah)**+)Y4i=l'4%=S@Cm5?bjXirF.4D=4/PC[
*X&f'\LJNQH5jqJKnEbnQ(]A2*0ir`eiut5"(Ca77Stp/sW:\fcii8(Qaq]Att!*Q%@9erYdF6
X4K9.YTL#<TMA9)UpR+J;,F-_:1jYmM<_i49BLNMT?q2ULS7p)@A>Wgb9@0GpZI:1$;09diZ
?<+i>52VXB[*`SBkpI:b+%5S"8Bi:I_?$EK1C!^9qX1X@UY^U_>&$MOXOr5?015cMUcbpn=O
HLfE_Mr0@-KQ15Ksj89Hd'!tC[#6#oTGt#m=!e-:Q?3mkFM)<6YELAq.UT+'(Bt]A_JmWL=sY
#M/E4n5ngRA#VsFWs?<''N\6T`"NH5]A?S3G?oTe0[W?&A1K0<r/1j(8l5k7`[q^!g,f5g/[e
E;Rb4R#9Vu?-TRl!0D&V[TBQ=Wu0hq?itUP;-oBdFAHSdogn._mCGEA>-]AnXYP&'rV#Ph]A-]A
\cK5EqDBQe\NROWV>Pbk\L%,!CB`:n_A-MSCi3RXUe_[T;8pdM%[?#k@i)3%;#8:L^%lG9s_
ae)_Z<0otgqnsQ:VHO<3LD`)ttn.<*8ie%rL:W'Y7<1T)NflL5We"f??nTLO6oNM&k+\Ie.M
@CtA<_Ytg=pBCPV5]A&&=EA\\&_/5ahS4f">*1XsIgb(/KYFa4Q2mRq<b?'GU#O@:hp2Gab'I
&1P5]Am;6StVplt%'j&?W8X8dM"u_>=FLWV3$>af4jUF&FZkmQ+@@_<nIdc?,MR(3L5(h8AW'
(P7`mp&&a"6jsO<1p5kd]ANF=NUc$"pN5qg+^dG*YVN2(T,.+'P<gg1@W9[h`bX^0ZHD.$,7$
1$^cOVl/"aA=9LUMUV\.e[Y@bS_UMA5@T2@U`N!#i"G;+gu'mFI,2j/@g0D^O"_3LsPP#m9n
@"=)'6qCc)-p'7+H)Bhg:mKgKpe`DnPZ.E1FJnc4j1V`4Lg]A8uTIW&C^kI(+_`Y9<N$B]Ar;$
@V.Xa\<j0YLS`E>"EYJ^U.j."SUj3(rIA46NC-)%/>a@9QO/YJ)qJ1rK8.=1Qio`E]A*EY7;]A
[,1WFc)bV]A>h7Ua/:J:2?^SR^G`T!96f<3,jC0&h'0^)+Ir/0NQtK,A#fSfFBQ$cAS24i[.*
.!`pLgSbDKpE4d&'b-2(r]A,G:'G&4_jt+-J$c3\1.T:$"]A)Et@\tj>^4KhQ8Pg[p0lg@0c#V
gq?oP(s=_ie$U;JI<Q^pG2FcY`E64Xs%7<,TWiHMKNpJ[tPHZ@(u>AV%!Q;GMqq2T!6`=mjs
&V5r*+1CdC:pD_1$n\dce67YhAL>.sD=;[9_"@I`H0!qgY/'-2<<Z`6`<]A,\8;pfB_V)ka?1
uqGZa!L4$k4>Nq@Y>I=GNT85,*m-81S@b-HXYf;K64)8q8PR]AKsl\3j<8.j98YM,eNnn1*ug
M'[YlaO!R)BXCgaRF'01i:C.JBr6kI9#-6f3YAnZgdAml>QWgt?HU2V?K@IH9_#PMXlT,$V?
7#s9=P7gJS"_tE6pq>o,@D+91l85^#+&di&HmF^RG`%f=aZi@P82]AT;-m.H;q$K8-WR[1fU)
XfBVg]APJ8>/fIY!fI`em6R[DDET';K(113*&-P"j@?i4@_OKf@L!Lc+P`W.s+dF*"Ero1S]A%
^X6It&^T*1h*%`-@EC\.JG1U<ZLeRQXa*b/%H*G<GPD\nPd`%8.8_"g^-@QhHT/Z,cC<?)QU
`EFL),K/rM-+ODlOXp0U-EeN]AcCiQ`qc-TMd;1f]A.aD*3o<C[%:([m8r7*11pHUC,GM)i>3)
8ar<.-EP?@(2GmD$.O_U/u&1"RSNEP(*9B3o0f0=b2,tk0gW&nos1'JEaM;Z)#g0BN7<ZXA*
8$SWKf[:,]A-SkEVWS5",_5r#6/d44$2ScSbNa5o:camGa&=8dG[DjQT]A'T[LBntYQZN9S_+\
Nq>DNN`e;9?$ND&qe!TeYG'p*dck;]A/3Qj:;/]AC7$h7Jl"9H97976J_.>NTN"^NE?cLZ@[,E
`9?nRL!_Un1?gk&q7?/<^$t/#<H`?X6/kdB?8bYP5NeL7h'N\kk#llDn+&R_dCg@I^9g,o\;
gdj7Es1\HXaD_uZ%3-V&s<cql+6.Q3ZCWGBA_O1PJa`3d<ase]A_uV-eEXj\gg5U>S5WYMBXX
GRXu1!`#^LUXm^jgpW<uS'_cKdZ"EG>N2a#u9)iobpOrc#-NiVb\^[qZV@opVtM"@1#?U_,k
OI&=1hN4jNjt`@k<`R"A(B:e55rE8+OAS/q;/S'Z`ZM2#h+f-IKqsNY7bhdEH9k4ecD3$/'L
0R=RPbhZTJg3aq7%+fc8cUcC3psud3HD3@"[QDnt:-$0%K(H[2(:K'@n'O]A@c!I/kNZ3o^_p
^$,7oK!p9I'@V22-f`WU">l)/R&.lPD<9=bb-ks62JFN@IU3R?#LTt#,%c9h'6@C`5O51#<-
B#nBW,qh;f#]Au,bs3hubO!)3/o$6IOC4l<%F(^DKe05RfFl!lfG4P*_*@I04B]A]A_'pKm.d#Q
ZqFKk!Zg3(K/46&D^Q/e"Fg@Y5?2ZSAN2@jBBaVaE"<8X8D56nGTD'r)JpIgi/KP.X*JgFLX
B<pge%Dh]A?qg]Au)hsa[#KBk+h&C9FmS%cAnU^ErDnb]AUOGc;OWV0Pa[l2#hO#T_H:RWe3#F*
:4?-M0-o`$%f1L:udgDl9hr9X\eU'q*-*9eN"5"5\Gnf['a$Q#)R0$/KV':-RBA^J8!4Y!V3
/6a0Js@?u3mMH+MAYpfQTaO]ADp!92F&6:I.MM,X4<\4`&&k>9g*>ANO:>h+V7fVE<`/!>ERe
sD+Q=p,E1`<N"$*gTY<#>@U0Y(FG%k"og;mn/<[<gO\(`01M..DG'lY[eq5fd.,VLe&`i<?;
b).UMchZos%RFp'7O(t(WFFlWG?GY&t!""0oD%=o4DolK5H:I^men:fXO?[)^.r*S'C>+-[d
cN<d`5)'6@JeI;HX*Qf8Yqh&`j3tL>?KkOQ]A/!aP8Z"+XMi$0"=9/s8rM$#lV@E6^'Eu.PIh
7,.V1M-)\'IHVUMb&rib='2kVs10d%I(*X&o<r*$(-N!8+n.]Aj(r<O0tOaEHL?`.@GQ5@E@>
\qQh;ZE$*O;?A6[C`8n7VUd+=a&<L?TrV.W-L1!d_8D#3694j*a+p$&*,<.m<-r/ep,"aJ&d
s>R9f^^\eR[7Ze8D'U/-@<Md$qjWR&_jT$Co8t/m!c1k3_,7?"9KeP5BTJ\4T4k"iIm=7-Qo
8:/jpSL0R-Ao,giu@P6f`GHs&2.*L]AJL)5b3uBL"#M^VSBpB.Hn3]Au%,o+I`;UgGIU3Lnk)o
PIDUq(^S:MC@+T3cD2Gq0*j%0$W<oOhOgubo\AGEd*(9p;#M/>.1N7Th:*IC+&bq=@M18:O(
[0]AYYJ@H>%(FrN"a\8X#oA=4=EHDlT=0UAfR_MIRQTEHlD^";mGu^=PI`l&u;MJjN5FYUKo(
icA9bma6n?U%>44okO#bi0_9-N4=6,)/9c"G:X)mcPeZ=hP-s2pS2V1N4D"sq&9n!F?@PA*O
@fW4KL*W5!\`R)ZEV>F7d3@iA9^Q^\PT5R]A/=cK1cO#Rp)k%_!A195&uDP+n(p_W[I[kl1\5
_=>"a'$coiFK6FOlG*qm*g-?I?q__N]AH1fY)_@41k6V$k)9qPB$C(h1,Wb-L>SrCV'dr4$o8
RM9kW%A?u\WJ/n"+j6%t=t0g_is1Nl=Ea\3F5f`<-AnZt,hV5-i:*WYV\%uV.QdbQ<c.*UIY
.=,=j3'Krl0`Jj/"L0d()f&r%t=W\JXGq]Aj=Y7?!Ns4W>"i).r$mijI'uJ3Eq`+?r2BWg9lF
a@BXW`BV#3S\%0uiEN"[@N$F>?"GD<Sb```d4SF8keNupnf";ooGdbU('O"9iOQa@>2Rd[>A
g"U)Gai3&f9fT-WjpLJe`Jti!hYjr#-*$HdS?T@NrW:5"&8#&HL^E3gW:p0]A`#/>X\\mcC\,
<EYb(ib+HJSKSLD0J=gi.ubKX)8.*4$$c#bc!5p?2K;0[_*#:Oop5&KY7@m^piM+pu-$%USV
]Ae-9<%>XA)1sa(`:MOS5[Lbq/ZR]ABiK]A7_9TVa$n*rY<`@bo+i4:uWK%h=."aob)=/d!njl&
5H$;_8/Qdm!GZBQ2bdUY5f40]AN1(I":Nu!Ya!YaZ.=kWD*o#?9U;&R5dFeI+Ug.nb<if4Mhm
;OTIo,nsblk,M@(W="@'IN,9!)`j!K`@Xlrk'0?q4q",5(8!"6)oC*j-FoQX@OWJ0m=aLW[%
I3pRQ2*0IGE(Xfe]AWF1l<D=iPA<eh.#kp_T]Aq9</#L[F9tR$HVo3$<CP.^qMFE\<f`bY(**K
_Lg^>0da$1#@&h"0o39G6?(_-/D2re7p$i&DJZhK;cfigkO6h=rkM"lmETac-o6AV!jWME.c
FB!dMY.]A?#Q6"%-kuc5YXb>uY:n/oR(&asO)-Z,e.=kc`;H_"<4I6RsUhlI$=8Ep7Rl+I#7E
7MU%GC"trt%9Bk7R#Uk\\R"o8D#'$bdC0rL=LqNc-?LKXGXgPe_GgH2i#5)-FWu4<TM1iAQ:
HkE7iU9bMeE+Zf+c^[7.'G6ReBQGJkhl::/m[@>"i,o/r,6k+WVb^qgWP5Y6u*:^`>s"4f?E
"(hlFgVo^qs'BfR6*)eIJOY8(PWI)I8\6`BE'A$ML;W!pR-1u$C:lR>V^Mf7:#)I.um;:1(!
G1(sZkT50-nfQo`<,=4sD./j2DtRaAjUaG;c105UD6MgPB(;B9#57&1Tm&[rHq>;Vn2-c1<H
"_$"1'P]A:-Yl2M><+T[i;K=]Ak)UOP3d&e9#JL@"3Vorn+>EX6L(eUeDqLh-D)bUS/S5(TBqh
pl'"L5J]A!ug0tY=Gtthft_*jUtFiSCu*+H6]AL),RK*Ep,H'9@7FCba@W-4G@FpN[;65n2q,,
\Xn]AsW:[=hd?Tc.]AS%kAu8A&qo9k"5\B:QC9d*6+,`h\9Q=q(=cSSFs"Ut<E"\f(a)A`O)4F
NIBEb2pgK!AK2s@<AYTEn)8AU`,"[Kk\AX`X.c'?O#osT<l(0$5qjgQ$0W_;Y$`9^Bult\_J
raDlj7mLV`>9Ud)nlffj[kX;c5EZ@!If36-#"&\,dsZdNKij.e&,5C)7C0rG3j_tA?cRGgo3
`=V?_\O&qtFu]AZ(.>247G57j8)nubRbbG?*.IP56Te6OFGO?-5^W]A8o*FLucM#;JZ0k3$6W#
7VsXeus9eGB>A/UU=^N)#Xk2AiHWjA*5U=eZVS4+.o8P\58>'g(u`#SB0q9dg[qRXIaU,.:F
[r/LOTC^Lh`edm$^bFIUToB;(cJ[;]A[>W4^f5/?c3JAMmFU=2L1\!N.#VuNlRU[$QL)V.6_^
6PkB^eE&U_bJt)\$bj)8ht`tqQBt)CcIPUGY,!RJV>[EA_tI7\qRedDa=;(8d,%sFUQu0]A-=
^5[6677QY,g@,7_+ihb[l&(QE_XVH(^H\M>0N4rapLME*AR\5I'r'?1Ch`dI=aD<'T(Jr6-]A
HP6Wf-a:GEMJsg"VRZu@i5eIWf4aP#iTs6E/D[+tk`N2+7kst.+eqRH25RS2VhSf2cq[$+oO
_U`J6*d6E"AmlX;Ct6BO4-!;Th+:CtF+9q<'CA&O^!?"DCBA(P$.TLZAM:XeRg(U:Q^k/1`m
ZUY.PH5*3F[Gpfqp!Y0?#hd]A(E]A>*3487q2*9pBHfOM`_"'T*R=HM8GVE*sR`ZJ^G>['^s7P
]AIAs;5kh+qPtVU`Ws[Z6N"Hb^K^t0P_:r$A"Jo6+cVkJLa@\pnt[BYas>Rphn+nYp=O6s?KM
CLkR[2p;W%_>&23&)O.Q:W=`Z+,9860lmdmU#[hZ)'n6nq_LgNQ15lO`<TJ$ll!ck&uU0kla
?9([%Ps9g2i8f:k]AR(isMmX>oUHG`1iJS!S))bVp`9n4"VXPnu;>!Rik[:a]A^:5?/H()+2!Q
<_ODV5#JVN.pjbUY1"I4G&qaKH0J+_^GcMp\-nE\YLaZCAHW@?@`Fn&Al=M\V;916N)%01.S
/rJFT>dMbeSOfttIgoY"20'E)tKlJ+\D*B8,GCW7BNr?4UR$?kd?47F$CU9s_lZ7t`-.qH`h
28+KnVZjp81C/f#f4(A4@]A@Z$ErH<?H/6@eu9S\a9mf8n%%Mq)GdVf)YOJcZi4.E-T-a(*_R
"2B=VRW$@1_3Em_&b<=tK74+2oa]A=L*SaW.`OED@DD"`cQI<;hZ<?"onR:P/Y37\gp2-d&)>
Nl[/^Kuh;`Mku^rj;Qrq\,NTaiDuP-D4>.*Wq^QPMUf^*Z;]AG7hD^mH*%lO8#07Gkf"]AZ)'R
9EmRPHC,5[0o3h?O(Xg85UGs!E/sepJe;jR)9`W#7$BP?ps=/9FiSA^]AMdR0j]At+WaM3X^>4
$4kMj'aqd@h_OdsB4E]A0c4,ukuQHU"r^51"J"cRkAPl6Td9H;0T7Q]AVkdcX@ifr3c%kba50=
.O^5]Ajc%T,)/m@g;i)+W6]A&).llDS&S"72V7O=uV4b:dg\E@gn`?L(ON3'NDDI4jOtYQUnc#
cXJTDJt3<JO9.hSK'Ab#Y$o[=S!B>o[Zr#,)e(rP[^8nJ,1*]AbD\kM"5_9?)E7:1YF%-fE9+
_3"JMh_6H?[QVXV@[GM?$OdM[.DD5gknsGJXOu3-#lCJ+2hV:%'QV1eLS0i9[MLTL8B<ui>D
`?l4I=Wq9k9NciUAdTMl"%f3P32pgS+9Iq+4<YboY-mPd%h\.e,527b&iVk,i#G6HQ1!0"t%
q>f.[G4kfJ[Q-q?6b.89AEG"UskH6q$23XR@r$Z$r;s2(kGC"''HJ@&iKgT^3@2"AtoT*S@p
jm:s,+GXJLHH(HVKtrF<H$"_]A9raC/@0henR8XHaa+DVZDEJq(7Md3MYs(291`+;k7AN7:.o
k4C5mkSeJ!.gk#ih%4u55@L>3ETjMTfGr=%@s*IL<8aKt'Cj3gHBbT/'.)p'\5TcprGL^3ap
8sH52&<J@\L99QBMV*eY]Ar4O5`sUDa<k!aWis@ef*1O\5CrcFiaFWu!lu>_K;9A<+^a[#tr:
+9"Z4o]A9#aYHo*k*N,mAi]AEcVYqF[">E8(r(o$p(6)jBgS)aM85a.7eJLoG`%=[1Q'>SW&UH
-C^>Bd*dsp)S*k6_4M0>$5Y")5ck*O10VW[=EFT?W:I&@^$D*n0VAnS]AM?h+!dV;XZR/UZS=
">-BU?W:/hW8JK"AEdds!(hqA<2WH<'t3Fn#@pI>'1/H&O`V!:Dn-&Y%"r!:(AH]AIV=S7PpW
%tI.QJ*\S_=P1g6bY36UQakZc20?M-q2<#i]A=KDVDrj7$iWqY_IC7qpYhf]A^&R`&;R`^'#p2
8?3Y>1nI!S*9e+7KBHVc#_o\5I-f(+c<re4YRUH?)W)!e@lf%K_/N.ZVUMQH!up.D%qT6-DB
5C+He`bg>#@?AbIV<M++E-eAFt5o]A@6A9ZjVjpa&H:87V5kXW@LC_+p1HoeirRlbTpE:P<NV
d9@GBS:%p*/X(LtuHX@WhJFd!N_q?!:RXa0>H=UkqTbR:SNUMj.%hG%!1;o6uRaTm-PKZtp2
o,R`_JfSAoL6?c)CIT&V_2n^oAdS\Ui#a@+-ir^4,ATt&Tt_uABO!t9(gt@V'):bNkoF53?A
/0TW:[UIIQG>;[sN>>Zbf,`5ZSN/(PFN-kt2.6+<d*B(ue5&T;[nVhed*W;9unh.`RYrZV'S
-Z=c5IIYl$$=Q_j;WUdocrigmlX?O))-&.*hNOY"BuBP1nm0\hQ=&`b$_#3Y,M%*'oe]A_\Fh
j5s;VkYXR?/_.M&q!KMqbJ3DjTU/!S,Xd]AkG`&6PpX!oWSptNe>+39GAM%oAnnn^&S*Q^&JK
*^k8Kqs7:9mrF=jHf-?bMWicqjAXT<I#tD-M':F/ZfB(3UP5S_S\VWi5J[PMFp4&CLIc,pJV
LXcccQhKj0_959s&%P2$1Up0mf/CI?ap$9]A='_#bO:hQfj^iH`B`DE>!2bm#6-*tr&j%Lo7(
NEcNNjTe88HkE:_@^E5;JWf6dS2`s<(ZNs$FL>IB?,Ia#)Y2",P`(LA!K2N@]AOeU-=\W2GRr
h6sS;n(;XR9smk]A3nE?*?T59c3-slhk<KC`R4AIFZs36PO*68+=J!4[UZs7PZOH678:L$XFp
pV3\p&r#^,nePf%Jh]AoH0ZbOp38jFI%uXP35A/aA=l<jrfQ_2%Q+NB2tt9"n2Cj_XS^;;i8K
&Q.ITrO?g67UPm<G)!JqJZ[tXC<s8t7\OiR$R_lX5&*StDOY7W$O#P`s/dQ_kA-j(Ao@.@r+
?%)LA.nB<lufbemeX+!Y@ZjKO]ArBiknj6)qKZJ.AkLD*gH2Ut0C;ea,N>MCBs4@MO&qBgp[1
/(Du]Ah'/[2o-gUtUVMDU^8j!S!`%]A;N5q!t:DjN-9E6$sdnkr]A35%L:OtU1=R8NBTrfe*]AqE
?=l2gW6NLRAch2_^u6(J#OUnT2]A/PPP+lcQq&a]AZs!J)M[4U+9Q@oY35$DB<8o^LFhsS63_&
Y*_P=BUH`f91'@<Qt'3a)s7lY6Z$1Ye^$%u5Lq*+3s>n3EX+HI0?4-[He$$(e[%5)E^)caJ9
'.5:#up#gY>gr@Rt-d_"35oh!6cA"h!bSiG0aQ2_)d,_b1IN+2!D3T0"5mP]Am<>h$V=kMP5j
<NK-GH)'t:[uK>T-Po\1k3+Nqq*AHj#gt/K\@F,\j=]Apd#7COPr;3EfFa\+')dC=:6i/XqkA
!kngI.#np7Ab*6FbsQ3pg(:,iU:]A@4EI+8:(urG'*'n3b5h[.F.KhqdoCJA]A(fR.'m*HCVuq
k\cG397#a;5MR^M78<3is$Pb3rttmfC?moc1GLuB=WLDG;ati6.Q3($Wj2A1b,?1>%]ADnkG)
ZM/C8Qk%Zbps)Sb2:fYP&*jA[bN.mO=nu5OsVX.L;F/^,_.@WH\^AVuTsVA]AskYQIe:6N`N"
16sTYq:=-4qXpY"q`\70/[U1"/48DY5gfsZY6C9W8&[N^(h_m-k@la-gqqgktkid6mG)X)3f
KJH"Q)Q7_h6rE1o'iVq\%YYX80b03,>W1UZ6h1Q]A,R;+L&gYB:42#XZ"NaDc4);LfO3mU<u;
d&d7^Jb9XKJtG9"JE8Vb>aW:;+K>d:$<8D29'b`..PrOC`e-KVAfX!&5a$^7CLLEu't?ssAG
WHWgcg<>EFmpi68HG5:]As)<bS5If/EVUlK6H5IFLN=([b"YsoG9Kf^ah!5XqZHU8lqYdc"4j
oEQ_hBPo23@p8aq4H=]A#TlPNU0Uu47*iMW3=dWHTCHmfIHGuI@o6)F%Lk25[bZWniie@S?lW
7T&7THU<&L%@+A5PHTb76WZeYjZkQ*N"b:j)-3FVLS&sc=Z[*,MK7i-EA*d6cO!3Z]A![&\HI
WX5qjr2U(d(A_]All8$XhjoFFRAM4H!#^W-et"id^Q9DXD62')ohI??O)oV"`dVOre(&o]A+EZ
Gl::cPXFqcWBHfq63eB.6qW]AtG\@mqJ^%gllGe-u!+Guk/MhFOjImZIBA6,&nYX*[9JBM^KK
d2aeEnmPQ<bYH3,PBFb+65qeGol#O]A2trGG3gKr4,#T=B<C2O_7M//WU*OG'#iG*ap9@&AIE
nK0s5)%*eheS2[.%<3]AJefL2<3@gj)#d>2U,cH]AbW+@%]AjcrPuD=ilmOp"f1li<r$<XB'mN1
DR&H[RNT#u=,gYpr7+Fc,A.[8S2'pH(XbA"ZX^,PrR?N[i)N1\qnU3(-L!-;f>NeAGs)C8D,
)s@hH<rAIp=8p9-=js`mJ5/s(TX96?N89XKZN;bSI(WRo%kA4--9rdY8*,;pH;qTJU8]AjK2P
)"T50]Aic+O,ORALV[5N9A\%+Je_:bUdFLqi@=Ch?]AQ2</ju\=@p$Hk,D&q@V>1ajRCq'UUXJ
5Y#Kf#oM9t9/ghoNK0]AE8EJ?HBp\SqP=BZg<i*@iTrD;DZ2O[j7M+RXYPiH&C@[c]A4*\oh8.
DoSPgt=F^\A%6+7EFk[qk'nBphHpp#rs`RNTnP,^E0>YBtjYYP$a"4(%JuGVBpZTqa`UA5&A
i@]AV#ldFB@kcK<YDbD4psl&Eo^7Nm8i5P-;H*sZFQ,ON5$[F5&"cYfiVksrl;pYYpc5fU+!N
jmJ_TN/pRqY%BmbSd^^W"Fr*gF&0XO&p[sPA0'#3O7+FjXC,WS['N.8TbOuDfaPc?>CRG*%t
`CH[S:GJ(NS`kr';0EKVtQIo@/Kmj!2LYfDpMNT!#tGe06f.:=s0A@MSg%q4##2.BP3Vk&kr
N=lFm1IChJRWV$C(^3<8Xp8l&/D@W^N?mou$cRmm4YO#9LfjrYH)o8S'Y4Cr37"]A_lb+k9k>
X/tf.%Q_K=Eg$R';Ie8D:3-`A?!PeU9uhhlVGBJ3Zq&\bi10*'%SoCVPb\1A(f\.!f/Q\]AP%
9kCN<h`o:K66.S!J*kOSXo7t]AC;\J9>[XB7gp,XR5;*XtKF,s(]AabU+p)?omGc[R#@b$UX1#
AVjXlgO*qCFoT"bfJ.fo@b03Q<UVp:>Q.KTB>>D+70[:DeYB]Ag(@uaA`o7C,dEi`B,hl=YI0
4!?Dpi[@/Q$^&j`[=YRcG7G;V`.2t]AC^\G$kj5Q'DZieoglAkge!i^;p4S%P$GVQQf8iXZc^
S#Yio[t'O8@%g]A)mX)6G4L[#n0<SMOg8`7l^SgY92$_=j7dj3D;BT4"=.Qj*@jKO@JEOI&dD
Y<I>5*#&d@u%BjnqD9=ep3.b$'YKru9+ZmR%jkRp7!+"q2s=GAPS8L>(`ehECs*53L^\.jOY
+eIBQ=ahq;Iq#pp``p2g-E+8L.FcToO@rdMM+5m0)<-mFJ.(Kt4[.nL&`8[AR7g_trS3Q's0
X$u&W-Z3bE1B?7IjFn:1UYn'g2"`U#f#ma4MPs`qg#"CO'>r)If"O&cIe%Woh2$giS8*c)OF
b;%.q:/-ZMaUrZ=KBG$i!_r3DRiBXRY947_G3iS#lYg'jIZh,9+FGP;085]AI&F.,%RpPSSJP
i"!S/Mn@G)MgKFkGb@mgh1Gi'OA2A1ID>aJ^"3-<CZWi!1Zt:K>SGDJh]AB9XoD=;^2hWS=9A
Znk]AUaht]A6I(]A*r)aAGQLCh%IDXpCFE%*AI..>q@,+';";Lh4`pn.U+2ffiaD.0O7AF!@[PS
s%`A<!.`24C4_7Okk(:;CUOP(2lZq_52L!ni?#gKWF,0Kg.foKcYSc6PO#d"*:MDjPA_uj4e
[AI@pS9.[?Pm"`,EV=W$EX;S',MbJ61_kB7-2OZ^pt^%\Cf5TA)!l3lN"/?&D6mBqWRImiem
'Dd]A(Y7cW[<RVu,6s>=XBN\"5I.H56sePG:N==(d1!K?RZF@1Rdb#n*Li_TmI6(6qYFAUrjF
Vd@h\jgp%Z7"&:*#^EudQ5S;TO<N>$ps6:;[F=sB[#HJo.XQ%ZSAlH'1#9CPq@;!MK[?2O<Z
T9\Y6G2BSsIneZsV,:6O'_Z@n]AbdG)Ui.$ae':R<1.)LRZO`,.e)7T\&jd3_"/gkE_QBnff$
V`uNX0pTcLsm^K;pRDG#@.dg\J_tF%_+f@\=jPd_]Agk:#KmM(GcP0ZmXV*0"@B?l4.19Q/9M
8njbbh:sAmSBPHIYu)6PD*RtC:`gHRYt,WX9?\[bAOWq:ZiVc+%a*b(.'!?r\pnDT'@KSiU[
k'=Gt.#k*$4Dl>+>C:2/.'Kl^*jCoV9mMSeC8>&)>sl07X_s*ld8_]Agqdm&LB[rhYde`9;SN
&NCoD5;(Lp/l*U%i]A_`TL6jm2RW[UWX-`Uo<>mgl4m!UMVUQ;HX"6?C,9:(K0dn@C[L_W9>?
caW19tuYUWGhqA4CBhpLr6,h)?P0TlmDoT>G'@YnGKJE,p6d33n/M>lgfP+tUJ"MK<$B<V&+
[VcCC?I\M%OU?J9!;1=c/*R9p,_;O$IaP9qeR%!rU-o)(?B6X!G5TR+5b>Q2U?T2!EOnM0&2
A@"99b#R5cp'Mc@6H9VqSWEd(6A7S(0V*`A@bFH]AiSY:aoTmi3OPGk)t[QNp=41Wd+p$"%Cr
&6C`-Hs6./5t9tIQ'HG>sB<qcd`&piPc):>KLh`p82h-VbNi[\0cZ^Ng2E(WG(e79=2Kd#nH
O`/;B^Jl$c`of_!R[25*)n"Xg07H;R`Rh>iC22=G5-;PDq31#Qae-Da'M7EEapJgh<l1:@n&
kg`nBtjKiuhZBR/:c]Aa,4hZ@qfN)p`kMF/BK[Vlqgr0nsJ2R^0en[<,LUn-BgM))M[1<J'D@
DL4`2$SS:]A[>_;\2j^7F'R>^u?AT3A1,=^QD,>[,G4/D1^F;\[DnXUb.k5<Q)<]AgWt9W:Y4m
[#4_bgJIRSop9='0L\hMA^dZ"O03:.>NE/'jFu\!s0)6^/#.bLL2e>R-`S"Ck>0Y]A6N/D7A(
b[g^jM_p72gh:f1Z",eZ>oL@UJU6KG[;KV#oqjSS4399;qYBG-N-ANW0ka7,?2VA?cTqN_]AN
o@jb*G`/b,J/.TNE=HQSMp+_m(bOM7dJS;o3N@V3`_D?iirMn\%smI%(XWaom)mrqh3P'$<4
U?\qUBZ[RB'r\M3Oj_cQ)r!Q$IPZ@sA_:bn\D<&XS9d$;M?o5L^Uf3e&\M1og'9J9Rohb-_7
)VmMS6T7]AOGn0";LYO5^$^*1=W2"s,4JZONq#!'i;L1BK"'tW&h(iuf_9_LWk9UQ.VHpTP/]A
hJ;rbo3FUcM\*H;S>u9XEX@O,33m`3fkl*B$d1VbY2#nbN\%Y[mQ:^!3*^(Sks6Q'1/!hVs%
J3OfOj&TBIE6AB]AZK-.jr(J5Ae&='7!q9A!ZAP,\6<r'R]A%rEm/\"c1dGs%%0*C.$*d9g*JQ
aiAfL),eFrPN2a#_l>ka*GsW;&P'O=_[6Dq[:i:B59W36WC[<s'0:<.?g^@/hS.j<mdkq<h0
#Y.H4U%6>ZIZ)iT#pan:k>LLHPC0%)Z/''O(*=;jtR5nA!BCK$:p6Lh&N7V`'q6KLj1kqSR@
@3^<4=c"YFc-c`XfaLaIR"93^>+3I3!XHR!k3=c)Dg\IPh0r78(1\gG+ptY+tC4O;&=#F[jW
J7PLenK3[Q"V6A!Y;T_T:-fQ_d6+OXAt?:Ei=th5SE\iONeX`<aV/i'aCKHo4'aB?F.f4A%B
diUG:Z8X-($15FFrVq:8N5`ehD%'ss`,7]AptQHK'E=F>\l3,jof:rYS4pe6%SSnK7TLGkW9K
SFMSE`2i\uT,hNTGKZK&-mAoYHU:%SA-7+%q;7mOqMM*NKB3AfDCU[k;Y0-qLH$P&jML/opR
4(d1J<obYU`eKKce^sS)gNVXTpQ-e:([Y+b*<H[Sun@>@Ai5?F"b="%F5j'hSP)AtQq^9_^8
55IOqH0WP7n\$Gu?=kIG:FZ^i++KPasG0[r2<*5MY9uj:3mgk*Y)Es+2rJK0JLD#)g.]A]AH<+
BU7$_f\k3bHJ;<SVj&nA!u+MAr!ie@?o^R?47p0TG>!WS7p_J;0:=uET$I'^f;J6?r?@k^.;
_fT2hVdPgg_CRmiQ;7X*;Galm?c`>4+o[i8or_^:i/WoU\mI[`Kd^RV^X1_.Rr$(^>.?TO^E
:jedBi6[`8M*D!ONu;:fG2`57D-pYDr&[>Z#g_niEL1Y<=$5fhj=o%IGem<2<Nf*?ON1(VPY
'Z$F^SKGK.$'jk?"cSV)8b^m#:VR)bTl"U75^%PQ>htPsInk24CSIpK?F1Qb3Jk=Z?c"a7CC
6>0(guVd8\5$,\3O&jnSPYhV-dS=K_I!^S^q#aL(cql;!WH_Q#4pb2GcY&Lr@l[=eBJS!XQT
(h\4Z`uu0?740\6l*N%iN"("K6o-0o+4I(=J4kbM61Cr_VZ*/3,IjQnF[N8Gg[u`HZ-MLs*T
HlK^W+MI8*@<'21*cHbW=XqnE4ddbDMo8r9ije`d7p5<u#k<f0sB6W45653Y(TSJrgF?R]A0J
qh@QP&(l\WGb*kYPfU.6do%d_mrP^t(hXf4aiC=iF8r)LJSD7`.8LfFh`r\Z_#3$Oq0,mAL7
(Y^Uf.QuM;/%(Zj5H[CE/e.^78A+f8Y^^8EdE0/i=MlG)lmtaW*:!q9d@o;<u*L&t"'2ds9L
dk7j"Gh\2&nC&L'="oeuC`e7;JXWY!kGQ$:o>E9_cEnN[;rhBq>3XAS8A9_ilGq?!9Z4X]A5_
-^69Z0Y@4(Hs4t.l+A,n<DHLb76.[C_t>jm&.&QVU\`1-b0)_.G/Tkl,Gki7Qofsi'RKMs4:
3^@C58;_$I6sK!TO.m820PoBuRXXPM=-WlBeFiE:PF%)"^((/jU\g7OSB_l<FhN0U1T;4,>(
o]AfL";oIgHnU@UkqY'TF$e.\DN9nKJTC_i1X/csOeU,9A!jl`kL]A*7=da^)c]A7^)N@#Rsl?O
3p_Ff7C(1`C]A_Z!CaE+<!\?cUkIIbr['.ia^JE`[ldkdC@oOPtKD$L4]AfgFT.SkUA_Q[mOed
5"7t?^rh"?`>Ym:XgM,aaS!(E24J'?L)d^2Sq1K(-fsXB%?3kgB7MD,9'q3o9k5ponFGI825
>\\1gD07SRBaee(lA_5P4#ON>%[djT)YE;/&DS)F3Z"kaL=Q2j8=+sqfEV6N#U!Hm%\+c]AF:
u-_33pJV)_GB3WE"Bfb0J3Z6:7RWN+G4Foo34RQ)$:r$j0EX'$bek9">DbuUg`W3k9&h!R:&
lMR0]A(-V'>C\oaFj^9_>*;d'NQZ2V&0c%"[fd)JEqIWA48?JdbqBM&]A4T%?2gZ]AK+T)60G?G
46lgT3pS)TOH@_Sl$8A*iR^j!^A]AgK8SjYML'>,IH`i-sS:5Hs:Cd*Iu!-S2(41c""$N;o2J
s#Jsn.2l2c=f6"J7J&^J"4[408#:LuFZWG&+%M@oQ>OXMTn48UVBqZ7^G2ro7MgTeoTNL>!=
q-DK+2=6'!RQ,oc&D_nYDIAeN9[j%,Ff"J!C<%5r'dsL>h:<YLf/L"F5:H8rrL@g*G."9c&8
4O*9X(f3Tt)2Z`'loPh1YWA_skdp-9;]A7fO"H,[?<gOEn7)%8]A]A\X[^&QqY4KriuQA8nc$*U
WulJhrdmLo,"qINq7k'+rdPZ8M[M"j(n9qq^"X,7-5Q^SQ/>n3a_hsGA8_s^#^%9,*M(hBCJ
T3([E2P+oQmg\;U-5cMRD-t+nXfR=7;%J3ICMVUj/(X]AX0%mhKq,Cq0/@2W8*2J#2Sf*#?^p
2#5S@G.ZLS2*NYZJZKP$Z@asmi,!5fDK4u+i)a-68@Q9)6Wot*g4D"#]A4Ji=o=GKJlC9T,]Af
S1N/h-2ACDZ:Ag/QfLMo]Ao0+[Po5p$AV,MS+dg24P.jtQadc;g1tosKfi+r/.7NT1:Ci%?a8
UNcTUhA>rWtfU.[&]AJXS>Ols/tEL04l.n$7+dWoVRjb5W:!_.HVQqYB4h-m#eZ@%=;g8GCHA
O.>*GrW*QB&M&F$o+MhnX1d*21LW->(_*:"pes?*C)'[XkVfL1T7!8tq?&V@Rq!F_f(Hui3V
UupgR7We0>:F'oY.7"WJTX##mtcMO?chB":=OBOT&UBY$p^I20A;(?%"l1#ok'/s!^=fJD:f
)qG0/IQqp7o"S&R>N,UZM(AI4f_n&\7n&hRURGAIIK^X=(^%,`e,Dk(pG,Eeimh9Pe/=L\J]A
%SDAmO>ZB??h9ur8-e]A]AO,5W-o#HhWi3FHU'dYnmcq4\9_OF3**)am4d$(F-TZpiEs2jUB%i
`kM&,1$22]A:)Eb]Ad:P\K>Y[G&;I9BmR209EZTH(E^UiUe/!'\=l,LrJS^>8>sS*J,d+I1O."
3pbHCPWIHHCf^q,l(SfN`ELh$ZEi%EdL%Rc]A>bo_FO02\r[K_uN>LfF]A2$*sI31+'oa2-R'7
f>q008\cEhO[d\"^#[0DT8r3hscV4^`hme-mi=C12->f[hjq/V\LU070es/9LL*8"Bq+?5f>
U+A[Ao/Wu`eCnhu8Q7!:1N2+BAj&2@0hb/\n>83Lcck4t\1%JO2)B*F)l-YjllN)JXN,l4TR
dJj7l_klJUam;^L?`&UbK_2J0Gbc-I68T%Ra>c)Nla8jHK,@@hZH8;Yb=5!K!s#&=rT>[56]A
J0?dMf9qcR/%Pq(?=a]A.o2j/%]A;a&%9H6$B-pJep[9]AamGV)n%&_#&Q<X`mncE6!Qot^ePFO
#qc`%N`MWd.$fSu7@Z\nd=^qGp?0-=\,(o_j/,g@IoieK7G\o&'eC5ZpAa4q<k5u2IATVp]Aa
XKJ"`IZJ@\*F>M6DV).]A76`/LC#?(0e"63bSan+5"[NRZq<c#\.YpZ?%+U9H15[B3E`h0CRc
Y8V&jB>lVX$AXdsqAb@JmZ0<"o'PCtCRo:nU?6j$"-rTp%*/VeGM:DDT:G_"*TnI@1TP^iqK
lX3P)Isf_*jV/BB77^ZilH:JldduEL]AL[GHH(**!"o[X'RNFF\U!hO(6)a@+"\s`3iuqOOQS
jT*q@G>7t*?2WqW<@i!Xa!I<_t@,8"<?ZU!GGWYhFO"hjrUmhNhPa^TnTj)B/-s0i`lrG0A,
W>$RQ>^]Aa5Ogo5+E#VAJ!e%oTe&e8kP7@MmSeoAe,!sH]AjD>[P>TTAr^oKdhWq/tm%)5P8o,
[5l*=X"K?o8o_$sUZ>LQf_I?K3LGZCkU=\us5ukE]ASaHN)*FI[,#`?';OC-<)floRa/.g^+4
.'ROIDlT.5L$c1#\<pi%corjA.h5W.r'QAY'o"5K^0&A'*]A@rVm^6g;4=W@=qaADR8JNs./l
t*S:M2snI?*[duA-ae6`bbKNVN6;]Ah&EMOjPUs'EMod[9`Ma6M&\\D""J,nZXGqHZ1a7\qAZ
s&nKi$Z9fKD):&HWi]Ar=+2[$Ge@\.K3l4*';-Yb.gQ]ADk`lG<mtnC2Ec/8<[9oFfjRWq-rJZ
?o[4$bE8[s0\8$\,`bP4?YTciK<da='*mVC7c`AIV".PeF_?aCcT/aKf3tfGa)m>hda]AMU/G
ebcbPaM2/3ENTiK[p;Q)Sb[[c-OQi7pc-n*"?WPN706[;XYOrjCtRGVoA?rRNe8bAbk?jE-T
MUM$o@l'ic5>`"$(#Fi2gXBn3Pf+84YcOn55+=_oJKK`YTQVD<5Ye<SN0DO.RA:le*fYm08U
%gm1L5Q`A./Aqf?1KHG!t_MW13Rt_Lf!QTbGoamrOj=Gl!#P7n[q$j)TdJ:7gAKcqd;%a8b+
Wf3Ug=aj)\-cl!:?.o.sJEHOf=d$5lF)^VKiu!fV6]A@LR#c5ElofWl$M*QNJ//j\-\'+;kYX
Sn7rCL,5-Ln3>VBI2'nq9r0^[h?HD`:(MDZ-!Y>&Oam0)L_\L%66'S7"kEi,6X/3mW7_PaXo
K95r1+E.B]A\$5SW1W./5^KA'?'4tXH&70KF*%5*IY+\4F;Q^b]A\lpHPRD-X,L'U>@@\EbDZR
]A0A\D*-W@2dmtgj*0smV0lcC3W(lXO^cuH2iK6V;M-hVb5nQ>(P._b!"W<88*;:t^=S@&RS+
C3>V'4"lP/@7u]ACJ+Ls'!YO!JDYi)$2?Hs>.+-<8.=fkrOTM7R,pH<52M6bI$dKIg!*]Ae2fJ
ATMn]A?iLa]ACSRmbaXm,ndEA!.9?A8&I?g7SUt%Sb.7SPleQLQV!3RQZ\QpHT()XH*k&-IoO@
ao,=MQqK-\^tTNCFQuO@beC8Kp&QNTU%rM&L37s9=d7O`W16CI7J+*OIkDQ&OXUc.%i"$haB
1k/j"-(!Fe*O6O56kT?[POsN&i9F[,:Mh9em23>EY<s?:_#j_.OS_O(i$TEGe,(j:oJdDeT2
^r):#O*6?$@Sj,hH#:0rcO0\X;_&V11nS_OG$tq=V>E9U:M$$o?Rjef)7o@!H54SRsq!MQ!q
&,?;-c/Dg$O,A14Cd&.Zf*HV6H@)J')TrugWoWslQ%I2+#rEDZ/`?]AD[]ADP\;7i#=S&(r_\_
%7oX.','A(2/4"mdP\d]A46gmO8?^JCtN.]APKnf^dnYTZJ_+ia71frQGBmP2=E:6g%oq1$c?a
mc*?C:Ct1JkZS$>??XB_^YVRd+)@)p*RC$\dsbcTA:4tnaf("U@b:F(QOl0Y2uH\u5PFCUkL
?V1.)(+l0kJIAn<J_Yo97YW>Rd3$8O/,+8P%M#GE@]Ai8nPGm<pG]Amn]A!07/Bfm7+TGWdS6(u
[Di"0MKWE\_1KO!I9I*q!`aXCt@le9\2U[g<Jc(@`c)+QdlLu<&J(u,-qLj21Ot5[E[u?OBQ
e?jm[P)Cd$!LE#l>m$i%2?)6P&Nf;)/Wb^Pib('=K&8(hjRSDp;UMGZOJk&A]A\Mujte0,*[R
`a8cG66N0"P_7j$,!)G+'U4<.NQ8e;'hg%*P95Ga0Z:1C0\(+4G'Fn,:V+'(I\`M.5bftqjf
^$i>g3Pc"80CFe0dJ*Xdcuip"Q78)4H-XponNf&>):.]APb+\,Ukh'%W.R-'VHn.[*CbmX4(\
as'O[b(jD8]A6s:W2aG=S%(E-Vec;8:b_;OAJ</lMLBmO(-I8GGXRS<f>Oq2iCg"5?%4,@L>n
'1/SrT+3LQPl._8BgUG+cl0&3Z(c6*/;46pprCU&Qq4H]A\i808mUZN^TJNTDm">@t!2e<J_/
EtDR2b:-lZcHeq9@e2@Q/W[^SQpV%NccpShGFPih>b#Mc3DED><]A(\ad]ApB>37#Bgj<_brL7
+lXKZM@)dgeSoU,\,<WX()3dVq`<m1;aLMD9i";BQ5'$#;*F:&Sl_spUgG2^H7Y5MaAl?g1[
;r=IAl*Y'`]Aa!X'\sZFJ"oI.L>VBBa<&7EV:=RBRca)/j)-[P!n*4G&2[]AE1Osf81A7MM$]A?
dg/)(l&@2?P4(]A<EB3+=HC%Vi#5)9]Ab7]AND-ZK+CFBVUSksbqiX*2H$X4Ki$+-OnV*S<V2qE
U+dEF0Ic-^/IhsE`it?!E@QbPJ.itH!@<>hA1d@ik=92HZrE.#%WhZ#:H9Ai&K^"1JDL.J04
A_nfos$:90W(+^k"X#ZM=\CjTkFfdrWNB;p>3C^Ynm8(Yp*NCqgf-m19\[*qY0mRZ(m)O7#"
$CQXu[nW+J2g2Vl,;lMAJdG#g_kriP57F7:TlkAiomb\Fb*W$8\k-cYn-MbW"i03nA_!)IDC
_443:XJ!3>c^.nA.T"^FnCfrA.,-'%FX#F-bW\@H1JB.6o$WK2Fb^3YcTPXej&5SU_9]A\g"\
$0!e$&d,bEHeIPo;C&+)[&MPZTWB*=<=b'sI)f6+Z8uhpIHa#HD@f]AR8+B%EeLfA$\068IJp
bg3V;5hB`l<`%lm6H_aWnUmrbmeTDCNm9)cU0k>)?[S8*17]AjX_HGlre.`d51Tk071A;UH7q
**#u?!Mq=iS%njW7g``R]ApkQG4buLL7L.)D<ou>TF+WH6P1b\0IKl`k(5%"&YqLVPRmNrA%n
YaDb`YVT'6-Cai%\OO&7lHe0>XlDN\)>4\"ms;eid7;PVIWBa1u\2S>p''&Ke'nVdcYD-f"u
?]AF-)30j5[#-3QN^Kq(I(+%+.0H^'IH]A"D^7!%"5Z4Y6uJ<t7/NAP3"j#@>e@s[nknYj$%`d
(V#F#3ohE:&VTfJ'ndmmmQk[ucuSJ]A:e']A@C`ebFk]AfC2UCu`YC%\biBYfn'P:WUQG?G$GiN
,]AaE&*7!Pm6S"d[35_jDDTKU/J.iVSScgTnCZ[K4uSqj0.5b#CapP'`tC>X=U]AbulLpsToM2
2O3_;45S'p!XMH]AI2M?gqh.M!'81*]A^+V)o.OX(M8[225E`!8ruQtR7G#kF%DOo$F0ll;eE2
%?U;3;PAKuSAGF\1eU89oXk+(K47t$?0[qh\8&?i+]AZq_+#'dr/#Ze1,bM4<hHk%C[F!Ne0r
Z/QbL#N^*5MS=OGc^?MSMUB*1L_XEGd"`LHpLK-)Z#M$e2#>O<1,!P0@;P=_DoH=X4-ce0rM
_a6N!IdG'OfB3VM-QFgsf$_<E%gs?3>]AIV1LE8G9n3g^#okAo?aA9Mj'C!ZV\qpq:<*_5R48
ePL&(^@DY%*mW"NZZ4/q=hqgC=[dGS5k<]A<J`'Q/a"#2$5=EdP^B+.p#IJls6X5!N-c=@*7N
mcsQ<;#Z$rnAiZ?&.lHNSGFtCh^ME.OMmVSYjaU<c%\:I^LiAl?a*oS$V%=Q*gaj0>X8cIPV
`4<bf4In_NApNc,PFO*[Z!>UBq.LcJ\$dNW'p2Vn"K>I\1%"I/uV.LN*L8]A\uZN(*A_)<A_.
<28U(Ki,0_`2Q274BBCLUSABmrET69r&D^e]A=+*n@T=?<^_L^11Ou0hbIsBH$B'mU2W33A;a
ul:!5Wg;P[u8sq=#F`/iTt/3M-nQer6p/F>g1^+=sa7/=Rc]AVL?.*=+@DG-]AO*YDEtBEGld2
VF%Fc$5PX*F",6):U<gU^"iKM4&J7q<"YXIrc)?T-^1P5=BPdLk:3V%SV>c:2"s8KYKi;X9!
X_ESd7Zb!po_?m4#WGl'0DI!rhDtppQ`W@OV*\b>:a(8K/=tqaJ(Oi#2U(F-sE*1T,gWRHl2
HR+&H3&A2Hg"ojf91YATh8c'^99brW.[=YUcMi9o@-O*Vrp+$=*Ql':DIp%qq$2T."baR>25
:NCFGGP\eD4Nm!`\Nc%qEOf&Xr\J(@VpQVt/?0Lp72t[_IQno]A2m`W=d"h8Tbk;>Q!330B/m
hAIX\3`f-pua>.WsC[[/)(`6sTC<LgG11N(mVr"F6pi(0M$>$E#pGa%GMqF'g"K3$S\W?1:f
a3,/^5SBI=C7g`&`(S)mg\C(JD)1i;W\-cZZiOAVPb'@KW)tOFZA[c><pI7A]Ao*3F7S(f<4>
d%Lk<?ft;*/*6t/8jkifg23l=Q;#=R5UVbqn4')+YVlULl^<;BM<b@p[WqYplJmTA!?FfF!=
YF[`<"d/tZL9V.Y#<:DoPU5qVkM9sF]Aq^)>8-K80Q036S8ZLA),n=[Xk9Ri9`kPfn\9.f2[>
@1[JujH.%T^L2^K,jh]AX1h`=P+Tk8!mu8.^B@f;!0(*T8LJ:a%JGn3j.eH"DS'G@H4l;-7?(
k1HHGj'JiTH/qK2fP>lI9MHXtRmm1&%ug@0uPCY@8T:qH^>6TNo=@;Zcc[lnRK:[nKMUb/39
dbGfMc3)QpP3UPt0^/[tPX"#>WX_,$)L0p]ANJ%bhl,Yat683d_10rCmJ;%H:p5Rj*O$(bc72
f`3pXMGd2Ysf?#8]AAJg96QipFJHi2NX"Tq`qd"qk\"pLTV1=ES/.3MVb-?#2TabL.+q7\agf
?-*O[fFi\nnjg1e7AWVdh1r2bI`d3C6O2o$b4<"-uCk9tIo,&nWDXcc+boTm&)+$B7M8R=sW
.nXMlZB.0NYT(PoQ%O?Te7c7n3]AP^PO[Pj);`.<LCWk3^rhm6blQHQ<97(q_rLVt(BiMWH[;
,K\bpM#^)K2e@eMO>UZBcuIhT=L<#>RDV?,k0;gR"#g&Zu$[23ZpL__gR7/bphJ-\4]Akq:>U
.7alZHO*]A[)3pC>F[rofJR\>QJ,qIlh10G.U>olbto4C<d%mkjQ%M8Ze_<AaWo>Va:KiR:Kq
udNqAPApHbAMTr:*KnA\::ij*pTPam-a,O*)(Pc/eU&jZOh8=>!/-?*4d$\47Y(oSsG2W[.W
4'#G*+#L!<fT[kI@*V:J^]A%G3Tn"`I8VAN`\YokFWPO<oShoolNqVVA>Jr^ZK6a8`2bXcre@
+Ipb>AD5ki4r]A54^0D(-Zs^gR?d*dBJW`qh\0#Ob6l,EB1Eom$3%IBhAD_^gLgd3OJ"o@HXb
-F;<Y1n,X&//JgI\G$^-^OansQaq:;nb[7GiQ"4;dcD5UDHcQok*+9P[%4kn+.(F\dcq^[]AC
6BM=C!3pg_Vqe7kTCm-A=5A1%dG#oD#JUpC&,T+-K,o>4SY!0DBhu,'(%lI/LEa$.4,kg=e6
ip(`A-u+JnK(NAnB(]A%P7hLIc;N(/7(!\=@=W[d\p5HLC8kc6R'@2i$AWO#g:T4`aiRX206H
+=k7h-KD=nr",d)$b7-,iu;dq[(HrXo$^@Z(3>?#V=i]AkcaBg<:h%eVk_+J`9RrrOdFeXDY>
XI?(6L=nsY;a4HQp0.Y_AR<SZjr)[-$)(HfVZ/6<26B[U`I!^"[^M">IoBP%-+to*;"`+M-_
A64AJ6$\pRdj/8q?ld.OVEs>G[AHn1KKh6&Qn*=pG"15`fP'5<<_&S$&"^IVP4t.92L089_F
Xi:O_k,n!3@ZA!>Up.j3nmS.]AckET/FmX>lXA&'t:I/<2C%(Xgp1N`"TO^i-NghUg!Um80>`
n8J3Pk]AitfX=OO,.qW48[$]ASN6:8n.l(iD:+=FNS<lRk.aD@PDBJDCiSA9>6sC12BH&J)AlF
n(aWL*j!5'*WJ>F'#>Qp-tZGRQdKm1aqq'2/r[E4#'lU/8Hp8@WQ6c!r=o%^`Jf)-U+OCpSe
HfPQ'@CBX2hSKRT9WCO(fc?E-5t9R>"Y!3]AQRTjIPn<N&q]AC4n,2@Yol$`M,h!S%jmGSi91%
!%F]ARWac7g;Jje&F,]A,T?ZI)ojA9Xn`W/>i+aT+3(/,UeR9orLgk/c`eV4/IeY]AIkfS^K$L"
aEc??NFmq+.L/..=)u:Pb<kra-WGMKn+>7X5+1'-\9sZPG=T%GEf4BBLC`irgkDNE`S*abp6
AC;q'ODGWMBp=k!AkNsNh9)^]A:%H@>+N+:kf(>1W<k!J=;dS1%%^TP4b,>+^>*P#?%gEU,q5
1Q,2Q'0BaAe_K1o@=UOT/lc.lB]AGY7[mMP>hk)?sK[hL1aCjkTqbGJnS??.Y$uU!4diQ)\+>
+C1iQ0q'-$kD\-f<mG@9*Be>CMh/%kntgT7SSduNaM@KS)T]AP7Hc\^WRR`77,4a>H]AqAG)gi
)'9$E&(#CY(5Q]AJ$S./KuaG<68oo>'Mj^<E4CYbb_q@8[r<c*J1]Au.%STD1r?ZGbbC9`KgA6
!n8!2)Ddq1cCnL07UMp<8L,3:j[hPt(db\8;LF>l#f-K^WmUP\_couq%%c`K]A<e$4e&UaRRD
'XG0r@"LgrV2%ZR>V=e(X,2lcfM+ua!TrH+*b"u*MIs%7&Si^g;U`Y$=1$A=[[i>M?Wi`:[r
$t)\isCdq\A!X:P<4gWV4e&Fkho1IIIkGS*JG*#JW:2lY4l3l#OYcE;S^;W[XJ657hkDc/3!
>9CKRh@GPm4n80i9aA>0E3PC9mch\CJ)78kK&[b>F(t#h(3jkM3@g9Ob&_:%!?H/5">_=TLh
/\YjHe\%=R[1H"u%b]A!X<D]A_YJ-;[99P5H56f$I^=OO$+:.Ui%ff"(0V8..d4V;a10$kC/=R
eF0ZgHMKr9STsNgqjg8$ROEBa&^@]As%56+h`Z0?CE7hSKMhbinY.4Y?mBJ%NH/qX!A.K.o%3
1kiIm?1XgLYD0a=B#OJc=56WmBPnJ9-uDk0"Tj)4E9QE:?5Kn%AU_<@m>$''N_F/FkN%bSMu
Ad'dl?Y9]A5pIU<3=p%`fX=khV:O@MVZZdIB[Vm20&1co;fK=TU6Y28&.LI!=,WX'P'>aUnId
HQ0P/GLJ05n0Ln9K&5"?/Hj\%q\eQ=:ErV5)W-&9h+\EDJ/esm:2K`MnJ<p[j?j+q8"TSc7J
bHu1oA=k`?D6p7on?9SG&Aur+J@P4Io5o`UD7./*fP5(=AX4ECk'gH3YS=(<ZC%s3>=^/(7F
,m.F)4V1VKsRWg4#KNPnmpKcWYE@L$MNS3hB@TcOBjtk`Elrl+5a1d_`J\2#6<@l9K5Z0.7W
R_]AO:9KE;=Ooo)iUg5B+K<*8^hMS1"lSS[2b#4_a#20u)D-Zhid@N?bmTOUIuUWXpt\#^X[+
"3KbDqt]Apd;nAbIUIeX>FefdZ<<2]Ac4ai5BmRGA_?s!?uGdX0We[ikLn_q3kLL$sQe)YoXup
&m=XMR;pt?&IIJl4q#6_;#r]AP&<\prCC6MNB5,uXS^c'PO-=]A@q#@K\b-b55NU:4ULZ8o[Qf
YA_@GWu^(I1$(N%N0L@/TL,bo8\"$Y&.crc?bK;eo.kYXfgu\t#ZtnR[tj[J3kr!9rWtaQ@c
b0(X9&d#<I%"hn,`e>-b4>)f@X@;k!##Ps`r00<N]AKjD.r-1sGK"2M#"]A&XP,]A9fq87,D-mK
`"G&Z6GfoR&Cn<EoWf:k'AcsFg%g@iu=h*T<'^GB=!P?QA1Z!6&#<W`^^SX1>4q_F',MLm*W
3PKsk&(Jb]A?XTP&-6Q0k7a5&YcDoU'qPTL1mlKg<qI7\2Zsd@C\XbPm]ADK#U!2+m.0)L-k*?
<,&bun#F?:/VE8U;XQWom8N'iWj[Bml"/>jUH5#GWLq5ZWr+#&6e5Gr-*obfl;`s\bF2#Xo+
IuQT3]A[oA@R29;X'+i+\WmaMBHb'lYB(hk%gGRDBA\-_C0S4B7u[R!WX3A+.;h60("Uu0h6f
dM^-*hgRe_6Ie,.3MUse!rU/M3EHFn0EUqD1SJN;5&f-.mS>BVeq7idYV=+"8-024qKD^<td
*_XMZCDU'#1[>uUJ+t;fE^<,_SEG>$(1EqF5YR>[s*g"BsWaD3pkitT7kDD:l0R%WO:DbYgl
c.G-r`j$GMKKT.X3Z'VW)lO^K`&Ccs4Up^>UD@,[Xh@GU&443AX)+S,s[4W)i/Vs1']A]AtEn_
s)sW[-2SAGO]AZ_La+bgR2nDcHI;2n-;19%0gfl5$K"Q3&L,q#tbCqfbC.KgQ!d2k]An?BEq\O
XW\a1ducNS--qM"h:TRoaj^a(9C7o[t@H/)`X@F!^YE2+pp.=LGAIjS<RNY8Oku>po)TqE+;
reZ&5i+N!`UQD*'+Cg^H"9F#."G)9dF!-*)3IU,\N)IhQ!Xp[Lndq1Jr_WC"VD+Ys[6jVM$!
uqk2=oH&0HI%FI*]AGCW8E[snd3j&fd@u]Af4`dtm$R-A$cFhLjF4/p>it_RH5g>(]A:MPXkMKn
a&do)S=Am5ae[eURLOE2f09cR=M_fn9BVhLF/L`Sj'2\]A0>-)t=e3$\:n$DpEFiEC5or[g>*
n?uu`4Z?QH;T!!Ff[%B=ml_Nob"R9Bo3FP49)DE_<ltWhbiJ.UQa$9Vlq08n&;!4?Jdpo]A>;
8,BM]AA`/3Ft=9"Yd$'brr.bW3$@:m*IMSi8`o'eu4)QB1=KYDJm:?1/"Rq96K\6:4,%77JS)
e>5dr`>@9YSD=!1q(I4=CcMCH<O9H(oIlF>l%i3([C1VIk/1oG/h,6&(5`I*60>:&31SeSZh
SXaeL<%;qF1ou(%=F<.b_sk#`+W'ta#nt&\W9S'QT=jUIkR<Vfs8*PCZ\U)!;XM1q%;AQ\SE
at`nuH[B0>T-6MXk%XpA+//&6WHI'-^!;p'q8$adR(@"_K\A<d[]A>#b1WFouZ'V>R*tOq\LW
qUn-=AN*=ZH>O6oEPe2qq@Euc+\S)igOK5'JkD+pi!eY'_ulu>kSC2pA`0>=nR?Eb0<Z.<n)
n*gnWIuE3mK*srR%S73RZ\QT(rD/Xl#?F;.u=YgaW>CCtM/?@V/_(4[E3`)+Nns]A17E!q%9'
mN]A`#g]Ag7PGd<rb5-*$1-rh?=mO=2^R5d\ur$gZK,`bI0r#4U%?>0Kh62F<*k`P3eR#;ka3r
d-Bj5%.M,7pkM?Np@Q0:(*+tF?,HKR)=!"f8Slkcc"[<NmV&2M-X1<]ALbLHge7BAk%0_Xa&U
T#a3/%bqr9K+H]AZ_)lBOWE8o#V8"bqYhM`<PjYVU^5[C"R?meb$]A+Jk094MDl$8sSSW!Y8&O
/'AC=1gVdSXrMOa`r%9-f(pOqnE6B)<pd,Z_a:T)PJ]An"aYB<5YFS?I`@X1Vou*KWi^4)s#,
0Xo-?s+SfIQR+cXS<jS2ft6^1Tp<%*OdPW]A<+g..2F:ig?P0ErA,q:bCXbIphI4g5]AY^"&<E
]A:F9,3gc_3+SIg/7mf:n$YST9!9B>CU*U(8u.IjTp^)on&4j&6?S\6#BW/>3i[n8H#BO_;Ha
QH`ONJkIS<Qi%aIIlK6e]A;=*l_<fE>oAjfc2.XCZ6CbHDe6TsKT`'U9a9&JJG(G@$<o6F8!p
BJ7H;,uTr4[?Z]Ai)ZN5i&B"bA,jDr:*lKYtQ5Cm8fPa3S)8VGl=B:4p9g<+)EI*O\3)YfY,K
kqjY$^O,R#lT:(Er&V2m]ADC%^R$97<CoC$RKE.Ebk5!=GKFLp%]A\17nb55eo%C28b[pEni4*
ibQ;P9(?O;bRI2Y8X7Ld[W+j0Sp)oH!"kfR/'ED\E5JcKKC'k\VnQXKGuB&clOqoH;9jqbc4
fo(Lg?A$dF\`;UPu\D1>lSYu8dF%:-R1PSg1BM!:H1j?-/`Q2M1NKO[#,j_,f'uh*EG:--f1
@4\NO0e2OMbM:bgpT7`.I#e89^1@*QK;>c-Z)uH"gZ9-W;nWd<]Ao2UdM[BAk-gNYf&_/R8/1
fSENXSTbu\=nDDmtm'?h;ENB`5Sf(k01W>=N0M2pasdB6!QEea:>h[J#H+Qb(9coQOo,>7:F
96hl0/_W3*#^Ge3eM8r8(4G'd+ag@GO=#@4?HcdkWVr2%A%sl98bN3;I[-\b%Q(#p,9c,L.0
@6CIh;RsKs;9H+i>N-,HsSsqk$d8^7LRa;T:rDS$N1(%YeP!r]A4$kn(gQ`#=EX4qcr8NhOXV
uS7Nkh*8#<YO46$J3%J&?_<VbYYY@ou8<0b8^lMi7HoX\%YW.TBHL&J.G`>4mX6KB#]A$:1K-
==<X]ArCOQ!=9P_qfuBBS@Za:#X.Ik-T*fWpQ$brBl%$(V(g)Q#)?J2S=`0(>%KR5bZW\8aGJ
[6>(>t7!?PB?e7"/1!`^[V2?!O+?t"IT"CR!4o#b#b`j`QX7E`<8F?RI5!<SWDXlL34[1Ejf
fo.U4(t&RWWn;"n'_f*2Z-J39hatL884LY)_X)KPq<96UJQpXI47p/caVSV9539aiIW]A?^]A3
G6\37aMC@o1N$nXr0a0i6]A*c^T8'lO`c@erikr]A1N+8M/ja!%.D@VPg7L7B@J@ifuD>[IKd9
HBLND_MSRk[,'l"mfTUn*9W&=+;rN*\Xm7eFFC_F)fW<5,@m7F980"nS1<PZ9EqLQ-rp%-qf
bZ^Y.FP#Xe]AL!#I0%?NJok.HQMZ2(O*Ui,!-;oX>4f2:_h!hkf3CM&I$cAGpR-E@mt*/>,jJ
l-Fjm6>=ka39lBn[$j,^R[-&/<qB>Oo:R\+NmA5A=`3fI7AeBcs^_5INO3f?b320L;+=2Ngo
I:saAF@"!JI7Gckht(o<et(Dee*/ZmM+BS?*f()iHl%U9.=^ek_bM=qi"\J'ZV@!p\RnHW)f
G#YKhe*gpQmjVK;-$X5c_5e<t29U:%OrbQelBsJ@_;s-1.;P8/\Nao3+t#HTme5LgibI$MN.
Y(5JNZ]A?"-0BRjWlJ&WU"OTd\#:0KUr\=@HJ_s7l*WZj4%\Cr<;d\$@Z'>=@SbE!b7H.]A!o\
tGE)cZt:H"MBqi:r2r3iJfE]AFRR&D"4MJf;g;FBG#fjP!W_BeFJq_JYRU0S`tVcH4kCb^.(:
$HAu&t+EHmDnO$7ct;(IK-!pT!;G_=S7bUF*%\g.4!e.^)tG"_&gdHP;-[7(?APL%QcX[sVf
5_,Cm[.3^HVYF@#C"?\#oJkf1Cj;qHZFf&.=U&QGZm0%$n.?dU-JV5uES0=Z,un*S9]AbC'bD
uaWC2\V1n`.W6E?Br<GSb=ZQRV.S8g$A.5nh#[_o<>eXBtd"h^IVE?ehNKM&,cu)nN6NY0?_
=aDnHkGJ7XEVNH<I_Zc+&P$K1=nR.Zr28HuKJEaXAk/fd'f/d1(d+pn=*r^lZf,B$W_=Yq>9
T-F)ft!QhjQ.We\/PAdRVUY'(1!,_.l<\&]A4=]Ah9oC/9IQ<Ynq:9Iq35E1`ObML\=gXr7#e<
*h)'fWI1]A0QXEphUC`V(f1V'tRmL%YQcTRqSIYW#CWI*@fAZ2_g5)ZQ!iHKNh%*EIB+bi`Ue
mbEMnq!hCRN>!k]A=9$r3V@T9?e\>mYD=5o7QEhV9=4'<WB2FC-JZ7.p!s+-@EI',O'F&X^YQ
etdO-Y3'^3b+P4!#V-3Yh`#@K6dtSSt;ZO)=UG%A1Jr*3Zu9/WNc/kmU""m&V<:.Q/Y)a`k]A
J+WD%0G3_s;/@C/Jc^tA6^N.!aW$in^lV2)-D<;A:jPnKaq8<30$KkLM]AAg&a*09Uu&XPqih
6Yr4G`/,hSa;:$$Nn/oea8B:Dj-'hX!?oaDAk/8R@$^J,6cHr.&kZE$&7TpLq7Td7]AY_@N,j
;Ts%[aMm#<S<I%s]AHD(jK\51NuS.nkA(07grj7k8=N$SKjVJ,k5Mac"/9R?H1l[=TN,4Mng=
?9_\9'%S1Q.!Fe.-@B`[ZdC)cdnu`)S/ZlmkY&A3-)R[D4fgJ8HTMphEs2XGikq2bCG"qpc3
rJ0FfcZWqtWp*R<q#c;e0YF<'J67P5e6Q$m;31e43/@>"OEai:*mfaGB]A2*7fsmm'EKU701V
gF^l@%OIbQ;>ZRMY%Yj;_DNYj2%L3U^bGt9HiuNr">6QDE(BU.`Q?<LOItR]A*W81hT*]AE[3`
pYOQk;kVe\)7*sQdi\`2l<oe1-"^V]AUK:MP6o**5SRZ!Y1UG9[a%R_bV)go--ahP_)3RhW,E
4(]A\+/LV/tV,N,WK)O4kJ-CHVo/?bPiCee\5Ga?mQKaX1PGLT^(WAMA+/0CEu_!8*,4)5D+&
L]A*Vu;]A,(I0V)6a4n:Ee\GfsX?aTf95,<1<iWo:LSE6u%9.Ku_j<%/G;q#IR3"BtR]AIa)2%n
?/UN%4p^GqR,W1/2F>aq&P-dueS%k5?SN_(E[1=F]ABGW)Ff>cBc-Oq).hm'DmA__tS/jWD.1
Zo14AeSSd-%fpZ:&f$(AD\'IGu)afne/&AA>@8,NWX8'PlMW+E"[(mc=X3<nu9$":)DaRTcC
pF^F7j7h^X5'A'+0=$c2lH2JremECk$07(OtNhI>enn?//4J.&N+SlHi#1n&+EeS_'05-Y-"
(n9E]AHCrta8Mollh0\o$G8=m:5+e]AlBr3(=<%6>6+Fa`kfXA`ICgf)=3R_4HR2Lo+*'8[hU=
<tUeHY;HgMVoK\8O*7dd%2YT_]A^R)!UDR?jBNbSg(EU*o"-'I-i2CuEbKPG5I[<24jFW_O\k
J\ab/Jcp#gbH/Fr?0H7&O8F/t+rreIDQ!`gYXKTO1B@\d5k88_9gR,Mq7,/YWbOZ7jW:l,2t
B$-JhA^C!mFh`FIBRnKr,e8V?\>-u:`EN*uF/+UY`2fN)_NS1#pqKh6P6?g!,(qYpVlWmkY9
>_>jT;ob6FBI0IYnDQY;p;ES?o6kV.5%;%Ikr)Ba(d3K0jet504@!40)uQOCOZc%k)F)U)g)
,YgA?;JVO0o.GrAD^b%:"#SNtU_DM^B\.W=\Cm9[Ck0[^Ho%+uO)*>g"PQ0m*3nNL/bg;4Pd
^('[NGB,nEH$A.mln]ARb'Nr+GT*1rI`3P"2#H%4)aOL+@,UE>Lhq,CTX#:+g;477[\jiV,6i
1Y_C,SlV_9,h?4u/E-B=?tIo$#8U2,ic1!#:r'[Rf6GVZI]Ar%l=7Rh01.h0B>;)M<&r)11_l
Rei9:3c(eE##p,q5<+BgYk3[@kfqcK-SBQ3=Ce>i*b9fO[*-!RnI(oV<(CkG2+""Z-ntdMub
=3sc;H)Psc'R#;4P!e3Y4$1N*KK#S`l`qd+MI\/r-D,Z6R4>J_>c^1Xr[Mm8)0T*%-,A9/kq
Pan[m7)P6oP6\c+VRZttY?6r!VFTqDHoql3c2hii`KWE5J";/G:!Mk)I<8S=FDHbTljUG"ZH
.$9=rCIkdLlcNMW6qN$!GE\;<`2>P9CjlI3r_@p,OLHDpQ8F![Q>r:#L&-aW4'r'7.%Fb:jH
,ssk`^a$]AFQC_au&uq*%;scC#W/F6\$/e0F+45i^^aLo^hOM'\Q`4#%4%lN<.ZWs%hA=Q?'E
p=,#Xa9rDtB3W<^EicSUuA=2Y"gHMF;`6r[NkVq#Bj@q'G5D%JPW:]A(La0F78J<a!%!MY<5T
%6-8Mqdn*p=i\IiME_TVWX+#0(Rjn2q)XS<jg!R!e'+-r4N[aV[aIpP';_q(*`4'^NO"\Str
iD4GbbRnCY<*A5a6l?X3lrD_T]A3kFG[d]A6GqrAF1+.oT$k.8XCPYcCBfd%F',*$CO84oCWR(
E=K@eIGK3YDUuO49OD6sqmUiLUcU]A#@<_;WHe0>+H*NW$'Sj6`HC5C_)qQ/DlKrK[#gP"D$M
=lll9kMrm#$$pVJp5HiOmd)diPc?HJ]AP)k-t^VVc3F9S&L]A?EDp$X$jPq%:CRE/-QTt*WMC\
[FaE+cg@4A>c_e`'&Nr*Hp^O>102^EIn88YkE+oXJjNPP&gSMp%H@)1W[hKR:+1o4n-GPS)Y
Ncp7-t78]A<+EQ&!o`%pn!6;j2s9s.[%`T>UN.$:$P*M-S7qBkGt,kq@$&3(M@]A-@\c1t/f<$
aj1M459>T2>-13,e]A_F:g,e8>Fs]A<:I+XNPIOZTl=SJ8Wu0f>L.h5a<Fl6Y/qqC4ue9jZDUD
TRr;MfIges"mGS1`<C2XAkU%:#a`(-!V.SCkN[(m5DF)#-ju\F]A?!E%7!78M`I"%d4#Nh="7
m=VI[q,.T4G($@)iDq"`4e+h19q?P\aQ!!=?9t2,g&>W0sbsl5UEnCl!6[AGVKW4SmbQ0Ajf
0oE`t9^$kR5-rY6@jab_2QUN)FN8kUSeP/umP'GV+^O?54XEHlWbPnM*'<X.sXcl]AnEIFIfY
9_+aImQg;:9AoG\K+f&J&5Wr';47CBQR$q@_`8aorQqmH1bZU(tt`83n4QAm*\H\dpG(>TD4
`\qq_jAJ"mInB]A!/dW+4kXeF@^u?su=c1N:""CS?M!ZD2><KE_32#PBE43`#d!Y,9C]ALZp"g
D>?M("fDS*O),)CL9Ijn%=(IBm^0g\R]AoMts%jaHdm@KI`!NlD5JFBEmF,N#mr'SB[f.WZW"
*U]AW+68$jFk74HW5ZYbs@BL$sMgkQlk>UV-He?pPW7QL-k%n\5g''(.Xr!m7=^pBWud1PGI#
aF0:rGP/\(8bT!&d#7Zh]AYj#XEIhh(ENa[MsQMu@?OU$LJh`n>%a"7SZ9^K'q9LEY(TXA[\R
TNr2S!eBGj3_Zu/imFg=SXg`g@qpQLl`5c:uS\cWI>7\IkP^3=;<_]A]A:WW'(^nmM`<+Z>DS5
-\8Wom;Kg'pQpaS9*-cZ%O=?i3ZQ(KJ<M\Di+8iF^QJG7jcWYB('r\!X$G8l%DY22bfONjM7
XD.!Y*k.:CSVX;:dXI1neh:AFc0\Ml0cer-+o*&bcsbrI?0i8Ds+euh3jEb,i]A,"UBTBt9`7
JmbD,X9]ARc$+Y\9(Yd20PkHm8XIS;E/,EE;EJ.L\XG4$cDQo8sm.C]ANI'rK,ZHom^blWDD%a
+bG`D*]A?,X1EG$Sje/qPYpNW2%-sc!cTWf4BKUR#i4SY]AXK$gdb.FtXbMXk4*Ghq_pRXOGk#
"M?P<N*5.50*ZL`<lr?+-eO9elh?8DFcbk6==>I'd-A:)GOjSC#R`Qa877'VOm:V3n3`oL1]A
]AEPHKt?Mk)CqiglOrnb>G8`rXQCUJ*ZN\i"?l6O/?AqX^26M8nSm9FG.%@Kp<157%20#%,WY
;X=3/dh)8a94%9PiD@nl37iM%gkTXDY>&a81hS5a;c!5PVT(*=[m%+:$!Mu^YN>IKe9`*k3&
c<p1lY1dH-O"J,Al]A[gI(O\CkK$E2BQ#8TN4CtZ,b>9AciOhU5J2]AC\r=<d06O@O).JJUl!o
Q]Au:V@E8XWpK.pQb=f(i`*cX=,mW]A1bXGWRt*?fInW0Hiim32s@diN#4a?@tn4OO(=p+#XdI
`8sR5_idNAOflm2EihB(/Z/LGtbS*q+4Y\IITlHV";Tp-H^*ek7smlkL^`5I,(fWeiJ`C3N:
^aBoMZs-+JC(B4<4?r;=OIc*nl=VAm0AFFNGe(FF3c8?LmL8rArgP.IC1\FN_G-o(.k_tt"]A
3)uaEWKh*jRU;jI_J?c>&2AGuqe*ldT#ADps)QWR(X1n-hKt[k3E)P9oJ;AJkLU%VH3rt"5F
.dX_(&:km`p83rJ*!a2c,e%eYc<DoN]A6V=35W7[,5qe#DQSEcL-!O6;Nc<!s+s`L\GuF.0V*
T^*%f[Hhc*#D2(<:+2]AXsl4N_8I57!"BsC6+aS,PP1/M$^.ABP$hP#qq;f770eSIH:ee#AGq
lmeY9l=u*BO,`inFo]Ad"`hODST.KDfDisOQ&O6UGFQ.^X:Oh7HggtOMO!G,3u6%a2/dXY3pF
[&h+Bh\^L#;NXGK-V/<3Cu$MMoC\B%S-6H>4uZdH&Hpg$NTW'1-PG0^"9a_btSFmN]A\9Cpe9
F0+_=SjkMKKsIK)8Xh9S<%'S9,tCj$:++4>bcFK0XXL;FM&['=a\p5Scl>kZ-o#ZB;C2EqfB
U"ah>=@%s+#;FT='1D5&9Wcfu*Dehr37(m58#T9!b@L%Y!bNr0,6"aQ!r42)hCBE`YG35X\;
q$qjus#b]Aqd9[aNpajPnada;C!l1AcQHn"rue'<gt<ND5^c^qT4:0DYTA@EpuSi6R)f,rh2X
)I7Y6OeCa8ZAMEJ4rU"q<Hq:7m_!gE8f2kQ/15-"^a"<6d(8j3s5-4;%V&^/3=GP;eRSQL(n
\V+-;]A79<:M2@tXcJd,P2O;,l"HJ73ARk<5MtL/cieamXLn*gl2&W(t0&9.lucb1C(hIk'pB
7@_K#E34)$/(=;,[H1Lrgj3-k@-"l;Fi[NP=!<r`?:AL)?`/l"7i"nUBnX&i=j+e-$lRa2e"
T&k>b=$7r1_eQ&`:=X_`:N\>S0NY6<):,"1T%^7p%57(_N2eGo'ctl"emmdX#c%AT^55$P/&
O(m20CJ/>ARf3nC,)B%&YbuIr.nqeB!-J%@]A4SR^id$lcX[$MT2=K?tmDeVqC<&ULI@4Z`u"
6?cIHtS@)SXZ"4m4IM#3Ju5o1nJ8`=2(rafAo2rr8,R475)FuaXkMd*pE`ZFLOa_Kt3K)X-f
NlY:':I;I\idZ_sY^(2Yc8T<AXrQ1XG+NSS^U;IfYs+D>$P6f]A.N"[;LdMqCY$#K^[sP`;U=
pJ6JoA_>pKfo8'.*+&FuJBiC4631,3/RQse:Y?TYl,0EulW.-XjmP6CD.EgS%id&A)9\e0K^
$T7%tkc_88q+Bc`?G.fr^G)o`oFp_VD[*CXUl9i%5]A[TlF4hp</(u?o,9;S@?*(>8utA3Z3$
HY8YCG(R1$u6*2<6?I#7l*@e_.quX3oH\gnEcVu@*K$fVTMYon-Bm?A^jHn<]A\kc:<5nj%r_
cmN-40%<?.A61J[cJXkRZOdi8kUWWng:r'W@&7&^)^(=#"2H$ZFI5g:\82Y&_3`WPdNJ,N>b
Gh<R<_L7$!PuOT6R(k2b'9&[rGM`HmJ"?%l)M^e5Y./AC+&-g.BQTRHFCL09\YPiuVjqYI\m
F[apB.\q"&p"5356gK>e>mATje^gHGl7H7DT(["ANl%*3Y?)+JcT:%E=EcB+asC^@K-O=Fb!
SSa92*m7@mp(nH#=cL2?hFqK*K>n"130J7(.csO12_gqh<1Y%"NGq2moMroP9F=%T>LF$.gt
)*R!HX#3&brko()tg_lAc4-[SY7RFA[]AEBGiH.k1O(q?3Nb9-e0*skD$UcJ-&!(VYbl%cW-&
3fCA%BJ3]AJ.r7;GP'sUlEjC"2ojhVFus?RoUjE\n?HTGMhg5%Y-G0K>5I:c%cmIud7[#-0t[
MNGtD?QlPPN9j)t;:F.,5RW<Y'<W$j6u+S2Sq64#(`W.gt$1%<JjJ"OJA.<epufatc&?h7-_
@YCdCCfA:-;;TjuZ7(,sc]AOb>*Nb=EXoI?t&cg?YD_L9eQ'f+'.Eb#V+Dip$H#X@QBQ9ugC&
p)4GN*[ALeEFh:KFIn/5iF([Q)97m*smD\Y-YW')-FrFl$dW1anR,>+97C6Y3VFDL3]ALhIT(
\)S_CC_#^7J*?p*"$!.?HoFde[6+.p>"JeBl5n#g<"og(0cq=d(WlliY=G>E)Q.QqW9M.`?h
jZL/adCGkg3`nZEo`re:OZ7,RmKg$`lr,*'a'0?$&l]AZEMGMM787ERXsWd98q?o+6Sk)h`Q,
:ACn#m=eDOT<WVa?q<ddiaE/'^%[7dU[Rr@F3U1^:ZDLd:9S.6kjLusU]A@-g^(aJ9E"bsRj!
;4\@9oB+qr0QQDnh]AIoLQ&T^OXk-78JYJ<*\*YNo)9>%l.7Z>%o)(YNWQHoB1tT.UEO1<037
R=WX2(.gO1CttG?QOkAt-m_;rj\9@\`Otf=)2OGI@B`H=iq#ZV)^n@>#>3(Lqn09'QqE.AUM
:&*?`-q:lEi&m6CV6($lL3!%Cgi)l"<+]Ar+!mBX?DMd-(I)fk?Q[PI^UhBO29c>F7,p=-_#V
?X080hD&OAD6$!,=E>?l[jFD?M7^Y99fg@k3gKWJTlG[PuT!2Wg^AApa+@qC=o/^QI+)+[ja
caG"VI.LQEt0"#[1n4/\TPF_L#`4ms;=XO=IW`0*Pb3-;I=T6&"I&aM*#KD!fiZm&'mmAHDV
#PZiBd38RN.AV7WcmM]ANd9HtJ?oe98Up\ATqdUjOX;pf'll)_]A14SO#!`L^Bg^b`b)PNU83(
7a8l'^hqOUe@q4#QUl`r6a#^WB%$?XIBm!ZV+(k3!9_g['+J.SkJ`:Tl[u9-%>f\GA6;38*8
gL8/YlRqH2!]AeW^$M^N,;m^lY\?1L!$a[tZsJ5;oGT+U(7%l;l0kmj=I`+MBO\T4%+$oFMd8
A_\t=T_!#pM@'QF5+`jW<D45Wi.d!"d)CJ:aA!P)XZBcCIj2O@/.bR^?@Q8M(W1)WT7&Xg7e
m&@%,=5S+>]A&2Rne6R]A*e1+.ilY',GBc\R:DLPSFXYFq]AH(NnpplGT_)@%Sdu6#':Ddb4g5G
?B0%rMm)Y48VDFdpU\Fs&+PUp]A:oZ#46g`f%&K0Dft:)$+1L]A7IAs5gTeaOZ^CU&?e[a/oaE
^pbn*p%_Tk^PSD03Y\,G3s;lPH<"mNnf3pRfLHZ>N.WR)Z(%q5m$QlF&O_[p:%aVU6ln[W_=
!d7W%k(9&GA24IZ%%kRq0Q?3DhN)kXTG:Jkfb3W)8rEE2jUQ,,]A^l]AW`+((3+E^)#H3;,so:
q-?GXk'q%YK6/XUTVr#Q'2o15La1[8;@<_.@6'\Vhh-no,AD/d6"\=K^=Ck\PZXrmtS7MC$E
/\Y1ME78Il.-)P9pMh<>I*!EGeoBV/Kd1pn,b8J@N'\[l8O+*[4CFNlQeV%+C$E7[VG=;gjQ
T4aXf>f;3<;CM=B,2T4h1/gg_TALJ_6q`!'!#p;L4YV:(A4QY@%b.uaAcPS:mS:[A4;X9%H_
&i*Wm(WPs(W/saKkmhn)q[@[G4q6NA3'[-EM]AD0/V'/e*;""Q%@eeI)kR4lFtHQRPo-BL?@k
E:[e&$S;f-([D'&38bjO8"!<P!1QX-kTB[\VDm+5AArt=U4bTGC%`LnUFhIgD([KF[c+5+I-
[,dt]A+3#7D"S3rP0M4k92pL=!+QJ7.V?=_GOpi2h6Wlf[QVX8%u&GINp3QIlGYRVNZ?gJLm!
L/@37cOAr'j_VC2p`pfqT89<B(FQ4S3*A3F.*N.&c$hSC`gVVhb<;CB+j0n!;09.IA*ZAa-;
I2_C`;\\*67=bPo"ST-8>t/a^rH+\s$/sJRn!>s]A.JkN7G#P:"IJM"rq7-;!!.3[KS+'EVHj
4fi]A.:%;Gc+=Gro2XbWJH``/Gc4+'O9W+m*Ti[H@S6PU"&RRZT4l6F@/=*k\srl]AW>2D%4C^
i4?[?9_a!`4V"'sq>T&jA_E,QF>a0=%[.PA2&%rLnneY)h;n2"!D_htW$kI3em9YAF09<^lm
hmhD6,r.O^<4`r<CD2N(,s4@/,A,4C;7!beJE"L@o<*O[M26WX5i1-UVRAu9Xtlrg'em+^,o
/pATXBiJBZj$pd-A<i$tU*,PWmX?cqI)k5L(87s9Te'%Eq`*+,MV^eUPI@o,idV1GH&"^PZ:
9+PPYVAL_Mc*LJA$(.7=0r2C^$bdK%8obK>QkaVm1(:\,&=d]A+aJFMlXdAl4E4Q%PP&\X[QS
/Wd6FjI`:(j*3:0(h65V@p3%\.m\GN&0\.6^u:^DL?+QXR8.]A'rZA=U(Z&(r&G$#E6gTQ2Ci
FN7JC%NH"WeA8$F,W$+=u7R[*WLAM>X8:&0rFM#<]A3WM7LlXuPlkD*[%/^=mNH;J\-L51b%[
K^YLj6p^g.*r5Iho*[Qe.Uc0YM'c7aqIPtNB(f6Op2e`#1S#@`MTQ7I:7;<]Au;>>qJc^MMqa
.!_d:57_7>132R#UdEa&!(mr3T3p!6Ea^BT71LM?QUUXZ6A('oMp-[/\uPLY4/+gZ(s2)153
<dX9@]A,\o"o7RaJaKA!5LI2P6e?LN+;+9KrY4>5L'r"i.>@"G"\]AVoP$5-i=nZ-]A!Q2O6t.b
C('%PdSf/MmcPq\5Yc*khpgFEKt"&Cjq*.a4<;4Kb'lp4V;S)O%-\:cieeOXOX)dR;dm@R]A<
oa^s+D_*?946f,feH..9F4QfS+<)_hi=oFc"B@,ikJ$f,aa3f/KW7s_bp51pV')K`=]ACj,/g
[u+KX0Te_Q/+sXFLtHO'-DBt!g8hXQFLei_7T1J_<!%mOfu`Y`Pu^lG,%2d463?F1;IKhMo4
B8N2,?hqcN!F24bEP37,j2Q(8cLLubE9plIS8%f!@CY5p1IqHEXcZsDm;*<'u<)NE`47pDNb
gNsU`/N)#`8@>sEbFGdFR`6re/S:8?eE,opbp6VKMF1oCX-d;F7:FS)$e4#Jg!`!!gD7\_YP
%X]AO1j__X7q\mM$<Z^(K!T#hhp;o$R*A3Of9fi81j"dX"(P4PV()HAaiHE?i**6o;Pf;!#g0
SHmU@+Z!NQ;l5=/[L\<OHiPL,TNjA?m/Y(K[Y7:>^Ths.MUtW5fr+rWPq$9V3U]Ad)qOrtA0Q
Xb80'nP<=2[09^3fq>hb/UmE1"JSV(^MJ6O6*=8&r%kXea*2YYq;(0-h`$Gn/LVA_2kGj`Ze
FlGK,nq:>=HGoiH.kR>L^l[]AZpSh)V[lgVMi_Fn%g^Sn?q2?EV.md^qgfO<j2X65CjrX<,f'
_%UgL\be\XRG/Ep#ca@EP.WR"(#=E.j14-&!;3]AZZH3V)IJ`$=IdD;jKI\t`@bJf9':dIj%a
<9XPn/WOKLJEZ\T2_MD@D^3LF'$7d[NogcaX<HfVlVEIb70[`U@0sBWjX]A>.IHs""<)\FY_;
&NZ!Ts9qm\=b##\L3'D,*1M+h0^W$3JO+kiQC"t"G4O$m;]A=?3j$k%3%=u8h+l>LA?56*Ut,
J)Y=bJP,#-M4emR9hq1^8l,AlKt=+'.u:*<ntp2H&49GU<*bLT-am0aK+-cjHQENNgTD%13d
$H349_;dkNjXSIX#u1,AgD&p.$e!W/\t8=V7(`IU4kaK!b7o0m^c7X+(_/'rqY?)Udqd:JGE
F#[0Qs/ZIFCCq,l.`@R0RVL6!8f;[I[1BNNF"S[DZ84SX?u&Gq6f?W6(NhH&MQ&i52k*;U#_
JN0Tq$POV-ONm$\_QQI_-G@ro(G/jqS1T<Oqia%RalP<tqcU[EK(NjV,-R<lj,p`bOa/r3=s
.ZPd0J\Z%'bGQmNi'd>3O]A;A5.5IFlJE!%5XF%kFeP4J/hJo3%KIOaF6"783qo8#3ZcV!9n=
f"ANS(OTDA7MHNTF_e<.#I"D>o;^(U]AZE6V@h(9$&nW&-,+Z1T[^C886;]AF:/AnU/5:Yi'I-
oF8r@7q-\YeO*BZ5dlmtT9N&8'^N(#k)\^6GblHfZ1boGNDm_A,8)MA>37=R$TEl)s<\bNJ9
#NJB^:PQEVgXI&g/<\D.,AVr*;o+hVfG@Sp\T)J5GJu#Zos8pFL86'q66KqVP]AV\XNoGX=C"
$4NV=Q"'0DbnnCT^2@q;h*bImP8ID*\r/]Asq$-@j,R4S/t8l9_6=>Z+?Ddf83Nib%4Y=$8c_
L/trfQA/o4Rk22@U>ba7agC2Hebcg&Z3"EY^?s?V#[;-c^Y2E<=>7,LCffl5(MIs-iCTF%N<
4`"p@2d9HNDIL87_,@XOKbu?<dBK[@!/45),Us?no:?u#iKcF7k.R7dSMQV>TqHkUB4JMs3F
otF4SWX68.LFnFFrF6=m6;N\ECH15edVF+1:Vr7K6!NHR/M'$+r4IX2Ooer<EG%neKi2Fh\-
.pJ:gR.D5.E)gidn79\M2.]AKHSuh"8=fW.2<*_2JLem.IKr-:u$A$pKVJ%Hj9C/-<BJU8fTj
+9^59FfuAN1F54fpPaQCcI6gCLW88Flurn9+sS-i#+W2E'l\*`uTN)Er7Pj]AA3g^),b+^X'I
Yg$UpXkqq@e`>etbA0E-be#NS5"[8CWd=n_B,,%k3+kAU@bcR%,H!u'DPc9Z3ThqCkLrNr_"
\=<J'<J4?P0PN^=.B:;Io..7;d&Q%I9aoG2#\>JbS2![a/4==:6pt&lrLffOD;d8Q&"s;!q0
P/I(s0L4u:SIRLtN$Ppf*Tg&4nm:Nb`-a$QVDf</D3[`SK3_;b'8hn5l/]A6nCDff1*?.IMdR
8Tcf1KN&;D)V96GdF?\:Brh!O5T6hu7q!XV\U;&\prP,:\R_R3>l/I7Tb@8[\=Of2.6aBOD_
V6+`kdBH`J8.ORu.fT1ap*2e8[$#G1>)ipY`AVfII%i:X(r^V#rfpAsd;W!Iq%mnDmQl.s\P
!kX&%iO#,[C0q_Z+iQJ-`IkRD@dm#(s3)LbAgkYYc.popdbIi9Qj'F^-pOC>)Y%Y^BnZns_)
3s)`<I#g\[;qJWp'(DA_:5r:CG,MXr+R':/?o%)0!dW#U%)DJro`1H&!fB.q(D#@mUlHnrD2
[.+0GRJ$LpLYH(FkgY^W?\q0-9%r[#o(BF2$K=op:,Q9\*9-.!9<$+'h=!\Jth5YIdM"f[UQ
,d2-72EjQ!_B$!ZI]AqG2na@W%55rt,oq-_p@!M;3c5IdS$ug[qhih/`k\pIk8W>%;&nD<S"B
g=-6'`WdOT-\irLuIET:";\rnlQB]A-%!bg?nfFrrW~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" foldedHint="" unfoldedHint="" defaultState="0">
<color>
<FineColor color="-6710887" hor="-1" ver="-1"/>
</color>
</collapseButton>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c_c_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="469"/>
<tabFitAttr index="2" tabNameIndex="4"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<carouselAttr isCarousel="false" carouselInterval="1.8"/>
</Center>
</InnerWidget>
<BoundsAttr x="0" y="35" width="960" height="505"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="absolute0"/>
<Widget widgetName="tablayout0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="540"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="LAA"/>
<PreviewType PreviewType="6"/>
<TemplateThemeAttrMark class="com.fr.base.iofile.attr.TemplateThemeAttrMark">
<TemplateThemeAttrMark name="经典稳重" dark="false"/>
</TemplateThemeAttrMark>
<TemplateLayoutIdAttrMark class="com.fr.base.iofile.attr.TemplateLayoutIdAttrMark">
<TemplateLayoutIdAttrMark LayoutId="9ebf6aff-ad53-45a9-a175-9633f4162a3a"/>
</TemplateLayoutIdAttrMark>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr">
<StrategyConfigs>
<StrategyConfig dsName="ds2跟进超30天" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds2跟进超85天" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds2跟进中" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
</StrategyConfigs>
</StrategyConfigsAttr>
<NewFormMarkAttr class="com.fr.form.fit.NewFormMarkAttr">
<NewFormMarkAttr type="1" tabPreload="true" fontScaleFrontAdjust="true" supportColRowAutoAdjust="true" supportExportTransparency="false" supportFrontEndDataCache="false"/>
</NewFormMarkAttr>
<TemplateCloudInfoAttrMark class="com.fr.plugin.cloud.analytics.attr.TemplateInfoAttrMark" pluginID="com.fr.plugin.cloud.analytics.v11" plugin-version="3.17.0.20230612">
<TemplateCloudInfoAttrMark createTime="1686213877575"/>
</TemplateCloudInfoAttrMark>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="b9e34b57-17aa-4566-a2b8-cb598e9787a2"/>
</TemplateIdAttMark>
</Form>
