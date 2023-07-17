<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20211223" releaseVersion="11.0.0">
<TableDataMap>
<TableData name="ds1待办" class="com.fr.data.impl.DBTableData">
<Desensitizations desensitizeOpen="false"/>
<Parameters>
<Parameter>
<Attributes name="fine_username"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="startdate"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="enddate"/>
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
<![CDATA[select t.ID ,t.projectno ,t.Billdate ,t.UserID ,t.SaleDeptID ,t.ResellerID ,t.ProjectName ,t.ProjectSubname ,t.ProprietorName 
from FR_CRM_PROJECT_SUBMIT t 
left join FR_CRM_DEPT d on  t.SaleDeptID = d.ID 
LEFT JOIN FR_CRM_RESELLER c on  t.ResellerID = c.ID 
left join FR_CRM_APPROVAL_PROCESS p on t.Billcode = p.billcode -- and u.ID = p.userID 
inner join FR_CRM_USERS u on  p.userID  = u.ID 
where 1 =1 and p.nodestatus = 2 
	and u.ccode = '${fine_username}'
${if(len(startdate) == 0,"","and t.Billdate >= '" +  startdate +  "'")} 
${if(len(enddate) == 0,"","and t.Billdate <= '" +  enddate +  "'")}]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds1已办" class="com.fr.data.impl.DBTableData">
<Desensitizations desensitizeOpen="false"/>
<Parameters>
<Parameter>
<Attributes name="fine_username"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="enddate"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="startdate"/>
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
<![CDATA[select t.ID ,t.projectno ,t.Billdate ,u.cname  ,d.cname  ,c.cname  ,t.ProjectName ,t.ProjectSubname ,t.ProprietorName 
from FR_CRM_PROJECT_SUBMIT t 
left join FR_CRM_DEPT d on  t.SaleDeptID = d.ID 
LEFT JOIN FR_CRM_RESELLER c on  t.ResellerID = c.ID 
left join FR_CRM_APPROVAL_PROCESS p on t.Billcode = p.billcode -- and u.ID = p.userID 
inner join FR_CRM_USERS u on  p.userID  = u.ID 
where 1 =1 and p.nodestatus = 3 
	and u.ccode = '${fine_username}'
${if(len(startdate) == 0,"","and t.Billdate >= '" +  startdate +  "'")} 
${if(len(enddate) == 0,"","and t.Billdate <= '" +  enddate +  "'")}]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds1已发" class="com.fr.data.impl.DBTableData">
<Desensitizations desensitizeOpen="false"/>
<Parameters>
<Parameter>
<Attributes name="fine_username"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="enddate"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="startdate"/>
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
<![CDATA[select t.ID ,t.projectno ,t.Billdate ,u.cname  ,d.cname  ,c.cname  ,t.ProjectName ,t.ProjectSubname ,t.ProprietorName 
from FR_CRM_PROJECT_SUBMIT t 
left join FR_CRM_DEPT d on  t.SaleDeptID = d.ID 
LEFT JOIN FR_CRM_RESELLER c on  t.ResellerID = c.ID 
left join FR_CRM_APPROVAL_PROCESS p on t.Billcode = p.billcode -- and u.ID = p.userID 
inner join FR_CRM_USERS u on  p.userID  = u.ID 
where 1 =1 and p.nodestatus = 9 
	and u.ccode = '${fine_username}'
${if(len(startdate) == 0,"","and t.Billdate >= '" +  startdate +  "'")} 
${if(len(enddate) == 0,"","and t.Billdate <= '" +  enddate +  "'")}]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
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
<![CDATA[SELECT P.projectno ,P.ProjectName ,P.Billdate 报备日期,isnull(f.maxDate,P.Billdate) 最近跟进日期,f.maxID 最近跟进ID, D.cname 销售部门,R.cname  经销商,PS.cname  最新阶段,X.follewdetails 跟进详情,U1.cname 跟进提交人,datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23)) diffdays
FROM FR_CRM_PROJECT_SUBMIT P 
LEFT JOIN (select t.projectno ,MAX(t.dDate) maxDate ,max(t.ID) maxID
						from FR_CRM_PROJECT_FOLLOWUP t
						group by t.projectno) F ON P.projectno = F.projectno 
LEFT JOIN FR_CRM_USERS U ON P.UserID = U.ID 
LEFT JOIN FR_CRM_PROJECT_FOLLOWUP X ON f.maxID = X.ID 
LEFT JOIN FR_CRM_DEPT D ON  X.saledeptid = D.ID 
LEFT JOIN FR_CRM_RESELLER R ON X.RESELLERID = R.ID 
LEFT JOIN FR_CRM_PROJECT_STAGES PS ON  X.project_stagesID = PS.ID 
LEFT JOIN FR_CRM_USERS U1 ON X.userID = U1.ID 
WHERE U.ccode = '${fine_username}' AND P.DR = 0]]></Query>
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
<![CDATA[SELECT P.projectno ,P.ProjectName ,P.Billdate 报备日期,isnull(f.maxDate,P.Billdate) 最近跟进日期,f.maxID 最近跟进ID, D.cname 销售部门,R.cname  经销商,PS.cname  最新阶段,X.follewdetails 跟进详情,U1.cname 跟进提交人,datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23)) diffdays
FROM FR_CRM_PROJECT_SUBMIT P 
LEFT JOIN (select t.projectno ,MAX(t.dDate) maxDate ,max(t.ID) maxID
						from FR_CRM_PROJECT_FOLLOWUP t
						group by t.projectno) F ON P.projectno = F.projectno 
LEFT JOIN FR_CRM_USERS U ON P.UserID = U.ID 
LEFT JOIN FR_CRM_PROJECT_FOLLOWUP X ON f.maxID = X.ID 
LEFT JOIN FR_CRM_DEPT D ON  X.saledeptid = D.ID 
LEFT JOIN FR_CRM_RESELLER R ON X.RESELLERID = R.ID 
LEFT JOIN FR_CRM_PROJECT_STAGES PS ON  X.project_stagesID = PS.ID 
LEFT JOIN FR_CRM_USERS U1 ON X.userID = U1.ID 
WHERE U.ccode = '${fine_username}' AND P.DR = 0  and datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23))>30]]></Query>
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
<![CDATA[SELECT P.projectno ,P.ProjectName ,P.Billdate 报备日期,isnull(f.maxDate,P.Billdate) 最近跟进日期,f.maxID 最近跟进ID, D.cname 销售部门,R.cname  经销商,PS.cname  最新阶段,X.follewdetails 跟进详情,U1.cname 跟进提交人,datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23)) diffdays
FROM FR_CRM_PROJECT_SUBMIT P 
LEFT JOIN (select t.projectno ,MAX(t.dDate) maxDate ,max(t.ID) maxID
						from FR_CRM_PROJECT_FOLLOWUP t
						group by t.projectno) F ON P.projectno = F.projectno 
LEFT JOIN FR_CRM_USERS U ON P.UserID = U.ID 
LEFT JOIN FR_CRM_PROJECT_FOLLOWUP X ON f.maxID = X.ID 
LEFT JOIN FR_CRM_DEPT D ON  X.saledeptid = D.ID 
LEFT JOIN FR_CRM_RESELLER R ON X.RESELLERID = R.ID 
LEFT JOIN FR_CRM_PROJECT_STAGES PS ON  X.project_stagesID = PS.ID 
LEFT JOIN FR_CRM_USERS U1 ON X.userID = U1.ID 
WHERE U.ccode = '${fine_username}' AND P.DR = 0  and datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23))>85]]></Query>
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
<InnerWidget class="com.fr.form.ui.FreeButton">
<Listener event="click" name="点击1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[//模板路径
var url = "${servletURL}?reportlet=/CRM/项目跟进/项目跟进_填报.cpt&op=write";
//窗体
var $iframe = $("<iframe id='inp' name='inp' width='100%' height='100%' scrolling='no' frameborder='0'>");
//将窗体的src属性设置为模板路径
$iframe.attr("src", url);
//窗体的属性
var o = {
    title: "",    //标题
    destroyOnClose:true,   // 是否在关闭对话框的时候将对话框从dom中移除
    width: 960,         //宽度
    height: 600,        //高度
    closable:false,    //是否显示关闭按钮，默认true
    left:100,
    //confirm:true,     //是否添加确认取消按钮,默认false
    //draggable:true   //是否可拖动，默认true
};
//弹出窗体
FR.showDialog(o.title, o.width, o.height, $iframe, o);
//$('.fr-core-window-header ').css("background","red");
//标题背景色]]></Content>
</JavaScript>
</Listener>
<WidgetName name="项目跟进"/>
<WidgetID widgetID="5e56ac86-8cef-4214-ac97-cc2ae9d10342"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="button1" frozen="false" index="-1" oldWidgetName="button1"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[项目跟进]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<IconName>
<![CDATA[add]]></IconName>
</InnerWidget>
<BoundsAttr x="670" y="2" width="80" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.FreeButton">
<Listener event="click" name="点击1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[//模板路径
var url = "${servletURL}?reportlet=/CRM/项目报备/项目报备表_填报.cpt&op=write";
//窗体
var $iframe = $("<iframe id='inp' name='inp' width='100%' height='100%' scrolling='no' frameborder='0'>");
//将窗体的src属性设置为模板路径
$iframe.attr("src", url);
//窗体的属性
var o = {
    title: "",    //标题
    destroyOnClose:true,   // 是否在关闭对话框的时候将对话框从dom中移除
    width: 960,         //宽度
    height: 600,        //高度
    closable:false,    //是否显示关闭按钮，默认true
    left:100,
    //confirm:true,     //是否添加确认取消按钮,默认false
    //draggable:true   //是否可拖动，默认true
};
//弹出窗体
FR.showDialog(o.title, o.width, o.height, $iframe, o);
//$('.fr-core-window-header ').css("background","red");
//标题背景色]]></Content>
</JavaScript>
</Listener>
<WidgetName name="项目报备"/>
<WidgetID widgetID="511d8eb6-be78-4361-b832-9b282e64e8b4"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="button0" frozen="false" index="-1" oldWidgetName="button0"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[项目报备]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<IconName>
<![CDATA[add]]></IconName>
</InnerWidget>
<BoundsAttr x="540" y="2" width="80" height="30"/>
</Widget>
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
<Widget widgetName="项目报备"/>
<Widget widgetName="项目跟进"/>
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
<WidgetName name="053020d7-ac04-44cb-bd56-8cb784221a25"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[项目报备]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="430ae3d8-dc40-4489-b33c-3de0a9c7a463"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[项目跟进]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0" index="1"/>
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
<WidgetName name="Tab00"/>
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
<InnerWidget class="com.fr.form.ui.container.cardlayout.WCardMainBorderLayout">
<WidgetName name="tablayout1"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="tablayout1" frozen="false" index="-1" oldWidgetName=""/>
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
<AddTagAttr layoutName="cardlayout1"/>
</East>
<Center class="com.fr.form.ui.container.cardlayout.WCardTagLayout">
<WidgetName name="tabpane1"/>
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
<WidgetName name="982d9a8d-9fea-45e0-996e-3832205cafa2"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[待办]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout1"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="92861700-0be5-4bb0-8e06-0a86628283e3"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[已办]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout1" index="1"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="3294ba15-e56d-4c93-ad2c-f0d4d92eb442"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[已发]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout1" index="2"/>
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
<CardTitleLayout layoutName="cardlayout1"/>
</North>
<Center class="com.fr.form.ui.container.WCardLayout">
<WidgetName name="cardlayout1"/>
<WidgetID widgetID="e5ac87bd-bf1c-4c48-84a2-9172f8121254"/>
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
<WidgetName name="Tab01"/>
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
<WidgetName name="report0_c"/>
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
<WidgetName name="report0_c"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[0,4572000,4572000,5715000,5715000,5715000,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[ID]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[项目主名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[项目副名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[业主名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="ID"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="projectno"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="ID"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=A2]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="op"/>
<O>
<![CDATA[write]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_dialog]]></TargetFrame>
<Features width="1024" height="900"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/CRM/项目报备/项目报备表_审核.cpt]]></ReportletName>
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
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="Billdate"/>
<Complex/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="ProjectName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="ProjectSubname"/>
<Complex/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="ProprietorName"/>
<Complex/>
<Parameters/>
</O>
<PrivilegeControl/>
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
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
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
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<EnUP55!`1GrlFB%E3G-.A5qR@="*PF7`&9:@r2Tiik6)JZcVR9I-TUQ2jRRO\]AT6)%aui[
Ce:+KeP(9-BB*i.en*c1cR6mlBi$n%ZVYj;cM+o3CcfmcV<flaf;Vm;8sNJ!Tt79MA.Nb%6L
s@U_PND?!2o!M7LdQHb5B?%-n7idt*._>L*.lO,[?j'Diqid,PHZ?;2Ef_=J"VaiBN9%9O[0
1]AHS39W+oISJPTTYmae)1SZ"]Ai8^T0;[<c^399!:&XK'Vu*mRI\t1.JHY^S.N:TujQM^X"DN
%#cch1$%u1(^j[)=aq?DQ8XhFWu]A?`llH.&pXX5,Za(r)UP_jphZoASd>_aNkRK\i#Gf&<;I
g(tm#B8;GgVB1UF*#q#C2.RtUoi.6\AX2QJ7tb)A<H-,Lq[A8.i?)t:<cUge*23c;VTc\Rqs
<@%e3cq8`")69_UG@1/t"=/YOi`S2o!Xk@8DpU3AnId7(f*A9o1B=hW2l8NS]AG)?0_+n;J-O
ROUP.DICYce;0#63$6//'km_?dOJ$Y8WmM<Mma)I,?m[T[>^lUd>ILV!P?G9WqHOn__NXU7K
/XLHPSHR#E.cDbRmt?Ro4VJ[Cpb/D&]A)+p4!B&"N-_^nZ)\"0D!@mM[JIi-:o87fJlN8;>%j
MH/Bg4V/m<[MRtu`e"E-9R)GX38qb:u&"`N1cYNn"QHad)0`0119498kEG`GX9)K*f.dniPi
gDBiDgrBnDR%2^IAOGI24><m8JZdnL=!*:Ri/#O.*rPV;>"AK/"&%#\VJUPe\4;MQ,R[+hoG
KB7`7VUG8biO5j5%P/^uS;73N@&S_gAhJ1nUqIBhGYXf,'ipfOe%Y;,RQp7`0#J7htWA$=tg
a,PFbFDcX08Y4uZ$X1FH_^3VG5!#j^?Xb\f:MUt@L36QS7dIJSj?H3C""eq$u]ABk@6(HnNW-
OPI_ifZJE)l>\PU'-[BN(.EjnQ'nEE/:_)j#*2mI,kX+=2Djrmbf.!:n2=WH'Oqnpe=RNeC;
r*d)hcSF5SMHG_kR9:r%m"DU50s3>'uuZ\VF*XpjrFEpbYk"i;od,^AY7M=Gs)S*D"bj+UF]A
n=*KhOTaWBbjRqN;1G;D6fa:C9@5l>HSjReP<j2hA[Qt5DR7e'>SH1pa0(TLkgb$bUrh[ng:
8kDh7a/GO3\<Ij3*/Z\6X^+E@B7WMkB<Be6LCVo-+Us)@HcTb&'OY\Gg9JF2o[+j^!UoDW:p
(P]AIA8-\3S.kLKu"*b9HTV+kn<*-Cb[W_OLA#QY-M7l6Q@UYbA;Z+/gnEW6u/@b7Y?0"g0:k
BDcWLr!m'_YNQLiShjlU4BsT]Am=)#_MqcLEqS]A_WbZHl$!Imo=U+GcV?,2F2fZR'ZEUQ"&eM
VDmtEoX&/F=<1TJ[G7AsSgg1N)*%AM[XXQ0*14aG[':f1jZ\"V-lNf5O\GYNQ&UYI<`J4,>k
IiXiT^d_,*[p4UbT8]A\V,gIMAVOi<L=/&DB#Fl>eSYoNZ,pH'QZENY\V+/o`'n2tmd5ekuXZ
<C/F3aFtW+T;HinK+p%CRtgJ,r?J+m_<'3<@:BH2e&*q=YSW[(Hu'/5Yf;*B0u9&(_PYDNNt
`&Gad^elVf&I`oFim-==bj#gjt[P&]ANqCQZeeK?6qbFjsA_)(*1-U#0>TuJ[N/eWchXlR5lG
fbcfLHYreD8fJ:P&3*lAN!e,j(5K2@nhON_(?Xs83q2d,;FNJ>9t7f0rR%k59=F&5(l=.mb_
9@]A<+"cF["C$-(:5^-(c+_c,2.M/pd5pOuTskZgfhl/@]Ao-m%_9n4\r#4A&AR__ljY'BFs^.
Pj(f4NNgAC\PJd.kfG"qfS<0$WN_\,FTO`0_?Y_]AJ%QoP&%JHn1OR(<Ebn"[I!q/0C3(BX,,
%OAESaKebXXaLM^#"K[JtOOSIH'3j5rK-!\00">N9#GnWmCpg,E\$90"uHjSRu_Ru]AZ^BWe,
lco$8cbr+/c$ah@7PWT9UaP+u2;nn8>N4Z^]AiDE,p`J';*J`qqLg2&!(_t($mM)Y,>V&Z=g5
F1R2Xq72Y)q]AW5BT!PHjDC8QXadGe7A0"b(/$<W'WEf;3Uksg9?1CW^EfTipTYed)]A"N@3"d
AAQ?MYSTLA0^AWV`<GpU3(p;H-f[_r`L^]AuntV90U2U2Rjo^9HYp2]AKKf`XPdDJoXD6FMgn(
m+OMt@h'7@'!K<dX4?[Kq.>uC-=q^p]AK.NJKNb/b`:#Y*Mro&@'*FF^KjWC_D,Np)VRP`#mP
!'P]A)#`tHp'N]A[o\D)/Ya_,9pX=Kd-*i';2C8DjJ5O'*3q2;mi/b=_YDr$bA;HoJUPsZLbQd
U?3da92mZ;_HJY6T(cE"2d?QHTWnVT7F(rj[5F%pQZW4<oC-G<k:=m5l5+DVcb)]A)"Gd$)mV
IaR^i>>*B!_#F@`-rIlT*hJhM[/kr*!7$O'X&#pL9U"2N3>Q,hh\X_(O,X$lDh-l?-:-glK#
9#]A7^ehi5MU;'4,jo9^mpB1"4[<7I.tl2YBWZ)Ou*t3^=qC!.pjSg4=s9LjPl2a>J/e$6mLX
9)ZFGafqnT>]ARF.eP!C@3L?"')jZC_,NmXBpeH@#>$E=9LW?1/gRj*qUL#Pkod+Bq<G&,>Kb
Q.;QgQOsVPQ7E#0'-0\&^6>4!*kP&3lIMY$%%`]A?B6^[hts,%j%7J?mq/1Cr&6K&F5+6mrt+
5GN+q(PK\eG^!l9eDNH7?AlUR=cl_\Km&q'+R\_=EJHeR>:"e-Kff;EjXn=C.G(*k84LCKg,
\Khd>%#o'$Rk8@*p7"bHrG?oWo^;?+.cu3%pBd/"Vu2NGi/?o)*C+6:$u$fPm^3L4XM5NH#,
',T-!)K&]ApfZ0\e]AbcKdQHiNIp[fIc2Qlq@3)ORr$CpN(lr_'kntPu,>-.m;q[E^tSLe+#HC
QT3584s@8Q)-_KJltUr3L4523]AuNW1@!Q=[2u9=KnVJ.IWNE2J@:;CL>fH2]AdW@;]A.kqq4qK
#Ql[8<P0auaK8_[;gDo^81W2uQJK,Q[<RJ8+liE<I!LccLEegMbtrC&;!8RdTnm[UJAT7(V3
Fj^(9t4Ep<paU84fC2pLoOsrT@s*Xe;4sakk_5M6$WsF$5dC#ot!=p*%HB&sQCiPs3-7hP@H
1-%!g6PXEHWOt`T"^eBZZashhVfig9U^f\LEog%-^<M6q>TO!,jpDX.'N@tUbM1SK-$dN$RC
p+?.\J$@Ifg02aEnU4GXY2I[]Amk<A\*0K8W$e=RdIuru7^fo<(+KCG#.\,HB$DMK4%ODuGtY
@!^;N(!K?[XS#&#ogrPb6/>Ni&uWp90;+SKbCYH2&N@cq`6I_rKk:ft>WsL&l/aPn`rJtXP.
SSV*W('mn"8gM:1rJ/PPjK!g_`<'lP1g1'#afbff7ddMRmdrBUbs?CPg?@YF"3n=mBQ5a8fD
V4LN2q1b8Ag@7T5DEl*I$"*E^KkK7CaeV61`bM0-DFFaQBmUMmb&o*lb0H).ETn?+P"iLK_Y
+CnnH+>&'Sp"42eV<``3@%-I-/fqIn7gp\R``jDl3G'$p?c#N,nHrQE>Z>ChZ.sXpo)M<0X8
Il6g)8#[Y++B6@]AkZTANq%"oBq@)Z0m2a7N=c9uKU2f_\U5daiDF'LC!DAqOnnb<l'u?(VRZ
.cd=skfj-b;P`8F%[IN'N(NuHKt*<EPaP5A%A@Ekr.@f&Xh138U*M3o=,?I7"V]A;IS=\AZHS
']AS'#.I!b>U!ni(+J.R]AD\(hS"5SO*IFR<8JX&]AEXi'Srck?Xai`AmEjLkfEAsR>l8?kHbM9
.:2R:4NF8knF@tH2k2I,I='C-3Rodntq)I78H#)uFL#i&qCLitY7[ND)CDdH!RndKX+$M(b.
YK@U-[jFWXBu=e=OS>*]Ap@H&:>4Si_:h**Nk%%MgG4DCUHMY,WLW,V'Qe);KI+Q[4rgH;Qt?
[=Y?R'8H[iN@0BW#2aJM/FaObY51g1&?BZrO3i]A"%PR*XY+\F%&DI!/h[lkU9SN2IoQC?<.n
FJIKJIOgNLo02j!T3U$qUR]Aos?I=RA>Y$6fbfPmSFmj<rkg(I14Et6&ELK0RKgbRZWsfTEcc
@l$CF/hp9@^=Ae/-g=9,AS,nNLtD<NkK,8(ee5OZ_2`-?>U^Fu^Y^DQYC`]A7'?[mNGdo9^8i
RE=um)?PM>L4uo]AH6!&TAmG0UDV6kB)i.0g,l\/hVF*ucfKu;L,A+:aOnQ^=#!>$e]Anbn"hD
)1&$AE7NtDTAeNZdc\'Grp@E.&!T`Otshp?Io$5E8C4\7F;KYe]A3niRY==:F`mA>`42J,?oP
#+OADAA&pMs"%S!nj3_um-3@C=X:sZ^5"hL3'Tu(/J2"'D&:Q'eB3Ms79!km(F?^_&/+QoEm
#Mslpid0mX[@4W^+$D>E"^Y;^&Tqt+=!RrDkUq<<PM8!13"e#=QJ\)(5Z`C8ke1ptgIc:aW(
M^nqAJ!70:@<&<JO&mo`>F:1!;_)3QJ?RaW?"7e*BuFgTUPDDKn<CpsdeXYm!/)[a=f6#X]Ag
9r;)(O0)Z*;(j\DE;7dW5W87g[H8%f3+SN7>,I-W)RJpAK_K\^'2-*-EG!)"&Vc$5jepLQiV
01=d;*gkp3G_Ei-%RRl,JE8MPr3<D[U.RJeT<H_7fKN'*pHdIdh-Bg<*ILDQa/%7J^6?6+j;
D)KGYmLn9iP_0BjL%jk_mb5,70T'9l:.dWMFr7P.AhA1oRl4afYu/Z@\^UjqD`o)<]A(di&!I
<):1L78F^''b@MM`NF_DM>]Ac/Eh__B)VTX7:O!&i``L4*`9=PS)j5mATI.rV4kdDh^VQg2Bq
lIqg@S,X`3I)2'60.9rH!uVN>l=H@khuARri.jrF>Ynp<q=*9qX=L"NiO%b>cq&<g`K$(E@f
:YJ=K'P\Alc6jj%#Y(o:J.T^Io1:]Aj*MqJ8H@e^b!dhbnimfQ8X6\u`GdlaNsDEpl$7"\1i^
oZ7e[2lCX0"eHX&5#pGEoL[PS$oLr'n6XO:Y9o^+['u4f25Yiqk?5(Ke]A:um05]Ai-6fT6!RE
>;au%^;JSNk4`?aD'TlrF&BVe$14kX9dWBklrB!%Z:aK(tn(S]A[5N>GXmHDVMTd8L-*)T!=o
;27D7F&*m=jt-q4`#7u8>>>Gh4sdMcrIZG'04r)Cdu%t$NY#aWcbKVYa'fB4GO7U*#gYaS?=
6Okq!pGproiPCH_+2dA&_BIBgBA[JX)-4p$5fcA,aJ'G1p*j3;Q5&(f,pKipTU5LVW38QkAf
;,o&eFg[,(=EeRr0q9YJ)oKN%Qa\RNeDeCkDr?jS@L!nD7,NLZ2TuMns:6*7%pCcB#7VL09c
g$c=BRuSJ$./)92MB`1`(6;JlLsaIC0[Y`Fb@Bk(g*6A(M\qLCR@u$C\,_rb78jg+/>=t;sZ
ibkZbY5_`g7=eh=7Z3O@RVN?#UhopBQ$Y^Qj-'rQ,GJj1$,`M+.86S!//G\gBL;;_0)b/1:G
eD_R*!QF>]AnXnl,]A_Lm1J(o[o'&Tb)%ir&Y:`tKg_)mZgQ4*+a>1%!jg+SS&bbuRgg8;FA\o
Zn[1D^o]AP4SZT=X!=RGfPLT&#n!j4P@m,cM+3bM%:EiT&"0U7=lRcSkMV7JX!L$)n#9o[)(]A
3.q`4:>sjF35[?shF;_]AHoa'*LF3Mk,e=Y#u?FsQ6=$C/c/q6[9nEnW^\^L//F!ITA@%E&4Q
gTD%!ubsq%JtK7TN-h)9-5h*+4.`&]ABbGF_jRV%l.);9_NrS=&g8Y`kLD"7O58rIX``ekLPE
Okl)C^#M_6<IQ8>["5t%*AIEA;L;J]A\Ie6r0<^iCaQcX@bfP:@=ae0L<PHfi>8@<8!'\V]AgQ
7_O0*KC26X_BkIP3mP"hp%a276rR[#)$Dm3'Pi*-:,_"h,_CX<^b=?)_epc\6(`KKBi=#J>H
O,LW6qH'_Y"br0a2&@X">>!\E7KUk_H1#@_"%-IpBY3X5jM^j_h4Rg3s8EdJI%.PCfmTd.ch
A1<?@^^4d8H'Q>!l-K@SU@\PPRC(:]AkeE`G+&U$D]AEmaV(c]A!@dcD27r#NL6&W5V4shtK/QJ
!^uDQ@mBb*DY$OJQRNO)M(TI9pN*pUJl)kphao%cF7HjBVt+,j!,r1['g[1($.T&JAR$rXhL
':fjZuO6U)OplP4Yijg:Ur'mrW8MJM<Als=TjnCCs9C&&C_]AB]Ao\=e7BFK8qNem_0I.6EACm
0CE)ZIu^5#T\ndALr,Y$-*OYAd4H]AO>HeatJr5,%Wh;IKl?N(/9lF-0UVTa4SY+Io'r'k+6b
aW^-NYlD4@0,5a+&)p>qrtF?TKQ]AbS1+AqI/=G6APRQ_'Q'5KNqd?UCqqZ6$LC[[#S8_2#)U
kr$sIj-4sKB`UIdjD$q_8*#I(43*WU<?`nPcG$'-Mi<!3^N18C;CC6^9B%t)a_+`^/0,"fZa
gr&(Kul\tCgF4#4SV9kTu;lZl3I4=i>nu$fS+@io%(q5rR\)pRL(VNkP:"^<9<01bJkQ]A-V]A
0!i1O7N'/l.t\<bl6_oRmV4jBc!lio$.Dr4Ha:7jFf^*D*K`:Q<f!U0%BroM4t#i=.*EAm#/
1TWAd7+A)NrBESiO$:\C(Ld=%?L',?gI1n21G\^\Em2PtEu;ZNHW<3em"\pBd9MDGe3Oo$Bc
$'^EXAat\89/,J^RAQ(Z+A^-+-Wh]A0V5^r$V(_0GX0pRNDE^*k"I';.I>SQHHg8,#o82p[H5
IfEDVMAi_>MgNp$4Y,s`9PBuo=eUu9VK9?'rT+m]A6Ws(`jS\#E8HT6iu*>1@#e>@*W(%3H-k
McCZ$]AI=WI[fY'R74,f=qtS&ZjHPV3[fL7"8.-gi$5`h1l(%,24^D]A=K8mc/JiPfH46piQ`"
8Xn!!&:hda[5`/O/?QP]A;'`,=]A?%;p;@ZHu_H;<'SK0/,D5=jJ'[L1QD[ROV0o_fP2UM4Hh@
XekeWa.)3@>q4:R5JFCQQM@c)?7d89AJ&gNY#;Z$FSBuo1r$on<B7PupBe-''AB`FE.;RMrk
H/i!0laNh#*%3cCGsH/f.giK\orWIaZoN7;4krrThnkbgM7$5&m8B12k[Y"V:3UR+>a?=9*C
i<=L;ur5nil<2t^p*PRTm9$[!DN.?mW^%l(TS&^P,A-bYte*BsiKnf29WU#tL:`L/.1=8^ZL
!C#+lJ>"B2merDQ'buC3;dt7!V*H6:%`IJ$-Xd,Rp!PcH%bU+9MXfjlg,!ImBWNL=0FIRVB4
UNbkT^W,]AenaLnB"I)fhIohMPW!")_<1SHe2^dB*193Fi#DR$IZIp<M]AYUbP[6j*:B5]Ank\9
je=`Q)Fn[(Bd@3jQe!;BU-#FuOV9!nZb'(HMbh6b_dg0IK3.cU41GQ<i(`0$!huq<%E6#tfS
VWoHgkot';c[b=/?6Wa3<W"ea]AFUjj@q%I9M/WJ-&[)6Rmli:R7L`]A;eeI^XTAXd3snE>2uU
$A43;H0=fJt>NhjF<(-\V7DnQ'abXYLVC']A$l13P8eL#lQs(mF&)_'q@V78f2=>1=6g0C+b^
*ofn:ZC<0)+ZR#VF*]AZapctigQT,=pIn]AhF7?Y[NbGe75/AX8Pnbuk\3<</PYN'"pikA?'HL
PT[=M/+GJW7SN\8MjpOLN(J.(@LG`sGL=r"1jI]A_jU%:.YYg[NVTiftjsL[N.CO#+`"pKpY?
i-I4\R>`Y/[FW\LI>C2uq%:0,r&.7T6<%f^3*?+g%`VnWpo5\kWD;*tr3<)0ICa35bL_WJ#+
pog9518TF7J4aIa\Z:1l0>laFO8;Y(*p`oOU0h>FBfE?RsgE=H1.)C>,?1<:f]A0AUB(orct.
1=?=$h'QF?7]AWRsW.PV82/6:;h@;=7KaQ1DRobprhq5%m,&@L^?";2="!jj`!W[q1g?tlRWk
ojeU"f@+9kX$0`RrI10grUQ*Yga-Zb7[EHJicNkH]A"E/fVMA*^Ru?XhR+m>H:dH"MPF6XRiZ
(:X2Z)(c?dQ<pqjkBqBhq(eqRW;Ii!GE)E3ABP>P@S"QcaFWY9)C]A%M4jjKkpIfD=aZ&t228
+?%6,'ifEDon"f1%(ZW1OZsV5&K_MY3r!<i$Je&gDnPE"kgFaY%MK7eL0oL7J?`4P$;<@>oW
)Ps`+_J[Jm#0&[8lE8^ofj^\=hj\4!*rG2]AG:Fg-N'Yj95Ta8PafA5<0r2[_No*BR;[</h5,
JWCZ%-#e%)tq:m3+4o1O38ZJ_$,#7c3)H#?\feD!%?J<GH,qK>^NEGV:*c>+?>F^.=o/(b-M
Hn#>hVLl<n:75km@OVRX[Is<gLqbcE>lh9o1Qh7`"<YM7S`NC4K3Im"(#o67pN@4"4T3h<l>
AS!H;f&6d7Fh/,H>g/c#b5M8DHkQ^D/g*uI)?KO=Hf0t*.REQ#U%19XB+;:HSdd&*PdLhi")
@fma^@l<\Dd-(W^>9-Hb8r%R0EV[)@?C=BrnE>R^ipuc_)$*.c-F8rM8q?dH0)6-PG/aKIB4
idqN86gab8Oi6_MOHG/QJ/(cA7SqPOK0Vkrp)>Zq8rOS<]AU/D:;tBj]Ah<;dG+iUkSn&6"44B
$=pSX/aBtI**`WF'gUf/B9UfhQ<3J$q%eUMsg\Ml+3d]A7/@#E:nl*.#R@.1.ALJ?n%fq?+^b
oZh/*j7#Ijof^8TX[!<b9%:Zm"!da<6[Q)W./djL;/a.r[%.1n+uONqJ,YZ4G"/1AK7Ak9'd
Z_fZeJ5]AQQ4[>L]AD/6W/g8Bc_5.H*BE+$]A"U=\p+Ib=M=!=\>'e7LO7jR1I`1#-KkI5VVOTn
]A(!C$PBh@Yf*LS-)s=.b>JVXeoA$LKlkMSj:Wc6(c.?KAF\06$k6E(\YHs6iGp!_pPNRb)AH
1,XIaRH;?:=n[N5=a/lU_ubqUp%&TlcYRXoWEHJ/Ni/0@5+ee<:[`'hd0!@I^(ol)3RXWl8\
4mp**^hQ$CG)LA"\>Hb4GO2PLsr>J0"$c]AH@nF3hu(ZIZ>l=&*-^ck>$(u-!hAEjB.9gkS"C
(F;&Or9eDnusa28I">C^R6&%c2PX?A[/h[?V3N"&`f\N!(jRuUW:X?.jJiCLkpJ\J=uhV.^\
^&\ogFfTb1Nk@c)<aq3<:QZ$UK22C1BYX/sjm&Vrj-kiThdBB&e'XNbubCC^dtcAI?=_%l\R
=2046cMB.sF+1El9&o&>PZq>%J:MdG<hJVLq$?16V6J:q"j#0f(GH@M99!hBF_'ED$[[/MYu
T0.da1XJ%46s9n$`)BG.+CSK,6,jhC@3#K?nggP2&kPo.a<BZn5,g[[oFn]ANh+S@i"CV[Q>W
k9mB$cf,u%RTH<<8[SOr[$Ds^oBbrpU1$al@,MfOlY5snO3CF=3YQF$5elOdI>aO?ZJHu(U$
rq"s(3skWDaVrH.u($YY<g\+Z2tg7fh4S249jf]A$95gB\9EQUX;8=rfDoBmiQ,oXfero5rCR
LEp*T"5b;70G@p9-X2G%"#GE#!V\d.2nj@IcegC!sn,o"VinY-Ke7]Aj?>3HJD6:)5FJVK?;e
;a+n>6A%ep(K0\O2q?W\T+P2<*qa(%S'DH^Y'aKC4jhji):/,"hZ8pBRskNdAnh,5]A"CJ]ArG
ui%>uY@FNo=d,s2bB\@>L@#La[L;*MO0'3X@>/ooqaeCUr+V:"6TA-)uL4(oI"3K@Ge&9kH'
#5ZUiEV:*eh>'`IZpUkWj]AW0=:$Vutth\4!n%T,kA/CrNa+cp$f1mg<5?`@!f;cZWb/k*?,5
S?H6$#2Jn=rWLW"t,Z6oi_Bh\shBR4!\TIjNuaO_dW#?Wi%'R=236T1VXe)AGfs7d_#<Cc?^
XJ;GJoMP<Odm9csM,bF;44`<m>06UKeEcV.9+"OOq]AoW@n_=BnOI-UH;(]AE?F@0Ip4ge;tZn
HXh2fh-MDA9]Aud]A"06W%E8?>915r?>:a)O(7Mo@s10E'\A_5.,]A>B*CQ=5A*f3KMB*<>88C!
_b2")f/`NV79.U-@H*NlpDJChH)6o[*<)P,VX10)0o6YY'>5!K-s_,]A#7ZpqI6iCEJ:rfX`r
X`qcT#h1/+9Q^eO=I)sCXSQ:GGI-jqZm@GCQ/G[_b'/]AS4PJYkFaY[Q:A0&'oa5&k_)QC#%F
q0C=1i1sW5VZkj<cp>DBq3?=Ue?-,-R-lnNfVdgE,"r\5Sm;).ksKp5MP^/bgB.c&%>$;A39
,QHcVBH'Ao7*'*Pmt__L8dEhh_5"B+MS&Jk?>$,A#N\gU&Yh<8&o0k.EM`EB6#J5d'M`g("f
Fl?%k.nK'g8EIb.-)4i%rlo0.G"uZO`kufn(##)-p3D(Q2!q@G_6aCRP]AdApm1j8i!+B+Q8C
AgP<d%bH)P4*9*7@<cSK<b&0:894(ip*)4$;a1\1^p%A^#eZ5e"2"_)4GK=%2IFEboLoKu9E
LUo?-S8b6$h*E/'[G%+X\gJSabPeO6emSq+bCu(T?p(eQIGThM]A(W^(qd@G>1RnJuj6c>[bY
'!\6Tmoc.ZV.=GM1GVF@C$a?"0fmkV;/b8?2*]Abp%B.S#sk?N$,`]AE2P>G[3klQ;!qOUo]AFj
!E65b^T"'AtpZ9SAbS4q(&2$D3B(Y%cg2q_Kc;X4e;0!&\@hKXS:>e&`&pea.]A;MrlZc.D=q
?Wg7:i6egR`Q_s$p@#t+2$2:VKEoVDcU^U5,!q.aJ_%`To:n'9"@TBBQl.R-j]Anp`/5c@TJt
=@2KtMfVa@?@fhi+45r<Fji@&T(+'SR`:PKB+c4h^SZjW'[WK`_H$Ijqk#pT0V4lHQ`U)1H_
lcO[m^@7X]AM,7qK*RosJ<(I%Kk$?;15l7bDS5ZgRLo/YI]ARSACO)8?0qG@lXl6K2(A!BGr$_
8_4[P[F*:8arb-neJ;[G^VR,g!N6'Qsf!A5o?s(f5>JA=X;=0pAR7P'R(@:Gh.'[4)/&`iq?
Qui;)LEm"V'&h.GI?bWtt\f4J9(8kfZZ)>p9Y^I`]ASgh9!,RgYKM9(a:?s#YD7.]A9kS3G.nD
K=c!Qm=5Lm0.%Mf$D:dk3b5<#UHgksn/:e["u:0KHu\g%d:gj`&b;?ZIL;0g)OS9ScosMfRh
UU9[;2mDEc#SJI?"K$&52;oJ"2Y@$[ids]AO?#nJ3)-6.7EnKP\iI:YH`Z_i2rrcP*r-mf8qr
Dn:lUYk("iqX.gB6g49-6ZHhSFXECr/\uA7S[bE$"8K/DR+eu_BgLjW4Y"C*f&GP<N8D*c\p
ufHL2Tqr^J(q4+%Ouh5D7=l4p&W2B6d,M=98!bs1%pE[rK4-D7g=h;c\1[/mK2*3Yr?lWk&:
-hlGqXrUtG-K!?qY1Ip)pq!Vj;eZifd447E`m"7O#en.*)5n%_$S%_Mo4^cV&c7T_L9IcA`J
]Au7Kq9]Aku.b$okuS[EhAJb/R'cX!_ZftQ6@;YgF(m!q1U%_)W/J32[!\-)/L45^UY"7C\$i"
!7!mXRCW%_)W?Y6BD8G1GWn2A<"'[dUA(ZF.K8hgG'G!!~
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
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="433"/>
<tabFitAttr index="0" tabNameIndex="0"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab11"/>
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
<WidgetName name="report0_c_c"/>
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
<WidgetName name="report0_c_c"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[0,4572000,4572000,5715000,5715000,5715000,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[ID]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[项目主名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[项目副名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[业主名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已办" columnName="ID"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds1已办" columnName="projectno"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="ID"/>
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
<![CDATA[/CRM/项目报备/项目报备表_查看.cpt]]></ReportletName>
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
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已办" columnName="Billdate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已办" columnName="ProjectName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已办" columnName="ProjectSubname"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已办" columnName="ProprietorName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
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
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
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
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m@!c3>MIp4SPIn=l>5U):cb;K3H7lCbZ'ECdS_s@:t6BqM,Q"[RT`]AiOeV!;C(?r>P(T2q@L
,Q[e<D($Oq7rWk]Arc_o,i@0ZEGe1cJGb4fA:;FqgB!%5I7[N'0Rad:e4,JeGMP_D[6[:<S7<
<h^:B>ZViJ%,\4@,r4:k3nEbiXd8m_jYi>53(GD(qQ_iKVPtZ?a14#8\kIBcm.tr-^GoE6O^
80S(\\U-a>Nl"_l'WKolf/?ZQq/ZQVps'g'51*3P@K4XX<kX1$gd!g/8\95FV5/96D,DX^WL
BTS8[9,7*N@_R,,j-%-c*h;4g99c`["rjJiHI=sN_J$2pEOk7R_*P0b,/2nKlcnMjlraY_#V
qe"p%-03^7WnN93OO^nk]A;?m@[cu$LQt_LbML@\IO5"=<cD_b6Y9"cG=^Y4.Idp!%_QisT6H
9Tb1et.uRK-qLRq?^R_!suVeNLiE^Jb8_5KGus\luG&>b=Asr/RIND%t:"qcq`uSV`'<WpRL
2:)[,D1dC;l\eXMp[8sWN.au]A5`+`[Z;OEcUhh(PC]A(bq2mK.0`P.]AliZI*6Tk!4E5a4P0NZ
P$oJH$HV"-9<-dO:1!&n\-CQ=3t*gf>buG@S^6^s*f,%U"$aQdS+P,9mo:!Bfoe-`=nfjB8n
kf9O?ii--]A`s1;Biulc]A!UYiuUkMWdTcB5p]A16p]Add+gI!<m]AI>Cq*5lSPNRG+R<n2?KDs16
Q^a!#X@hBiaToK]ASC0BWeVCS>E><\(Z5:cqT2qcJ_`\GU"InR26D5&oEAC5V0N,ij2jJD=*?
7,S4%D)7io0BhL#hA8+S@hRaTu&CA5G?P=,4OO]A_/_DSa"X)]AK?)_/]AON`ZmP7X]A\NBpRJP0
A6NU_X)G!45g0,S:8`P(kTYir8:ui)0Yg4LbYM_]AZ;e<h357)7jf9?@;8Y/^2<Aja1XE5L`N
E!h";ebk>HCJ7)\6"!@cP"s:\@lj<p.C\o+nkj.'NlnCqbQt!Ne12&M`6,jJun]A_adp-TQnq
!)\e<D06,,]A_$T0on_NLQ2Fj^72"Q;:pbK,BeItWP4\eV!sGp8ZJc!9HV"pO)6gMZiY'/9?V
Oj5t^,j?UXXf7)n.Sljm>$&X*2hQ+US8bEb:YL,X12Z#;>32MF8O-fX)[U3UhY-lDMK(`)<5
\P6JPoB1JRF!Efi)>?G19F]ACu@Ws<Vf#a0efX+iV^1YB<[.$dNW;i>I[cD!%M7apVfX_X-E\
N<gIjlhppN:HRW1mPoKV(]A&p,Q((rOJ*6U:Yq-4\=I^LcfY.SGD?HOE0a'B(!9%e&u+D`eM2
\=>k#XEu4;-SG?;u4PMXD*j6SrIf>:[rB1$p8eLZh?1=MTP'^frF5BDt,hAp]A,oaKQs/)(MG
tjJ$4>-GNUuI:SLHN&WUsa)K:tNC1f0(iautF_Qj[WLK>mF:/sT0P.OeiJs-6%n-7J(H)Ne\
CWe/!@r3Y^rq,gi:4>k+nRdKZH0+ITf4u+!-VK*J,?D_hF+pOG0h^OaPMNIfRTGatT;)'t9h
_u!*NV^kJnIY89[+[mYK"CJB0+^t=T+9t@!0iI[%OK\lAiA6*gSUf=J$>9jjYSnNbt.Yi:=P
[SSGRCJ;gLNk,\U%STcY8:-0]AB>s"rcp;&tkUW+Y`kA#%B"fK23Y[GV;_q!(VZaC%cG7d)QK
8r9I>5ViTmii@">b%`g?>-&YD&m-KV]A/e8K18Z<-aN-d#T$[_d)RWOfmR]AAR*7s#]AkAr!;4T
7-3%Yc33O9<SBQ_a:UC00bHN&RG$Zec7n0am>\jsG=Cd!Vqq<8Sp_DSRhq+6ALMf&YoDCWLh
90%ce\q=X:_FQuVLYp=b$<V(>cR,cVm>hq<pDXI@r.XC_Dfgc:XW0IM+:6uOrKb0#4]AZ.Ca.
l;2!rmNrn6>_Ka"/->g_r1#",>.Oq6FOemtYcPp^SH!R",M?.Dj4#5L\f!3O.a&g9b_^02N9
Sp'/EQKsZdS,Qm#.ft3'3?kF;(M,pD>6/oO(;>0+'dPH5&]ARHs[HRbZ6SWpp]A/f;!Fni?If=
WuU\+l1a"Q6"DWdnWk5Fo1)QPi(ZCX2FY;Xs?5DSP@[JFO0']ApE0ECh,ahrkTfE\U,`HM#5u
di2K3K^;\oq/M/+M@0MaP?R6=T(X,X4@?m5qSb3eX:7;p1aJ;E6c89uS$iI/bDm2f9Hh!gr2
q75[L"$4C0Gg#JH;i%?5,<m@tl'2P;o^t2mJR<J+ofX7lnP9I1M'BI^XL6d"0'D]AD\)]A+VFU
3l(2sK6'+!jMIf'CsheajA8IV$2R]A?*r"_?jUQJ8@j$j4c+*Z]ALC-d")9;3DKL[;I7c80bsA
s4]A#9)DO*iM0B^BR;%\^ALu8:6LI[S,%B-8s)9Iom>SdM3Q9,M0#%GO,f3DJ1_Osbqa)1L%/
QYZiPKA"4&[!l8-H85_,^V[hC1OoX[T@NI5B19/f$oh9q!Nc2V\/j2XT:1&_=<aDpS\6%:90
VVq>MrUH]Ak+t8#rRWWPHabFpnO.+Ukn@IAGMY^:[9(Y^%27eD=#s-FM$$cuV]A#U8-,0r1uU6
mR++B]AnD1C"^BmG*ZnYJV^0C&)0PfrWLIUTWucl%Iq<+:qI=.LeHq=mVr@*L"Y1&>1u$flrL
@RR+d6#bA/43b6'B;(GWJ5ROYG/cQ6`%'o_$4rk/sgI]A!csDLUEs;#@</e%QRqW#a,G[+,^]A
:h$*p,oGmF!SE.A%_+*Q<'(0IM9')+QdU8C'/LAMb#;l$>"7$LQN00J%=D@qVa68.IVg$jO!
,SN/hV\V79#'-2BL.kOp;PZ=.blJ>:"PDN!b&7,R[R"<`8TIB?U&;O`II_S&5(S,*[FUbanr
NPEUV#Q;d-sa]AJn.Gpbq!ccgJFbj1#UM3fIE!8!te`2s!6]Ao=[7-^E%cDWQ%V3&oFB%:?E0-
;0c3pRe9qCfT`B!rYdjUWKWV:Ut`"Q;V`Ud"nu8i"h5D]A#BPZH3UW!((ih#Z!1i_FJT).a]A@
ME>E3CY'"4F3`CC<TV+D[F@r)YNQW?h_;X^@hl&:I?7<jG^'=drR*.W?r-0XD&FNfbdQs#VM
G?c9r"3sr)b=`hVZWA,cY=/?tAfd+Z]A_!j/@.%e,AM1'-6GV??R?#^1[p0*Pj/C=t7>fV?W-
@suaTqQ3ER[.<%m.!o>.gWqGl5%9FRSH()BG+#Y=o6NL!g!il<c,%&F_JNd0?L?J)[s,K9?p
7J/MM![iuR@/CVug*L\3AN6aYscr<hd=ONft]AEt=n$>YSN#KCTnD>RfR5OuFOs>E`eS'I]ATq
8<DS-R@E0S>O@f!PS@HI!W=7lnfR0F:PMj3$h6PU;prR2)fcQ$Vh[Z"8JKRW\OGOF94$3278
O?[j68FmYfF2_\73i2qTZ8am4F2#'G0t[YIhg1Z=il1Ge:HAkD^pfnrgMGQ"VXKGVr!g6Y'&
79:j9aXo=dW(n?Sq%pjPl58Z,Cr58PRAs[,%?\("-BQ,(u7%rQ&Z!p<As%-9f/h:;63ljA]An
NY;ajj7M/2I2s1AH"=ZIM-`P+H\nTZ5G6g]AQPOs<90-t3']Ah*?1<aVB"spg3+q:)Cs;,u7I3
==-Jib8T_@VU?fkgXe/oF?qV7)c!Nj@VZ02"kaH9o-O7$YU:3bJN!2=l8%$cIF2uWBV53)?D
.7h4CWK!@I)61@Whc%QU?ZO2"p;/kH0X-N"=doYK47SMl+pso[>WdfU7bu*p;JJG28(&2$[#
5R8mbE#p>^cLn1j#K&@s,?$k?rH(Jd>oSF4A[@\GF[iWHe*>(XBV=mUT.VW;3BYDr0+/]An9C
U?;%s_aN7CYGF,*W\lPtlWj[EkI)jrIV;l;aO[862ilR6eN;rgm&,WXU*K>Fi&?MrE4DQ\?Y
(jlJoHfV+<+\m2bl^"mZh[F\*\cZ:rIJ&l/D'l&UF9>IfL<:nE?kB6--PQ5n`%9iPs<jA6RZ
'7%EL-2P<TD2i^_*Z&&;I>aq)=bMf*l)H$6UQ"58d*;+IfS/-VFFjg=QeF4n+gFN>enV%XqC
7WR4VJHh;q<FQ(9XMK`Ucg8s^RJ4]AiUl%&+(HquKZY&?VI(2VsRSC!UC:91ZK'fo;0YpaLI=
.K'_U/*X)-p_fG19Z5]AW!X+Jg5<M:.>^47k%ZE%,O]A5ZCfS/D%#1G2LE.i5:]Adh^tj=iiju9
'_tt2<Lq'48'uHQakIDM0EXjLRbJNH5Cfrff1(Ek_:`BN9WkhVZ2i?962qMOj5G#=X%)g-`O
?u""P36NVhV^kT:Z_#ZChqR!H+[:4/U>\/P*m%gc^1f+8$'u')W';gf6e'RX8:&PGsr\C,/O
*.0[<*D7Ji^_a3PmHd&V)*oBpK5HH5.Fr:>=<jCL"`(b-Ja]AR&m=?S#eUkAUWBIK[]ARFC7cQ
3P925@"N7"AD590#9k.T+F5b7OBM0BB5]AS7ZISU$JBHX]A#>p2ZTJpn@r+a@2,f22]A?ir:ao7
%0E6:Sip^:%t7Z_pfISu)]A0JPT-1?%'r+,]A[e($<8J!Yj#`EkM^ohp`iU2XDh?C8ODh>K(E9
:!T<jOD_M0QfV_G*RQ=DUAtqqn?Y6(CQ)NFF)d9MQ:H+@:pB>rQ4c<+t9khH)Dns"mY12-dc
t(]AN6",q[]AC_!h[pfrZS"q:9Ei+U#_+CV/Q,JpZc<f1km]A<r]A>A%:L':SN-G`pKJ&KfX(kf<
F]A/l#,HW<mMc-9+Ll;A:\:^g4J0b_JNt&#.#s'7.<EqYLCj#/YrNfUI&<3&6mI>>j]A`:JF#'
o\;D#@ZXfQNm2t"j7e-qd;e*`+>.t$MIPH"1BtmU+-,1Xccpk$<CVB9AuWX[Ba;$+*l^R0ja
%qS8uDH;F/VnND(fs%i;XTZADh_^/c1MNkFb9YT0%RMm73)V,_6jsc"YE\A@[W<*:2m>7[FJ
PW\X;Oq&,,MV+uYp[:>:&Fd0GPTX.D#3taBG\Q*eBo;Ed(#HV&pRZ=')?/)a^npsg7=oRZ?X
?`uQ01p45?M]A/oCe.>OVC!9[g!q)kDSG'+(V(L7\ZF2f\.jJ*\aju:0%g.F6-04EAe-ge>Xr
3QJjN(-la+D&KDX*`*h`5BlQ8:Z^pT1T$AQ#I34X,NHa0T19-&8j!f;SdHS,\`[OVRCJ/n5J
D1d4ZLA"j5W28l\C^&ZUI@R=c)3e6EE8sO4&975%cis'>/CsoDcQ$c'g5U$X9d&i+O/)=IC$
Y`VFSf-@K&=^H']ATF1.tG!=^T>)[NRLI15:?s.g8afbc)HgVGs`usUuPG20=snT1.!9s`oL\
0Gn+\mg;-jh*P.k[q>=nd9/V:Np't\\4ki?8pg"\IN\?`Hp82b%$7fK7'6J!R!Oi))p\\LU/
T)<G>+CrU(re7_KtjUTTPG@[K)d;anD(_')(ABK`O^bQ;!,H&?0P7S:kk%HP3s0]A,FJ&CeKH
-EqRm4M4Q"Z$2=un!nAXC[o.pW-a24b80:t`5&=-Ho<0Or(6jVn[A%C^F__$cU6ur-]A_aeT>
)^(>N8cqQNBB/tMF-*cmgA=k-Uac+J2QbLBSf_!aI6NZ^H>j:n-<N`6j)mX;%*=I8r__rVCe
_'cB3fALB8cK4+I\un*fuPrdWFA),5='7poM[S$H5]AaZ1/'c4aTF;Y$^,W=`me2n<;a1,MRF
+PO<TRd4N]A1+^7]AFUohRj-g\PA$9VsY[69j+U\3I26$-\WO9mFTYU4h%:3Lg>6ln+qFK!$*2
C=M2@sg_?n^9V&r4T2horWkpG]A.<c1mL^<TMb#q.+&APUbbLn;A*IL%)b@_oM)oO-QQQ9*#a
/^5?(:D01NE.B<ll+K7$siemIipm/b9(r@F;0:JTQA<=+3gDMS$^HF<4BdKo`9b$BbJpfHSU
l=oO7A&nEWT$7oYZYu+C^,^&9i\clN:Q8E(^l<nDig.NMPCCW7:]AP]Al,ID)6ar?3/-a59Sm7
Iq!M-%!ZS)cXmQ7i4(C4QW,c`Sj5KBI;[N#@h&mgci\eM*/8V1]A7%6b75,>KXbXMXV=I9i-N
NL%<Ddj[0b#]A]A-6VSpq7o=nn_IPpqMLZ2a_n74qj:J7l1m-eg;k]Aa3)"k#sEUSf_*l-DK$"P
U-U!W;#@28%OT--bBVY]A&u8sWbq=7fjMpJ$(Os@%^B,#g@u=?Upe^WR`1h&3uV8Mre_J-,K'
GB/397MY2XnnK`(Mk$olP`hSmOThBm_h3a+-i]AFk1]A$DX.)2Dok_:WsMXb['q')]AIm]AMs(cU
De9u33)IP*5AP?VoJ!#cQtY!OD-b44Vcud@?*S>aa;*d!*Gt&Ob^3n/>d)NbO(XSA"or>)kQ
02Phra)uVZbmiC-1-kn=Hfh`rjcC3d:FdD+>04p=toOIo07pOu%A7-88#(-Gt?l\j%n3-eZ,
./Lme\8:FGM\c02@.D0[_i4/9RJK:2If.c)[jjqY[p#HJJ'1P!fO?W(B;YPK'7d+u+PRX6!=
+0ph]ADMSO`6no')RORf[<euPR7TG&-@B6TRpeiQ88PrOg3#NWI6Hb+d$KT8W4_SaXnlen,([
Q"@F>eiUfVNHC38;cda>JJR-F3g:-R\1-NT!rg@F5<Ou)`;3E0=@DNXj:ao`V-BWGFp_R)X+
W8=K'8Tf)?S7[\4)S,eP^OrQpQRT)=b5G"l*;)u0YW]AZtm[*QK;BNG.QE.L\FQNB'g?/=OY`
lZb<aS8oI&7a*Jb&U)THWR3&q(iUE5^b`nV@L`-_]A(AXTe^5N/sF=%s`^@$,c)a>dfR_(j+e
YLlL/(?LsC_8q93VYc2Q!F5Mg-Hd?rlkP!(>)lfG4_`$Cm]A%p!$1K>sH#bjg62^dTkq_WGr]A
MXc=s!NkX4+nbs.R<>HR)Q_F0'\@TkOtAi^VBk2dtN\HfH6U2&Vq9lF,+U-,gD7;4]A,?%@6;
.[P?m[i/=3V<q_E1ih%4u,ieVK'O]A&ZO4\\K?V-Ssh?<+uGl>uhbK&fKJF44dVC@3i4(D7@l
7sHO)-)>95;nj(&qBK%pK"Xr[X7ZEu<LS0eR^;kHcDU++qq70tYPVb!<d(-hKD#0h7kE.@St
lXk%QQ&!lO#5N``*`QpE#TC2mDQPIq'(@!p+d:f:[6K6LfOE/-6OTH6G:la+V`N%Hm\i*CuC
g%ubg=F+9:Mju3q\#*`3V]A.Or?b_&MrQ;+QPQi^T<nTTJ$EN,/0.l1JsM5+8QRF*,r(`tf-B
#Z/ul`8?g27)'CJ1^V]APAPO<2^fBQ\"IS5QC$3-K,:qu_dEoj$Z8Bqk"PN3KUQA5q:.X"(1j
^gq\96T(ZE0)1c;@2"2aX\V/```2Do\XS8;!u@[#u$H;<\CXcWY@qXjV7>NKC2(2Q76Qkq0^
X-"X^kUC3WNbo.^pRLVGK/?UtXq4ib]A4NsHL@j"`O/pGK"LfEl_']AP4X1%r0BS6$,nlNg(TN
PSDTL:s^j"`ZIYG>?P9?VJG8VrJYRp[0Ukd=IJ9&mF<HigR;FmD7a#DA+A?V#$>_D!O[+`=6
?99<K]A'GYrr/5og+,eb*oFfG4X41n4,RT#1(7EiIm\,Ap-8/'U7>m2OqoV_Zf!ECO6P#Yrc1
'Xn"'u8Aok%@th^=9WZDb+6Llqh"`bJIZ(V5\nOf,BUai:.DljD[[N;fM<q4t8Es\=f_MU[r
c==bdO%bgE,[r7\p3lVf,;@K@Red4n'f(1jQL,M^HLgNIU52`5Uuho%#JD>1j-9POVX))*:r
(q-"O%rB9]A_Jlg0Z_&,adr./.OA.3sY/7/V=eBuT+TutA%(qliqndh3.P-AR+[#R[<dHMO]A`
4I&DbnahqjemY_+K.HUCYmnBEflRi(Ll#DO1Dq_S6:PWC96UJV%/?>,4)_-&Ciq<E)DEK!`/
sC5\1N;OaKjK'gmFi:Dl,1c_Do?N34h`RCeFku=J,\L/hTi(>`O]AQ6D?)R&^\8OFd`7HR(qU
B'0Lok-(Sk\c!4\PgA`4YNY>dVPhUU=R*G(/%*.@-Vub_78)V$EEis=dig*5o[#^$$D__G-7
+N?pGN`X4o=jb3m6Y&7o=PHVlBROJXML=fd4V@D9@HZokMD)2+6?0Jb6K&89i;4@L=-n$WF-
$(t1crp<WZYS&HS4&GAb%&UG*WbU"beV9*PTZWh-9uG`d'mRY8$h@jJXOnc>_[:XkG!5?M[R
BJ_m2iX8!SKA@/S7V<TVDgSg-"gW%nhcCcCbEMhq-@DPh(-(kuccD(YtOR.<Z4iL+GRUb>kf
^q&[d/eE4Y%)8%Vq2RnsSnu;&L.']AMql#2BEKWt]Ages05P:":G7&6;uopBL]ANjp>d*d-^s.n
DY4^Ic[%483HHp:#SLd!3HB&$)X"3c?aTNMZ,]Ap't,-CfW\hJG:>67SI=8NEkk'#Jhfq$aT4
P`N9,WHS7g\BmMQe+Z"lE.W`e%?FVqob@smOm9:nr,.H6?em$sBNeZ72lY_#PBRrDk9'#eh&
\`n&oG.MocLUYJ=pWgJ&2X(O`Fm8V<$`D"nHjT@mO?aSHJY*l'S)!S.9_tK$='*hJ&]ANOADK
@'n"6*%J\V"(o^k[q=%2oR\K>B`drHt1d.m.JSQCSr1pBu/^,P[m"<AlZ=&/##"e=JBfN^3p
Xg>DYkG_=DG[09>8fn5YD,C!t2WCfj\5k`)1jhi=H"fi?sS/b`CVd!X9D?,X>lUc#"d%.pQa
]Ak`Iaf*D!p.Eie,fHZ!//qq4QQcWU%O?gl)5DV-/?OrY&U:_BagUcsGcOaYma=dTF)g8nMg9
NE)QjX3@s+IARm5Qh<OFF+M!95dK8^C]AfP@k>F=P1%1"Wt\WIa5g7;In"gi(?1?-"2&Va0PD
^KrVBq\ErgPD462<?u!pMb;/5oVd6,^-T7$f=jHb\1+.8BS0;ghBnZkp"T[h-CN\d)QM9k=D
9c)<N<#T+_[C+dB+oNDool[(7(7.Dp5DRZ*(2iC_%/[F5J"B<#$-`^]AI]AV%Og8o;1?Sba";I
_]AUk>]AWu!h;-8bKQPBG&n&I>6+YNjSVTu9PE1*d2bs'U-IN^_f18V=_5+%/]ADA"M./N0V5MD
'+_t%SqEbMm0ThS3aSb6'sSJB*-iS*+&O+1([lnO.qpq3Y4rn2FG)T(lRhS]AHkSpF$oeo^FK
=L7M1TA3^=D3X$5"T!RtRa:j"tcp-YPu=9HQ`:<#ugQ'U0ZNSqk8@K@$7\DIS9mH1KeD,jZ?
"-$Jf<5nR/qK4_@Y]A77P[TA[XQULdqhiZ2;jkM>l<%92137)Cr[_isTO94+GU]A)!**:rdtK.
,M;&Q.p&C6RjeW\KEF8/b[ts2Ih^/P93"et\>mOkE4"8V<mUK(>pSpEc`elEJG`%`F;B,5JQ
Ofic,/;7IikPFFD$c@LnUkZhm3P$1TFDt!fU!gZI$0.kSZ:R7?5_]AT7lS2&?#Dd'XsP3UY>9
bfjD(R16W\%Ra9@)<3K\MB-:H-Jf(?ecq(T'#K:;<\q_VVKLZMuROtgese:cF,'b[l%ms^RA
+teSgD#<X1tR.Va=oXJQf"DM?7?Ao\^KPB3Ajn\lR+\lWFth0HF.Y*iBf3f`T'EWZqh()TVd
/$[m;OUH"/<"2E[IMk;@JHDT,b<njAfk9dG@\aR!p)n:fHa;Ti'F\BNbe`Z("FPful7#tm]Ae
&la]A,\(6JiTS7]A9`2):eET;$<D*3!")(.H#d=a;MUY]AgbW@LXK]Ajs,^ils[K9H[[oJ.]AYGrd
17dln&Gk/EaI*HVQCcb)gZ,^'eGPa72%uC(n8.T_W&XO]A9'mNlC<[A!a3E<_:fs`X1P5j`GQ
#rCBQjL((&W^.IZLt$QMn+mB#&rMI$X6,7A]A(2JUbonDKO&bDdY*UXklgWf>aDFoSoPt)'mR
;4G#K<8JK+TpT/O!X6/-9V98s`g2*eW6IH%:>r*Do3"XMGkc0.R^n"?j8$`dpT"Oco@0-6Bq
YD'(jG/.^:8AG?#5fA6@e>2!i6(CPH1G@Mj1R#ef1ph7PS\aOEO4T(iTR;39AdjL[gS)cY[n
%H2Qbl44;d>H1D\t\\:#8T:S>L\b"OC=uqH*XKE;qV::0;0Sb[BOYZN;Rh53d=?).54cI?FG
4m`!TR.(e9ajG5cmb.\)ckA5oWJU5b>oS^Nb^5Y=<[f,o#qlchVQ6;ao>Z<"N!eZVHlUO%,`
*=ERNZb4<Tc7Mq;RDJn9]AM)7^e(1Rn=OFRmB9"L*s=@Y3j%7cg=;U0'!KE.T'JKFoR&/[Oe@
<&*8AD:F2PK&dIA&-d^?BNeSML]AnH9gH<3$S?9(GtR'l4m$/nsej*^lDeRO11.p.[3b]Alr92
=c3sm1'\`3cB)OrNrBc(9_kWAP-RrARt=#JS^Z?NGlluE%:<;@ht1$'h7`&o5AkTPmmd*HHI
Z,O[.pGQ/NoZ*N7_C-cARmuBJ?S"]AOZ(E-noJ2L'QLo5sphao%UD<1_L4?b5miFEs&4,Q3A8
&IR4?qFuojP7?"oF^fO.W)!MP]AAs^Qd1)bRrMr\8"U,UT36kC"g4#%CY,PZCs0]A4:;qUM*.'
bZIL">;Q/n=tqqhoHkQP'U8mH48I+:E7S`<#D@/C3l3A$*AVVq'R'D&f@8<-9*N-\V??FD=t
(gH^U/*VRD,,?jC$:[$^,_ZkULiWuj)!0=!(JP"NoNR/o"m>elHB=W>IU@%-!8G4Y!php'@$
R".g__6+Lp1)/g!r<]Aj+(AAe^mj+V2`B^$KTtJ!I"i1t=KF?)`#5r=De'545AD]AYn:]ATAgGR
O2I)1+PAH?hkBr*qV\QF#0cdB::uS3nj1b.S,H('H[tPK#OpL04,#fQ4$Ir,O'jcIF!P1A3P
&d`EXqpO?[D?[M?(Mb/C9q*,%5nHk-"#nDRPAE`u,lJ3_4d+:Fbc4W3B_SNm+"kU4JgG4]A:;
25;iMQ?JZU4JEEH0.<W++ckRO$6&cG&@7.'aS-MrH1u!\-]AS[gL_\_hAt@e4*V#!i#TI_GOQ
+!_)llHn),5!K6QeprYI5+&Sm>T*u]A#_2EkLJ^.1_mina(smo+[BrmB`_k*I^u^3U%P^`Boe
GMitdJNIfUm_BjQ"*`Z5gjqP+#O]AAJ\-)b\_2IKPrCZEQi:ZI^Etb&/<CXHmruV~
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
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="433"/>
<tabFitAttr index="1" tabNameIndex="1"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab21"/>
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
<WidgetName name="report0_c_c_c"/>
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
<WidgetName name="report0_c_c_c"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[0,4572000,4572000,5715000,5715000,5715000,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[ID]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[项目主名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[项目副名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[业主名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ID"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="projectno"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="ID"/>
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
<![CDATA[/CRM/项目报备/项目报备表_查看.cpt]]></ReportletName>
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
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="Billdate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ProjectName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ProjectSubname"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ProprietorName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
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
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
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
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m@&<"P2"acD6u@#Q)Dir)NJO"@l`Vg8P>-,5Zsg0RZ_CEO;cD0V.C-Na,(eX/CTuV;&%-pbf
D4:F2F,^T]A,sGK(rg<pT3O\l[>CThnQhUEj>8C\_[#:f6)MVf7jF$^"'h[8,#PF8F3\^ld@W
sM&e&b5J))rs"Z<91a+#Nfl)<'iq8,?l(NM7DW;;Y\Ru,YJg,^.2/!%)s4k%M55jFlq:!+5F
C3d4kP4>p24H[]AjVi<?Rnk<[54P3.Dt\co*kKKR'8@T;HlGY!l?c[!oQ%m,Uj4;kkXMP<*QE
1a)KS"t5.ci)Wbss]AH8;s>;NRFig7ENIga&b7;E/Zij'3/%+``?k`;OM`E+#<V&VCR)X4n0,
?DgEF/K]AOlY/eb@@UselFaK&mD#_SdAQbbA6*HWj/KY#BY.eF_\Tsq=O)sFp*LWKd7HXAdBB
%@&%ou=paQuq6B=:!@2P%q(4,i)B?IbJ#g/W3SIMR\r,rVp34RN>M&[M2)VL8Z$F2,--aG8$
B7%_eGp`S's)\rY45sVZ'n#)hl9p;Gei-K%i@CX-SGQY[m]A_q1MB#hM]A?6;6p[:$OZ@L8WTp
'js6E%EiB'V(U1TKnNK+"cW6]AaisnYKb#gK\^K$DiZP18=JSJ]At76XRc29bHnn\]AfBiQ?>8s
LIW%ZCA`f-r#3m[@=UeK&:0D5.6O@D6o$A/BM$j&id?-Xg9hY/D'Z\FET7,.a79I#5^/V"4a
]AFW'E<L+4,pBDc-@/U,%Tqt?alc2[[Nq:53l2)l`Q4fg&?sD=/4\<YQIPV>j0WJY'9]Ad@-a_
X:YDi:V7Eb/MP?9]A=Qf!$P)9\;VaiZ=aPE9FINMisrnM/48rHRPm]A0ubACe"pN4m98PbdeqA
^VXao*[0s6!riTH.5<!3AX!ATV-o6A[s)RsqcneWD1?2J88-`s/N.l<peq7GY2+fG]A+)cZP]A
M_2]A?L8T[Q=(JEQF\\(k4ccL.)/oDlPjU7/A!rDe0'&4f+P&n\<Zs=hZD$Q\D=*+Dlr6;p#Q
'_8mG%`LFHU*0im"E\ZeLOH9-M@_IqG\XSFXk<m[VX&cXtT6r)2n6jor-k@(&?5m4>D`M=]AT
T`>lo;'=Ccq8Qr&l#H?i#&/$"oZ'@;OD*`9lC52]ABiiU=*:Lo!1ic]Au2sf0[-YZ=)1&Tl,l1
EOi0`@R^U]A<1pcd320;\0&3h^31q(PIX8aNbOYfK05bPoTj!O%(;596$mXr=N"ZK3fEFi'!o
8Wr*c0!$u4lo/0"-3F-j/qWRcU]AO7(dCZ10,CPI@.a&;BN<;.S(3X&i(M">[DJ*GsIUPEfk<
PDa<B&mJdT_]Aq3RKltEF[3/pbU\.OWuNsV^PR4^<t:P)!-./;Z5tal6#MhFRFKd\nA[nZI1T
")YjV?F-jt#^:0QC>Td*-34a2G&N?YY>-ORn/iG8^m:c)gjZs<;j.f'QO@Ao$lDp8!.84sU_
k/-W1[N-/2o7fm=7q8X7VES3$96Up^>spDV?]A!7uA`#eC=f*@mJ,PKN\?qYpTG_=O\kZ.O/)
ZlAAcE2%$uiN0_`SoclVNcS4rD5$^ts=5$D8/"4TXJa=oaS_hIp+d,(Fh)jeW+nksE4'3Iiu
f>/Q+Z8NcPTU$L^+GqnO#]Af$9!jk;)6M#r=;(%HL-d)I;+:5UOdL;#rJ"YC&T+MH#q*KBW#,
c?9%!*Y^-lB.-A!Y*f`&DFW&Z+A(f/%a<frF+XG??OLO@4&7OW4M"`cX]A=CP^D93hQ-h6L6[
P.INnOT[TK6q[a`4A4/2*X&afm[LK'&H`HB&?\2b^I-nFQPIhqk_QkOl2UDY7Y,Q.LX<T0KH
PUn>p$#]A$WKbD+,*9?G&7F\&h<b1O-T;gM^F/[0ucV'OCi<a.5lC47<l8I3S20<63V7bnKO6
--%M?EM!m.I&SVPN!:4Zi+IhO=+g^!p.!!05OKB0fh@`)AqW$1+e"1F<Nl7qBY^.I!8('ta9
;Xos,T[dJECgOQ=DicJ<P;bh'kQmjCfL-npchrSr>oiF,oD&l$5m<I?OMm?)u>^bAM<I9lHc
am5Vb^\-^EP>`+>2utIKEllXq`uFHV-Q*_jY$1lU\YWk&aH,Mf=jUNf0ZM(S]Ae^8)7TKWr=^
14#B1Y3)0;E7:_R_n/n94r>M8V:D\ipc(UraSW4H!7keK5q_aoi:^r[%uI0DCdomoaZ9p??g
X9&mEbDThpVHTDASH:/g,Ih$XX(9Y-WqQ<Y>pbqGU:HY[SCQ=^^:e=(ip?b/:YV25e;egn:+
h$o.KX/QLYs0%8t#?B\q%AFLkM]AtK#>I2^_Puf*K11T$q=f37Ybb]A#kA4#11IC]A:\sVdR3NI
Af*gs?S(+XL#B4X=.@=^P)H:kJ4:UF/S4(QK&.";2Rg)01YD"n%O>Z"BI?6p`@?NIh;jBI.r
Z.4Oh8(Yj[E9,OlJ[V\FAsZ&:?^IWWA(eV/u9^rd/j3>8(T"TouFhjVB9:*9!E4@U0*@'lrb
e*ac(t^V#a=?H;!2g/esG7ft'aP=B-9BE9oM=Nq97MbAg65EsCbMkXUn/np:h9RM4P7PFI'r
-ZWaj'V8o'#?Fgh>s7bJasa*4eNF4Am&)2>fOE]APGhfb[W;>Wg/i%bX?CeI,NUJKtI.'&)N)
DTAr/F!bGOolff2iG\VGagFgA2":3fKsK;puU]A+n]AJ_1r)-8RH(@*Q;d:jQ-o=Ed<1#,@&A8
k.Ii?aH`k@8p#GNaK4N'fX&MC.ekXK,=&Bt$-&Yg%E"c]A2?1-C)jSmSfaP_WJa"t^cT0ITbN
V-4SGt`[erY#*!#ouQbXZ=1Xn0&cc!__BgS1n$&$m[#-T8Z>q_iXCB<<jnNAD5;&Nd$4V8aW
,Ngd:6K`Pk+5cXMGI+E#HPAl`9@?"dNj*S@`K3iR64G&NUm0m4/9Q3%IdNG@QDdlto:[$S&i
9"h3>Q=Lh(),%SN"t<#BX=W1QS2U#D]Ac<tdIg4+qBSpb/X#i+GeQ+J7Q1S;>=JoC>LXLG,*d
'<Y(jS3*VH#:83ok#Ef8Q+@Ns:lOlZTi8LuQ#=QbGCf#(p.2>dAQiMf+I-Ld-A1dQV"Rcg:-
1]Aps#L`/dFk?DI"4?5AQ<RGSbq*I^'J;47t+U?ES56du\qp[[2p##]AqoC&)hNLX(WX5aDK6O
X!E"`sN2B>t+-t1:,PW-oN6)[R\+:gerHq@?[.OF(0IX<-%"!R5OE[?&-<MhGVb&9M)32-Jb
ceU%o+uNk*T?"Ku`rd.8<$`3Z5gHOb.!<i@:_+mRFXHj7-]Aal0'o;h6+P?SYK9Wk7l9N]Ae..
ZJ0O$]AH5-G\=%S%64r0i$+Zi`Vm.&>TgN$*O7.Cq.lCsUoiXT[eLC+aL,qP+_m]A]Ah(gDH;N3
O"-H==h4o6DQF.VE5b>qIs:&)tqgXn]A+&Fj..KnY(moaBm>CUqs*m:'4P<o%Yhi1Bo_\haNM
`LUO!&bZf]Al0jW=iOS/L1ksa!RhXg&eJO*:C@Y,,ueA_0B'AfIU[B**1:HZ2Jhi6)\'JIP]Af
/iHaR?*"0eme&J<8aRH(316lL/3uQTk3IeTt4,8,CaHG,p%'*U@TC5/&,dUb_685b^FdeYFN
8mS)I]AVTcL"t"Mrg4`V3heG(6<Sb;oa^O`tc&=-`TFr[/MG:Ll;<<nW!*!\VAJLdLD&dng^>
fVgi-5W*gHV$CMKkS2,<JAu/Cfi6U!"1X]A0.WiJ\X%9-\4FJSW<^=>=F2m3>K0YlRB>n(]ADP
p>Q&5Y>eC>S78q7Vp*'U\(]AWF"?KXU;T0UNMrsMJRXJ5%5&-DPS3rih@(;j*?u#aKapBSj!H
mHTl'cO?Wc<mCme$K*bM!e0\rX<r#\Z=+j#C@6r#$gSC_0ir"]A+<e0l4_s[.?'m`tdO3^]AW0
SfBua5.Ke6)(^??Wq"tY&NcopVd08b4Ga?b_Q[>H!Zijs7/nO/Q-M&Ui>W2UG#lg=0\C6)(g
?\#&eL#ds(b$4GF1X9I8g7aK2i\6P6(hfAX?cf_HFFh5Pqf%rWFIAI1oEY:\"sU4gnF.4Ir2
N8U%n<@9[UJCpQN3VAo^p!1BC+r%m;TVJHcjt3u\.,D<==abX!hN7I3e#86q&l`KhMt3D[qd
/JICf>:tOgAK;EWcT-Vi'ij0&1ftMC+W6/!*':RBtXC<@K?Uj.Y(+SZ!'@JCb7a.YnEBfDbL
?[k9+F]A*,L>i6/%ERp5KOSoGOJPS'rFL@ePePVlYo7?2q"($)1q_AD,o"d'IgAnf-[aZtMH=
$ThCr;L?^XI6r1`$ghLW*N%sM$NNZ!P%1^3"7)P;dBpqb0WkE2mOYX6@:4]Ar@H1bXmpmMV+%
r,m]A7b^_X$f5+31("R5Dh-Dt=W)L@q1nFT<rC?;uB@%GpROam,26Mc<=H9b1GUkK6-.;Y%8Q
W!g7=`+k$giHr.W:hf\dOM`I?9Q=jRUnRTk0IY<U[BHbe#1<QWolnBh*kQ=;MARbMP#u.WXO
h"MJJ.'Eon,cG#D[XM]AY@@tKR,G+6YiCpq;H"5R]Ab?8VP_s$dAOhTHda@.3,b?`J[]A=g73gi
/<=ST&mLT2#PsOK^luZ_P#Bic\s/t^D\@p4N_AVX]A&MC7*MPQFJl]AupP@-WJoWp75M*"/;:i
+kC>b#HWAJZcu!Zc`_==7+i""SiKa8rf!K_o"/V!q+A4d(`(>[Q3'#NN5I1r&M+qH[334[_(
G2U/n1Mr;5_:*.q?,Ci(cE)48LG8^HbRfOtT()c/QG`p^9nK3^`BNDId,d3=b=H4AXK]Ap]AW)
D):&koP_7phmWT&PHI;?J"NZfAM!M'2(hV;Gkj;tp!pNAms2?)-L^1qgs27YRTQ4sU&M$aBa
T*mrq5\WF;P'ko\j<%:cgG)"lmFB/CoX#s%H9$k(p%R<C(R-F&q']AXPHL_mOEL/[=G?'"l',
c=TZa.3>?"D(TQs&&anmQ);'8K:N%o>GE2ag/*InG>N-JAZl+J&kO)N/ed7rOXH5%:ApAC,T
.p;%2nS-6-W-NbQ:&kd[J2RsP@Fq$q*EPijS`7d>6AC8=??J61Br1DSMLj9>Q]ADdHnkQEhE?
:>NE"//jN<WHS#iU]AE(supZBhcW"]AjuVgJe+t(;.`SfAYM@(41I[*_Go82R+jc?p-nq]ApXAF
9=!SZh_rE_YYB8GV<>'VI*]A=Cg.$R:=#"qGA+e!W8f,P^"4RM+.l+57gV4J$?bs$okhFRM)\
IO!8gPA_+J)42WB!!sa$4"e>,N5ZBf<N_d\5:+=/B4JghiZ=Lsb2q3(2n?0nd0SY%XZ#>q5A
Or0Ni!mH5d64NT<,JPtmU[kHbnaulgQ46,?aEI8M6qMC>e"1<XB.9WqO&IO4Ml5@+aYiM]Ap#
KIV^Gg)I$nS'#srnNp68)K"RGZI>tQM5G/Mkd@IOad2qSL\eqh<6\Uf8sgp7H?]A30;i%JU8)
-CeSKA#OU(_89<pA]AS41-LegfI<c,4sWXjtDj7kf7Qouoa;"fn\GB!sd;ALVC0]A,:=Da3'jc
nno2jBU[2^Z-C3ihK%r0NLc;^h/kZH:D0#4-/,rR8<jM@lF96-go_h[nrJ#>E69cC6&dCYYY
J*8lc!UZKG@7)ouN*lb]Acd\OTFs#]A983.>:)FE:Ce:l!h=VpV9;8d"iKF(rD<a6OK#nqI!5h
UF5O4JMC/Rbb@,nAf0joJp5KU@JJH;T,<CTQD"Tl^7Uc9o]A+Fb?E,<.kF&<QS\e#cA<M_Z8X
]A1*q/+'A,TD[.\kR$3ec@F,6MXp-SED@h8G#[e&rR;.)YJHQC_#"L]ADH\u\G/\l4DLETcg"c
5e]AHG6J-t-i+YV4sJ=2ek;Rf[VQp/6TA:o(/GMJ-(g=-TH9r:j4=[',qRaZk+_UFh3\m:UFk
ESbm<3<%2(rE`mQNT:FjaneQ/ZQN>8!lNb,:Er1"kE]AKQrFPYDZ!FN#A,f<%&riH_eI`(KGZ
!b(Hf$e`0hR:uMOD&p+qY5[S<*/Q"KWptcBMX?GqcQa\ioo#,WOs!>gIEQ4GED/fh3J7o1t+
oeOS7nrP?chf%),<e)g+laiNs`=EARNcAZt%Gn._^X>`XE`0To9H_:3EVH\_VkP/Z#TT`\5j
t,Zs"ht58g4`&(EHR(V.K[d=aYs5f3;k>qZ?/NNL.`)gl6@lNnL]A>1dP,@AV+Z$HSkEB1>Wr
]At6;;(tgFFh(9\h)rAZ6"5INZUOl+7_Q2!%LIp%W``F+GG3'I?N=j]A]A%FFi?H=UD3%:>hMhg
#ECYh>\`4]ARW#^"ng+o.YfOj^c)=W!Qr;gMRnqmRn/_jrcK0WeUJS,fD<,oM_tfKa8GuGs@7
1`h.;f]A^jW8RfchrY`a!sIG:<P0$7s7j44c1j>MHeA=3:ma0c6H35Z`Y(.;.G?3IV7DiXK&G
V5BK=IoD8f@qo+8W%g0ehL8gM2B!2):)>_2LXAa?[3-TB^q/:1Z7>Ad3`NSG5Umj8i^Nd.f-
m\31lhQ2YmuD6")=@H^FCjtr]Af/e&l-Xta18/AY-@N"LV\>!KCG263E`EiNMoO#Z:O)54^c/
K2^."G^iL0BIUEQW7=%qZ8Rqd)Em7<eR_-8L<AmX'$D"cXC$%80#.C*Sag4qb4eilj&NLA1G
p&(l%?=Lg<T$p_"[a;degnRQ_.rP!b@eWEt>7LE%*oc0QWd)X^1TfONl>)YU7L`Ms+>(*il%
9.Oc0uT^<JrL$KiV2I"$S_mX/LShm"93lSURO6nuYK%MZ`pBQh(ju_P;tA$Z@oU7b-qo^&3c
EW/$VW%UF@`cM35MU34`7o1q!B"3PXZ5M:):Aa!n+iIbDNPBaV$"i&Ti"IlNQ)ich2@TN(F_
l2UsFf^-nPM';sN0_.f-CXom,oUf@[6I)?\=G`b&<2'?7sWJ_/*0Ep4CTO8&%PjhTWbSZMmX
1K<ULNtRHqDW.DKmZ<3:;X,O"H:G]AO1QS\1liO.o8dB2[mC\)[Jb9QHJWSB=<G*W8]ADMhK#i
QWUSZD>-29M/0)cFp:=c.h(jt=o\5IUlh_&g[GO*_E\$,#FHko[bjmUADYJ]AEcY,g=q0>)$N
qdEWGXBZI?_ao^Ns\u(Vieh8YS%NR;023s'n=@ku)+O4"a5o]A1X_.XT`UZ7.%"be,Gum+*dj
P(>iN/$Jc!aCWm/PL)VAS@eAV,fMVJ(J%QAPE#WI=oJ30"/q8[H*CQUd.a==mF%t[\3<RX!F
.QRTS;)a0Tn8%93S_<A<'j[uM^>AH)b&P;_[FQ;5V0Ya\VFci4iXBA^MpE[[Qh@nK]Adt#;$p
b?:bJMccXla6AiHZV`i3r`R<\aF>lMODV/n%q?VOWf,d)de-;,$<+ha]AuPtD@&7l52Q]AZC:9
=2,ISLSCaC&V/bPb>%?$:Tqi0gXc^hmDdJ7L>?M2b]AYCUm5q\AaZ7$toKYKoL<q\o0D?GY,V
18rm&u!*_gCV)"Y_L94,46q]A2.k`l(QG-C`oS,$b)1s'%fcQ6#W,Sg$QS4<8M1KacTm)%!YV
.<6dA/a:J0fAMkEBKqG.Z5NhlWf9Xi'%+Y3JDqX2Oeq1J/rXC,e==B.[';B:1TJbQ]A$8c:hH
W"+i<AF80"@oI(A#^Vq<nd,jW;!pE*DY<T.--cDm)H&c:]Ac;<LafEXQqSqEGl,>9(60M?c6^
P1asYFH/2ii2KQVf1L3i'H`[nl41`8t^LKDe\)>7A2&LSeaDkHAaF>nV9#/;>RA<M"CMk`bu
10&mqb0K;gf%"@C^mN`g2V9oO/LV?9k+Hl`j+("bG9@OQ+rp8SDlr-XNiWu>/p&-,dcAWKko
sEeR\!F6<:9'+E=>P:Z_D>C&`0-:C2,*b?YNL)E,"sUg^!NYrQ!QD[MO"k_,P/EOE]A0^P!B:
`q,q+HrKJMCXN9#cGi'`*mqZ-HaOO3PoT<TL_2KU0>s,r=T[<#e@f&_5!<:cL677DNO.'9G4
SM!MdFq7FT&lfhV%KJgIk3EN/DY5UoP%knN$L$kk)Ht:_W\u1b\gjd3mGPedX-\^oJ>)!m:#
_[e\\048[h/,]AWD]ANcD2lj@TnLkqa:%4*Q6I'RERu[$uS63&qV(Vn(CPE:ASq>[hU/2OMuNW
#-\$!@<l&ZrgI6J]AJi$6Kuf0MhKhr5jt/7=%j@P#QCBP`$ZC#p6X?]AhijS]A`*,!FH8.n`urW
7tia$obi,H8J?JXR.jI+62@o#B6^=rl^]AJ[iKX?ql#WfC>,H842).93o\krM`nB6TK72_S'Y
?94M3bG5s-b.B9bm'?C>9D2SZsR%+'W2)E3@W',)\M/Ikk+*H[Y'!UKeYYshhl2fKTs/R8^P
dYi]Am+pmQi@IA491D%gfq-a#V`&8iq,,j,EYq(EI!j`fYNSqn2"jVuVtHddN6Fj@;ZVk)Fd!
!hfeO%M;&(ZTj-U=o+qsGn/ZYKuIlA/")F`kk[i<d9&0isj/V4A2;[]Alp(l0%Pdib_.1-Rae
kD8bm7GT6K390\NX*Lag0eJhkCG&''O;WUkYY2H<]AHX,+IbYEb8%fh++I?P-F34BGV-"W*92
R/3ghP/p@4,badRlJTd`2qFDGZHE@\6^qBJ8k,%+0Fc(X<%IMo@:kT+Z;:?;-S4W=i;I".n0
\SiB'2K)?18ASefh]A9HY^2R6!$!C.5@jZ&I%M??a/pKP!s.\B^!RX;M/nePoh9.Jg$7[!'K0
XPZifo--AM;`E7Q-\(,>KHp1P]ABpMP,PQFiuM;4AMJkn(1f'1kFL\^j&L;O7a%9-rnp+1fA9
KEQU5W$og:J6(`V(l)6m9cM[B*I&o?Xp[I'_`P03bTf"2X%;2GC.BA-=snINR<TD`?1j\X4d
*r;rY7'X@ZrWpE5&8UTN'04++NGN,8.92/h`PX>3hr(T$nm1*Y;(H2``3n_&7VuT$<M<GX%R
aCOje;s3a#h5coEM'N9^OMQ=3_PrCs]AF(.E=S$Zt0uioROKR(+"+=q7[EIgGLcU[`Nd66G0c
=4VfsBlG9GXSpM$!lTd^06si2dUsHV5M3+iR$TrXYO0NeqZ5uS1Odje5,U=Ik*kVhp=`Y2Ar
m^<8&=40=mLj?:K/S!%>r.6UjhD$1Dg_`4J!1[XP:@VI;8cnd-Q1uF)b1H6>W;\(7gGrA@hQ
'ZPGjJ.4=H4]Ad=9-2d7-U_%1!N4K-3+skeScBU0RZ@NfOoVcrn;;6"_MD@`iI"WYVI*h4h<a
p,GFJaA^8".)JKo"AVG<9tafq;fq'KfJW(!3br*X3QKD$9J#^CR9b4E*[#-r0oP_U!Uc7%Nh
><<2q8=Eq2P@SYGTug(H[6b]Aq4hQ$&@u7@^.q(nl2H*m4>h-@-/A@B\4NKrpm65nbM'd_uoS
()H<PUDmjPR'YS_W@+"EH]A[%tGj22,k0pQnI"ARUPa(`'t*EiPQo^/:pE*u"67BXF`^(Q[;^
H+CQCu\)F5`P$G"nh,]A4Z;?ufVU3=?>7*oRI]Aeh@`qsiiUGMCr_s)U5sK&gR:3`OI'_GM+m2
\ln8(,fmi%G[[h^R`hbl[H:rFeWq.[X(PdZ2eCk'^bl@5G:F9:K"(CE3"2$sLWX$sHFNr-Ig
nId*&nEM&@-gebi580hlA;<Jl<Y?aF`_q6i\^ZqaN.+US"@-]Aa5#l@L#[X?WO_J$Pa_I>Kmi
QAYm:02Z]A2IDL5*#HE>`o@=*n[oT(F_LPZ(V7Wr1roh`S9pP87U2n0/kH%('\HPh)Je*"[5m
SoGJjj4\CS_`Dm<ZortKPDJI>bo5k*ac^%t&`55QtTYH-[6+K#:IV]AUI!VeQeH6-C0r]A_GY>
qBNHB]A(b\K/pZ`I7#GUc=IF0/7Psd#La"P"Q;6+n.CY.-a0k):TkK!>#pN*+`n3"=6'm=bi1
HY_BWCJ:(4%k%ces^XiLaI;1ZknjRK=*d.u4CR`o%-=d6$=-?Wu'0\NHu$`Nb?=$gF8+#chu
>>k3?HMH0E^G^1]A7Mba_o18X1`6;mE5Ms^g&^FTX::Sa\#p7U,ls\Z1G>.:i1"`j!<JmIin]A
q:kLd17cC-$e;%Bg_/NO4<HFZP(E6FR.r9u'"n%m>$Z_!W,^Ja)61D0l_f/q.sR[O^ON^#lL
o>c?njNi6o0lT+tlf>SnQEn*ZgP/pE<nI58oS'!D--Yno'mh&$*&2#NHo1!A="O0h;k>OS7'
PS6n_j*^=8V?Kd2;C3<GmX4TS@%o.'sNa'F'_IK'`EY'dPF6W8$`uX20c&'\ed%tqW80WL.5
+*[KO9k"KbkIBq4TK3#peA74UF[Ri3`n:rM[6e\3`rG$9i/jgIhu+Mq/g6L2fu(*jV]Ar`[-5
/CdBk5#cP/=B[>Fm%6`oo9`$'/!Qq,V-(i<V:b?hkMeO`FF]A1]Ae\J^AfJhe&+q!dr6rZ00@E
;O-\:c#hTo!`uK@opgL\$%@Co(kqf&C&C!)/XYnHd@\]AYMBg=4r%YP_0oQ0P'&*YP#g_^0Jt
R`jU)Be71nb>gl$5*pee9[#U0CTt`.Z`T'+Q)AE<Y7\65c<r"AOT.t_JK$kU8]A,s-A7k8U2I
%B=r2V,TIdIDt`7!&r&<if[Z?=ui,4I.<6ri&FY9Ckl-RAWIZ7)SQHB'<=sfbZ+#7\etkqKe
+=^/f'n9D2Pfa^o=ZHKsmJfl5/3.8TrE=:4N_lYreheRKX]A)/MQ9QPlCm@56s)oBW&5!s/\C
)P%%b*-2DHonI2PHF)3A0?J!*5+2]A*/V2e#I+DdQZ1mMN_QeGqonq+ePYmi3Y]Ad%s6Ku5o`n
mb2]A?f/K1`daQ>t_e;q1!n+Te4lFrIT]AU`:WYZ(u^d)g=Z[/q]An'Pb9V(q&79pDj(RKGg?sq
A7H4;hEGC?6A!rg2'5ul)]ASST;-Jl\1GS>#T9tZ<AnL!,2s1unE1Z+8n_CsJs#gX0.[n>FTq
0.5K^Me>-p1q1EoriRX_G.NH2rQ+=KUZooDSf,X#rgfigk;/9'5kZ]A\-Y+Qs#7FkWc0u@,Xa
tCj#?;Ip6Q'I2]Ar#@~
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
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="433"/>
<tabFitAttr index="2" tabNameIndex="2"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<carouselAttr isCarousel="false" carouselInterval="1.8"/>
</Center>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="tablayout1"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="469"/>
<tabFitAttr index="0" tabNameIndex="0"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab10"/>
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
<InnerWidget class="com.fr.form.ui.container.cardlayout.WCardMainBorderLayout">
<WidgetName name="tablayout1_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="tablayout1" frozen="false" index="-1" oldWidgetName=""/>
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
<WidgetName name="_c"/>
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
<WidgetName name="Add_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<AddTagAttr layoutName="cardlayout1"/>
</East>
<Center class="com.fr.form.ui.container.cardlayout.WCardTagLayout">
<WidgetName name="tabpane1_c"/>
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
<WidgetName name="982d9a8d-9fea-45e0-996e-3832205cafa2_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[跟进中]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout1_c"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="92861700-0be5-4bb0-8e06-0a86628283e3_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[30天未跟进]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout1_c" index="1"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="3294ba15-e56d-4c93-ad2c-f0d4d92eb442_c"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[即将终止]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout1_c" index="2"/>
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
<CardTitleLayout layoutName="cardlayout1_c"/>
</North>
<Center class="com.fr.form.ui.container.WCardLayout">
<WidgetName name="cardlayout1_c"/>
<WidgetID widgetID="e5ac87bd-bf1c-4c48-84a2-9172f8121254"/>
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
<WidgetName name="Tab01_c"/>
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
<WidgetName name="report0_c_c_c_c"/>
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
<WidgetName name="report0_c_c_c_c"/>
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
<InsetImage padding="4" insetRelativeTextLeft="true" insetRelativeTextRight="false" name="ImageBackground" layout="3"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4572000,4572000,4572000,5715000,5715000,5715000,5715000,5715000,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[最近跟进日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[销售部门]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[经销商]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[最新阶段]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[跟进详情]]></O>
<PrivilegeControl/>
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
<NameJavaScript name="网络报表1">
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
<![CDATA[write]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_dialog]]></TargetFrame>
<Features width="1024" height="900"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/CRM/项目跟进/项目跟进_填报.cpt]]></ReportletName>
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
<Expand dir="0"/>
</C>
<C c="2" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="报备日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="最近跟进日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="销售部门"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="经销商"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="最新阶段"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进中" columnName="跟进详情"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
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
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
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
<Style imageLayout="1">
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
<![CDATA[S@a&'>OC2>h+:gMoqEjl:9(%%WHi5U/SZaIP+\b!C/dk]A>ZG8KS]Ak#0@jK%s+ggC#V^)Pq;I
bfW'#a;)FoCacrP!'\cTb4Vb!0%^qqV'2O7P?Fhd_.ZN3V=d%Q4?rA&jULkW[RHHL)K,qpAL
;m-19P_Q=L.*]ArKle(&nTk+An@ajImk#b]A!8ptd_>*aIVS3d'uZfrtj6C#<Zbp:?E624=t^E
^M5@YqZuG9hH;:5pVI)gr7Xh7_oWA6kD[[91p3E+qi#Xj$^`UnW=D7Q?:GsEeh)1g7h:.=\`
j3cbT/pXR-.)7&_?nb@@jV4f&1tm`Y)3P=J6crr(X8MYA0-;SR_[0@7T3<Z^$f=G6L&d_*L+
1hWC\AMEFR]A_R1lhT<iB9tr4B!MO1`C,S-s<4MrQj;$[I?F4&s)]A*Z`rndfZmmD/H(T>WRXX
[_EMKj3eL-4D+Ef[\PWNTE;]An+?A*?iR!(%G@0Wk$NuaB`FKqgq1>.4=N?LGPu*LBl6;Th]A(
3RBFJIR,%:nGbM"1rVcVsP=T"YNPRNd#M.pPr?@[-^o0`!mZbZ$Db79h<pt6Q:1=*_X[&YG&
,]AHKHQK-u/;CXBH_N<$fPNruAl"F]ArM5&rC<F-c\E@#1Wl.5ZFu00F^clo*gr_'Rl>\kFL+I
*K1nldHPt?n1o3$lLZ1BaY>M[Ig<)h,BhD=<=_R:=Emn&*$[lVC!SDl>p_L%o:1u*%]AoN%ca
h(7B8B?hdq!Q4+1Q'5=Z-Wem'hNd"5g-Jj$c^[eF;=<u56%e(1>TgU$1\i<F@P7#dGRLFhT'
Y*o?u2">6OGi>;U]AQJrY;It*N7NTq__EcEI1Pk.VRiS"[U&,X>_-c;Dln4O$+u!`pZA"50m8
mpCcJN[LW/i,MO=4I9(0OGFUkm[)G\[ENU[sN7]A]AUi'^2>E^MG5AHi+k57T'@SGK)Jp:b4_]A
h.##p7I@*'7!nt=(LZZ1qqZ1/g>$)%)J=3'l^#S2.laZX"j<),Q)<r]A@O52_4-(4Zad)H'N"
gpq6?fbQUqp/'U<hdQ.\s1#><t"M!X6_Zf&0H+E\iUV4<*U(gL-u'J%5P]Aff3BYKe,/*ZsUN
6ph4!$\EdgK`"dWAt9+U[RNq.O#EfQUXS0.Wp?4'V`=l<&)6+I)3Y/P+$\G'q!4^&_=IkR4t
E8AQQVdU/[&NXo53-O+Tpl&hphYBCpM:d)2RC-;%RnqgPalD*=7KrUq:bV>5''o%g0&POeZf
g%T.;1e5W?I*U)IurZR[u@IO_k?e03M%U%p'&'.c^4qM5TbGM7'VLGmrBm;-7_<rU@g.)uFF
p><5pQoM*1_*3=2"ilk2kFs[/2$A.DH(sAOIgSIO&[2A"c=<%,r6@$3WiAS]AdT7FPAq9PmnH
I`T'Z5M[SC@Br(@cFTDZj=-d//=XKV^EF&$eikmY:l.*b0`Rue=eV`or;@oY0EK7XA/s+4p6
Tqln$]AX(fMTN9isM<=qdG^(2lb>'X!Qk;F!4%bL(BjAA&H&3l><9'fACY1WAqG7tPGIGZ.(N
`^1D64l@Crp57%_F-6KLcQOjKijL(\Z(khu\OQ3eR3$[u=;Lh2n3(2.Y+DpJ\U69!`@_?iSK
&B74sG/Bgeha*ecH;XC@kA7mOU-)_VS<On7=2M5loh_m27CM&9A5d4KOk0AW_$l^6,GB9o$P
`FqEqN?7u<dsqV'*7]AmLZIfnrHmGb!c7]A_:V0`\O$S:\\EUh6,@+Lh0=Ed(n%kZaNOrQ)A*g
?;a\NeUbu]A[*f6Q[Xc5n*n>&H_S4]AdEc,[RJFX\L]A9Gp]AiM?J>XOJ%>%!Q:@P"n-sC0+5QN]A
V[/&O7JG4#:_>_>&OuFt<='4_0@.?%,N-"Y!ihk%";S![k\-VUQ0ub2Qlq>5V0JH=iKl,D,h
?QR9$A>L[P=6rfFQg$q_F/pRuKk%$%YBW9>>u5[;Xr\78C@1L+C]AUWGI=a#cAKN]AW&3<Enn^
>f`AJ1%ehju%^Zu;5/3?\X5K"q!sHcl3NhfOc8)7'U`b2)n..ui3V:<,PZ9<tTD0;JQt/0Ik
&o(Tp*#Ae'tQ.=K:.]Aob\eZAg^VRG=u0J0n;i3pfiJCBo"gJaQJ<;>9?R3FB6(CO(2eWPWk=
.Q!3K^5Z8L>KqjFTIofrcLanlR'9eo^`<D'PmWO^OGeemg%=ki(XKe;)@;'kOfUY&k,ci`fC
li<#Left)X?=e%_]Aqu:<F?uo3&+L<8OlBDMV6I9eT_?&]A=&3jW]A7(91<#<oG&E_,Dr\j#4kS
_X+@R_ME;aNrP[BQ&KSGH^Q]A<AqE1h/UjD%gDK\nquOG,2+(9/^a1VI@c&\IV&5'*Ue<]A3"\
Nq:\SoU]Af#K-0I"*1<]AB8bW0S(l:lY:DG_9!7>H:Z//AtXY8P?=o3(tjPXPh&(dECI/7\$c7
<BBXK,Z:ZE"(:loJK%a%Xa%@HJ;(2fS2sc1bX`KiSUMCK?OtAd$b:2r?:e_:(bG]A5Q4!J3Ih
&O)O_W@jA2)u:aT%TQM^stjU;t8deM'14R7$n-g:pf,kD(G\tb#)9]A@,Uiar,GRSeqHAmAs0
(VN/.Oa.j#2nG"CRgNaqnJFnZmhC1djSF5i:uU$)F#Wk7_oeKp@Hp1DH%_]ADpiSDg)"\.aQN
2J@&h-ln(*RCqe`R(E-++mO:rD>.K14UTe9?@!!BkrrM-edFJQ);L6K-8c;"U$Y?NJLkW=G'
;]Au/]AZ<H3p\Mof>$Pu<(;Z0onWStdsTpY.j9*Yu^cO9d>J=$]A!EdB;jG*uma<i;<\ndVYu!'
0T@o=AmMol#(GKA,Dp?3#mYbVjn&qp-VE'qZOSN?o>VRAL\]ACSBbr.rC0LU6fj/3@lRR2IG?
F/gSD4;1XNX15V[5!TuP;3Bg4EoOD$O+U@__Bl(P7OB"clG1PlTc$Kq?S=@JZ^"m,+MV[Gju
UddoNZZ"M.I1,gX@s]A<'d)l2b9R`LZE(GU2VNMdLHV]AERj0"gR71PAD3k.G\@1M_FDB>`)Xq
Q=U?!h\<*gfoOHnRXu8jQKg6RJ#lp2g^2CjoSA4G!,RrNeVsCY#a$L'rtN<CdjY.B<qj9)2&
D/NqYX$#9,!OdXs!r,KmC&Nd[/R[X^'IbcfB6p<md"_3i$EO8>9am[X1Y*P3p:$b+'q(jHh$
KJh[Oc%I2PrpL&FF$^KR*A=h&uCc6%]Ap:WIB-=&6DfD^8+^^`1<`k*@;Lj4F,2)b,)6bV\X(
i^2O/"AAMnA_r/E0F<p!c7Ra2;qe4p\l7(jZW:$(R?=i=Kbd/6hA.5f+n%OhCsgP_oX<rrmK
"EM'd'2s0]A/)5As,\3!;Fbq0(o(.)n=]A'CU34@6!e?G"b*2I5X@XS%2[qbnmm`P(a5V>!_nR
W4>Mr+/nBoXZA7H]AV)`-CooD!;)VR8*dWCOL\fIJ1o=A3;.8=B^@oC$EHGNtb+ti)]AMeK*G0
CP0X@Ih+ENBh/mF1q-0(/r3^h!OhNMA4.<B+6^0A-!+D!;E0Xg2&[[r=TcW%;o>4#PVI&P,c
9>=P="Mg5a:7lhnJYDq;Ome%I1Orm2fkAY/<tY0"$0eZhA,ir%XHAm_3NYg:1J$&N7(H&T&/
7?r'#KI`\Zn?d_0@DV^2J1DpGh!qY.1ldGOQ?i!sQok_%pPM/8lt9cm,8`@-0gNamIb*`@TT
:0Y$&:4AnF[kisJ@@pbf4G-8t"">Z7XT>er/Y1U%cO@ZMd,?n&%QI==H)aaAboBk[DuBYg!4
siY>Ijt_[6RWF(e30,r,EbhF=mIG4ZFLMgaK>T*H3uuEGJ_e,>PgRjX.,%JSR`).mUO0Xn#<
L!6'e,!+sN'9@P;ug%XG3Aj.*mgd%<O7/?uuq+&M5'-Z=3)s<"lmn'j=HgA**3^lgf49B2CY
N@;FrYs/Lec/TeT,bY^7#m92GpKRp#WLXC"E$-\&U_r!QN?rSl@oSl4cM>2=8Sij+\>sE&":
a)Z2q`4k!Sh!XfQH"H\6B2iM<]Ac/Csk-Ff%NBWkeKPi%r3o&k0b2/Ns$KZnMJ/.4a]A]A1'cNM
LSNSe-tROn\05dsR)5Is#rA$*,a^)2H33r]ACDapBc+d-6H>FM^WY9l-V_%)P@eFTc+(hgT=3
@,D6uk-;:FY,VCClfS0it1>C8T<afD@,e_O#4iH7Z"6^3'-U0)G*DOQt^e1=8X7>G?eq-t?u
FmJH)a\3TF[X4V]Ag>P-YTDhP%WaN5pRIZsV.dRN`Xc%E2m>rr!a+MGe__s?"h6V0K"$WDns-
3k<.-?**oDi_%Mh%t^`KWi<BFd(#$1TJkj#hon.)q6T4Wb)jq$j8<+/%\e,pR\9P55FG#rMJ
G)`R7ak;WeTI?TSR5Cld6tk@[1UG"b/MD-(V!6P^:Y7-5P!IQ7:(llIY^bkXr;In_%G<Wo)m
?9Y`r#$egH!Hh5Cb9m<[#^:0VJ6@A6[GQIB:n`XkZVsD7jW\uUV&)^&<qM?@D\umHiPqV-jn
K)E*:6O6>@m<U\LB1DH*=D+im"0Y)KWPPfR_jNAP^iX((35M)8$P-1coMXK:M(B2k=N6oF,$
J=<6o"N4lnOE76sYD<<ir:ZlPa.U!eKCFE*eiSUri0Hb?YHPD`Cb+<W_P(okb.+'f&2^FhU$
#&4B`?Y+hNNnDB@I*D?+)AA&M#n6@AFr^=?f.]A:Q$>qO:3@Z5l5Z%NUXZ;[IP0\R'_R%B0Fi
<'1g2u[6``_WmQHDmW4>1hnF^2*pQ+T4XF[PVbNqTmia;7TQ>:?FQ=Fe*VR:RVe8:=N\anIH
^gjuom>@Xp-qq1kWfN7"#!K2JntFj]AD-/fY=s>?q([m"gD/U'AOf((u]AXm=JdouHO$YgZ@,-
"\/O!uHqGKk?''\T!ak.:PSCElmoCHoJ8pS/`g+>1>X9>p.D=/Fa^-iofhCT<huqA7n_V8p_
Z3H<#%;-CNc-HLR">]ARO@,]A:cg=m0Hq/Kb7lpkY3*kAf`3`]A,(t@b/SF1A;.`)o;5G!'*;(f
USd9T0/_\IAJ$,)gH5ShqZ'7>pmGQ1L+[Yju/@nM;,?1'$+fQ@@K:06U5:S"7u/P\d"LtD!c
5T5'58eU!X!4/VmIX'KuEG(E9;rA..*uB(?H]Ah%Vcta6Y_T:;T.9_"/nF-X)^3b!l1M.R\V^
T3gG[nX'psNclHlIn,,)fsSsL*oMor,+M.?.7g%0'm2fZrV69[i(5N(.V`,<natp?=!LET<j
Ht50n^pA,%a1OpjJTr9I(P$S$l<b&r1Z&,qD)tMZmQu!<lHAMU@8#KTJfH#H+_?-VUo.P3Mf
FScOdi9+&K6T]AWO#hXdC+(!?;WEl#-&qs^"K>>!h;;2_H;T%YA_XcfUXd!+S<cXN^#0"EgWF
!book:*DY5@#PWQo2VQVDnk.[nqR)3XZ@AWkc-E9^r<'dse>PTg%mKk5Ro,655%U?0gQC#Y1
j;*;o6[#jYYskl=ZC>&><<gQs?c-!;Bic(@4'<.2G3qT,QpNpZ+(Be2TqMDWeNL-$pf[Wm[U
A7gS2^:W_;\fh$:o!?MGTibb8WslD^?<I\cH3pU+57`5pNdc%r6e=Y$Tl,8Q+]A(MnW>M-Sb[
GK.P%V%.Fg$bnFdF-VO6]A8c"(fnuU\2L@;;eigZY"9hQ&pjbG?4Gs5*Y"A8Tche$+n:@a-3F
[NIrdZP5$/CCQL5FM[<kK^H1S\a8,Al\%A]A`h!5\rlSDO:5qm\PTZq+J)LuiIQG6e\Q0p\3*
AOk&H.Q1sYr^oQC$lAt'3Bs:>EpnrpAG#pP'[D?1G&*\5CWF"W>:HF5JZof^+mmnk/kO2P7H
=I?^gkSQu,2LaVQ"Y3!hf(S)X'EqNji.TON1qO(@O"!3I"(:H*[1`s\2bpbZGK-O6HI(7d)7
@-h5Ss7rpSa%[]A8G9n*"4XPen:L<Rc&.$8lA!M>um`mePQf[Ln7k)_(3^Hb8c.FtfnI.SW\<
;>">+EY<?.7/k4UYL=qaVa(U_H4g:q"2c5I@CAe[Z*glu+!).#`\MW"0I+gA6?]AQW@%_nV.\
DJZl\mY64U`U[E$DaLJ'pGc&\hHEB2qeP+e13665N\r3h]A5C/=t4&a;>"M-e'SR3Hkj]APVr;
IW]Ao$tiEcGo^Op=)=]A+=Vp7?l`$'<2"S2*d]A_6,!l=r84$E5%ST!hNp&g2>V5lhU`9IZ[aI9
F-^C&"">24%E:OLM_Pd]Afnq8DtUS,^O?huc"?04Tq<Z2&]A8jAkO@@t_*AicE5nS/o/]A.+`Lt
f0NG1^,'b]A3R+sNWd&G"G<J]AjH39_@-JBPeNdol(:O=?USM0F+LPsVSjjO3T0V<RO>Jdd[6:
al&V3)<"=B)o+\`SFp<UB(k%j),(@JRZoW[eDZ7tCO"f5m\SEl.:Lp$`(aYkckN!abB*q+&E
iO6j?aA';E%JA&PhR:k2!8RWpV*"[0^Y+i.H>Ks_;YA8Nu-<D_5f=LcQn)7AX8p>TF3aHfB?
+Z_rP(Gr4IVBke87j601<\]A]AJFceY16c%!$_+FHT8i%*.]AhPCF2L/rhe-i6QQ1(79H;H-mQL
EN47_3fp@#T3JF4llO7,A1,'51a(<_NkVqcJeBqPt-Om1qV'X\MNdCb1]A,W:D#i9*[s4ml;6
*m;9r'fEM(LBc-RX(Fh+Q0okI+pO?#cNbeT,R57(<$WQH)Q"q#Q`+hu8Sd>A2r'P@C]A7n*WE
Zb1[:;uF^WAR_dk_'"8g`oef=,n#iY9d^*JZp2]A(&KlY"71!g5)V%(U2jKPZ([g)=Td5)1&S
m]A,`/(rGYkICr##.Ie&Jt=Ya!,^,qf67!/,#'Kl'!W7!:60:Z#e%+$Y*aN(t_5"(5sFd,;DF
^5(sQNu3g(,ePu1\CZ`5Qj#UnVKd;q9J65=AFDB<o^c6+Ng#1?>h"s+kHi.;,?<:(Nl@`4b]A
+Q\5B[\Fd+u#[5T>J;-_^hm8,\CC#uL@]AriWTH1#G!6NnR?dUtjt4O<$?_.Ltg&ge.OH4@ms
/I:p!#r2pCP+,d5#Q$EjcQFFGrt_Kk>.,fUDGbmhf4dJR&D/hYW`>ma'$!*@Dg)Q;+9lN2>c
AXf9YgVon.fSH"XN3qJMXtt%Af%pHZp%nq#j5Pp_ALVFff)c91%[[R+#neqTi0&DaX(8-J_n
EJi$U^=7TUiFa%S)'=2cUbK+W<PdU'bg`)>j5S:(`O7VH5MrNd[P(QGR9!7L;%-eg?<nmO^.
o6E@Fgtn7;$T(3g&Iu5#\[L?St;tAXfg^.)\0B+qoWB0I1*'d5EGOc%i=rtlIhItX+Q"rho2
nq^6]Aol[UiTBc0ok[\FH6]AAK9#2'q]AbM#=laXW$*7_@<J_15WWNCFIb,m$B.J=7+--W'LYT=
GH#J[7,*Oe'qW3i%El$88t`#:iNSpmIFMS5V9?pkm=oPilRj-7'(,8bVYV[%#5ua!mNJ_qh&
c+GkboUL$Ke_@RSUXb]A#1,p$,)p\]AOP1'!B@9u6K9&e6ifg&\ZhJ=mo"kc:OK1R,[KFG,eW4
kL06leZmttej2fU'-QK5Kj2<.N6G0N)Z]Ad0Z><J^!C8i'qKh=gAQ/A*,l+&`54?!&ti0A)kq
e4!<)I>K('CT/F`GT]AC(\W96f!Xur*`7-q8<.siAaE#[9d/Qo?\?n1&=,YCa/*6[OYN5kjho
aLo;GG#VRH<\MRp=(^Es1$Igl+f\Y$$K$h%+Fpm54;2A<Wk!h-dYI<[b1Pn*1@hJ;"g0h@kM
'pq+c-e;OhC8KOk6`b7/Qk=?:fTB,Z!D\*/j?MeD1=aPUiH#I$B7U;3_H2c*jgS`.D)3\H[5
VTW<rl+:0!N!QG\`4._d"(dd$c%<N/daEiS%h=Q*YG(IOC([C0ODdk"^-`T*JLI9WaWp[EU9
]Aau"Ubh]A.(lpb!as'5[^o+iZ>a>c[/Wb1I.?Tb$m.C3A2AbQ?/+Ol[/5$Wd?RK:a#upK8AGP
QN4L@WL/a9l_<$eFMC4iG1Y@%j,=T_@pmPBHZktMS-6jFQ"r#1GqO5^tIM:C4VBiEJ)Ui<Tn
8:27d)Q(JWTl'hgNW>j(3cI7(n`-C7LD0J7MoU3i5#El)0X*jb]A98rJmOK.$/+PE\Wp2W9;%
n&F]Af@^lZ(U]A?BnHa'ZR$R#QY.T(W/IsB^?H=YZ!m=a9Z_Q:Qn)._Wh'#$[T!.$ItG+rh;=b
HeJkG4U:T,uU$ad*S>pi)jRo:Fs[\h:jEP+K(>&q05cUcnVg2D6i@"59n?7N]A9rY`c>Hgps+
-,3fB>hC-9<biKYmJmi#dT/@<d:fdJ14c9'`"-XohrHO!/%g,]AX7B'NoDTm7]An1Q_EO&E^%R
C\lK9<Cg):A26lQ)J!V'%.r>0tAO16]A$n*Qh&grV/n&WP=:L1\@UXG/Es;LKQU!D-6"I\isj
a]A'AF'_%dN-!2o77k+<3kTOo+j,8+91PVUr1!2R\r6_("SjS:\E=j%Fp7MOH(L5c\=cGFG`7
V=*,u;gfBCg]AJ3qdA?)I$4TKBJ%oLdpL\[k>;tX&eD;kB`1Gj;#"r#&4'coSIV8[)cWM;9c8
]Aitc#iMF.Eg<QGI?rNAHP'CT=YOL_^5EJUs@dTK.T>TQKH1"3tdkGH&NIj8rDS*/\K.hLL(6
r:6Z3('bO7>]A$V9'(MgfJ#CEej,>0B>gieglkoR0NU6h4hO[Oeb`KE-_1nn;"!B8d?Oq?&:X
B!2=KbKmA(8`i4YRQ=5kb4<cBV(qMomEK_?R=so@No(a,!V$kba^?2cN:cI#iAb6R;++6@2k
5+Lb1\V:9UhP)X6Yg&M6U[_;E^L-22tULk94tLD2NFl-,K$!j=4R9($DCqLH&?_<NnIBChJ'
8bd\D\kg+WB8<KKMQQJ>J)cKVlPKWp&%E2&)]A$.*iLdEb,MpYI.,([4&eTRjI^@ng+,+!\YX
U6pRFg)@(FsH?G%.tbWkTe]A"8LFFMfnjUp"Z=]A%o-B4IQkKTJEO;`n]A`b(,n_8l/o#d5&=/5
5TZGX;Q4>PDR\W('-pt)DnS*4ri&43d1QFRb&kBFR;;OQ3Z4aqKn^MYP2_:S7[3F2(b_?"pA
T/="fR7M4Tm)@QN4Q@!eY2ol()`An\h0\(IX:QuRm+n(pMaqj4nQh`6'l3mq7l]AM8KI;'=0W
Rr5L.in"p;DAPON>J:F]A.]A/d%Y&MNm,*"'V5Hp_\5b3B"";+@a-:C1t5sot?]ADR%C=#6$i;]A
D9Q)Vecb5'1]A7MSl?#\8;'BmO;7gu,MuOqnk>.<%Ps-.qS?gN_)X_u8=,]AUp%A;^b+(&A<Ec
os`bi!Q^>'SlF[Wnh:;f!R"RcG,PC>9Xt/%]AANXI/O?rP\KYq2VKgqmM'ekb09DX.m0Jolr=
-ZY/KU-2g(d4o<P0(T'@nF@"!rUJ^<246M"YRuVO%-k<W0kq@b*q9KN\4P?QZEb(gnlg>/j"
+m'(gBs2#]A$D_o_bAPqiA&\^o'%mF#picIh/kJie@V!.rF0_OJr%E4[Tk]AtJ_75&lqh#j((M
TZY\0pEYl3>%AVQt5rD@l8P2Q+#BG%!ln1lj<Lg@qM=9,&f750XUE0N;3XGIV&C7C77'?b4q
gaC-Ym2p^_6pn$3On&+bA)r;<$%-"XW95b8BVk?Bkqu#tg2]AX1LYu(HF>cHpUioVI`e#6+">
fLRlZrq;gI7.[]A'4YJS88#Tq@%/_"':[+F1Z?"CK_`V(g*u:BXq35&ph3M'b\RF^#;.^["Sr
\DQef([?tbD!J,_>\F]AdNrr2a[/*%[*B$G8fQ<K",9L'Q^N)n#4Io=)QkMo35"]A<e'Faq._m
#W_"kau<W/_AX-0#a&9`_'&<$7S:c-F[:+T(h`T:L-6B5k[L0I'%4MXogb$fEC2k$T<enCI'
9.6bPtHA:fhg^\)ucg$73*$)e=qn]AM>-O3tR(p0.1^r,(`\rR6?A[O%N65'bU_p79k8_Cn0H
@BBsX["VTWrqQC1-ZVqMq$<LlEM^IXfpmh`FJjd5XC0ueV''Ns+-.bB:TE/I\M;r>_2R;,+e
57Pd97k#3sH[!(E)8j!6T`c]A,1uoChODU,2&!r#BF65'[b&^gu2;2>(!#W@[4t(c)+5.Io?>
[c''e7%?su/^g&js&D7BY'YN;%ETadI;*:44RXKtj4@Do*cnNnD$/)*/>,!&XeTS7OeY5tj;
7jd(R;&s*0"VRVa]A\'k6HY*mCKYf]Aoq+.6-EN!IbO-YSkUtP,bRI(E41i'05Fl@s--oSZV>;
A<G2F/Ck!n_ie6&"E$\]AM5!mb*3g#gL`(7i'M-25XXq!SJ-NM9T/D"\-)?3+Th#@:>5J7OA4
R8C[l2c\S&s"UY\QU#\('C'6(i:e,J*bTk)MJcsQ(gb'cYTD=#*7>S>o/<!%J%hCCN2\Dn^*
W:pF/H0$XFgmb76&[HXQl96=-YW4nRYVKX]Ar8ug)$>%+)*+6L>IbnU$>5Kej.QM#pN%eN\_V
a^,[nK#H.\&":S4QZIC21e@VO<2<RMeibXjh]AF!)&7`;PcbnYMt!Q_(NIjDZ?egh-JX)/n>?
iLT1']Ar_mTnN;7BJd&B)UleO.)0CC^X!jgX[Gs5V:5!P!LdBJS)qJf1&.o0MX<b:E"<:+k$8
TLc=4hn0<'Whj_eo5\06[t82Ll/P,`jBas$XN1OIEc[Kg&Co&3d:k`Ec%OVb@Rc[ES<kklCa
l%U4*r6GtZG10FfWp7%pBrP9Bk1XP6:.sT(]AFHdUM5+!)Bs\tF:%i9`?T*feP5UQTGg.fZ#`
1?<S:ZjGP4fAPXQ8BjXb.=t;PG`!7%seRr\m'BE^K:p6a[S.FW!Q2CD(*b8@NNbrW+"]Ak\7J
HR3[JVj&&d>YcmN==$AjUa8b7_]ABG`g.WV]A[p>aO5_Y,1U@A>L)r"\b[*5?1cnuLmfC>KC17
JAK*1V7a*He18^bF/%o0WEBo%^Se[jrFgj(]AiWH+/!>QVJc@nWL6BE14n>S`[`6bp`7.sF0;
kse/1keZ^V-\qV)htI*PI-ijdm)%<-g>O[birN"8/kl5LV.n^3m06\>h\#&nu[ROe+m"3Ndp
?/=ALJ7Rn4%]A0OP("ee.)DfpU)g>HCPj]A&gH'D8,4FoHBQ'3J)a\N>/)[lYPlka]AKhBGlb'j
nSmp#!(0R'7u'2jJPdpqkn,\C?\&NNS1EUT8W2o]A`4:OsGd01kHV8AH!F[E'-ZfVN(&3oPfG
.;*)I&g#g(U33:d!Y@hAnX,&?4INNmi1i/:YZImL-cfrnF;m/5@p55S>KUr5.Q,9U#Tk.>T\
o$4Hl0A/?0%IJ;V#AY&n/qkU"WY$8`).`t\(@pY,9_d;H^7sd"/eQ@da>`_PpW%%A:*'TN`\
ji+%V'p_C\"iGmnUG!nngmJHo7Rg!rrib&:V:UmC#i]A?cj*'V3Cro?i_B*@[^77d;L[LT$ns
:S7_L)%*(6$5qd:`]A8W@Vk62d/>4\=gG[EjiA)ah`92"'3q4B;:9COa\q?.V?-KSFSa]A&G:@
COj.EAu[54Uu^>L7T:Qc'd>#uQ,]Apqf;fm@VP!8R1(CeP#!5VhIAno@8^TD3A:9]A),SjZ?Jq
0aOU]Aeh#&jZchd.tNL!!23=Oq[M2\6=?V0\Y<D@QJ:5Q5]AcRqJ)kE&fMdsM!hc*mZj(%K*Z^
f[Ojet#`a7%K'oa'5:5js6uA>UoZ20FbkeJ_!9j$a4B=?3qjkc_oe.X.Va%f*t6P;=0)K[7o
gG]AijG`%OdElW0k$GYM*V8U_6mf=UQJ<lfhbfr\JqZK4tqhC+K0Wh8#$#m1+,$N[uVZ,"?W#
pfH%FW>8J$#!13'2@<`<)_o%i^d:\m@";F[-,^2^5+7Yao^J?T80ggW6a\)-924>uQ2OnPh(
RJ4(o?XW04r2q"T`]A)[g`%`.U3-H@"7F@>:_JZJA1dI87A+VmQe%%qTagII6L*Oonl5=/p3F
U>Ki6f_RoRJ6O*M(S$F@%NuIbWLn\je&jj2j-ls(8!q\e!\>Yg&Caat]A2K/4>Y]AUIcHn_Lt&
*Mf*@89\^]A/Yf,MU^Kt%<uH4JJtAMBR_e``DnPbdb4W.^u%T0Wb$%.Me@)b2_P9fJA*$%Yq[
6\Vp?,N<n@rckqt+]AnqFVegaA6SO'I+)A/iiOi&,"+&8FDoVLC2ZjBX#p'1":be]AH2p9.`QD
dd]ATFF8Q9M\%r(?pZ$$WQ(j]Ap^T?dDo?(4E`Q_n[NA%@\,u165e_p>i)JKA?7!]A&SW63Vf56
^%[N.bYXS1E5Y/EB3Q&/2ZE!Z:H]A@s]AChc^9/2e+hNt\%ObZb8VYdU#/Mq2Ek9J:VB<0)`f:
4lpV&deCN?BQ4]AEc+ZJ9Whi^^a@d_;:"&\;4RVBT!K`#SgB?KJc[%TK0(]AL,-rqkUQ3Kt9<,
<3q+q<Hil!R^COY%]A%YR)L;,X->oc3&ald@&E0Pkl8k9%H^'O_Bu4>4B`]AUs1)g81Xg1?4i)
WnGASkc"6+"kMOR=Gp6sHTF0^eoREDCmPqA$Gi%9&cTN>uY<E&UTBD)!CLsa:S_$_Bh$R#3Z
FJ&Z!A$!P]AUWal\A)QtF(:hG#$<5Q?loVi,$7q*$B&+&a`ECVpRO]AdBjI=(dC[.(g"jP9MPo
:78QHD3XFP"'D;Qrmb('.:c`(-a^FAcUB]A[VI;C+?Z3S;2@JiLoL=PNFaF>kD&>L\"RbJUj?
]A!b#+/hkoU,[g-*2Q`3>nd>Y0Leh1taTP%@mQAhA!6\QSWJZJrc40"`]AQF>]AED<RUapCk56o
8'mFRe'@gj##U9_\YKf*4#N!qtgE5UAD/`bCoP#A+7;o)#K-6IT1'De57)U'b4md[N2lp3,F
Y&3Q8gSl,On"BN8lg_91q(@W_u;l1HR*it#qtE-&F91,%<m25HfF\#SlO05d:?l]AnSu]AjHbp
QG'JFpD(@9'(k*YN>n+M>s>FsgNq'OH<jZ(n1V^Z=W8b6L6h+n?<R]A:"\9,!0<O)#9@5SiP.
RU-O,Rc#TJsrY0bVr.O4ss7R@3Y?Q_R.;QS/6SGH$TW8YDWUPt*%7S"Xt&2uen(>'#=ZHSUg
D#iOkbBQ4E+<)t]A$XC#U"d]Aq,Fp&nNiVmTDWi(<[9Dt$YEiMosWE8&oIYOA(I(/&H,9:%M&p
,)'p=c4i[V@Gr!4JK",_7F,:!E3c`kV72CiPFJF=LtiZ`ZICeJ:;_C0;YhP#Oh'udJ]AU'"hu
:>FU\*;6a5u?P)sjqFR4<KPjn+n+0_Fm.qEk/J,]A=MlGjh9$o6g>WDd>'Q5]A@6JMBo:PjaC$
1N'nbk_"On:Isk(&iVBJ;Xp3Eh&\Q.B/WJ.koq?8<;KYb!/dF@dTU"3#@2+adii#5/&[Ru&.
j.HB`!#;#1K\-6`I.flYb/e"[Uo#)*lR<IZJ4sMnWL($AKmF=X;O#a-9u:f[03g*YRI.N!q5
QWZ$ZD'l+M89+,Mqr_#qIRC&hYIG`Hn]AbYt:O;]A03rV::mJt_U8#"O;PkPd+h2=UB*`)KI1+
Y/u*]AXI9&TO`VKB>>KOUMcKCd.:gWT-``Y)DTVk7#+-Cl/4V/IVuE0Eh8"5m0>N@8<ioeBcK
%\9@)5i0,YH?3Yf<]A%G&?S3K2'6;!8jL8E6c*f?!NEM4>6J5PNUflcOkpIg@-m@m)%[+.uGF
D.%oA1pKn&)O\JN1((GObOA<H=f<D0D6Ug+?un\K@K?W.%r=Y%WcT>`oRbD\Jk?qJ-Xdk^=Q
IS)*Z2P4\gq=*mU0gY[_'WbFUZO/34G.:8#`P(An:i>_GnoRCCuYaYcM>1e+S[<O+3Rr"1L$
Jh>UW$C0H0t\ss_e#'mtf3G%=FA?%q6V30M:ppAbhJ+iA/U0pqYrTr@MO=C-3:`qS*Sc6&0G
F):nh.Rm"s7W?tN:U(ErWd%W7@j-6isD24^[CW/h?Z$OJH7EK&ic=,Y?7]A_AW:9j(W6(;g9m
*S`=2M;_HFDu,Lisr^kTC.H4>_"BMlChVfGo"R3DM.L7MX;,%.!!SdHo%r+,MME&M#^afe;T
=3N\F/k!Id5pq""9"/4:>S%K+NO&7%)ca0^@5I:GnD8`9MV3%h)a1JbPt<kRABIap!ujYP/T
pQLkPDLq.mj[@W+e`&f0j>LdkfTS%HmhkN>%sbaa:LinUNB>,CLUWpGP'/,@dIlVFfiLC4RE
qY6i,Ldi3$!h9;H"RrrLtOra-/NFdDLb9T3cNc^"V@T#]A:IaMK(c(ijKLLe-A>+"\P3c@AJ/
-7@f,HO>>pQqF=YZ"*@l_N:$lXI#HJ,+[^T@lX^$ZCb<%-*]AHV=?`UPY,#pd8fabj*8N6feK
VM>/*U'^I)f[#%@E+)'bXJB!$Yb?%#DT;nT%XfhGDn(.#.ha7WX]A:l$b"&/C.'n=jSOj7VY]A
i>'MamYU&ClWO53C7e_X7'!;pEOXJYk<CgA:1Do"#P9)K(ukBN6>Md^WZ:&d/M#o(UHQHp:^
W`?@CT)jY2V%6->XMUg&Zjf\"<#?:e=XYh<Dn+HjYG-0O=J_Y?=1P!ZkcVZ0csdIHIbqm3$I
^WTY*Y&e%c5D^/YS@.;\UQ8<j"TY.8%*_&cc/H>TVm&9cXioCAg5"?H;I;8"=%<kVg$o>p1D
]A'Os*T&J,]AWHC)Tf!@@'F&\M+6Cr7p-brE@O1V%BqfsV6f]Ar.WX6MmBOC%-jDLC@6.W!_;)h
C8]AFojmn:U9806f><\Kf6BGL+11<WrX)>kU\G5IXE7/utbU$F9ShPUT:GQS29pJ#Gd!rub/p
NU;-kIupVtKn#2_4X!Snm2p^rfq)REjgcbr3U\o=82kE^(J<9#?+4L.1c87$/ZTZ<41ikBIF
B<U1LYYgl1^>W[?@1H6h1NX7O)fRaghr*H77&8aAHET^=ZY\2TSqVVa3CFo5T]AA$XJo*;5l/
g_MDb4r6AQY`eUR**?eQeNdP7EdW6u4-5l<PL';FNE@!#0Jf0ar=Ah`:BO]AdTMnU/,SXG+!*
dr0U;JZ5B:Wp;H&k5ek@hO>@[PR13>)3Hd/-S]A&h4fXeX:qVX,@^D8Xq.%*J$f$;?9GF[]A>$
cq>dEpigklQ6M8qTq9FSJrO7FV,6K?W*9>uR_\t3(Dfb-.tUcVXN-:WpGQBu<[W>rO5`*>P(
3>hqmU`>7WMqL$n>ph/UGe[Br1]AV(SBO92C##:pS97:HtZ$#,J'lNAR0ghS4MQ:Q?.H7Xq*%
qg5(@kM@4_nTth/EUUO-L\'AZm.Gq.pPD2LTV4gnq_hmYFr>WA;cc*WV<9$D/s1WD\[WmigL
eN:+^mNR^V#n5MhLYoG0,:!=UE'D_m(i,\-?a5B#`AZg572=TZmVVacg=IQ'oMYH0Lh"'lJ8
F6r@]AMJ!D0iN;[7@qZjc^Pka$f-%-jli:B)SCdt2EHE]A3CZ.7lp[;PV3pCni!.Hp^M:-4\=6
XdZhFBnU%4r5AB)Kn"6ril/U6FjR$$Ah6ZB_*;o@B?ej*1!L8E=Y:)66,Me@U_V:Am>a$5<]A
9[mqCm`/P^qsM4-$NZbJ-E85&1ZPBu=NTHDKh6&@*U-"t"k`QIDs>)&HOiX<oofn9i*Q=nj]A
S]ANl"K-Za*Q;fMf7e"PXMb-AlVrrLn4L6?q9+a-HWi,YYci.m<]A)e_fquBLit*&-:9tKnXEO
1m[+P%,P>N$Os>f>r`LF(EmJ4'=D%Ag"F@]AS=W3;uU-J=M+iU>8GD0Qb^nlt;pX,F:^=aH^3
a)_u@M7IH1C@TRmm1O^:rX-tm/)m]AbTNga'5&=S/MjLi49TBgN0n>P1)6V>hVFSZ@i=Z%*q[
["VA!*E]Ah:,9>(*n;M1)=)_asApf(nALA]ABn116N#<&'V0INn(uG"'?k,qu^%irthp!67)62
=hQ=5gaus8)qp_>H="A<JB`=K^Zb(L[;043.Ca`h79'/Trr?(4Rf<Il)&[s:D-jmB7$Y.YAq
e1+5i=p9ap#+?\OJ^%QP+?LWJVO-kM(_?@O<UNLT'R?W>OF8bCK(JItU@jpu32&Z4I\tcJ'^
@oS;7Hlh!Yl3F[rNg8<2_gpNbfg*Ug>rWke#]AfZ+3*nOA>C7.;a/U$]A9kc:+?f780S'JhH7p
_5-2;VSX;[TWjZot\^&#0h:9?M]AaNp)/n\BdD2C__@gi8G:hBjXulI:Gh4nj*H.$L*n&9/k]A
`F@[hOhEWO+h#L.Ig.mI?S^!oN=IVo)WmBgZ4aEXmc-;8;O"_Nki_-[,<aTJJH"7d/m+`t.U
&M-q&XGFR;1Wr;3bGno8LQt!OgB8jSS)q?=BD6Dcb5/tDZ[]A/t@W&'9i)OP7!/+W1&H3%5KH
Tq#"(au^H^rsDftLaU?8[kom.Puj6>]AL/SDN^NAR;IqWPeat`Vi5tn[H6jUNG1GGr$j[kS,A
1Vmke!\(Xa-!rlBnV'Ha$GS+Ekq\Q[bb1Cm4!eWEnhd8Sn#l?h\lgS`2/fiqn@m'd784:kFP
e*]AH\60tu7ml3\T'@j$3LA#R9_.B)`cc1U]AjnJAo?Q&3J'_m1'"67HXEhP:(6V-W!mNJQpF+
,3&0?'d6='*(5?32M<A+$Sm!!8Zn^Z5r(9R\))FAN!HCg=.HVTF:qY$[1G.h@1,6Gm[]A?=40
>Nr=MnE3:@]AG9Cg.c<0-'KBKXQrk?iLm"p6XgbsdR%=Q*kbAiol6:[)2,*sQWUi912E$Fo#B
g/#^9'I`->)<",]A*1Oq*]AtMela/#^T4R#NcYkM5jdS"h,"^\Yeh)5%D$-q(Nt"Qa3jiOZh`Z
L+0O<0o7j(`Mm?);O@[_`nD0<1JST!8/!2CL'A5:;GU<uqB#%$a<13YDG3BW37(mCL8[(XP=
$'tF>([bAJqr=K_$6)PKX2?=E7EFt"K"&Z:r:XTdQ?n&bik2W!k>-jWK!=T=T@MN-%]AH=drh
lu["/L1iW2\?>[,U/p'/Xh7N]AV+O+%/NN%n9`1`O(0O%7'JL5F/Lj1""H+9I^S?!@q`NUSE_
`1nnrJt.gg?Ks#aMq*]A;_9F#dB5Pe>@%ujuA6(Om[bLFQ\_;;h?":>X#0=Y8.d<P]A\>pA6<c
seDJPk?"FJ'3[ra>!rm?&ruhYX8[n4nHf(t;SIn"mU.UTYnGDhMb%:hiF8ZnalEBm7RP1jpb
jO8i6"-8B#8[EMTXc7[llBt#DCdc)ssd+fQgbalon`!*(Ennt24l'Vai:TDB+_STA,lJk]AZe
3b62krG*4F@Wm?]AmioR2oum-!fc(F?Rd`g=.&Utk5M5=$pSAZZ!tq[8OfnSHmdk.'+N#RZnN
!5j`UN9Id_Y_*4)fFD^@R?-"=B:q/^t5p8<Fq.?C$kqX,5(^j1N[Z^i8#0OMcmiEPce-(ii#
YU=@mje'()8%SS/9d*H;8,Vasd0Rt,3&bSS`>9R[Cp2=O!D%c]AFe#6Q3Tde&*$D)*T\?ka+@
6h;B^)o6THm"+G;AoDgfSmKVo`lGcFOceL6Tte3UL6mWmWaHZBD9VXd7rVNO"j!"2BmiR+Lo
jBht4T5*45r&ML5&)S3h\Q\*]AOmFZqQe*Ta9TL!+geW,(S7!NnqS=gocEEG&U3fk,EP2C,<n
l7ul=#"C=^1a#aC?35ln0=#o&'?j?fHOSd4mXB8Y'dFuVQt>O(XG_1U/'.jLQU>`4^q9UOER
^l)X;^C=U:8P:dM6'`;N"t(ZZ@HE%JW^UqV7IdI6u7RdsTl#Jl(+g@`i^;#aMRg_uPY-jAP8
Gkb_-q28A9JJ)d7iO/L[l<;uSMooQ'C"Mh,,D^,TBqqIsTLT-6O:rG/'q!>T4A,;G)R>aEP.
Ib5OiV+YN8u,>2uUi104X;;Q'2=O[mN*6>J*8gPb)Y51u9d/o)-U:gn7ssd("[CN0Qn#brbE
Q>Gk>md7M56PPHGL&"(q2VuNI-QN!_t1a[.cqFWkia>T*6:ZK2c:R70.ag;Y?'q+]AUaC(bIS
(".%^V>uQci7FdEWm=hkr[C,#A1PS>MQ@?\Ja43O-J7#7o`0:m'YDknG_sM@,mq)4:o]AR+dK
^)ER'V/*[$:UDL]AneHLGiAHm)7ZTf^0rHQDrb$;P:2c?9lW!(#/b^U,Ps]Ai(X%#M-,JVt[XM
iHJo'%ieL)Qb;-f8_C"5QS["%,:%,D=n.IW+kIQI/:NLIB,F:MH+b^EEfuqDHeNL@,rs]Aloo
(`IYV'3al'hSAs'`SL;/GnABWZj@D1Qk@A$)*CSXHp.AfkY`g!?#Z$rMR&'@*s6f<W=hd`G5
$Wdq$&/SWRG<_-/NOJs\E=Fto?4`eYSV*\;.r=#@%cDR%DmoOT7UL+b]A$5%^7Ol.U;kTXSo\
8biVQTF&fe`>NQde/rQHG[=A&4+'PQdG`mI$F>T1#(?FdAcL)/;>(O<&-<s490XRF4%$;AG(
l]A-YUi.(E$O#QV)-X`tA7/'GiYFh!CMc[pDs5kJs&i,A%Sd!e9qZ_aB@q(,(:IpCc.QKP$Nf
nRXk<?PlRYHiQ#PiW=rWHM#09^K35\/YuG&SEC&EV2^U-;rq0hT<Fo3%r8!#GEM6!R\&o0dQ
h9@72V['>Z^HKfT?)Jc[*-F_V-*(r+/?9UOSXh(]AeJ/YSV<$PXE4W$nk<[/fkh[qcoX%qRpB
:;F*k$33Yc*UY4Lb+^Toj(]An3L#b=V0P,4@*'U;b-90a=;.FjPs,Ia1miZ1eD&fKNP4D4q&X
VB.7Y=S`/3)ZT\BO6B-ah,+B*k1HeQY%Uo?(gl]Ad3o5-'=S=jN*H3BlK'T9mrt3VAqLd65)b
90?.a5eGi7K.o-0A;-,=nbQW,DACd(L2H-kp44Ap!1;mX`7>raWb<'p*Up;*^MWqqC0'sN5m
'4)mZ)RP#djXUBND=rC$oMBGYep"V#R!j3[e?2cqctBaLP4P&Gr&**<'+RNepL-E`h<?2?[q
5#u@gfq!YBGk[eq5KJ2Sul)4nl?LNg\7H?g"`68^[_>.=nsEO_=BG]A5,5-?uQ'CE";GZ)15.
[W?31G@[ca=7SK-qIO%Fd)ZPGIJIgXGbNsa9[n]A6%3RUcdbq?]A=X=MH7;+HBVU=@G$Ntq[)E
Dc\f&AI.eo_;[;2C%g2bJ$87H16Ohj*KY@.2"KRJ0b65lCWf9dQh&cd<8JOLT/Kgc0+#-?,f
ChApW;2KTYl.PKY(Sk%[;]AT=MH`3G3?84`5C9/F1944ndL<QiYri\Jnto:C;8%4+sR</k]Af8
5h4eqMi8CMF"ud/+Z2%I@-c1]ArIrPkX#>g\Y`#aGH2"OV[i`NAooT"'V%H[(RGl*1(c-LEpf
2$T/WOP>1-!lX0]A<27K_/kpD`s`gIH1(?bPqJ0o0lh:\^E"le$H00G,LX`^V/+9*l0PFqtF:
NCC5Hs;NP)RJKLe)Jg04<ooa"S6PIi[T:sCr-(%s.++IZ&m5<2nP)3X;^_\Zc0Ao:/IO9ZJG
Li>hI<fCa%!AU':&!9M2nF,H\Si*._$<N6>p!*01:>o1Q&uSHR/)h[,Wm#iU2b+bqi'4)Vqk
U5=d[OK_3Zo?5IZ:lJ\B+6gW8t5qMB$ijBm"q#=i[*Q_2:\g3G,BUX39C%8;l4r-N,\36P64
VW,8,%JR./`522NX<c:5cg]Amf/)mtofAQr>kNtb[Gp3$VaC,*/'jLW7"e3s.H\bO_D/EG[YJ
)M;7Qrce_hsbq3p62%0)&(aL4o`+i5bgs0G^uX%MlH@jPe6Ps,&bG2+ht%:[e(YShV@bE,38
aCnM$dBItnm0'>HX=]A,gaV<lSHD5/E!"5l:WPoGbCZ3!['C#*+_G[B<[)#[g]A9WhZtJeD%F2
'MF0A>^I^Y5ZsFHc(PK?`BK^%Y21;M\>MLOk,h?#C<qakY1V9X_Vi&X1nlYCrB]AW8MP^@0AS
Ri>NF$")K7QOYM`L4$M3mP8'D-:+*SuT_(h0rrpg+:GX[X$+/!UHbZ;]Aa7D<r9qgldZF5[mU
cM\o9*">-IH5;.4$T4g,pu<PC/b%e;(^qS*^'Wb?0,S-GCec>K,S\#>kW=r+L/9Ctfa.(^/C
M=G\Da'(,&q"sBOhCpo[9jDA7+frl]A]AUbGSq?dVFFS2j9B06T$SZlk1W1R_@R`u4!cm6+2kq
4QFjHH/-::E<hCeOMN.p0,PS^+YmO!m5U`O2+IBd]A,GC-q]Aj.ZUN-+L0h,ll-i%$*<Kg`J^6
TiVS[gL;ga/U+7Cs('uQdj9EAA[krPLH\5O?>GGZ,?R`jsHTT$E2:'330IP4WTOa5:LJ+=%o
87[_J-4d.(_.FP#VZUSLO]AUko:qOeF,f\q`-s<e=l^eA[>b>+bemk:gAXIEd\F==g!.[-pSY
LUH<pTKSt![QU-=.p60Ho2oq:f6bA!8SlF"3/2*#F4'OIYh#uW_`=X6bN^//eP.=W3k<63S-
"u7!gu,_3RDKt0':G,nM>Z::nD`E969YM)'J2S<u#(!q6u`C=qTYA-95&c0aRt8X'&Y+'HNT
P5DAQTW.c(6=!#tq,=\O:g6Wt$]A!FnA0B>8dF]AfbnM"Td[c2TV\`G.B6(cU:6WDuT@$)gW"I
2Y@D0(5"IXdiKt7+e$&ou(89%pOrEY-PjNLCBM/g%>6\R6d_.^#f->nJi^[<LLY7[OSl"2PP
(iCSpA9>Ze;-jhsH-P:J-d,j_nbZF60Joe0u!s/#h5(]A$6&$ed^t*V/5(Fl028$1-Gkc^Yo^
=7-&@_CpMrR]AKk0@VZ(tL4*pN@ZZSbl&pXZ?Z0Jh7Ho$!4DYY$^JR1/3;iga<+EVo$4Hs?OC
i9p2DbWQ0(=I9`1DS;+JY\2H.2g^GW=hU`@i]A3n/&<iX\RH&ehuJ5hfr.J978dup[6\HJI[&
59e74('0J#F4;ug+Amd#B=et&so?>8rTB!"0B^e.rP-*US0Z)D6a]AEGDiF75"4q''mUm_iP7
d>oP"!K$X^rN2r<-ed+i!Hj.QG`-?BsbR>*k`HZG#iXE!93K+@e,"L]AM(Jl[8^8S*qfEZ1Oe
c+_K:8nC?%9KDE<Id10VO^o:U_5]AF$8c?t@1%hN=L(q>rSRmjdY;mZJ/11j*aHN?>]AP3cNhQ
>cDt+j'r8^aE[CQ"6303@@8,(J'=79fokO0FB(3TN^9)0?ou7UiZaF+2sd.p!_i+IWf#1;&h
iPrP4dAmBXDdm5fG%j]A$2]ASnt?]AVB[]Ao]AS5=$[=a?6N&+R9DgG>ma@4nj+P#"OJmrqk!=//q
C,U%5g(oILKrj-U@PG`21)I&j!S!kS@og[7TE+-dnXZ!b2Ed"d]A-<ggs@E%40k8OT$[*E$-O
`9h[[RA6LneEcN$>/\%doc9/?nEWJI"eP`i4FZSO<Be[V%6&"^$cVm%+.%MoS(P\B31q#;!B
jWIJS)g_!bZ!=AVD&QQ#2#"N(oKm*QgQ:HR_\%Fs1QnOf,a0dq'A;@t:P;i!-*;IX0iB#kCL
ju=1^K;";u@1(PDas@X_bK*pn14tua-'s5qAdgIM*Qg5r\I8eJWUn`RhY5??X`qHos7Ld6gA
A5N>0hZkD`tkmo6n'La'SW)1H:RI2X]A)Yb?11n$P\:RacsARIQN9<h>C&;HAN>9,IlF?g(%/
sP&!3VR7Mn1]Ap:'H3U07IFr`*80h8rlKC_[T3^75:s6XoDj;b/1bCO2HpTa6\q9@KrXBel?;
b-ZdI_41I7%)3b3MNSqi7K@?M`3i&rA9e^kkW>Oi><J8S1$B_N/5hb/0Km4B>GbLVccu2/m7
Sq)-I)^2`WDWq%iJEe@Q.X0M!k?g5Zds\G<[MPH7S`YZ\Q2r>+SJNoB4OJtY#qdg;e!@RU.%
Iedd2;6`0gWn4'7`;hJUF-3Z+_R'h%:8j*E"LV$Gp'oYiS591LnY%TSEEZ#9mYGBpk/NX:*P
!Kao6TWS\DV;63WMa_&8aJrm$1boZi2a#F(I:_^fR_\m-*DIOS!Q!4of(MHUmLTBUkbTO>Jn
DHZ"11SmsG9N[JXY?tTaHhqHe-1l<W2m3V@rTOG@s[`GN"<&n(aN"dO%k4rP)PiV9%%*n5kk
\'W/mBIW7S)BkhO]A63Xh4N@)B`p(jFuKrb&=*2'"-t%</K\p?&+UIZn_%6=YlbU?=WCg(AJ!
,>RD1'-B@PJjLJrnh;n*W9g&Y_MZA"KY]A>\lZ7`"V/^GdB`j\ZJe:lk#)&lkBc3]A=oM['Dfj
n"CfFU_>((V6%b\IcQAZ)s<rGNc(r4k1"]As3Lld3^KY<k:lJOB8WGR)erCEU>`GIo]A".6*P7
M]AMU9nAd;IQ9M,;nrl?^J&H2i.:81UAJcghZrHq7BE<Zk(pXd)`YdrOc,rT_W82>d_T'4f/T
g:Entf@e%k!-1XV7DOM$IQ-q@N5m@^#:g3a=goADg#_F>Af^"-6^5KRu[BZ&.4X`L8***T>:
84,L.%-^8:_ldI8Hlk:4iD4j[GH*a#qd,h&0Z'a7"h`E2+\d]Am)h=\s0Q<!+?mEn?6da!pc8
uWojDj_:,T\??3]A5HIs)-oEodI*dQP+]AXZ1CGBiD'LGj]APNH"H4KkMbt`Q\IW',]AcW7`ae"n
otP%<0NkZ>!b[8OC-:k)7o"a;%0C_>gZ17>fL]AGu+!GsWT/RGJWl"Dmo1:%_F@a:YMj^7&T"
d^n*sJZSms@IJ+^ekP%i&Xf*r]AE)T]AnL18#QtV[N%fQ?Agr)h"dBqhC'tk0;0G3)c)T#hY+(
3YXh[`>k??Jb:fNjXU`%32m2kfd&ulrO!?#A3G9l`]A5Y9)/ORTghGC1F:ZU"9C?:Zu/(,=uG
s7JN^Va'_$<(HSF[Z-u&oI[%S&b/-RocE-I!<lhXbBd,6Y9HP]A'fI+J!@VldUsJQ<HPn%Hsm
\kr,VLX1S)m\kHjp9r*dA.OkD`c-0@tkffaS>Fe61dpGsj\^rM%IQK/qXqeNdFr,U&qOp2_8
Z<;CN'n.oPDX`_kkpj74[u5,!+$Lp$C=pTrRi&W?5`Ob,R<]A0HiU<AE0m%,H^@Icj#&n7L:=
^3U_k=41PH0\)@J:t>+F'r".75(;j)1+(S1(V2g>d0To5)ONTosW4RLj$0Ej;@:4mOqBDK]AQ
f[sO;^I6JPr.ZJX@=7sRO18*e]A5/Jk*j`Ob%'cVDLV\/h./\5C"6l/KIba3=?)85H36k9`9G
\`?V%#kd2%#s.#d`Zub45?>9G>4ga8[CSI+\\p$rH<2TKiY:VYRf4L%FScKc1G/>*Z-X$EB6
=!5b'?`UCnYh=-Q\NO)U.qDntn;E-UBMN,6^Z)P`lN0QLg7*Hh+<S^RYF+2Y95]AtSog@A1&"
)G\4nNg+G)9lYF*0^(l]Arr$hL4?+mgPh]A2hi%AspI]AjGb`</Z9kEDKcJooJq&R!RrgrV4oai
CQSCl`fWLor+'#1Y-Z=qD^kYT.!:9NZ\8kTXg4=cWdhlSXPdhp1tn;YQq;@(;o(k)U<NWkV+
]A0"mi52dR%[S9q*S4e;6R4/=OUb5?-L)373[I$&oakoA,6&,Y.p9@J^)Qono?*Yl1:W?RRRi
^4r'Rb7W&0)j/5mu`-<,1X%&GST+J,6k<25Ue)YY8tn/I''sL>qHBRrl47+=!/d)_U,adYm1
T8@8:#a>u4`;]A:4!70Q*O=k8O46D/!fXPBS<@%&G"dUlnjfY.iT=bG`VOe"8pf<go?6cS`<Q
Q8U8tO:t06"uCAgJE53]AXUj&MK"#d]A`bES`T[ac*3o^lk2eYY1V5QFg!p)d>?HPSPqGhC#U"
6<b8.*bdpsjt$>n#mU-?UcX]Aooa<C^#Qb^jLS1$>OTF%ANu%1CE"pq%q&NS9@N=EeSD1k29?
VT9hp@Hk]AR%!h&*<Ma>3dZaG2HUTd-6@M3;Tetl0Eh@EL=@d0"39ZA;[^>l-^GH*Z&A[Z:]A@
`5J2qD$+.8>8"*OYTA"`3O2,lEKf^Wk=ScZ/!F(6rVQD,?rKgX0c9@U[BjHH0FdNq=(.l$j(
e,6C'&`CksF(Z+.-Ln5KjZ_/M_V\PI&1f.uUuYPO?$9tfGnThq!n'jK[ZZqbb]A1@sGcZjlg`
,-mL17"+.C+Qp,*_W4F1!3TcQ'`<(1\S_M6?qd=0INe*a7=#[TZE@9&n#'7jG,<BniR8O8qd
0pqLpM6J2Vg"ekF18(>CBkR8Mf;(B9,j&:K\e.TB'I"Mg()9-Tr/u\u.qYM(Yp?@q`+T+]Ae-
R>L_LCP!UBd'.#Q9hS3X)*0`$q@pjfJ%V-<`<194R4s8_<5W2\.,"r3tAlRe,HHP4W'bO>dC
mQZm`_h!bO63cj<\DU/k2XE;/F>4HpURZb\U3=Mi9T.I07Ps*#*i1mOP_^Hs7+rUG,q(1b=_
'(Z[lL:+tKWQcsCr\h+1mjTNhBAm5TPuUPN^K.'o=>A@#c+bG0f3B=#oVJNd``&g,@uR@iMd
=Qb(q>N_a?Q>e@:i\(2XNQ5VR'i#nA]A5]AM,P13;e8bHZ"i-t.4M.>:.;>O%Mf_117iO0<rSg
0'DB>1E=Y+5I_0?$7m@p13KGU1;PY-@8s)7qL(s8$^>b[)EQ70MU7?K&H*4tq6kFti6=N"X]A
SC(7tMW`B_%.*;t&Ce%f19h<bf6iCX%Zr/J!^SJGp-*,ZBN0lh,*%X('Q`lqV'JqROQ_W39\
T%nMrerr(Asq7^.GJB1mR\/CG`2d`kJ5@;W'<F]A%4T1:U6s(tD\?_1D@@+0ASsT1"ol5@Y7m
M-1g311HR)39pH,40&![qjog6B0T.ln>%JJ;nLk@q<@E%;&+"s1VIl*]AVh*R$kTn<^22&JFJ
Et^a1r%;sSc3/uDeupf3DK^/<TB?]AA8]ATR"@Bf-YO+rpHpVUDWjEgQS.8\FO'!F@]A=\ke?Br
<k!,.26Ik1"+E@^[Bq:Ef>]AF$Tc^#Zi]AVVrmK@D038L$&3s,jL!KBAXdN8q]APQ<fqokVqWYV
B"=,)j#tR;_&s.VH,U!++E]A&'MKsjr/c)rg^D;>J'pQG%+</)%Wq\@lNe>1?c;nX-GmC@]Ah^
>D3l,qj*Gn,9NYjhQp[4TGR<!!=nT"#']AW0E;2/!!=nT"#']AW0E;2/!!=nTs.@*Gs&qSj\d!
Zc(k;W(J-#Fp&lrW1,;S-0n9r(OXRHYj2#Yq#\:4P~
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
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="433"/>
<tabFitAttr index="0" tabNameIndex="0"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab11_c"/>
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
<WidgetName name="report0_c_c_c_c_c"/>
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
<WidgetName name="report0_c_c_c_c_c"/>
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
<InsetImage padding="4" insetRelativeTextLeft="true" insetRelativeTextRight="false" name="ImageBackground" layout="3"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4572000,4572000,4572000,5715000,5715000,5715000,5715000,5715000,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[最近跟进日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[销售部门]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[经销商]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[最新阶段]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[跟进详情]]></O>
<PrivilegeControl/>
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
<NameJavaScript name="网络报表1">
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
<![CDATA[write]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_dialog]]></TargetFrame>
<Features width="1024" height="900"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/CRM/项目跟进/项目跟进_填报.cpt]]></ReportletName>
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
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="报备日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="最近跟进日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="销售部门"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="经销商"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="最新阶段"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超30天" columnName="跟进详情"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
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
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
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
<Style imageLayout="1">
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
<![CDATA[FLqcW;ea`=4JSY[.M`ji\k8/=+MEbo?Bc4/5_t5L!!W]A\'J"c5UkK:.;F<cF+B/Lid\Wa)+=
NpS%0T!'ontWt^>Je=^V6e7orOC)mrRsNcTZ]AJHZ%VE9-^#AJgZ$Em5H("j4i/"rH8UdGt\-
^SFau5f;/3!Ie/&*Er1T.B^YF::U?j0UtD,K#*A[OE(7nj7,T.WrquB@V*Aau]AJtE$n$Dc6h
>R6ES_Mq$4qO9$bfo+XX+tqFGs+D6TL[#AhWBkaVIgl]AK%;r#a^'^3.5bZS?OMqSq2dnmOSO
G./J`IA5)+^!m]An&G63_M=!p=UWK=P:nK9R;#?A.-Q^L!Ds2;g?ABa<\_f3^/(*DT>D2RuN*
P*jPlhnd##_`<8FETe4"ZN0S1eH6HIkl3_`4'tNln5,.1]AC<JL_`AP['c60.5D([n0qRjDI7
!.4k$[htL4T%Vr:-2W%7a"^Ki&0nqB@pnW4k0CFu\,0T+@"R=CX4E7^Qnj5D*Eg/Mne5h`Pg
U!kql)2/E]Ab7/O*k@*\*Z+;_;dK9>@JXL^;dK*i]A!4$#7pS.<$"#/`<Nm]AYgeh$bA!r&H14T
&$,naCEGi>#Ft$RfHm-jJG0Flb^<EH"_p37C$"P`iB[0NI05\nD6r(N)6sBPob#Fo9@ojc:S
DW3Fij&=@dr&p!]AEhG/&N+*S6N?h)r&in4V(^EnAQ`JAkE8k]A@db3QGl4XmXtiVU^i!+iQN8
HcA_r8>=qI#$2-A$'e@]A0qO"tN?lr2G'*MIef<sX\nXY[eh*spNb`G'l'n4"e[EAJBU.sjoK
A(jBBGV8nCH`S0$ssQ@&(eSpEmm@?L70s5Ct5(pg%Ni4n,I#@XlMeOIGq`RG#5-!/Kb[YLKT
C&[TtiWKSCMh<:oHSa<Mcl!_Dr_YUrsM>B:u9BJDt*T=^C`V;b+CD2oJPa0.CW83`VMFC1k5
,i;:U/KM;RfY&f8ah3&r@k.)6-9023Lsl\MeJgOdj(Vq/^#uU_elHM\5si%2(_/2P;(FYZZ"
oem/cp[!<)9r#J<*$EDWjW20cYMIrO>B^QGqY6N^3[jtmJnM"<:RH/k$_!?,a"mi3X<OO:XB
A;*=N.'M0O*PODrj-MjG%bBcXo-0.=k\Ydt6SY^]Ac=ue6XaN660ZdH1#?./7ZFhaL!9h*B0!
U3iU[d0UKq]A"SE6^T>"7T0i`K7mSidHp@/pX&"(8J.dle!ZkD5D5]A@NnVJF`j8ObnVOigD]Ae
rgDTn3Y+j?"9h$D0B\6"afQc%rhI/-`ijL[)8UI_lTOJC]A$fBrKc-;@5D&W'QHHQ6(@mda;^
b(`&G*PC;5i`*s>?D,@rmnKDd<fXLB+?"rI+H=7dqS-0baHh0kEAIuWssiqgUl,I:!^QL1V3
72;Q8]Am9B-*ocm\[Zk+(HTPmRJLOO>HGIk\?chdJ$5dVHOH0S3S./dG9kod!W6^*bU,o3e'=
k2`!kmpiRCB=2AfZRV&(0i;Y(W@ZE\NQP7*99^hP<k9=2B@WejEG91A4j"Ydn!^gO;V.kZ%b
-."0DSn_L$[m5F,mlY\fg,63$Z0Jh_4Za>W8;V*%qp;nQsi<fH!7,TQPS*?jr+CJWG"T)P5i
h,LiBP$h$*O;"S4.r%H_(9j2pdo[]AD]ATfqj7h#5]AXK"%*C/\Jme"t\P;Uf>/m_V("K;E+,!o
<p5EjaIGS$fTVkgqM>A[Jm-Z20;2r(XoBWJuf+D)]A@uN715!X^D]ANU[q:eL4fS]AQ?kArh$>7
,U!KeJnT&'AYHbZFfUb1j^8R]AEUi^M<,'%K@@<E.HTan'J0$E*b7pbt,9%1]A;a,W9s-,'Y'&
F!%k]A07HqKT;.\K'I]A6(8J=g"p*nYq*?0F,K+SXjYk`,UC,mDIX8*b!;LSfYB[-!'I1A2n+7
!,#N)mD@oDr*[JQg*0!Zk'bU@\Y96aO5oY0Pp_gQcGXHsQ`<Fij9)RZ/UT8Rj5Zj#L]A&Te@N
0]A,T;P+iG;j.QFe.n5n@Y%UR.KUs1ubWXEV(Ttu0"pq7Uo4Ci>"Z?tC;B"m:R4mNYDg'g?5M
b&&XN>WR4]A;d$`_WjoN*-6g(;sghD%j1Kc:U]AZ>[FBfA)68NZ[1NVl&bn?JbCDaqCi>e;,+o
+VEX<?+\B[bRpJXABkWYS4#989af[IjN-1.gdq><,Z+_R]A;W5Q)EYQM&-FaXLJquJTM#cb6C
:tE/Rr3.d>Hd#FLEI0>tL/-7-)dN9r^N0^b-0U4Q=+q71!UZ_@.E*PY1QT_cY<&"B%/(LU.O
Q<^n?gm6dit;h.[]A]A3dfZ;Qr#!M(Q39=TI'b7ERLi&ol(9?Q[k^ft"l"Ye&mX+f[:\9]ACf"2
F!A;_P)3!CYWTTuf8M/PC<4?%UIb5(U>kj\ThktXg`2q&TA#QISIn-EXRV$ORJ0:-HJ*A:Z6
)r-1F`@>.bf3[un^BQj?Ima"EqXjo.GhQj_Q5<SEuDGg3+TF>Pd"2<q7MMXqGWfWP$.K@d/]A
nBcL\Ke`Qun-UA=b"<crJZTe+n+=+]A3(b%S@JV:r#;mSCn<'e.cQ/QlrF?#:4dRM;L(^H$=Z
92Gfeq"$5L!K;JYgAJ(*!`.VLILi*:&LT&uEMl![(Q5n)r5EDKp)<5NYk;Ln:Wl;TL/OmecK
t2SW`CoKVcTGNCVX-DO5?^+^+2//`Ofr`r[,:%a>aW"o?Eb4\e]A.rO1[=^jB"EE37peFipAd
7Nm\7a2BCh6B6VA,Ajn3HcbQ<E=`V,sAaG3eN"Li:`/:e\-pd-85<>`$N<YDO'WUQh98?Bld
%l]AN3m2A&#?6*^S_Z<*'$([r@Ef(iYW#Do;YL:qpLg,<_jKI>]A)X%O%2V=r8k>DkCCSSKCD$
H@\`otepj.?\I.RN5gH!7KZY2^tgg,U*(!sFa#dd#DG%5U3._;@kk&==&I9!&TA)23U!<FVF
NQmi(QjBN7S?YFA=PWDVIG'B0Nq$i,lDaT,aKdA&5*:hg,/h_E>@/bOs#N6i"0G`Ad_SNcK]A
G2(r@+(R[`<0f>),8))I6_E_Ld96*jN*IL.bgCf*ma!.ugOSYU;I]ABahma%/l-1$i3"&:c>r
d,;h#/bfRoK+Q]A]A0QHEq?mI,hPAB!to]A\Z[*B3-$5AP?>NKV08Xj,-i`K3a8(dqX>(?)PtpA
9==rfP@fnKtj4%PtJOUQ>,oirpf7:RD"1U.'YhlV0:t)L[6S*rq+-5Tlo\*aN+kS5s<deFNu
M-Tm9tOhR:<BN+I^%S`CGiU,Y_u"(a6^++I)a9!adTRoL)7VuT`/c#>Hr]Ao'Eq7VH"VS&&X8
ZGN5G8%.^b7,s!#b9HRT]AR`sI1H&4[Ub:bE?MFZ)TY<,C;^gHXXN@kJ&?@R2m;glJ_h[Qjn<
HeUh12j?/HXFE-D@X=:4OP$pfX:Yh?Nn[iAl(5nSF9;;5"S_HJ<AP_O?uhCK:Rpm]AU@c\A[1
f4_Xdr/[+[Ep*P]A,k.=rci+W>c7?1[kPcc@)ILS.*]AtkX6B73crDc0cM.s!g2h:"@p37JW*?
Y2him5e)O*2DLVLu67P]A@Y=r^.+-0(,^B/33f9Cn!7tP'^k;&QE,hXN7(f&r/iF!)<DHOG?e
*,<DitXm?qBikFJ2g`#6d9j/a?6W`LOQCeS0SJdLQ<J4U2)Y$([;XE`a5;q*a\\9!/+pQS/D
m3:^7`S+lqdp1I*0]A7%M:=!`C:1`*0m[i2ZA0V.XR[O(R2Z7jB4up\]A(.rgfkA:h#m@mJSTG
j9gjgFd=jfcb%PqN5.-p'*$:V<5O?HY<mQMHhi6!=DtNfcjBYaEd>cTU:Q2]AN+/@GU;\HeW9
'(L_'u6n;>_Z4m&":B#K%gSKT*g2rb*&N_S7jA8o8aPLZHGn-^bUVkcE/LUuDZ30H4OL'6ah
%\n%`m"MeH\\$S^n&q)jFNL5^>k\CG(m.3Vi6\.E''uoZlf;2rkf0g?t5eJ.q_Qc'X!rXl*g
4nV<\q=BY7^(kGKi#\$GO_fi0Va;/"9Y>"/W1,("a<hp1!PdVZfH2[ct4En4hcKm;p4.9!(t
=[,i$hq@)s\H<4-I0jua<AQ9aEj8,CE`HYGXH"DlVfJm'1,g[*H7K3e>9lFD9V0upHT<h'Cm
4YZ=%6)\AAu.N@CY?#XbcgW"6T:cWC/`5`6V.*9-eR=0`9_-^3ZtWU0k(uqLPch-oZjH66B_
c:R+8BdmF:,<V-tCLUe_;)BVrSCCA2NnR??/qF5t8_j<BlKJVH4,e>X*9TLU%F`9.0MJ[\K2
`WqECP/&:EWu-GLM#,4m;I;=_5(d<o*V@LqF5,@Rro7/4C13ne<h!"0]A(GY*b2Do14ucs!%%
<<pO8?W:#Djm]A#M/69@^*TdX:Q_$0,(#dmSRQSN9"6>fYr<9SJLQpLX!7%)a*QL8&d"^IJ=a
Y)W6p6`+D;agr+PY6e@H%0R30j[..*m$Fh)Fmmj$d8VrI;0E1%B0YAUpo@1BRGd6YC(jY\JI
OQ1%jEI@<Tk?sIl0C_pO:%k2B4?8;'ZM,!VCr3Z0]A'AdT:5uKl&X5jpKe%o"UF9nD?`MQumB
?,nfVeYcd;q923Z"'<r=!QLFcIhmsH4E=R!'_B4'H9To%j:q&^R7sOsI_kKt)Z+Ks]A$$qr`1
R"48TaB]A@]A!pZEb+&kEGYC7a#\#H5\'`5X@11"iHrDaFGq(O200hDIpRiWV/]AH;]AYAb5rA0e
<'?#f=5(3j.IXt.XCP?]A1g-gR+T9%P]Al]Ar9q`k@=JC\M%mF"INrJRQX&B:V=3a;Spk/Fm-T_
1?bu:S%2_(nI[&*C2kb<Yf/4+18!-)dT'lK`@3IseE9b3-B"oQ!!R428mb+aomPK*%c4^4AR
g_p)E-/k3!^neMALH=b^!S<_d+%Qn=jsro=@:#haMjeXT/3CN[p]AXBuoTl'd<C8^BID%Z6jV
sD5AC#2KbqCV;#LJr`rAJ1C.GO1G!#cGp1Pl#[8\XdGV6)r)0s71.^Qj3)Nt=\7NX#)b`t/Z
/RM)U4*OcLhK_)R^iddZ^*83<O7bpIk:V]A#JJQ+B&d)b_eVS%a1_soF?`oM)QT4I!]A6@Q?:)
c$e^l.G%aK5tb)I.;T#$[lW"8<4DcrR/WO]A1gi<O7$_B8(JV_quqqu)m9-*KAK-l\dPk>*':
LaO[>N6a@!]A.8KYgBSK^Z:-[q+2B.oQLHr$h(GO<V;FqU9cQ;0KRV%u&-s^*N2nA<#]AOqtUX
;*I'cGL!/l66'*7JZQ7pHacg$q#36<G]A\Qp+3(oTDAp"&htCQtaWDG=hAk;(L3J[KeUTS2S3
s(Mr?A)NH^Io9iVAk>Og8Hsb-4BIG)N^`F>(oQRF&bfY&(@X5IY=fHuodSG%*[b0&m1X4nJa
.Bu@gp[\3U7uL"2q6nLO-l.M[VpRe\Z8ZTgsK_L(W:#Y5boj4?**hj!`!d3b.>kf-IKA`lnH
2?.kRaghpZ%k6e"bu35+.0[8oc@gld(EIt\.":gbMo3gLY<XR(YeMX$i.=Km"WlH?hRQ5$5`
KZL/CMN#1OQWp5KX+65CDHRdh%s,^#`,)!RjrC]Ak5/np*mLV!CCO='t=;f;iV\KX78$[1678
TcYjmXi`<1o;7g=(1Z$"M/]AJ+jg?BQ1hN&*pcp:(b-]Ajl;#C,T=*51YO24ruXFj/f_?W_sh9
lF=4[_G(08<]ABILW6mK:7cY)2ZeXi[Fdb?e\c"#,"-<f"GocL;IJr,\*khDoL%d./jHBtjeJ
-uN52YZ&8Wn-29j2K%$kYd^2PbgJ']Aa53"39>,3I\ka^A>iZ,kYfE/M2r#NZHuM*3=Rk]AGL*
OT0TpV*akdAsBJ3s;*D_a[[tmM3d*5G8ZLPiHf17oKpPXq0PL&Lt:JW=dEaB`eU/oJi5,LIF
2(b6NM"oVV6mOD,k2W<(U>P?9m39\6m1KM4r>uB3TO\b$Gb5cm1W%]AI2JNsIZZ1$X,U[cOS*
PfR_-k<2s1cVUcUYuCW[=lDfGP*rWC!q>4?Tc^d+H`[-d(S;7\'27L7Q&&4mbMGLG/c3q!<7
9KZ&)::P:>/Ui2JBL#-OT9inh'WG'</`bU<UYD8@'mZ*ipdX,C=34I?#e0Q0@mfL7pmb<]A;X
mF9r!I;Va1BWp*%1sKGV\OV*+B*Fc$![A1037/11oY_)U!%M'T>.B"Z2AG@c.Q4R`JjJr97\
.n"Ad6p47^J[A5f"-2e6"O6&Y"GC,G<9Xq?AoB%B0N^e8Oj70Y$KG)iB=fpAY17Ct$;1UMI,
roh>WQ+aK%Ehc-NWRb(RdC'.k;auL45Zi%Tnl3d%$aWS5+,3R-I:0E_b-1qYr.3.!J*%b::m
]AL>X'BR-4]AVJ`4nU!>,FVXtZ?At.\R$pG'F*:Y<dp,l^A550Pr(Ta/=5)ED:DfodGuT]Ab/cG
Va&8Z:b&60tUE4^o-N=L!<HCe?_O&ID^--_i_\\V]Aoo\rRS*s^."?OKOa>2XcT&kjCMB>H.%
p^<X@\OR'(O5Q.K_fP^kYaCQ<o?+X4,tFl\pdjC&&hX9$!;>&);N2o41EaB@Z/P90l?tV%c5
Y)AsMIPQ`5>OX!l't!#*,[9H%BQYL?=Jca[8OpA6CGBsOsFeii,5Z]Ah>j-.5;<1l+/,cu/E\
GR`"QbdDfA>:).QoO72tb#Q24"kN@EH9\NE`2DC\L;[(K?FrjS(/KYo>FRcPGi.Fi:j!YcJT
UA<[f%a;).uQV6Jq-J"HsLNhHXIK&rU)MJ]A=!L-d5`BO!Gk_9*J47Us0SKan4P]A1N+B+UJtR
lZ*(]AnKT`ciY\;G2O;"V'lCOtdS&ebCr#3!.SJ7g4r)-1+I\;O4lE2bAW=mn;I)2SX.W3/SG
oDM7@7f+39/!A(f;_&38Rl8l[SI^G\RI:u=#Zm_ns_@:[*!<mYu80@4KDN>N'-%G:5`*G8f%
Z`n3&3uBo!i=]A7k0VJ"3`4c`UfdnkV2'(><&-.5L?`]AA5(hE3bprS^/d+;fon.7(0[5FRAFF
J+((!#<5c7MV7;m#oXbZV7l-@)r&m1^O5IZT.K7N.?-bFZ?(]A9_O:M$W/pMke?fCEr!O?5X_
*'\bS'`988j0H.D*fZG>VoGO"RqE0*ToJgmILSW8?cEP.,Sg6Z#YgSrOU0?Ks-B&a<)uRdK#
oDI:_J?*@rF\2gHD(PODVkt;K"(:ie'o>4V;)Z*qkq_>A)W=2>.DV6G)eG.ne^04UOamX;\K
F?rH7VLGF3L!1-W[!)ZWS93_R$ldc[+`%N"^_B.#<qjX7qTJUrF4@j;\r,^dp(PS@3[/&nCK
,CKuheBXB"Wm_62\r)a7lX0M;"?XL<HhG*JLUr1$eN8m?+nE3aae;9:-UQj6KM425n5>jDln
nt8h#YMhu@O,n_cpbo/obG;.+['M#1kCB_uJ/p9-[Km@j(o,[6-Tkk<gaY^02]AuE5i-iBjYP
*Foi,pT=B<+il^ea/WrH8?lNb/pfihBqc""QI$-!.6D*N!$)LP;6pArDlga=07"OY6!S<B1!
6_^muOYL6nEPSnC+-Dk*Qc=3(9$]A7ETI2;FgE(RIsDk,pj)B_E,o*&%#oon1)4Jh\OIcu`6j
!,C7K7@4J\3fG^)'^N,B>*_1^Tot.+g0U4EJh-bn-[*l--bAb+3loUo6PTBC77`c#)@"L</d
jLTMJc%LjV88hW[Bq<H[:ScMD,HDIo@jdom*8Tf$3]AeSfbH3!\<_YPAeZ\>1qp7PH2g?"Hf5
6?Lu?=J4,9TU^@-O\$bgfN#X$NEJZ?@>.s:l<cJ=1DiS&lO'3sF(M/]AbO/(^f,#BG\umrJp[
n1!dV4Pu4hN+-So"lZlPS4[YPYe0(OF.ER4lAKC$pOV;cN\eQjP4ii>Gi9\1%^(=199Z!p&.
qVR8WnC^*oAg6u3.\naI?J'jA@hp["CAFg/AqRseXSL98+'h)+P'MT87\Y"lMHb5JS(SoJk!
*Pf_M-ZYnid=j".$;U]A2@8kW@hHOu:Zd$0"kImrB*$<@!P#K3f,gEX"N$JGFlY;lb^q]A1d*0
PT5/";3^Z[c7/e2Gne&$'D)Bs-!dc5Z6I;KTbrV`4UY<Xi3'/lGechP*2h02'l5Ec*;!$)OX
^rEQX3BmE0<VFn-`T]A<R#CtLI5W]A[57K@;!r5(9^\*[to$spBo9-+A4YU.fqTcL\1j+'.5SY
(Nc#d0QMODWlg*aL7r0d:ZtrUt?:l$L+c7.o5kB`bCtocod`iq#''pXD_\n#t.X'$,gCM\Hl
rNBN(a6MT*o%*O+D'lo%.(B0%E$I?-I\/\_3k_GaML:0;7gc6!Z&N-C'DpE.<NY]A^G2T`0;3
%"qUXe9%&0Z+Tu\uYL-HEo!OY%ml/\mD#arFPLe$T?ebM49Zp+tTYN#&?-Y0[WT)':$d'g%E
/F-5"5.b1h]Ab%!ZfAeAAaiAPH/LURhft<6/[<e(9S"96*5UUBA(C2kZ9s<?1W5W:V`ZHklEg
=ZX\Cp2`!>q'L0;/4F12eVpG&=-Z=L0cAa3@"\O1=bZ,:Zj1fhrDQ570o+_pYIP&-OeV2(kW
8`JSTX=HZ!sbeh3@ZA>SYbW17E=r^254W%_mAe!B>F'OJ5&ulWVnW96PhiA-W-mjri=EpZ9+
R)tWIGE.?Vd>_!/Hf]AS1THl%iNlYd4@bja]A5Nh.Ye]Aq`*V=ZcP<ZCgDXCt/3k\(/BGOc@77-
mfN'N)._tG\3^@)q<B!"rjHH[+303?if9TR@W671/@ljMLRZfC.YeUojXoXT)YfNaVLdPBi6
.gBA?G@ft[8D#R"R'^q4Y61d!7f&ksW\l3C=Q0oa_1jM1]ATgL\-TR*,(*FiZ!/7Km[\_CJ)Z
6dE="KW7VX9`JlT0^rnHAqb<Ug`0'C;%-r5p*>%"FJ[8Y8l9K+@juchj8&(9Zr*L5hkIZL=!
tNfY(NLW:V>4KF3oC!WfDR[dM-aUqm(9RBsA6uNDMVoL#MP<8?K1r?eu`8.i)*T1$lCMWfYG
FG&ftGQc]AUMa68)N+isZ9P`0]AH0=Ec[/Q?OE0ga!XDb_80Zrj+:=tgbQ)cEC^%UrXKC0"ps5
Xqp%5+dPOimE2R-60J7E!-b>8rLbtC7YX[[Sa609O;t3#tL:erfFGP.g>K!+j[.TQ:r+O45F
"bSQ\c<Y\F]A/<9mI%m<DD,r@IL8))KKm)""]AYq8b;NqM9G)2[)[L$CMt\<4O]A?%25ojf`_'9
=\SoOJlc@o,P_hP3<;O<"Y?^B$U<ZRS]A6TT9jO(RY"NmUCaoAlbj'W0&-OeTqZ?8g^rM's0`
?2JqJ<;h$6MKU4T'^GMr*4U9j!B*K$ipq4sl\Z#LksmMJH7cgf^d"WXo2U:T?iak8La<[E?'
6(W#i_4ke>f70'u-3a-6uK2,:fA$!9t(1o3s3UHe8@RcW=V@;U+2H*`<ToKTLZPn;;jEH=Eh
B#_"G@0iK6]ATJ-UeaXWC&?mO`cc6$h`%$kjM)6dPmd(35%S*fr%*24+0hMrQ/%55BphYu1N=
`XpEILoVrMoV#qo?)Q+9.Tj`#61<(G8O!?gKuh3//@h36V`p=3,n3kRa2;>+pV!tC5)e$p`N
lg@]AR3f.qLipmok\,.ii)=AZuSslr[lR5rp1>'3G6e4DuRMMPWWWmlZ_cu.M"DfS#>CKPR$2
W"ZfH*_9$;tlK%m0!Vq+'E/;N4@f"u.8o^3A:`SHk6\(U8(S8N?jEY*C'&C3!DX^N1YPcG'(
e>o&7VS+S;85;oJdQ&-FRF6>_D+]AHLD*iPnSp\U>GD2%H9j//4$$k?OM)X3)@gh.Xf;uj?N)
^>]A9BXo9r8U[giC3-,;J,Jl]Ao)9o[Im`g$gQ8ggRgmC0ND7ZKNA=$Xm40g$!UZ,ud3Sfb[DB
8nYU"IuqeE/jlZA3d$uh8Lf*`!gX)S!I9PsSW%[6dF5Utfm8V!T`d_-ZBRX-IO1#,t;B=#s=
\B/QsI.!\f<D`@8/j/@TMOm]A+)^Lj^D<7YI8IebB-4+[9!/EdD6$3Me@AQEN5QT;RVPnH/OY
C0RS=:/;,'(%p!Kk6B&K&=kl3Z@9FHY]A0RjU1mF8oqm:b(2(phgHLbKR+iV1i?Jc_qM;IK;D
UMU\V!ISmpaWX7,hHO"(8]A/$t7G$@2XF%\Uj?_+u/]A>ha_&:=tkRD:WK.6&s'+^`(kmCX"3p
J;*/o2Y&QFTEEb&rIbu14*`u(M*k$<;_)#2(,MeS4bbhC!Xm)BZMg\jR;_#e_h`/;2ugHZZ^
@<J1j>>*NU-b]AGYVHK^fH=A=jWD3k:1bhWPBt_E+]A`0*U[tki8IJgZFG26P):o^fl9,SCkeR
5Y@c\(16k!PpTU%0iAH#I1Pnife6BPH[H%sX`0*EBet?fcbL$mH]APMorAhO)@7"#m'W/liM,
Tf-6"Q=7XPLaM)(WE#Rh7b1#)?,WGQP3M'.4g<#Dq8jiU'VI079Tg3(!=a624nl&tjk/_3bK
b>oK>^E4:oF]A4>tCo+,2l:8o=0BM]A*:/9A7B;c7.frpASOOl$gQAAjL>B.Y=AHhD<^%4*0s7
V66O`O>T^A48X7M%Ng.^8i8`-/Tu*0kOUs3Z\Ge!m:fpW1Od'2"jc4[5htDp"Nrf^KtV&037
Ei%g\:p]AWg>':./6H*u_G?Xm>:=n`nGKi:IN9GiSj1H2"Gnc96#NXD42#Qc+2BY%@RT\MLj^
,gGT+8i>!/a`%$_/JFKMhJDN%n2i5mkB/*,i@[n"e)TrIFJc%jl7Hjh+LnXJ;p>kmighG"[1
IPWVco=,jA9c2!!6%J^35i8J(NeG+ambl^/g<)aq[a2fU#1=;3fQg7S`8R'fWdm?:6Li"IGB
&Sps3O>S$l6PY9o%ka4^Pc$E8InQi/r_;@`f59HYO=,H7/\>&Vrr[9$6m1rbglh.MI05t*P<
8OOeb6WnH8S_m+G/KP0<tO.n]AS4Fh^rpRd@7c3:6V(4U[/bScU'>)Y3$WR=g3<9ZUndS*lJW
7gl$rB@7`?H2*!U?IAGQks#`/(idh)u_SS)OuaUnb-_=JU/N"Nt@$R?XOlU3Vq9Y0e:=23Hl
\m4#SHCoU-:$S?[lk)$U\['Lp4juScpL^Utl4GD$VO&]Adqi>>#jroD)>.*AC1SJ8H>"1HuTX
$D\UebA'b:LD=6?6)@s(CW>MSchV!rCAIfR>hiiCA.8V,@VU=6;FH[oeoh+1%[nq%jn`L@+9
)0"8N$G;qh@^9\ZhSGE5IFZ2->3p!.*l(#BTj_B1m]A/5(TcNK6nE^'^FgKL8QWd_)>4&.nE5
F^)u(h;YlrckkL6Tshc52B*s]A94jK@U8s-/j>02=4H\\,Ic?*NbTk$oZj5-O6;[Q;ijY<@,5
i[:,<`^SX6IU$m[q/L(#W4SG'qGR[:$<89r/c&c!3R^KPa<*R`:>aB9s@o.[L(o4OM7DG7p3
`I;@\R[<(=O7Sd(HT$.YJ#r!4%a$V9=o+5S'`ih<F66Gi>#b5rcb'gL.%JM1YBO]Am>!Q)IIt
)R-q&MXV1_$mOEZ&;mSsn6f^P21Q45\7@8jK4Dn[DQt-,e'M+k2C'Kf27pOX>FNLD;e5\K=#
3g[nZcg`bsca^WEuR[V?1FB*DPfX($M1:@_2:,M9N.[oUq"&s?,pE*#sg14cr'940C>s\EG6
`/LbbKUf+9t=R_?0Ig-+FgJenPYpl`]AUlPKX]A1/T2]A?JU-aO75dBtG!0aO5\lt"HhVQB5E4(
[m#9^bgdofl7dmDO_".fYJ^or+2;'/gjcf<kDeNW=QR#dBYOC:U%m$1Xu<2$F`TZGGJkM:.H
rNVf$jMZ.W7FUtTY?Si\YJClU_aKG]A>jAOCOpsW8W&Y^nkV:iI'&;[#Gb9U8-7f=KC.bT43K
s4\KbbOZ@A]ALW'lH7i!F&UNE)8AW$;d8MD(ONV;&H6]A4-c"qdt=dHp>%Z)H!fBRf(27@,KYm
G*pV+I#Z$pSD<gA]AUQtF30pnS12nIFfDtCZuOmS?R502?o(_aV7S1f3)Uo.lMPuSmcfg)T<K
)&5B"P-"mP_iplLLq=!3RYO@=[08LMI]A%?1H&$SIj\n'((L&jnR5!XeK^pZAO::(l+&_ff=?
cLjMndDV&UH%[H+$G"bme'+F[t`WS;1!D:_S3ZWHj/7G_j3^^4Icg#q3J<XV[Elh]A=-bE:fJ
$PMYTq<B);K5\>OQ(,TH40iKdLpELE4R;h7"`E"#8\Vd0&RG.YpP`#@D6)\LK+>IC(JR,1FX
?nHfd>.gQ`ln8W/dt#;)GIP"`Lf\3*@%:@Zb^0=1qsQ4e8FBN_u?m:6mhUIa;9u'2">h3c=:
bTbg.9c:XgE.I/Eq7&j+TL*#UehBTaL.!7?rAj'A/g^r[*?6^e-UmhCUbpMO\5hOSciJjEWM
=.jHVIn_.O?[@:<k.sDjX*tJmG,Mrc]AZJ.20FKtVlj*MaU5]AkV%Pm3Pg?pf>;SITi%NRQ"/l
V;P<!qP,L:[>I2<]AURnHp_Y'(ao3TA!m!\=fY':2bGE[8lA32nflb6jKV'`Z6"XG^$Z@lG/:
MS>/q]A4!l2l'hr4pSN7iH5ojkc<70["Y5^sXmdc2+h_<Ai1e&6SRC?6$/1Glq)J(-B`p9qjt
+.;5[IT[;#qmj<Rm0a/M-0>LetK<"J]AmbW&]AB`YO*iSYNpCKansQ[+2U\!I[CV$e./8`\(>E
g3CHV>'W3(Z4LB+"S6uRsSB[5VrojSbNg5fSl/7g>)tLb]A$\^No0%Cb"cbI$LU+FcmSU.nNo
m_^*54!dTBQJd/cU;\q&8Lgd*o\LFBh8,A$(^mY8"Rg;C=`Cn]ANBHqIi?aaoqd(!]A4B4!54C
d(VBqZ*P^7;sg$J`]A["id((2lcH<ataas(f&eVYIAg>a>FU_Sf_q6gurkq%5KDn?n?M`cg4d
OF\MNDYmrUiQUG.\3l.<3')P`V]AjjN`E*[%M<=/d(SLBn()J\[]AG4d*\g4cARcaKcf3&<VH:
\q]AC]AEICg`D%8rC7it3H3M$Lg5Tk=&sM4=P!fUNig#[Dk7*[,6Fb6hN.Fj/eko(mf?E1k04s
dVpfg9d'.ItqN>*+CZ-*K?Zu]ABcHi]Ag(YW[$q37q-E4*]AEH+6;Bgo2l#QUA2MXaOM4)Q,E0%
PJ;DToi23R\$Ph<XX(mUH6N"!8\ku*j,)b&jH!K(#Z;%\%LFJjO2p'=tGJujs*u:Gk)AHn*D
;HlHc=Z)Yd#dkXA@d#U!;'e<!82dX8f>opd;OO;I:,n@RJ8$sR5H=2'a)68>gEi#N9cpWio0
:/-Aq%"+Ra!OJ->U<Bf41G1(l1:G#U(lM)IR9nq\N(8%N6Xd&hBRT8MUt)%gA\*dBo=SL:1D
[ME.Pr6N3cM?f^eM@u<]AgbW2KajD8dYTZ<pK)M/1ekko=8j)M7eOYh(2H]A/B:#=Sn@K%kW[k
TBOgcaSY"]Al(pcok\917oBWs=6j`?(SF<johX7Q5)0)`#-d.bSZZ=DYG@=*MtYYnA6g190*h
Z)sNP?PFr1-6cj)nd&i\U?FK3!g]A2=19Ln!\#8sWsuFg^t(kBBUIgBmcZ9^N:PXb))filID\
*HQ0F\o0%Zj,M8oSqg:BZ\IMk!C1,1T'Q[aii.^IQu=6qI=_35hd\Uo?%k*(eI`<>p=I(k(X
DFeD&=F<`>.e`3FL"dZcf3!C'`6_?j&i[KH)u]AbLd/uiBdOMbp7-VNk658-Gjk\AT"a^cIWF
K5=q\EHu@gp*&/^0rV+8P=gWM[Y32c)&Q/o+=3GM-TCnr4:Y^lE7aVFZQP_.1jt`;9$_K5J,
Xg>6JW2RfV\rh4]A)Mn<6A;_Bd'RqHoBq2n]A((cn:Sm1_fuZ#oM0+\mK$CnCkjI*`2g^I(.(B
&M$LFoJ_%kig]AA6D[X:OQWF0l8,&Tg1%?C'N8um!)IA9hgX+&XSb2r?aQ#Y@FRlI3QLsW*2$
]AC)Zn`.fGVGW<Y+I@W,cA9FV_cr0b#2ICtKm<:G8k4:+s=1YZ."JZdN-?`(Z]A4'Bn(P]A1['(
FA,*F7B7;2qZRBg.)qPWrgppN?_hDFDtJ^9I#_L#8t-?U([Oj9W6o*LCfD`rc".eMXL4[ZVP
0J[GK+n'l?QXA^sV`iQ_o>YK,W5b\(1h.#\3Ed7p8-]AV8X.XhQuM7SAcof@^W2B-_:9<N7Hq
NA_[c>88T7K31P@R!bBL7r!DB;r!$3(?f7"k'QDQ0HP\ZRSe'?':!VGV$Ffd@*ado0^9YG`*
:Ol"%\$#TKb5?=p4LacN_4QMW/]A>VT(RCbICG!:Zb4[[W2flp=L^f:!%TneDca/D1'_9V>*9
GCF6sH4$Z##Hc<b>h$nc#ibRErg*6!tXW:g,2U(F"*DU^GG/ifd4gi22j.NK"3PZpk:Js^c8
<?oE7)ffh-qEsRG80Su&RYAO?5G[I6Gk!\OZ'pYsX-/>$7\Yq?pNUa*PP;Z"e-@,h>Gt\0c%
%"dhJPr-YGG@QeN#kJ%]A$ug(22"SH6qj`cU([,&&'S-#]A@MQpR)4j]Ah+87C:EItb,#t-\Ssd
1Ir55VP"XP/NaI'rnm%Q-f,4+e>e-#LRqnhlDX5:B@;;[=]AJ1dijJTalYund5abPe]A%#)q:p
/b`scNBUE;TJ)nH^:oN^ZQ'[n&3TZbVV;9(Z6Xm8OsDD_EM<n\#N\!';JM]AEZGTNdj9PG&#Y
_6IMs^F-Q@oJNGrZI-R7^!N@+g-Bja"_1]Al6";!.*nkUZ^QAfAn+KKdZ>V31\ZXFO=+quHtq
\uX(jBO'IS"/I#s8'86:h=TRP;g?@`p59!b3&$OaG7mddOl[6PAjR/J>+7&MWO.ABJcc7u'$
F$IHdMoNWBj6V:ADCEe`c13ep6_2.<GmG"&"(9b`m^2qaeRV8lCC(rA5[+B&pTPgLQ#Gh<1U
VkXOo5E/ct+539CVM3HPIQc-^0M-Wgcr(A!6bVFKYh>Q0A+@j2;1Z^=uSh,0[)*#6$UNQNo2
R_`']AX\s;TsD!RZllptO%"<)ZL[2kdc^GEKH%iIRO4YBp*>]A2?t`l`^I[]Ai274L$/PbAnF)R
f.i3J9LNk&>N^T%GYe3g\39[&h6?73U>`4f?iR:,1f"VC.88O2?Fc@_rq<ob:'^NWsNh3gT<
LD%'o?hE/;%dcAK+J%)%fF\LZ\/4sI6?e<kpC-;h3]Ahh+,('H,#EH/4WUct#F3RmnbJ@7n<h
t57>X165(JNDFmIYVICWgqJ_!.er$<LpFG8@T#a8X.MH2*c'Na4Ia_-:<CmMe*]A:0=c/BpMn
=_TSfMTb"*,Ul'&nEl3`LMSh)-@H?-$nU=#g7I"kYR5fO0=FSWpgl(Sf)_uXX7KOY-HfL@8>
_(S!3P0YIJ/\#DkEoHCj&"C^-1pKr:#+ET3$cbQPJFDHl#6@*RWcM*8)5!ZKeRtnAWd[aguX
,s6KHM0fg[S$b:g'"L!Kt'9nN`leEKPuM6Hrs6PAr=dM/,C]AM#TDnCn*>_rti>SZ[EIo3;AZ
Wp<E$)*^8aLb:#]A+H?N'XtK=il<#5dc=[-0a!q*17&?%6&i^,DdN<.Kl=te"<G1e\9V#Ya>d
dF-;7/O5?`>SGTpika?Q'sKf2fp&W5F`@j\.V8\U"ZT!a7jqKh6d*^rXb-X8r1X0`rohEfWi
4a#h!Pg`7<^LKMCL!0]AVq-Rl1QBXb1Lo)"JB^6k)TD4U0jhd#`/`L^/'L6'%$fFg7SAWAGbW
k?BZ*27??@LH[`?VIS*@3A=Uh_dCG/4#/MWCkqcd7H*,h#[D3;8)SZ)uYHQ.tcH^6Qfg^4t3
*1<<>7O5,l,Z-]A*f/V"hc36DaWh.;jZ+_m\qn5198iM\UsLH/kQI[XQ)>s!Bqj/psE;e)B?/
"d>[J_XdcCiLAfO2Q/Wf,7nMm^n`.>Y+&.PUaJeWY(/&B3Ea6l*3HtO$hPe2a!5:Zdu.QnOd
^NSoL(Pn(5em7]A<e:'^55D=E@@#YmkVFc(-#1kZLt?Zi#+IgoL"s:`^u;l)rbNur!SN[j.m0
F1_sos&>cc]A5hmgVOmLZAdMN.WEE@Ko`T@1AU)[ehc\p4Y+`[q8,_T@r?!)^D.Oe+iT$BYcM
R9[DJ+k#EF0*mG!r?Jh!1Ta(0;rQ`5:6Ih(BYV]ADjXr,aqaipfu`]A)J_B]AO8]AMuqZG(EHD1k
-%p"-MQWZ/.0VTj$]Aln<<b:<^4'68b5B:6.*/f(UG&Rg(a.qpu3l/o(T^U>5)4'ms..*,^e'
K^b7irn:('-5XQ//K79)*Qrf5a/Ec<$]Aub3)d/*$>rABa+2lZ_j@9>,S*6P8be[U(NsQ]AOq/
aW/+)&:$ZuluHI0Vs&70!b[2sm9RJN!/j-:VcG>OE%]A-!g[;k"2M9Y)\m0,LD?TqWio52d1F
KiIb;[4!EID/j*B?W@TTs]AYIq;mG^GQ):^ThTlG:38J(L9I)X_jP3h%R9ahP(ZUZcbJK(=mC
h'=lm,S\T)!BO'`mn:6bokEkK5AR8R[e^&"k(k'p9teFloM-u%$,IsT+H0kno]ATY:0Gs@V*n
iDB2L#p\jWi&B:fcB,MsKVi5-q<064tmZ8a*>^[34#)2fJt"u\qu`9Qp^eX\QpYkWFRX$W?[
X[>O:.ljt*ljXaC7M$F30F>j[T#c:@=#:;_a!*5X`;#o-Lp=9)&LI-LnsBi\"idsd"t0'okf
2i$rS.$uIkC-]AL@NI9?o\Dj]Au]A#*YbNK@NXIM.g.G^Vd14^Ur]AVZ\%ik?0lV;$f<4iN?DcKo
#qDk&(G2T,AC@Yf9iSg&6`e;p#""Kkl<_g%r]AV4e+fB%pN5s;\)VL2?>3!I+KiLP$)IP'ueC
^7F[]A(U$QrPP^Pnu)o1(+)mMSZ&AHs/?ni]A"8msl#[\,gRB<p0?iKhh>6;RR.XM0iY'0%T?_
&LP6?_HWhPOq5it!]AYG*jiIR"]A)rUue!HZ0rU*_U%TMMq[>KLeGb&5]AQm,B]A<,^I168F96$n
HQ=pm$AU<Z"c=sQO+7<keeS!:5(;)b%V?8:N4=S=e1>tqf`-9lGOMc+6R2,D/Wm)(2)9tI%J
pX6iNV-Im]A"NN,:d5`>5=Z>W5k$F+_A^24[D.,Z^3H8itQZ\'Du\Ni)_MY.ckR4Ra\$1#-IM
<-\;65UlUX&)J#c$"C0iZX)T4*pg7HcD2i;>45"%p&nq:\b`9`blgoe/3OjncH&eT!LrsE5_
i2Gp_kqhDGHq=>Fe%&Q5@Zf]A<gXb9=_14<hKhQCmtm3G<J/Olk]AhaOh\G@K&KHhWEIorYXbs
O'\&:/.AU<0fKcm?pN_p2K,g>T/S9Q05VX?TJN"(/eoX#8K.ISOt:^oL7QdGQ=[p4;*RY0OZ
rm@f^Kis2$WOYE!ItO!_n(Hn9>k7DR6teau"3H>8MZ;_$Kn^X%Mi<Ou0"=\Qk^BnBgNG[Y!H
`-c?pQLf>p&eeU::RpqJr`9mYC2!B83&W_pgk0s+no3k)`;#;`id^YG$`:s'jX.PASmW>=X%
uknrM!=E*%n.!34'LilI&_d<[*LgKV-Hj\S'%#A$QRo`R&k2YXq12iMhdrRdQY.:Y1c:e-ef
R]A%\2W*-E^e^S_baFK=g7s6n2)[Ccfbam,GWE4HM.j;?KSGK6,7^&T?$W1NO!>JnF(a_Y^^>
Qn"`*L,Sd93E[S+a4b.Y:!$eDsuLmUl@bN>ZmR'W[DG"07W]A6TuQ#js@#kHg(VG^o^/Ns>2V
NEPDeV8ddQp#!p+FlhYMV=/NWF]AXaAI8=Lkr-dh6*:=Ss7X'>&,%1^K[(+d#T1,0P"Q'KdX`
ZGi;"k=I\ZYG3aYp%'IiXp$NN^I)N,I=BJcgEk0V/t#k9W&gKKms,S0b[L?NFMXGodYq9(rM
G'.p_\kiqu!Gk.,UrI4_..K9,43<U&)9J?4=U5DFmoq1l*VE[*:Y`&!tD'pJeH??+R?rR<De
/F'*od=\s**Bh\kKp,W%ef<9$q."N(%1bP.62WV0'5$Z4">j)&`acEEO=^X;mDDgB"C.Pa\i
Lnkb92A%a[:]A&YRjCkkp*$*J4gTjt?\t6q"Nm8rS.AqQeiG_JmSk7]A1?T_,nG_)NPtJAg*^+
7FuR90)^q2lUX<q>>Et<A8T']ANeX#IL/q'HgK1(2@J.=Aj]AVVUjr:qJ*T?DhH`]A*Wo6p@$VA
;ckq3O2fhg=]Ak%"%c$O&S\ApOq[D"B@8r2%!sB-N*_FGN\"7RR5ii6f$N3mQ22Nb"301&T3V
,?a@Rj)<O[O8NXI&(pu>c*U#?A]AL5N!\*cdR8]AuS5H_lGX"qW6)aC<sST#Y5:`mE;?RXlIQA
8oQCnDS,qe1-^S2uW.@9_&)u.tpRg#+=pUp%Y0pl&e+7[fP7W?pd2"]A[6'_-2S;$a.Q@Nf0G
+k#TkK:Uq/BN($(n@=,AKr8jJ[QQZ#TIJbOg6G!W]Ab#VZou5Y`mEOA8uV37[n[klcK>_2BM4
/kpWU4*rJ7UOIE&UG$ItG0`ckVlhKBej!&kDWeGi4qZUVlK]Aetkgc82/2_sf)VYPNT(kB$*g
m_!G'Tl>%<gfO5ZBW;=LWR&J*Q<\OkBZrlUFgi!-hs('$/bi[?;H"]A'tMHI>rW'+RqQ&OJDF
[e_ju15)qOC;96<0JpR(N?Nunh\a?-#Fd0#C0kQk.G_EsBS.)e9h`1K+NP-S0*'cRY?WhXM*
.TVEld*cX/iY$$:Y;`3`l2tniTtbckdku%76WaZA9IgCW>Sm9E-kO<]A=TP`g\DWdW)8hsI_L
<>gAO:bRuhejM6BYu$YG:@aJ&TJO@c_RhZfM!r-ltrb($%d%.2ATe1^?+Ei?Wi0]A)Z?0:/+h
Uf5&KIgX8iQci(^7V'!8&t&SY\PQX^qO@*KPP5VsrmMjiYEKucH>rP2Xs.2;cb?5h$l,&Rm9
HbaXB-X`6d0t/g_<Z?+-YR[k=<7nW_'S,!aHc?_8Jo)IF6_H"]A]AJ*8UE4$T99\kkY=J8V#bL
?\Lo2VUok9IBD]Ak/*fQ<*UWL`Xg:UP_"*+fPo;EHeTZ]As^hJ"2!SLc_]APg8):jj0'Mg!R2q%
o5]AikTD:n]AY\"TQ=tiUlU_$Pe[`4T]AZ#SGD_KP%!)j*VLQ7reU]AEsY=Rud=r#ChBA1.`jguF
98dfJVkG7d;Y*6G[<(PutCKLYDB.WP[km(Gdg9nU2k2@-m/2J-GUr$!U*-F;3[m$0Ck!t1!"
+"?351?AR6[4'uJCEMkVn:p(H6BI,o4X']AaaD=GTrkZ[WC>(nH?n:Q/bDLTs&oZp,i;E"MSY
5UPleoMZKQsENM/S'f*a*&@XGD.,GFA;8H&hHoH;Tf=Q:5kfcH;%['C!0S#?enbiH^u[?-dR
m!eVjiJ#./7qEahnBQ!GCqbX<)A?RTAD#6T16p^XqA5a-hi:Aqe%=5t*NgQbUmGINUlR%&_N
\IkkPV;!_Wp6PP'K^l/a(pG]AM63?S\!;9i,!'1X%b6*7)d4JMg3cgTn8=#-e;F1$(2[<=atH
LAJbV2si=2#-&3otr*e2J6'oT,HPVe.PDG6&S>0UVYS`d571T2T&?UmenC+5GCg"M+K0")nt
-Y>ihf!=jeB&%ZQSfbD+0_]A/_K&=u45U*T%3,t48S?X'bkT0tI<b-9%,@jsk)NJZUjMgO2p.
[(^"-$XnYP!n8%PqInF>:5]A^(Nd<SBJIPqprJ+9;4c)eRiSGEDE!uIJ@grZl\m@iehs.,p:8
Nnum0uDq6VN?]A:Q4^;r1<NKJPW7`U;uGi@2=qOQnuPR/(HZ"X(mGf2i:ia7\9"PT)Ee=YID@
(&0sXX&&^]A1]AdSJ,G^f*I/7]A8Y4Tc*4K$%4k]A*<D<bThG$PBR`je#MMgWM6&td-R;M-sF*]Aa
N;gFj/K#`ip*DTLenqB[>Lp<:FC';1_T.Ele9&sNrQ=epu&nmCTnBX/O[CgDSnKjeA#KTaW^
@>c]A%Ll/mP>40>@5TS@4'i3.h=-AJ`m7_Ls0;P8,<p[uVrQ!o"j\>6+]ASN.D_Fa%;T&pG!i9
.mTFuEh@&hJpFqN%*"`%*in0m,HMTKRF7X9@_O2r4@.[<@7E1J\b!1**>V*SGKZh)"0PhV+k
Y:BM?Q9r[>m;oHRe1]AI>.k5>8!diTZB=AdD"[>>i#MKlmg:[g43E`@2-\\2,&#2F-blPe,>m
]A97_.h<Uc@rh;,MM%JoYKGg0bFPI_<a7X4@2VCSgiplgL!2f63?L1^^C&5,lI3N5`eG*0+OF
02.FlJ47KL?e07@=OQ,\1]A2o96n3=^LVG'4MgWi>Ahg?P7!2>Kl2<RGh@q+g!SbtNC5W^^S/
R&FZ%_?#4P-)-s"&h9]AmJ9""N;W4>&dPPX"ebd-$`/C2'"T,'k:Zd47q$I+$O'be:@]A'*Fpk
NodGq1DGU'GjB<!qI"dImgL7c&eDj?T_P-./OFk+RJ+dD(n)O?b0AAu\+u?9'([,^*$Zr5U[
T-n&OHrXe&W0?^N2?<b4e*h<87l:j(W$sc9p$j,9]A#QsAdDW7\G3M'S!b$5KVU2t,VbY8CR9
K<I\*.Z5"5+R?Z4Pn&e%2fk(m_9sR#QWI._oM'e-M%[dA:<ts.AL,"2*Xj4>WL@-3\T&tB&D
$EJ+N.^-H4PhL`g"))1_2l/YW+7PIu"SgrtR&@1KkTS79HDf#l%_SJ=eYkTN=HY.XA5#P*j3
#rjBT0=sJk(p#cYoRaQGN6-Mn=uO(r^Zq2f1AP+n5EDr+K`h4j:*$^,/`Xa]A?g;RII>B5&n)
s\Sgb:+jL/k^Wr[S.L\1)"TpM,3WZ?4LCEJqFY`BLqc.#E58KRgC-8uir1'6+&rI+L#q>3f\
.Ft[u$ENrn$gkY^EWN.q<4Zg!%N)Y?0G[G^W4%;hcE,j0Ban2[;!V_qlX/JMcf?cUl^"uPk8
KZ:UAmJYe3u9MGYVl@`)6Gf6`r;4)7OX@)O4aFtLgDb]AcbY*7pHrDamI]AB6K6f(QKB1>>Vd/
osoMVf,lT\(GcGP"kqa2PEh#r&`2WPT,gme+Q9:E%!VAnosmt90C4qnnW1go#mf7iae%mrb[
cJfq%WCYfb)L+6,qR:-Q<?;tlEO]ApGs!=VQ+af]AYk#Yu2QT]A(G5@)'+I(j\Pp!!U4\PPPd@!
[!mi@if=.!jOAeTAPV.uT#i;]A"BCOqq$InP1u@_m7\:AS&QWf/uctP@(0uki*o.;=!95ra,p
r"6[Zc$*d%/k^9WO6*-]A<D`K1G__EU0+`(H87,X`gbVR;B+n-:7<&B1Z;kPkQhCW$+.ts"_K
a%2S3)"r8%JmOPBo?Oo)1F%T[6!__N4]AV&>8/dN+KYd:CUe<\k$O6Z*J\/ndD\Fh)BX;X<sT
Vl*;66nki_1NYqjt8<o0t5q5:M<KG)s"Hms?pFjsE*WaB'u=;qD(nB]A;0XT-bp\OJH!AT<+9
1.X]A1YgcOcU8U$_5gfp?"'$=X"qhIs8V$nVGfV,,!C_Z0Of:c+4=!%J9M!3miZo.C+cnqpPt
.bZTP/kK"KXoo!XV.)`*aonB"lN;n*6E=s*O`XrU*tWXL$4.H`t-.V&&Bs]AFI`,['KUDV+>p
q7Hittn0h:/h8-Y9JIdt@FDc_:b9idJ^AbaF"m#36\/h]An2q>2s0eF>EJQO<*<L25A>$oPs/
EoSp1p0&%fLY>)dmGm8N/NhZG@upN9Moe>4(9DbS$e+nc23FlJM3p2411ud(It!iBrB>CTqq
J&es0^tm!NNlQV;&bh1#%pCD;gK*PFd3/A4V:]A<JX29><8Z3F\?NH)TRVJZ-E?>.RF<n)<m_
9K:!N9[5/^RN7A*J?,5goY&0sW+EJ/UDRmS[+#W1q^h/@_bae/TrKuMEmh0OMB/gl"Pi!Rh4
NjXg=hmE1IEP'H6a_NXaC&o/lY[?]A/CW;VX0*"_Xk#&;^S8\:[b0oHQs?q`=MI%#qqXrdUT>
'%W*KE)WXSP"ku1k)2)g2Au*RU]AC_!a:1A%Cp#b%_Mt?Q@QXA)h"r8)BIp1nV:Mik$8fh/V2
9hOB4*G1.3oq"3EnW.a(1Z^ZiV/Q_S&G:]Ah8bbo<Q4rr$YAksFNSh(Q(VA[8NfhQMW[PEd8f
GLpdh3@,5<K[`e^GAA)'PNX?=JH#:;C*hV7OI\h0t6aEl8Jeh(7P7*c(b"XIT^3i=qN\ej6m
]Au!&RfT1O6CQ7`.I96@2YUA%HT;4Jg]A]A"j/Pth`^4RTJDCLt,(Lp=BtM7oH%.LJ+I"K:o.pL
*9!lha/mPIrEkpktmp#X6j%FK!9;,un.(;2*M*X<7;PFNeOgrk[fs#'S=TmE,+g1>]ACQ9=o5
q(t3s3ikWgT*K"m`[adhc-Y@q1ZmG_:]AAUW6%:cP5XDgg`SdbSc@Oglg4F(O2cceEK$/Z"s<
mVmDA+7!I:4W4c.[0f(E(QRb43U'_kGZr8$t26?-JU7JdM%!q_GQ[C=a<IiC"pLoa="uUqgS
:megX7-.K#V+f*XOCo^<kj4h0ES*Hk1,=K_G@5cfh2]A?/q8$\QcQNf]AgbINj/)q#I>@o2<r*
6#u9-aU`Z^BSumOLEl4)(4I"KI1a.iln%8Fs6@n*`KH*]A$gC00`j>]AtYYJ,`4k>,AR,)`hm"
q2@RGj\uFLu]Ak@sPcOaRZj7`QplFHSI1Z='0HT5K5#e_PZH;Cr-gOaot_M"WW"ZQ>g\5!GB@
gKN'_A+GBT]ABC"0S_Hd"*k]ADl#A:<cRVm>ISd7m^r^DkdD,0'0M1F3f[fOJIPa4:n#GB*p;,
-(Mjf.M?sC=+O/.]AINZ<gH=sV2:d)Q.5?74^5(n\diir5=:NaMh>d"e2?G_op\aWn#;YE9L@
=d/KAnF9g#a&h:@7oHYq0e93HD,oq)F'N%aL;=BVW#p)(Q$8T.=JX/Y<SjVZI+Z(nY8T__IS
B7=[fB35WWgdpDT+`P.T=;BIZ0ci+(AmO023;RTV(mVuo4dC5:q(:%JIkQl6J8/k9.Ir'?;h
W3@Kf8fuYcfL5oX=H[)L"-i<Zt]AC8&"&>mRL>'A,E]AGi">hO'I"`TOd^gq)d<,K\$4c(/t[M
TdBiC?,FnJOI\Li)iL>Y,d\#nLRoP_PQs00urHP2RL-]Ad/-ShR[*7I]AVA[05Zm,oG"r?Og&W
HOEn=7cN0qW4?@GGf\Rc;57PA\@RHHkl`kLY#L$GS>0c#K\`u1o$.DVbOObT/NTEriE!9%s=
npZjYc4#ur.XGi"SPCJ?,1)_KR%IKrFP/pa<g=d#:-bhRYpIDku(Pa).EZ`'0c<.V6c#Q7l7
hE$FY0^7Vr$:bI^]At1N]AL<OMp#W2?`b,+#<518.sg1e=!8?OShSdhbF>d++LrW&:H)eaJ;AX
?,B\`81OU?CL0/`/GJIpM!=O&9["oi?HY`]AlDl"a\=71llmbPsq`Ps"jrb0Rs04?iU9G^]A;C
SQSDo^^up.HNH3m4?[m:!h>I51H&Mp&*f_[b+PluJ%$L=&='ooVj(d2Kbro9%:*(H7JM_=O"
FpL]A?iU9G^]A4QmJ,p'd!!=(R!!Y--!=W?9"8FeUB91R<^E4LP6t^Xi55kRb)?9jV^]A4T.Y5m
Dna=9ft8?=;6&aE/Z,M^0aF8c=~
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
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="433"/>
<tabFitAttr index="1" tabNameIndex="1"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab21_c"/>
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
<WidgetName name="report0_c_c_c_c_c_c"/>
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
<WidgetName name="report0_c_c_c_c_c_c"/>
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
<InsetImage padding="4" insetRelativeTextLeft="true" insetRelativeTextRight="false" name="ImageBackground" layout="3"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4572000,4572000,4572000,5715000,5715000,5715000,5715000,5715000,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[项目名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[最近跟进日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[销售部门]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[经销商]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[最新阶段]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[跟进详情]]></O>
<PrivilegeControl/>
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
<NameJavaScript name="网络报表1">
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
<![CDATA[write]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_dialog]]></TargetFrame>
<Features width="1024" height="900"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/CRM/项目跟进/项目跟进_填报.cpt]]></ReportletName>
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
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="报备日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="最近跟进日期"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="销售部门"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="经销商"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="最新阶段"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="7" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds2跟进超85天" columnName="跟进详情"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
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
<FRFont name="simhei" style="0" size="88"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style imageLayout="1">
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
<Style imageLayout="1">
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
<![CDATA[S9nmJ;d'.'1QF5Hap=b5="-b.hSCfbV$00e+pOhNU"<-R74Ch8*Caa08>lhdJ=s7LTdZ!*#R
$t-![/7F$]Ap9&n,L)ehR2d<qr+WiP')q/f%JC<.Js$di]AX?SVbW&<3-+*$.8uF72FicIo0#3
HIQr;V9tX,6dZGaTmn@Y*[gUMhSikOS",W.FKk,aK^VR@3SB0XGIf96>B,A.9YQ&S:mEG6-\
$*?u[d+KNp?DtlQ6@C7I`'d#2c9"VC2L)-7Y?H&L2*\]AD/"$EV2=ZYS"f/Xg$rb/Mo-K.oUI
8,-Ts[d,t^TjCbX)CLulb$;>2'O=6J^^oPl+GdCs+55B$)5?S7?KV[f(ape3u]Ak<$u'\IMN&
ld/;>eZAa7K=%hG`q8TB$V8=%e#uJ!P&mFs$iW5t&O2cd-lrocI/!r^i^E0aoGQ50#@?\R^q
EO/B*Q?L?`6ABQTTCuN8`a^1^a<Y(m@Irpm3_'e?SkX/Nsr9?<D;u0@#pABI[BR1M3/J+R6_
To9ielqO<>W0[\D&crFsiiQP2e`2J_"/Bi<MiTV-%O$lB.Cp-At:SeF!W,9(@>NiI"\>SS8_
nWp[/<A=6cW8)liF2Wh;oJrAbEH,JW&GZ.A.?TorakcuST_]A2SL\`N(AA&qLuuC.nj8km.T^
4lU:aeVC:RAciq6]As_f&f]A0h]Ae\bFc8BqLT>2BPl*Lkh<Lfqr.(g7FCFkb+8JG$cQ<I""T)9
c'GN4FL@Sg708_=*;\e?GFX9Bj?Lq$Br=j@p#:N"pcR7P/G1JP)B@/#^pA=UoM$CSLq>IaSb
^K@M4t>n&pC]AJdYUWIXNt>Pbu=uMZpIXbF<ZW)YMHdr<>`&&VN6Y,&Y7XQV&UB/C#0\_MDdM
%X]Asg1Bk>@,\NHfHP>lBXg!c$Xgkm;4)%l[BoGA[nk<Arrja@\r$4.u[[Xgfdk-u'j6mZ^c_
b.X=[WW[h'!l7X2!NUOGn@?oeQ'*15BjhLr&H8W.Ks]A#.<5Tj1bBl?@_F?%RQY(Q^[VSU!B5
Nl+o&%Aht-6TkLQ.!kWo$$Q"0/ApCuHZ7cQ)ei$:QSEdtF#FoOPWkjk@M#G@AJM,kdGl=cNF
AB^+<K+0N3ee89_`Q-mfpJ?Hd=S,$s:Y:^]A2u+hVJ_Yu9J^CUt>>s<dI:gANQQ"5^Io,,^f:
*Yurq;l^^a(C))*=<W5dkKh]A.T$PC1m<E9f>ZchA(P3S5R._G($afF>PA-I4X3:(<>7o@WHN
TAe/B=FuX@)qo_6]AbAp>&'XU9HloW>Z5_:s3k<3hN1,@Bf]AmC)@&&:YPT%77TD1'V<n5Yp?i
s^G;Z)NGq0e25!kh>cgqK,mTCVNmrG3o`_p%qD(KC?t/6W0jn_T^<USi%aaVOtZ_qQ4d,HY5
*5>n'ih]AX'3&WMMfTHkA!0AX#]A7Y4;(#b6)fOM']An5ZB[#OkU^?7R!NoHHLG,iSaZ)Ij6in$
#L1E2@UTq$Y&Gu0L1\j$8GRh9m>>j(ePlt[Wclo9`ocTi(.qYk&^FTCF./HYYo0!V]ArG5)hf
K8.A?XE@NjOGd(IBb/E-hbl]A]A3mN+Lo:,r/,8eP99`M@l[4mkRsUE[ar7ZfPM5R(;)c*LqQ4
8`d60G&;9E)_i9S"#`u5^V=@6JS6^U1mNQjl\UO$u/StRf/>d)sF?MR$@&2%\p!_;4+s"9tQ
?Nl`EVDkh.sLaW:OJmmoe'QgiLN#M5@CRH^JjiWJ3k?"B[]AS"dGCsEZ?>fHTJ>*,D[E0'88l
pDUMS%Eg/7L,<PuBGH!?!Brb"F?XEK./\6$aCRJU]An$Yk^'UJ)#J]A/]Am4%%mn)fGHI-:1[%9
^t5=b0EfM-]Af>.eePV0k8tR;mO-5jOB$C4Ngn=A#54ubULOEj&B$O!^\'lX\aY"[IP6DuRV&
Q$PlUU\`q9*dChi!"RUOpEC8?g=-5!1Z@U%oX:#OAs=WnG>P21'jZl!(j-XIk1fLL'3YQ(/s
1*l?\OqR>6+BXg>Qc5t.j)ZE_Bj^(*:?nd:-&^Q+Ueeb5&m=s<l@=F>)F?N_Zk8BcmV0G<q0
5#1eeAP,8W!:9dY@F-9=p+[[H8il))ot'n+HWNG:Fn^B?Zbe44ALm)4i]AQMVcm0$AB_hg>Ru
4)?.a:-kbR+SQP"'=[`>XlrR4mLB^Ld=<UW7^i<bNg\;NdOJ?RRmE+o,A\D,dGY%oJo,([&W
n>/PhdP5b/e3PYK;qY(Q*X>KmFoBrGf6R(jO.OquQ5<s`4e\p]A<"LdVds>B<27MU807P0W0Q
seZfS/&;2;G36'So8d_+JrN[]AlMEH$eBeL-7'+nu/3!f8usY?ZlRA)%ahsaWAq^p,jq=H!5E
8YrO@MB.hC#i,NS\HIS;EXBM;b`bhfaaDa.f\M/CL!'SjS@^m\)4h+RrI#i/DZ%d_-d(;.4B
"Gq8;/<N?>;2a6*sm*")#j0D4u'(toiZtNfq*p)SeR2R`@LNjRqi-umSiRklJ'o>'tp4pSu,
Z+'3Z-:lM;%AK)%D\S7_;aH)nA6-;kn!N\/<>]Aio?c2l5B4T,Bo:Q4P_'l16`hgR8P?Eg:#9
O*d/\QYS_#I=&thchE8Nnel\_<rg(bpNlr9oa2#1XP8^P!bgqSZ;0^Wq5]A<)6T._,Hs1?C)_
*jsH#qH(#J//a;+.N<5NAjI<]A$?nrHI?D+p%<\rJ9*4N71ED&T,LCXL@)8_-cidCNS;*l8d,
)'("@M:7%6qCtm!=cYeed6,]Ai$q4hDg[hLe2[6)cMW4QMi*NW.\,sm9.bC@XI5%DSo@D,caJ
,aNl%2kOZPMbk"grY1L84VlU^STHtft$[#WpfEeerB@tQa+g0lf'?d%+NPHlDhi`kYAuDdDG
<NBH]A+\;i-^;UQBc^EX'L?&j:^ahB4L0:FIOs,f(58$%JH5J4/l&d20uanF]Aeig_DQW(%'0;
5fipK$rD7\VfDh@MVDe8gER[iYP[+dkX53gKa9cmW<8T8VO?6"q-:PT0IbJSTI-.D((,`@\,
bY>9P5jK@Ec\?P8dS\$jeF1kuPFp6NUHLL++Jq>X`]A*MhrY1"]AdHPEre=I[S3&b!emlq9r#,
%8fOm+6/lCL>nAYW_7n$N$Zk,bgY\TD4WcRRf7thrJh/,t>66oc\!*?OgfO.'JLf6+&H3C'L
V,;!7;iMC8\BfDd_@=<Mor<2.P4q4l.eGEDm5Zk1fNKgaqs&8g1f/#`=a-7&7)W!L]AP!N%iT
=[`"d9RlT/Z)[-cW(]A[?)M0tp#HG'912[$AgloDM/HT!=L(R&`E3B`QVpbd"KAjsp7Llf"s3
Y/Z[iW_1$qs11?+,`s?A>;g"\%(9J6DFTC3Rl7'b(IV#O'K*>[I0sUQ,+;c:7F5e%="dTJ@%
&qUU1QSTH2niG>(gU*rM70igHitVjj/g\$T=a9hDqp+CbjVCHW5+N@ADWp^[jLA5HSFQOPQA
j%rmHSKZ(EMFbGV&iB$k#9$uB2?$0%>BRB2,oQ3SFT$DmboEF+&ZZ6q=#3bX>Y3b[[R1SN_n
CLtplf0#.BpX[;i3>XA,C^X[F0>)S]AS;K6Q8V$(S642iFNlmk'&,RRkot"-X3qYMs)lJnK)1
kZl&lTNQOsII6*_IK]AJ9kDFnXt*FZ'S6H!VZ.CbiS"k=qsefhH3So#q\H<nmG\Og/9EV4@FP
]Ar&.mDj<BX>1G9)3V,8ehLO(OH+f=#]A]AtA7m!XRZhi2==a6\$+nsR6hpI9e+j9%tL+C:@"?d
@P_%;I(YSZcn5<PBIO=T&:N:>ILe3q8MB[[Pa8ro[dt2sDdOgV>WZXR&Pc\CE5^g5FV;MPuT
B"ssiq[#I[N,:V<+s&ajhX0k5Lq.-:kHg+\*Bj!j$6\afF6Z0&l@O]A7MbArb8m_Y+A1_mQe>
L1Mca%69_rFur(&6fOT9+LZlQ\oPTn"D5Giq*iF6Zk!O#j:&ED9=DFmnT05^&Ru?!D=N1GAI
dYc`QI1:Be.RgcX6bd]A@NB0'?]AeWCjWYX7LX3ZP*_*FeI`1KKW<uF1gMU7upBtB`#&fhjD1Y
lNnbFjM+[f-eBKc;pgA2]A-UB/j(hlreRTAtRjjrQ/>+Oi^5[?P)Fp2oco/,Kd_=(\dMr1E>u
uSIg8$#3e)FDNiqRFt;6E=P=A`W$qNB*;ZX^h69')ki:#2+:6'?M7Ed+nrhJJb'X"r]A5&t,`
*Hee^Gk]AF/nPPdER69G$cYFXa.^/!PcFB1NQ:-`+V#W'i^U"X)8;oZ2I':ni`H2j(@dJ62lV
WFo9W"iKXN,4f:6N6g>)cG$2o+Y4,NY6[DFCNLOEuL?.,#.u+$bqooh#nTR@O`%MQQ,)oNRI
6orE@,Pl&b-7K,lS$XnU:eWl0$$IJ[gYAg)+;.B=UcR3n2<1YgG.bW"o9W*`\!aS(J$_RkXX
ZZhjj%9o;XCC5#eek>%;2)0Z8:&dM.OM1[sm>Pi7Nn:N`^9PH-^&dpPb%d&?Z@+@A-cZ\="I
sX_g"?Ic87qt$LfjIsR4&!fh8*fCToG;]A%?VjW7>,Wp%Bkljr#=n9<C!bu>e[oB:R14D?UeX
(RA8"C.+nFTL9<`o1c6(F]AWsB$HLH@[k+u,uB4)7M!YCfsBhL6[KnIKC%.AGlgDHaWJ+P_aP
'HkM[l\WnP^gjK_Y:Oflk#?Pj"dY/:H9d[9SK`465I\R"T<AuG>frQ"[VFIQ3RMXAu:i^NVB
o$OnOIQ]AC0Ls(6UjCq+:)EA>FqVaniU*920U;dD"Sl]AcfU.?!a(n.o"_lLieM32hQ4C8S31O
n)`g3M]At;XL233u/a9/YmltZeQKY\J>r8p4hU[+^llj72:9!@XpHHlD)_;jo,P;!!ma4q1Kq
fhUPfq1:cSkYqEp507Mg&&K.$eTTmI>AekLoq&DrHR5hP;`ubXO#0Z?g+!3&(CN8b(:'IGDc
XF&r-#.g==YEkm?0Ad[$nD>.)q+EO1D]A?N`EpCD)8+k9!]A/P<*Cl3ccO[`A=am,t,dkeei6I
Ru>gB=%NGP^C1sp*>):)]AY)njHY?,Y32+A2:OWfJ"2+f]Ao6&I#B_fm!q8;DhFH0a&Bjq7I0u
1dY%csU;X.A.%m=T\P.>DBol@pp+jVqk3io&4=%$Wc_]A.^n9F7t'V@9c3_-*[5!3MmTG&lfd
>cBeg]Af<qm%DANQP>-.H6(7:bN?'heF97q\X1776ItePQ"gO8;Vo_,+i8_6fh'L?s?Lj6E,!
g"5f=4O;845ejhb_]AH$P_I/O3A/0f]AB!dWh`b71]A&eEBQiqa9+N>K#6Rt<YS*`?+,_NT`!D!
I=s1YG510H1F_)2<Wbr.GQhAI"nuT:..SSRn+\ELF9p_8RS]AP@57d='&<&0.(?Q#@aK0YYpa
+kk25_pM-D]A1^U`n?s'I)pLQ2Z7lu/_&5@@f\GBVBEHXYX;@iSaL\@=e7To&s9^-!'ZA;G#W
M:`kA$.W%__gq;R^s*0=2Lm<*gWDURd:`aA7;i>[cP*(V/1;2S%;i0@I6U:0GqPr_DPWk(Do
1mIBMXKUj*4L2J"=^d%J]AGSRD)Y1+C*u\>rIEug_cP)Jm2Kl!"aPK(0+[a8nkT]A#1gK69!/M
Ik\dU:Q#IUrq<)F,uJLK%7&9*K"6paX#s69Qnj@9A&ps2i3g6(B$!10`7_S"_Xi_Aq<(X$J_
;[u_c&4g:*[)t_hPm#A;Ejctfo*6kL`P[b0PSB*ARZWD$;<aAH40-6&7,^AX.g>W7NgAEM@l
:EbidA&(<9/5*QNB0X44NXIqCB!P5ol%tm]AL.o$F"qD?p<DK:!%2]A'm%1;!4g:YgOCLXTmYR
L1N&tl[M!Yn_2D%WM)tUpeNi,0O-TCJoUef/9Ep_/=;BI$hG<T5u=6#;EBStcE#hlrg?tX4L
Y)1pg67=.X9TNGhZ7SPN2b6XPi*P/QJT'9g_St_^Zp$&lB3V$eoPnrd'OOX&0[u&bXJ)f+7Q
brH*)\=D1/_a=Fer^<G^7"%"71G095M>'a0Z&IUZ8V/f1&l^M2M,*@GkJD&FeHBe+QDCY]AXW
@TY1>dkTu86M=AK8b`,6)kheG(e$\u.Pq@\n"jF7?%I4bh3a^.O)TLN!kF!@+/ue%D:t2U@^
LfHk\N=^84sa3u%997^JRuB_<q_aNSH93FDt`5OR>S:21]AeErH6,<[0_7>+\8A<'pWAMY[J%
WRoO3^"M:kFt;[U.I<8aedH%-!AL/sW&N*\$\YgOWU2W)mjC`Etn^bgmr9O89="T]AJf3>j;6
@5>JLk^0pG,EQOUemq=07W:f5edpNhYsY\p!7nSNSPnfCm6O@j0&N7YRC]Ajo\"Vd'P0W:YNr
a0*dXXH?BB&<nqoYqeHjm1]AP^dlb3o6)YZ\n)&9R#sV5qQEUcYpMmDI'.d-9X6AaXM%!/Rqg
?3SprN5Mt%ib9YX@6CRg8W2U7XlRS@KrjFt7o:]AM^cBZFrpM@Temg?NsBo^>aRsgSUq(h4#]A
=.2tZ8sI9H$N8[i(^`]AAsr`XKE<ds)LOCPUS,2Y/=m;=fa!\e@BnWb<NA'^]AN:%^GVm*<Od0
+L"o7[!$K<e]AijTTHk).6e$,)6",udWKZ:4K!Ge^DV]Aj!,!]A9`/-dSF<7JB8L+AoCNZad2i$
jnF%;Y*r1ljfFWn#Mq@a8oXA4(rL$n8N"J^K\"e756X0o+-BklNLUVQX:i_Y?Lm(B,iP?#(N
WkXq/hmo:gUN7_pLfrHBTB'rC`Y"\d(S:Q)[6.1qRH4SBtOF2eo9/G+P,rl_?mZ`jn_q24>S
!?@7DZ?c0;3ciA.nknD)q]A._k:@*j_*mED0$b(IQ&dt%>rj')A+rrB;#bhS`&l%]AUO\%@Am)
b^%k%IuOc=(51jK,r%eW/+QDo=u/)m`-#R3D9Y>cik>S7!Yb%a[e*5\HAK2KgBs_:);g5KCa
LY1Z%!'f%;"h;UsA/WG6JA<Vjg-Mbt8qi6KW0YBdf-(8fO'YhD<t)n*E:dqW&_4B$+u(6>Mr
iTFr,lp`a+/HL^Y=)MUjMD+\`7(Qt&YaBsq[tGpnd-C:+I?_AG;Ef5=@6?D7AggFagbo!1/c
B_5P&DT*G+D8*\uD3>LujU3E:0D'GE6FC)RX;gZ><=`@?9%V=]AEZ7bdOV=[#7%edVNOgmoDh
p0774gZtTtK7^5fG4jK0mLG<VYGuR*1D>HjlcppA)_<Yf<PrXjsSgeAWs!Wd%c+uP(n';4kU
Q=lY;`42;#1.[7l_iKi!F<[fHV"r8:&CF0\2'X)[KFjjMImCIXKqPFH'gWNW(u'&$UNC2CdK
&jRWLFCfi@X?ZJ(cA"6:g%D#a>[LlTUjBhFG4@K;;hM<E^c3UrE[^2OMVGs-R=g/,A?K&8u8
eT_Oi`AtKY=,qCAQ(S]AdRGS2<Q[-WiMT>);gV.rqSt,-(`4,NsJnGCJJ3+&cK0C:lgN;7S*m
D664f,ur[<&cHUSIaL]AD:9u97`O(8uk8W'S=0SV`P-c]A;01F_$u=T]A*u7ghtTI_6BJ_'\[Oj
VEpX-jlL]A/'mK.(1o^>M0Sfob<7l#D`DXOdtP7%&G[LrK318Zq"W3SW@GQuXA+WaH7Cl0tZ4
PAW&'.U6)2p:(B\"!g22U%eKc+n4ZHIsd@W2b#@?7L=)A69qL7(%Wb5b2R]AI'24@`g$kqQNq
qBo@ui3k6$8WU8r$-IZg!$NW(UYkDou+V6GUj9UU^f%Bh<qkfpuU:-OddQ.ZG+`@/u#rcIgC
K2s'N)#+.`jjmCGR_h73753lH*3A*oPsUT/T/S%$f'be-'8K9*=&A`G\i&#P0Q=E(1q6Y-jE
A4'Q[!q59\MgOm$r7@aVN+YVqm3gbZ`IA?BW'NqttIb,.2Ioo'8tBl5W_o!3K4M3q5jb[6r^
2X@G@\/>"s>)s/]A>:@Cl_*0o%trmd.;=I\=fjgN&Eg&3G?]AW/>.NN-L"F(PIIT%NXPDG`<%(
6J-?:@@Cl-ma\8#pcj$6Ht,[=1LGY3Ce-0>97l;rUeS#R,/X[gJ@Fho&7lIZ;)pf$HoN^Jik
0RY#<um?h)d5K"5fX&QN8DoIRMF#+U>1)q?,aXDO]A:1'3!'ZE*[*=*.pKcD+ARPYBTJ?XCs]A
mbbCnG;4tI\C&4/S13M;^"02O.8]AMbLfTGb#D<ZCZ*JM_RU!BfnHs&1O&:XJHnsATD?MUS=<
>n.,><e<G*!Vs+M0H'fGpriQ-o_dnh2nRouFDpms/`Q9N^PkjZ-Ffh'R\*^\EmIU\.G?`6C4
KW=2JoF1&t]AqHLbm#5S/I[\Wg^lb=9MF6_k@>bDiueb;:93OKMVGZE!fEK6lmm"Uu[0Y$2Z5
Z5G2e>7<7FSJ6(1t#.Qm@O>b8:Q,goJ`SPOa_+o_kH7WeogK&1VsYI6YCc_a4H3)Wm'*Nb20
R_Gdt?H[*rJnh>61+^@V.\`DR7&W)Z(1?0O&7?1t\7Zr*WXJ`qBm!OfL<A9uM]AO>LC4$qjjg
'P*[`Ch1=?^p4Q?b`&*^6)g=@UFEe&^/RXg<3PS3\NupdS,Pd=Gk&-jb6ULPrk:-5h(Mg6:d
sk9.n26Y`M5#l;TLj2VKFmM3M0<aI[+)ARSdR>Kh"kd1*kOKGY)Ko]APu#hWo]As$%W2C!U<_U
?3<Xu:'m`.^i,3He-dd8LRglK]AUY-\e==g`F2eVRq_s<YB3/=oZGPCG_k8-4*oU75/!=$e,;
Z)Ik=4R5=R&P7T4T\MX$O6:h1"VScS@_1g`UBs54FApZk9md/:ja!H9]A3N0`&V5qF0/AZi7V
O;<a^6rgrl`]A21%h9F]A_YDIVI$GnCigg.feM61u:XHklsmD``emg:Yaj>VcA&o"8=t=g_#hZ
8(E^f2:_>&jZOqLXj-4N3`c!?SJYMO(qK`/77\GKDg/<0Ca9^n/XQ]AOICJPR)*/@H5q0gF]A>
/>rOg,NP.>]Aeq5Ls[#"$?H9X8f)%^?augMuSIJq,7o!/NUa"g\&1SI>=*[>;lUIG+HR#Xm%t
:@lb,F"-u=lY7iD@;TF'^hGEQTe[f6pkW(p8<q/R19.'1J50_;Um#JE,5q:U#&CCCn]A($<BI
JjO<Oj`GC"08u[ZTCd"PI,@Nf"^hTCM'<0Q"TPJ>>qZc%qpKjjt43PQMsCtMS.GN&$B3F7dk
JnbV!Q%mY9sS&tXVJLt$-p4LtLP,hNi6R$tYSeYM_WNCI"\eTYdqMeoO51l9#lC#n^ZZ[oej
3S_S#\AQ_BPc/T<?6@o&]AuCE@oW<&b"tD<r[a9i;!h#S*LJ(_Vlio6]AqaVFmZrcMcGS3)"ck
hJWrpH@/i=PnLC#pYm+!#sad;dgBL@6)ZS(1jC3(1U8ECZHBg/.V)0]A+]ASQXC=4ZZK3C^T6n
2nd[EXF>;&\%?NS1"TZ,rdo6+h[qhhTcWGfflFtsb8;%@panYF/=YSlXAI0eq"!cc#qGj;-Y
.^7,>Mo/iX"Vh(REt84!*S,l20p>RN65/NJ(S&VH8.AIZWl&koFB*h936K7Bk3^kp!2+F.P3
b$l7[+HgKFpC\KeA$VepM*:0B*`1<8KsWuL+e'%/F)rn>Lrq.j#pd2>(pa(H["I*Q&;c-OQ@
/a\o6Ru60^!RlKeD.&W$NF$Hkr5'XgbjM00l^D]A>WaT3jZ_i4/&1buGeZ"bm*NMh&:(=+U1c
XWuIf2k2oM8hJQ/Mpe2k4.QK*1@r\4AHgn7Gn'cN&@a4Bg0_;Lp*,?u62Hc\uK^3g@=ecZ(V
U;iI_6SsWPW.O7^aH1O0m7pVu55LRb4l1Znkhi-@*cV([U&aI)>4kq!oh;@5;;unmeE7%+f1
\kHhWI5ra2<Q9kJ,?_9.>R)@(RVVIlO&)K9NW5uF9XWQI#0Z8fN\gtR,!.Hk&afY;Jo-2!55
SHEhgJ/fKt[(N0b\E;R=M[@@>\e,S?=ARrJ4MZ"]A;Y%c"/qFddJ/nVOfC*;8N(([M>FF7G3E
X`\S7Sql8'mulP`QoAt0.hL$"[?p\m,G-I.gKlT+i=_kPA-mZe4N^]AlZFh;'Q<,O?(d>$eUb
/moW'hDh\cWQd7Z/+@h4=bl#``(64(\!^DAMkAU7LiKAlM<EDQWb/"Nm->Mfc<>i1)"JTJkK
&L:,GD@jr&rjA6gV"#6^un!ioAs+8'.a"7`F:^,'sT1MaG@<3CrV1"HNMkPkHqJb2,Q*VCG[
Rq6%(5cT#_VRNNNc22n[?^BsN5!^;;3Me+`CI.G?V[N`[EM&3d)Aj;HpbDfQ-T[bQmS9dXcp
!e,LR9^nrN.i#o-\(>M^(Kk^_rmS[9l564L-mS`?R#2.smXojr!fCkO8(M7\O=\NH15&arfj
1"eU*GM(Qin":e.R?q+7lSGd9H-J)=&0Wj9,("%\NqhaG$^gW2YO>$Z$@Q^8I94nD!fGo*.#
bn=qu5pCKj"FU"LSuj7FRb0h0r:S^I!kAdd2BL2b21PX`W=!GiiXS6hUeQoY`0*@-cJW%]Aq6
DnhH_mZhn&%]A!FZ(kr+^haFZgu?r^ZR'/lefT5-!^`pt7=`VW+8A'8gHgH"p]Apd;")IN9>AQ
HQolJ2SKSltOP`/Z6B,9ce";d:e(\rC5D?CB\h#ir0l"G^;8fIH7S*ahMeqcM[6en]A\Vlp?]A
=fY=P1)o*/7H=1pTIX+ErD]Ap&1.L"LG+mBWX.A]AJoamp?[iV$csgE_d'%[48*2fQaqkq,/tk
Rj+:^/F^.tO<]AaTLK*#=7u"B!Si)ULMt.$8a@ml+ZIidO.l[.J:p]A."*R-Zr'7WAs&W;LtHY
XoU^N,s-%J[N8P[1smA,Y6FPBH]A:r-c7%H0$Zc*k!_gBr`k%A-/A]AZ7a&5:GW@1O$Y?HPg;O
Wlrh5G%leP<<V9d_;3-0#$$r1E16"dX`NhmG@ROq`oN0;\Fi7CcR_<m4fG'$S-i6Cpfc[dCF
W'&J#0rZcZme@V8P4)hbr8?`=q/3u1R^6:ah1VJlnF,EUS,Odqo,qTmD5h^jaKH%rp2Ce6aj
>K:dD(PgJ`WPB0AN6?ab$!Lec_RQ!E<I7bh>-+c[>:a:k\pf:5.+g>RSc[#n#5.oC0+[:kNk
B%&*_*UBF?8)/',V*QV[n&rJFY"2YFm-1hHo:*j_OS5N@"p'YImI/?nD*C^aM92,$j2Im[g*
dp>$?ssQi,1X3D:<5_(56XB]ALKAKqGiEi<cB[<\RbR'n$JMb[i=`i(OL)6b`)B1q64*%0Olt
r`9jK6)Jg\Q4Ol37BorUSh"\UnDjlF3otA3>k7*i=a((J`D5c`<TC*Sj,iNnuqSJbhB)[.C9
e=[*SfmeiRM\Ubn@mSm_]A#p)'q'3Q>o2[SXY[>3NWlT/,JoGRDEWJ$Y,;/!4EDq?[eH+LmbI
F_M%T)KmKdtD:mt:a-L*FL@-[1chO7(/L':qR@5l#QIj%5lW5Aau/"e;]AFZ!8apaq0I)''6C
WYIoW.]Ad23?qf3T66eS9\GR^CXbuod1#DECSgK7NKfa<JblJhg%.[!P0:u0iZ7E-ejY.t+'P
I"W!5:X\$ep:2Z*bu_#<KF+o%kM'PmdD![GRtR:I^5N?\%lID/c.%i64?3d@7:Mb"MSuIC,j
Jc?5P4/Og(9qCB$u4kG>TR8D#=S2n.1c#4Ff2Q!t`8_9$9G:"(:QS*gP?;(LkCR0TH`S\6^g
(Q5JG1LjU_kuc!XC46gJt'iZDonH6i&"`GCuf?>4t2PH!_"-`@6jK[9n]AA=Rh=i+*,TE;+Er
0X8]Aka%-gscH9sQC\0PY/H&Z9P3S)@T.ZFN%ZnRPD'PVtKH?NuOP*QX,?;Sb1p;Uk]AnJ*sW+
Gc_G6[V<1g=.0lnI^8t/ESREbTM;5;B&'&a%Cmn=Xt%2KP-e^Be9<<V8?8H.mnJ!m1FEM]AJs
oWq4n@lAZP\'1M+I`o$P6m^1u4r%JmDiSM`Z..X[f2mfoBo]Aeg$,JAMqOq+"[Duh24%;-?Im
g%+;XLEP96+kH_#Qf<6\`$=PpaX_mITa,X!>qI`>Fh?o%fK(bo39;^@#W-&nSc,hZdAuWP;Z
`FiMiKHc+rtdmLEg[W5e5;OgijaDFiPe`)c;<lK:3(%&k.!mZLo/2Ik2V?B^0C.6!(#c<-)'
#=cPidkm@h4&1jUM0g-MialmW\2rjF/7W&S!7@-k$u,:^KUFhQTHkO>E1Fau,[l4s5!,(.gD
Ys@($):CCDSJiPR[(_m2M(d>j-*6:,bb=Tq.jC*J8m^"jF6Tmm^JNG+=mIH2I;Ha34(!`ek_
/r,Cidp(EiG"9Qs#U,E]A"5j;=T[g0N0n4\p6Ej$2&SdDr:PQ@:cA^9>(W=0a3[5N2dH!QhM\
A04>nZcY?(G1Ik19b%1EhLb_kp-L%OgqAn!S+%tckp\%[12'ci;=21$FS8J2O>UO6c-=&SVY
`8A-M0Klff(fPVb*T"AYA'biY!a]A_mKag"pBd(LYfmVFS^6hdE!-NNBYFerQs)pjA#_;5aX(
+>#NkDLe:KRam-N-bAPUe"]A5tRFXr;tT7_V6Dg3C*fKR7$3gOhRD[*-7\:m=$cf]A8`]A^?GO/
CQ"TF;S7:)BLNjdZA%J4ALgu"V3>tc5,HD5@\u[=mB,!^%aCs1rE-:b;_Kh#O/;n/T.R.Hms
FANoeIP16r3j3jPoQOY^d+>G&lS+2r$S..L7\JF+uQ,M:]A54';*@m;k,tp]AY7=`4K@m%^T7D
e=@+,d_30[(/Z^BIr6n+.Z^EBC7[:Q!L]A2dY2V;lGJ%E]A^0-IV$Hrsd&M3d`t__A:ccZZZ?O
`&NES`4&kpC4$jgsO^Q5E0<Z(ZYJ4(RX"H=FpM()8]A"[K!Ql?(3d`bs48""DB6mls4L)#_F:
SI-0EdQGl70e3NXfI"M!O0kH,Y:b<)@6[Vcmqk0RoP!2dG0?RZ,P`1>Cn[Q`-7`0P/#!\ErJ
h5;u5#'#[7kO]A#8S-f,<s&\76=LeQcK/9Q+#uM7[+NbK]An3_ut%[NdplS8Fg%2Y;rjLOl]AG&
A7+k#:d<aT2G+79*ssH$&j%PBrb"I&NKm]A4'_7]A5\f;@,H(92j<<;\G^q0`Uj6;RBf=['Sk6
mCD$YLW;3s$fSopOe&LOu?#Ae=,JRcf,C:o$\:SY9ERTiG%Mm6Im.\uVT/WWN9W#P\^K^oqc
T3@UH$MZi3\iaGfXgoeArQfKL90Oo/0q`8G+\;)Wph+K"mTUEINUl2G1osWMIZt6l8`IHAY&
.;"R3XPoB8t+d]AS5<qNm9tc"Y25F\iGk,r!87!P'E%6+Y8RaKC=<6=U'aeh8/R:/3U6#mB)_
+2^3l+a[Cri-ZQ5R%I0`Vi11=2"dL/[YH^j4&Y;@n[jr=5L^:,VGm;Z:Y%^`9^Ru^NHAN)<?
CDj%e(G:pgR@<M;jr>-Z1XrBS+PjXB)JL5[Em9?-iKBXVZ&Gs60rM10F"212`INd6@o)/p2`
9f/`aK(Ugo?!hBHj6>Q+ZGJM]A^_p)&&XtuZ]A*Zj9.IrU\d10Wt\iJSPgT\jQ+X3$+WN5LLP^
2X9OQ\`2reGL\2]AWET67+>Or\1uqRfp'XDlnCYt-0GX*V&$s(B5(_ikc,L"_YA$O;Q4iZ)Va
&lVpCn=MsSkAGT>FY@4e0P`%LR9QYsJ1K\\8%7aF4N+>/PbRahb&_9K@6m*Qt8I!0BpFt*q2
I[%a.qR#ZA#H6$r@$4c<2'=MhJ![E/gpE4`N7lDEXL)<:[q<+Li%_j'F6\t`d9JLGNVE6\8@
f.fNBfdsO#Q<>nJ!WEfKpA1/k-3\;\WNHM]A[Fmf:c3O+0m\1`8+im!nuBm6[<Bq5#[Ro>,q4
Lro,iJ$NT#?Ijd!?Wi8jZ_T]A4'3XZ$fP7lgc"D/Y$6#&=_.GmL#+upI$G_<oe:OWJ&,\)"I=
F5kT'1`h/5SRN3=X`&k14"ts@Enk/kB)j]A+(HO4L-)a+;ZL;,4cQO'IEiniQtnr0SScW;4<G
u(49Pek1/N%W*,Wq1'`WW/Y,UYOa(@U2L@2T_aBcm>8e^MUkU/8jT^_D'=sH&O7]Ao0h@NH'N
4K9-b'XFT0UPlD`9!7s&Z"WN88<^,/$1kkT?t<@k0Z(T.*g*b)F$V[F;,M5lFD<.s<u\o?bj
+rp=#R7N4)a#*mcpGlXV9l"A6hVPS+r5e\sODU_MtBeN+eE'JDJR)'Y%;bUH--HBtflU_>,W
qD6O6=/<#r,R)KfGK++i'k;'OiH)($LfD@0h0h)m%S*.f)7LjD$2sc26YLn*i@GtCbnp%$=U
V3or_4e`OH9?kta>)KJG[Q%U%N?qS2<GL_(K2t"b5+ZV77um4qad*`D;(m+!Ft89Qf'ND?P^
Guq5uekm#%#ZB@I]AVe2X7IM!%+R+PGJ]AR)(38?UVR=OWA(*/=FgZ!^-R5^,&?S5#]A6`Kr*l8
DgQZDB.b<b&=#\.V2c&\$jl.%l3#kq5!'BX#.;(%#<T[GLKG!:X[hI22[UD'^,\s3pB1]AV]Ao
__3^HeX'3APhlSM=08MN%3RLr3F%_X'Xs(Qjp?o/WUsOf+GmaKZTe\u<F#n%JiY1e&5q:m!a
BaT<Op%(UNtUu]Aurns;X7Lj+s5idi8F&##bA$+Y?>i!i3_A=!eOch?<Hg0`_<9;GI-VRM/kb
6`#IJ3np$4h=1L%NqUE=7FGDbcNTni(WfK<&ah9=<OWDQgV=E&;F76?uY#fk((Zc8T:E"ja3
!*(Cf%\@@C&d!]Af=+4CbOLX:.-NF:dguf0n.t(`(-Z0'X,C68!,(=l1jbM=&1.7c&g#);P9L
=.?ioMafY$kq89ta4<2fpF"G^c#";=7n#jmb)+&Z5q6XZ3uG;UYK@Jpffe5XX6F\EPsYRhrj
-QRl7]AjRRK6L'@7PG+NeH'dCLW`J't*d]Am+Yrk9gVMN#-4ATGQ6n/ejHqE9t/Ip3*(5[Kbq]A
c'?Dj5mDj8G@+iG3pS3^l,iUf5WIlP=Nl#dI5Jj''P5-foWI%8<+o"ftMF1T]Af(7@U#6<]AnI
nLL%G#*im+&"o\W>sD57kMH4B4=T_o;n/<?Q(g,86j?LO:DaA-h_bC8or60WL8[@4)g0Q]A2(
cmGU_kiZiBDQS/\_d+:4IFD8c(I?pqA<@m>J&8MNW&+fr@g2uUZa'^Al72mUcD6jqrF-%\hC
_#a_\9VeX+2Q>2/--Fs6JT:Jtn3Xc0n9!5(]A5i*p>1HICBf!QG<c^;Fn==UAF,\sB>c,Ph11
iZ2%fh*sFQGuK^@l,r""Q=?(VLsXTXAmE9//-]AHhI=9^\qATDW8rcI"*SZoEtTq:c"DjLbBf
RJAcr;:#iU)f8J!?!&"d.)'Ve\6Lee'Al?_!UTZDf;*HZ%+2)db%T4T'$!Y<i*0gF5!Xt43O
bsF6dipU(.6!pLf/?@YhVBNtC>D^6;;diB7OMiWMaIajFaMf!83h^U=-h%\`QLikfB+P75I0
3b93I1Z_a!&K#_$'C&/Ea@'jdN#!!7jZ@b;rDAZ[.9@(=Lgs5W%S\2"s$,+6,mD\90Kg8u.F
aJ5c4@0QfaEIn]A2Kr%S3XRMFR,[%O)5]AS:7\,B.UgG:!M9GF>EU&A5:7'nDX!;^+td/T^&c&
Nr1FO%Ltn!3Cb3,jJba/g&/J2dn'A5.+E>R$ldfK!P)RN`s6B$l>[lDqm2hqtRi6Gu@f^&?c
MA[m>#p`L\VAYeEuD$PNsnP']AuDOZ\H1RqP&Z<YGk10T+K0PA]A?7[NN1Oek?13c7Xr]AUP44Q
#U<,fO7F90l-ZnGCZKNi1&Y_L:&7%)Q&#X;!2_3VtAJE#>ML@g#nVCM@Fr!6cn1qU\PPM1B<
HT1o&p[.*I7rNmU3d+]AH[1OHL1m+Sdl7E`i6L(Q_*n?GQlA@ssU%q4]ANo$RP>/H!7.\7Tg^J
9jD2^44rQ>F<*sTaX.W!PXnk]ATm!%qMj#r"g63eKYMZCnU#/4N[4[;k-+ao[C?lsWA2LEFFf
HXe2.NA_H!l<D9TLmed@o/qFY6P79bSH,:#Yt18rnROO&n8')5.9W8iEZnKplaFD!I`6QV+m
NnPY'QcY'HtpVj+lh,"WKJ,d2>]ANXQce,2-*ISY9_J>62aB_VUTY%^/!XFI@np7c`o8a?6aS
0R@"4?4n6Jfs)(p^nXe8MM)7Mn3DPe$a1%hKqCT>Q%Z/=`1U#A`12c7_0Zf1i*m2gT^9O&_:
c`hANcd.'-q;^82CnDVm#1,dlT`iCjkO_6XE[+,Rj8KJ?s\VYXR'(?1aAXl0.LEtq*EDW71Z
e]A1bqV<ABT7cDoD?nuI^QP=),nD.=3g)=:E$FC<F%[V>7PHoP^%0h7diN+$UiPJ\:Y20=ODC
Y$a*i>Og6C9f4eU=)T.XG9[A5,pYp[KE]A`LUYe]Apl8k7?Ga`3?mmUf%8O[S'mCbM]AsX5N(*L
#g+hK*%?Yrd-%d"r.?X2Z"l'N]AjO!dhT)lGC"CiMncJf(1YLK%U\Sp"'FPQlrGc&3,(Q/E2m
Zs5QV2i@Tc\g"RW[R8.%n+g^VIC$lJSmSsk7JCb\Hf7(1ID`N0]APl*aA#EUE7Ug%J8ikK,H,
/`RP]A6m\)%Js'5c\/Y]A6BO_<2pPja.@L_YoB.6r]AU5"!o#BFDqHkg@0#jO4)N#2EA]A%/I#JW
Y]AFP)9r#=<QTM#:!*Q?rlf=-h34T\IF5bQ(\MLdQX1_>UK0.5,`pJc8f0-h]AD(j\#'g\Gr3g
ln>)m4e4L(6t*^'Ui?-5W(O<Hj35m.Z7LagnF-W64L!HJ0E^=q',_g0-`j5N\h)T]A5;#F+#0
$[f[F!`,^V/9o6+=;c9LfL3o5$)Db1Xi+V5*Ng;78a8JhB+'CEA.*9edW1CQ8&gFAT]A_'<?!
bbBN`)o<=jah25dR;@Wa:F[Uk</"L>onalfo/CCMsCFUV"sg(Yd1S!B.0oZ"`_/eF]AB>8I+t
#egO>SJ<As#aO@"D:o\J4aImjLI\iO7HW<>DZ/,\`Xa70j>+mnYA5CmQI9gt0<;jZIjJ_Rcl
162>9#I,4nUa_"),5d+lh'0DodE8>NFs(G8:q0eh<H.Jq=tK8!,V0kaa$mo^7@3hi:#[#fC*
((o<XKMsU\QLKJXqTa\fK@;o]AghK#cLC6Giknd3&?6*_B$KK-lMI"IZUUI8sgu5TcOE/"?/F
sGlE=>Ph8h-\DWs>@(3AOb_lN3:$XHb&ccBB#O)p(Zb'O-/7utK-V>C.S7O9_-T6+/;T&[jT
BKl_X#`dNaamrQreEs.hAqu?_4f0VMOLP2-hXCNk?R1RL.@28H8GJiOte/fWbU_:'n/$-q17
)n-U\A\;^c>(oQkohIa+<q#E=hd!YQ]Ag89K]ACn:.*11*^.qVX.9S]ALC*O**SE=Dg/3$[+?%K
%tiuAS0"[G<NJbkq_mAQJM=\!Z.;,Iopa7(@!^,&VIP"RMmMOZi6a+).g8\Pedp$VqGn*1\L
aj7YAYX]A[8V'rP(Dn'jF,>ETiMH`O9:^QFEE;7fCo?*NfL`%XIROIF\3uBkEd#DK,!Kf8n%#
?DSE@%dPUaGIQ"7^F7KSK85)^9/rX&,=!WO6)[+54-nB6D=E.`SH!@[IMD^tJ2Z;*X+L(&]AB
(j"jG%b*YI9Ks&Oior)>Nac^fOT_b/h^5Y@V_udGK/C";ZPd-XZ>6$Rp21$YcuIiB-pG2AlY
dkSd5YAh9<QXWMJ#+fuGsTk[0Wr<1H(3ILjsQ(rf:BW4L3UPk:K1N[JFKqjAbn1plp9RF3/'
KLS\>Vps/MZ1u#4PO39;G6Qn[CX-AV\iUe<Pt<c!<N;1IVE/_2VgmA<MPQE,,ZS?8DdEa3Vr
F-SN*=/Uj6$t?V[XSg-(f6ae\(LD]A1@_MFlSQ&J.A"t-+pk+@<o]AiSj!1jh*%+:_n3@jb6ZB
U<p`4m,.t[?I)B6t&Mma5#&kFX@[#C'PkE]A,G5F<no-GoJ-V%MA,=7;<@:O&nc(-;lV4"X1g
p;i=E*L"iDaHhs.B.LQg]A_4k'6?DRH29)M-Qq?D&qHh=jK*<a;c1%H#ZC_NaNWK2-0j]A"46M
/Vbr8GJHhERL-t9<D?e%b(CW%`8AFDFkfg6s&NAJ8.;1T3c9a::$s(Ce[[oJP)p8^=SqF5p0
ruOn)]A(#PD`<aSL#8NNFA[4hMK0COmYSHSiPA5:OM+,7+:h`=AAmC`N,XnK\o/X\K(afq`&9
E@1e(QR6EeAJdEj8KP:Qo;]A3A!!6gnNT;V4]A0Ta`KkUa]A[#9]ApfUWW,g=L`%OX'K4BT5_Iu]A
!pB5G/jbrI<pSQ,OcAd=oXF=d:4TksT!Zl^]AVJl_CA5D70.^eD?`&!U=Qa0k%%!P?Em"aCiJ
km_"Fm#dBQC*X3@p;0u;3*?:7ZOOUA[3`"^=8arH,C/&1K9o@O$a-ie;,PlSVni;@XuY%d=[
0!lQf6!g5kP+&$q[oke/hXc[*gJTpa5N`2RStd5)al&N:q,g-WB$pRMG#OGKdKC2\Etm_->1
SPV\J(V8l@e3@WGP[L\*r;&iuL,$KmqZ8@'KOt-V!DC5;IF8c5MuW/@Z[i&=%n(DD*F_;AW>
sN_]A4lDsIa\<CY42io2?,%'5jU"gLMjBB!Q<c%2R<n4LT*VE]AQ#gnVqU'&qBQ'?ghZ]A$k.;@
D:4F9FQrid-kQ%:Flj%l>=9iR-^Udp9-S.=uH2rKD,mk1P9a]AFqlgGa&58G[r4Utt\>7$u"f
BS.>i-e[c>-*6h#)%6>:N[4[<Q?]A(J%=!+2<73K33OOY+J#:,=WHcM8TbhF0f9"Kcl"j35%C
:2pj?@'70p[),#0AqT/uuWlQNc1V#qI=s--#_q_"jD\0_(ZcJr-M>a)X"O;-\_T$irmdKoIY
@_FeFik#`U\MnqfGITqf0_WnZGQVNo`p9O2)9P%LeN'4<%R6@*R8">:"p3L::WZiPo7hDmf*
7a;XC7Y'fX5=HM"^Io3D@`r23E@u@39*nmS;gsLGYiG\.@-d%,K:ENr#.rX5dB,3FKsi;Jo4
S$%<s0e=XNU4SMJ'&)G62GZkR9V=MZ[cS;JC9$WVk7A:/lU/dnu!dN4G5Ir,/+'egI`n(lO.
2qhH,6&EGd+WB[Gam0k:8@H`kDhF[I-FqtFj"4p[-kbOmZc!]APV=lQ!!761_;T5ION?h7.Os
S#;Bl%?qm8:l5BP;B9Z*s>PQcDoB*2?bILD'bV53uI#+'i3kTF^IR[>6l&%Q03Uji_Vah+*p
Zp'EqDRVleC`-bdgts00nAF2,^6JtZnGNY9hW_9%HD*WDrAiOd8G#Q6fe5;s.n0,mR6m3j[d
Nb<62;tqY'\Z7QomcPD1L:^LgDWbSTF30&^V?VpI>aS"kp!SZlNEld3)ZW_%*$j,[Ibu-ChI
NYr=PG05_+)P:8g2Tt9iJ7\"&[iY%u@s#&f80-kMa0FD%gi"KBGQZ:.V4M_[IGI82//#B./=
oE!:?WXak!\1^"TL2p"/\Ha+'tc6k4L>clLE2lnKG&9JqssZH_#?,RjmA^8WB_:VA'6@gJ=9
."0b?_p@OT$qC25,bN"\GaAc=S*V@Ap.eF''VUg$2En^)@[7FPRlFCD4Zqs!&&GKD>rnu`(i
n]A]A=VTs@G=abBH]A$>rQQd\c-P"(:Xm4=&4lG"PHd,*0Q=*&fsNRBXCgT<q.kAa8Yj,JU'<j[
W0Ac"G^&n0prm(RSu3#eTpE(('Y8XAHT&WMr>1^JY0;V7?BW^gR*,g9_.CBi/h@;,k<YN&Mt
X!NC2qrp'?,F-,A7rnR.t1B=.^,$_T"R"p.4%eh),HGjl%B2L2N%6t9R<>`r2mE5ZJ`dIIH+
Ed:$8KgGIc2_[IOqZgNOsUutqUSmZ7JB(pn3tQ=LNOBK=W!gHkNDI2V>t"%BZLW>WUQP0BS6
dd:FAdC(F]AfEX!_MGhhn]Ai)btK:qN7?P4[5HL!H]A)n5Je1>d$L%';m)0!8BHcP9QrhO2#,59
AB;?Phu\.J2+=pN4S[R%jh,9q7f?HIL_1F$L@+Bj^/&X4/Wr^Jaq/G`?QCZ;]A(f&79@W9qe/
JSV8EP#Ql?#_gYF1KZo?H^\P3O<H[4\<q>KW>b\!F`g(tm`L(k!E&Mau=G)Vt(^aAcJ\7E:!
VX5eYU=']AfO<DJP8--^Nb:$p<"$T&M_k3PAGU.[d]AUI=05S7eHoP1f'Af>HVTeW2NmlY4Dup
X\O(9LeR2Xo"C'?N*he=-)BZXm9^bMX.s%oOWicB/sq\j&L]A?cGrofBthO'nG,Q<>[[LN%t_
?4KnKLOIUd`1FH2(@d^q&OEDd5F*^Yt6,GM(aNqfSn'M5nQm:no"/h*RV@D4R(]AX1+T"EbMG
:SG41p,M0l'QGr4e:7J$jpoi*<\G7&W*2c*7it3=6b>9+2AlVP!A'[R(a8RREJD9PPG`KYeX
Sa2.#SN,mNfck%8CqM7BYS/7Zucc%m<8A4SNCm8>FrZ5L^M8n^$2n>m^cp>AH$247,a6_#W-
l*eJ`21P[^8"[2Z"NgdOGV7jn,VM35+Y#7eB"4d2d]AAQTYUn<RpAg!p=9Wt9mcJ*9Im\IESf
uqF5[**%%hm`[-LEu?&&u"B2k4a\_@4Qc'YrtG-4q1MLl5grcrO;!_F[VpFG8cuK&YS9D=^,
.WHoQE87^V!_S3(.3atu=?]Alp)NCHf5im*`cg+*YVGOfCb1rm.__pcsiud8>]AWh-pi8ao#fG
C6,b#o2]A_\^.u*.n&B95L7fW2T+:ni;Z7cEk8c^[Lte>1cjP?+pa.TTG(:9QFpq*WN:riRVR
'c+eR7Rem(`E4:@"36l4I_LKacSsDb!B%hHm\a2MaLq!9_`d;Yp,RS`8I3E1"<na^c*B8C1n
I=PZeR14uchV7IFa"9JOofCZZA/:0n%"RFK9hQf;hQqH&?0u?dm84Bh"dA(TT30r7]AI+3b-T
792.F4^;<4>$%TqZUU9^1-m=lO,q%(NWk?PSb1Th']A&EDob,%gAXjA^fR]A!pat7-WSR(Fie*
D>K=Sb%^Te[rMW,Hf$tM-o(%Gj$q(>snZ`]AuF^VA@\f*I;Ccq;eKh:OU'`M,'n:5HMIoZ-FE
(RZWU.j*ud!MAXklFZGR$$Wd<Yh:/4K&8+!W#P9Wp(Xf?%fCF6du5I%J]A,2BGr:f,R1c,%P(
0!c`s8k*!/6'2?qkU3jBK"s&IM'YDU+?,pFQr??+tC9,V0\PkCnDbX?OOXTBaCB$mfsqRTMD
.,4J$r:^L9QMYYTlpRPo4NCV[Uf0IT.7(k[`>l_\!"tHZJ#-pb7V0RKHJZ,]Aj+[\[m+?QRT?
+ImSe#GC9V"<L<,8D6m&Zr#[S!Cc+oh^DXlS7gtC#+0Rgs<[)cor\mJ2I9M:k+s5.Wa<tm%Q
7Hl2RICJ$j@+@7agS*5AAWo%kkFh/YSV<r(6'ASMqT[+02O.!OA\TpRSL-U,dS,_N2L>*dm*
`-ahNKiW_i.$Bj_:S`d^%\,:2;06O;eF8=EJ_erVk.^S=f<4`1pHRR8of4[S0@'CmcL5!cY2
!=1nphX-M[C,D-P[giG'Ar6]Aeue[bkCeYSF[RimBi)p:HA$LNEEC;LsNT+$^%_]Aagt%kMnq(
^52+%Vq)pLEmcuR?Krr*&Q0T,c>o&4cTS0%3=9k7&+X0g@BrKmgf'7*!,p9dEajO-[7R!FmZ
h$N0\4\i@/Y\]A&IOKgaGQYbik7jk,kKn+S&o;tMr=51_;CPI(5-%<^e#qTpFYKg]A>Kl3ENo+
*QDWensqf',hm.!bXO*qR6SLMU"U^/2?mLd[JKt^Ya3:b&5Z/'e$DUZDL@;Qr$q;'69Cq?F9
U%76ljAPTIa%sjMq-c^NiKtA(%>9bP56_^4Se5GclL@U<:SjkL'8N'Ye8D0^]AuQaH(rP(UW6
]AkQPum<a@m^G)9"KC:<L5)M.6&n_I^eMsSTkYH$^1o$D!g[pihkV96gt?FHZZXg*V'UTEL^_
)=!`1T`:1Y;('<cRkYhGAeCgTJXS:-/KL^4k*j<Veo#Y%oBCAkp$Ia,lp8>jREn9C38CYX[A
s2l^c"T97MgDur&O!b3#NquZdcu[f=haj`/+3VQCauq4Q&On>k57=jc/L^?i/iesqoLUXj"a
3Rk3K##3s*7pX^WslqHYR&EK6@e4e@k5SbqB-n0?#.*+A\K:>BTL`21PhK!K\WfQ\b^^JPF<
d/A$:HL+IK(.X^r;thS`IM^J]AKW#rMpi#%YgDRg*EVTm4,_[rf:`-2l;AmH"e=H>jo=!STgi
G?23e;gA2ok>h=i;*Z$#'?n\I</71^MA1<r78.EVduFj\[g$KaN<m\s);]A"coC#61Qko3<sq
JJs^9#pQh^g@jDYH-;8Ee?<kuAPk:ijicLe\mp2&sT#qS#DIj@@;iY/<:'f+c^R2U`IqoW'i
;7L=G@gE%-3(!N'r?R,ic$D(L8Kk44)amo1G,rR\i-Lo9CIu#&Ve7X@EWn_WH(ttZ?CJ)'f'
Ge1"o>s27+lM?dmDYA4?/\_\q(V[a$sf1>NUH0'*Y,2*5rqHn!Nh1O$eE#+(&1j@+9b8^WQX
Fh%ekR/,4i(<pg?%!hQW,RK[hJmp3o<glt,G<3/=Pt!,ceZi?<"^qlK*e[7Q.)OoJe[DTJYK
0\No3@I1D-EZ@olm[`(4!+IBUr3sZTN=U0HpD2&6T>bREar2P70[gC=]A,p7SrIEe]AG/6S35H
kNe"/;>MN)]A3?$554O8Sq3deL:SPE%HG*<n@PGf`js)dYl(2U'#W"kJ%U*eLiB8^L:[V)M#]A
R?gQ2T!-*88*JE_b-?nK:uIL0%-`$]AI-K:O#^M=?Gq*KGb(C&n-8;,PnR@XBW6U7'"Ab@-[,
6Nhu!h&s*CC>g%uKDUERH"rb9,`mo+DCmD,XG#7f##om';C;n.jt6<B4cj`SeYQYuUiB@GU9
b4&WWAUT/W0)`0[eF<'0!SjhXe/>^:2jrPVl+EQNhbhYVUZuV9r4(M>I!@kg);8NE?dj@GeM
g`B<&d.XnB13%hN9DhWO;U)5-bhoNCCLo/<+>$@3#_E'F.C(CTW4nhohl;O)Z]A'>N=!GjCr@
8fRB<KUC;%8XY8"qQVNO`g.A+feCFF>h+&J8RcR"ND^osX.+Uj'^IqS1?kS_P=8jZ;BRG8i-
n$jF[(c0&p\!S\:BVlCM3BJ"14Hg[<kPdgO*ZY"4V_HO:G?A,rPoeOSn87L8pdZa^-)0[2=f
@$bGbR^ho1p5?1/=>162'-'HNBHYZ"79!p?g]A$n`8JNeIlXBA/6lcd,BHp(Qbe$MpF`Oa@]A<
]AEM@pHR''Jo4V]AL*(I)3X7fg;dUtH8?9Kt)7CBJ45XL@ur<GQ!?-b(0d<4dTIDfct^QE4Pn7
PPpPZ\:C/ml8+&9PX)D#!kFNpr&P5.*(oo?2J2&:a``+92EJ5QCisroV(4WK!gH@;,@L[:]A0
FDds3iE,465#0Gi*ZQV/q]Ak_)5=3]ASq@*rY%#SHr_0f$[t%;V;V:RSqb(;KnS0Rs04?iU9G^
]A4QmJ,p'd!!=(R!!Y--!W9EWDu]A:r0h;b(!=W?9"8K&&DjVsD.uGkd+W*Zs?d/M,I1^,k!!
~
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
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="433"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="433"/>
<tabFitAttr index="2" tabNameIndex="2"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<carouselAttr isCarousel="false" carouselInterval="1.8"/>
</Center>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="tablayout1_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0" scaleAttr="2"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="469"/>
<tabFitAttr index="1" tabNameIndex="1"/>
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
<StrategyConfig dsName="ds1已发" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds2跟进超30天" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds2跟进超85天" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds2跟进中" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds1待办" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds1已办" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
</StrategyConfigs>
</StrategyConfigsAttr>
<NewFormMarkAttr class="com.fr.form.fit.NewFormMarkAttr">
<NewFormMarkAttr type="1" tabPreload="true" fontScaleFrontAdjust="true" supportColRowAutoAdjust="true" supportExportTransparency="false" supportFrontEndDataCache="false"/>
</NewFormMarkAttr>
<TemplateCloudInfoAttrMark class="com.fr.plugin.cloud.analytics.attr.TemplateInfoAttrMark" pluginID="com.fr.plugin.cloud.analytics.v11" plugin-version="3.15.0.20230406">
<TemplateCloudInfoAttrMark createTime="1686213877575"/>
</TemplateCloudInfoAttrMark>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="97d33490-1953-4715-a1f7-834e35d1972b"/>
</TemplateIdAttMark>
</Form>
