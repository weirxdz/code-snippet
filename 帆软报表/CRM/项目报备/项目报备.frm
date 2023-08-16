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
<![CDATA[select t.ID ,t.projectno ,t.Billdate ,t.UserID ,t.SaleDeptID ,t.ResellerID ,t.ProjectName ,t.ProjectSubname ,t.ProprietorName ,u.isadmin
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
where 1 =1 -- and p.nodestatus = 3 
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
left join FR_CRM_USERS u1 on t.UserID = u1.ID 
left join FR_CRM_DEPT d on  t.SaleDeptID = d.ID 
LEFT JOIN FR_CRM_RESELLER c on  t.ResellerID = c.ID 
left join FR_CRM_APPROVAL_PROCESS p on t.Billcode = p.billcode -- and u.ID = p.userID 
inner join FR_CRM_USERS u on  p.userID  = u.ID 
where 1 =1 --and p.nodestatus = 9 
	and u1.ccode = '${fine_username}' and u.ccode = '${fine_username}'
${if(len(startdate) == 0,"","and t.Billdate >= '" +  startdate +  "'")} 
${if(len(enddate) == 0,"","and t.Billdate <= '" +  enddate +  "'")}]]></Query>
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
<WidgetName name="ed435167-de85-471c-b1b9-bbf21657a819"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[待办]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="50ccc755-489d-4fd6-8e08-fa6275d29153"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[已办]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0" index="1"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="3112ba51-e708-4370-a827-425c45fb99e5"/>
<WidgetAttr aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false" index="-1" oldWidgetName=""/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[已发]]></Text>
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
<WidgetID widgetID="5bed9080-3bc1-4b8f-b891-44414b743633"/>
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
<![CDATA[1257300,1905000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[0,4572000,4572000,9144000,9144000,5715000,0,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[ID]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="1">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="1">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="1">
<O>
<![CDATA[项目主名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="1">
<O>
<![CDATA[项目副名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="1">
<O>
<![CDATA[业主名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="6" r="0" s="2">
<O>
<![CDATA[isAdmin]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="3">
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
<C c="1" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="projectno"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
<cellSortAttr>
<sortExpressions/>
</cellSortAttr>
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
<![CDATA[/CRM/项目报备/项目报备表_审核_NEW.cpt]]></ReportletName>
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
<C c="2" r="1" s="0">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="Billdate"/>
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
<C c="3" r="1" s="5">
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
<C c="4" r="1" s="5">
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
<C c="5" r="1" s="0">
<O t="DSColumn">
<Attributes dsName="ds1待办" columnName="ProprietorName"/>
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
<Attributes dsName="ds1待办" columnName="isadmin"/>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="1" size="88"/>
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
<Style style_name="默认" full="true" border_source="-1" imageLayout="1">
<FRFont name="simhei" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
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
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<X%7g\Ka1REfp)WbRG)"uFeDQ)Z#VBh)B;>#_n]A+shlA,m]A)ndZpgYD&"Wg93(Ae`gV!aM,
FX0G"E!,,)N-f847@fpH6cMSpSeopY8"$4m/EcS<MPro)@[_HsZ:'oDU)qZG"NNSVMC2aiWq
YrU\eZ3Op_jZFB)lXg2:Pg5e@]AP676-Si_9V$F_^oj11aW[)!q+\BqdaW\^jDaPJ`-O8a*AY
N&s0F8L0OIJ1jFg=jCC*)KTuF]A@[?a6rXGNt*VI5?8YJR.pOSmbaW6UpMfTYZ;joY2"+I(/N
7-Ic]AL<E1jk2T?#!FRF,]AjfD1"WKlg0H&OQ`nbM6iN?2Ho_m`(K4=qepCq%]A47`.7FB7I^IG
5?`3aADke#l18g!]Aq1u'2&V!`i-)kF[mg"fr(Z^^Q5W<7=lArp"qZb_S)R_D!m/PI+%CFf,^
d$fD2N6ME&'cSP+C_0ftjaanK1;O@a_rO\f]Ai#_OWU(S%=!smoLSjK.>(XD2L8p0n-s(aaLl
q-a*,>%W?#[]Am(d%C>P?-Po;4\ht?j[994'(b;JpDb%L'P&#fQ(]A-5ZC]AR%>]A\'DcOK;""S-
gMGaNE@qTf#5r%Y0L0Q&*ntOF52EcM1Cq$@lYJhZ_R#3&5B[U-T79lpQ]A12"sC0KLp$?VmEj
WY#E/M6.Q2LJ@Uh0kGj@L.>Wa1;$;p3fU@F9)3AUoZjuScP9guiOoE_"5E'Da!?#@U4_6RW7
JqD,&D1$LT*b0et^JU\\obD0f""'S$QI^sh2RWil1q#?;3\#0R>HK*+7!mc!3-V@oQ<59LX;
<?Xh49UIn/ggoP!(>V!0FNp6Mc/!X!"+LBAOo2RNCVtPDKq?E[0GiK---dVOE,,+<dAUZGo\
rckj*?eo*FiGN5mco<D.#N1A'1Wt^0M&gbE4mM&DO6C61\1GZ4:eT-ABY8te%Rd3huo02)F6
231O3%SR6QlK<2L`C8>W?Vgnc+Eb>-S*]A&+`*Zf.1:l]AnV?Q>,R%UMXL'6rAdm_lTSTnYPl!
#bKN92I5TL8X:l<Q\j_LO/Ru%p+!o!h)rPqA:Z'MS&1de1o7M*u6Hck+T"\F(0e%Fn.EK--#
><l['*uT*ccI^&g_sq)2*jI@r)UWCm2G/"&)lTVJ:Q(oeU81H,'$]ANUC1BJ%eLtP=G5t<4qk
[Ln4N9<K<P"UhWn.a+,iV[MB/(*3,(H?0[jSM>D_dVr+J":</N!'X<7uYTFE-nO^(_p"geT!
N+JSnM8Q;eG@m3%9o."(ab%@/7s$>Uf\ql=pc4LT8f?Vkmd:7ja`#G#;YW\WUd<N5=M$7*&?
kPU_Q`su(QndY*Zm6'^ghslcODo?S$Gc)4p(f.d<D8iJ3K7YOLq:gVm(j36"kJ[+MMLOdE0!
dL`g%\K,\E/A2t;%/.G:1,\=)G0QhWT@SEN]A,/@IRl+#A_MZ3T4,kD;i;XBGibM<`;Y#-k,$
76"0W@o'apT$Gr,._FC:[<o;5+fu<LMFFZ%;P=g[Xk-2spJ+DU8C5N%m&Np(>OhcMWRPCNip
HsRU4>hs=DOR8U:H,Pc3^95.&IaJ4:3;"UVsle;i[Wuo^JRtoUuXsP"CU#'>Xi<p!>j1=cUq
$AoV\#e^Tdu5V-:*7pgDnA7e["N,uD\]AA^6djp0EL<i+@Cohk*U`,D2H/M)A&&@!?)\?n,CO
#YgC3%)Hg^nEN;7$H>6\=`0-*ZD&RY_@Wr?;%pXqJZ@$s7%2e:(oOoW]Af+V_deXtlD,q^OOA
b$;lm_u0f2:F,CR21"(lM3b1V5UQYT).9"Ec_&V)"Nh'clN"-A[Cc\:!S.ES/G>hN1j<]A.Be
Bt'_nI1A)8dNA6:RNr*J=\7=U=09*JT7:8^QbZQljl@Y#4@hd@;-_5T4@Lf%1iI5.GM>SI$+
JR,1/jEUjC*HhO=UM`/Q9&F="A8/ll*1(DBuN%H-u^.I!c7`dSWJ@':X,SGK69j0G0Ic*(g$
=3u$Je6u80KFkU'>4QU[Yq4YWsB\W2I43`@OXgb[k=@q(G"D-S5/Nd<qI4j*o,^Ie)\2Hh$8
RMDV#JrD<h#70!YhO-T6r#V]A;rQ*'-PVZ`>lWtHVJ]A5)0Fm8Gc+h@mUR$GH&=cc2ro;rgB;-
!s'-e*VUDCV]AW8-JPo't+3hI!6g8:GkV71i^lTF7d=X\LtR)$f9DPS+DiCp@$r-$Yt47]AK%-
5+rlAh8XT^&O$@_@mZK>ru+\<9N`8TUBr:]A0XJgf#b"M\XJ(Dkq)_OeN+1*4P"<aqX=DcU:T
gD'O,fs.Kb<UMiXMWHaHA%L:;PLN+WDJ%^VhiomGBdiVQ$f/GMNg;1;>"Qje57o=6u"tO-PD
Ep=9Jn;3]ARiETJZG4$B)gRT&JVL:pX<49Q4deI5aiAYCB+Sf=*!8fNbTiENIJKrQk!$+'#)g
M@!ugkTmXq*Q+QmTBqQJ#H@9kP=p?$^7J%>^1/4:e^:FVU!Ri^$34'=-TKS&PWSlE@;8bZ?I
F=_012Ih=N/IbB)c:D7Uq>>^Q?n9@*9$h'L9gcKa5]AXm3+fF!9[!bqjrt`Acha;tc>BW#$Hm
4fd7/BM-`Y4*ANs_;Y#PU_sl35k<JdJ8Kf,54(*gmFIQ-P$[r.2iNFI*N'ZpFlZ$XmLle6`S
e8sPVa(!e0#@T`L)gK.?\5@*PZ\UlRFRF+4MM:f\Fl>QrWJpjXk-E/`(?>/t"4"ZJm2jj;a7
,hFq0XjXL]A%+5.Pi_"eYqC2,%2LqhEW@Z]ALO9A7ir15CpHY6H?>%T]AcBj?3Q-5p(At.ZLJ8=
i;h<"buPFo5NSNYN'U`YZeaIQ$si?cY@GKX/il>oTF>*/LG8eYJVNS0kpKoCt-IMW\f4K7N>
]AuI?YCh,Xae)*egVs9M,U)md,SNbgBZX-$S"c^a'r2F':VCgNSZUEn>XPAt.h9#]A#q^\b(Z\
5t0K;;o4QbV"tWAgl9\bgSF`]Ac&D`uB09\8:Z]AH4XC/$c!)qZJHcDUjdi\a0IL.>Qk=ljr,d
\O%ec4g'YRdXT&G"Tj_]AM5`gU)gCjjYXM1]Adjh\02*RfF+,jW'lL?LAnaoX;)!?>)-CsqhWq
!d7'fPBRSNd4[PUL4kpjZBWY*sN`su\1`f<3[!]A#aZ1,!-kE6,=q0NR!`qZ;o/HmO@0"+gHp
2>:UjnReg+Nra?(ef@%U/8b)G"R)L_aoIFL1:?!0*[,pnXeI/Q$`!/ctJZTI)6^TFIlb^:dH
tn@V0h0<:iDRL?FB]AZD;YtAgYf`8Orai?UdBGJU05S^:c+`8U7,APND\+Y`e*KFFe_,Re>Ic
l23k@acO#Ph3@?_@eGM9r(s->j%=4s;iA0bmag.u>DG)9O2:C&E6W3Tcj/-(Hn4pITkj4&JV
R^rInrUX@bc&u>/@XB.:t?0%C_c<^.^s*YhnVPbMs5ihL5%6_>eM]AG(A_I.+LYgKg(8=p!@+
B_H=Mj-@l#iRc]An5@3dsN5]AH%o(Z_9#I*i.]A"j#@5FF;T@H@ln6;!rc%eZ\f59k&<35KD7n-
QsTg'CC#4niJAi.4F5DmQ&s4Y$n$bh8t!]AEcC5tLLZT+$NAM58H7)?]A5;p\ScOA)%%('BXNk
'd9$!V1h-]A:T$?^Ek]AdM@Pc!9odo^\&4!#&-Vi>I]A:Y6=)U0*SABbnlhfNl%Hha?A8SgN_@\
^DS-"EGmM);b3SWhl1EpL0nhch0CIAT7j.Fau5:-$!b)Z`j+E?-pE>d.QDY2*ntFoqJba$:p
)3s;YoF]AEA#L-27\O70s$RJrha\gB>B\W)5E%J#q'3>@`F6<!b'cUE)9?_ed'_^HJe\d<OJg
[9#jG/I`L+RD.+19%ak^Wd&Ra^q'u?#(26\VTjF.fR"tLNQ*`]Ad&=$g`YB10TJY&<(E(>XU\
@EMgFdAdJD(a$J1c6?r5sl`#_s&RlF-pYVaHbo0dT;UbhH@[^HJ'ORcN^oQ"*XM4r>'_c9A,
]Aq.jA2Vnp/;jg@^/,Ytl>KIm'4&'NEO8BWZ_AEM[ldm^)UE?t)LDe9X;;fdHKOTnZ!r.D6tm
Q-BL$/`Z-9M0($jT\]A.oCd[D["ueItl4hLsIADZo%p`;c-'sYP0gtW.6NL7DC9t+<+Mr6=Vm
UZer<3;F7f\fqZY%=8"jk[.-;h9:m]AdiAY3f4>W&(fkY`LOLaAe"o1R9$&Ao(8)2`.&"CNUY
jRb4;?GtO=J'RG43Csd>poa-_KrutCH@WiEH@MlY`SbL3U&eusiG`.NOi"@TDlH"6$GRFTj&
&[Hu*Yj5]AFXXBT`*$H8QCNH$in1(^V'+6sKQbYcm[fnDLE4Y3^/_]AJM2A$U]A8Pa&.o&AFU_C
pA8q&'5CA50+"WQmD!<8&A6iiU@n(l`hR*?(oi83f*1$%3+#4Wb!K9^WUKdrr"Mu38#b^]A#i
:d*]A-MUqj;-Se9!TqS=;h^#m5.sZ=MW2HBl$!#4cbT=IrKTL>Xp!el\.HR:nBTijBd_u@j+h
h:[7]AK!;;MA@9T@:eQ5''9jj24H1%oj-DiOr'U1`#r.r5LW(G?"([KDhH[S;E"[%d:oSS027
:)]A=+,*_$Nl)k*bhKubC3da2VMK7JZTrfU=5#S+K`RHRAMLF;jj#+F;c+H8J?>2)f_;eBr;X
="=>Xm\#oja$P>W:1L3R`_XODPX?gFS;H8GgCnoLC(OjOm\Q.?aLa-Knc'NY"Z;u?4uuHol,
Ro(ib#TMLLb1d)uVP-j#c\q&nFGpL&*D/")aeq^5mq!SG13fjNYo7%R8"9ME+J`YjB0Oc(5:
M9onJc[(?WOf.V1U'$d?m0?P\DY-)s@P"VUmW=4ToWOqGj=C+7,0U["[qIlp1om$*iWfG1bK
)2MTnTnJ$H=G5."VF4]A,12uL,m*5U)KCeQMtJ"H\64(/8YCdWH*mWqX@MA$HG#m]A*gADXL/-
W>0f`;DT9qm^<J5amRV[Yoa"N2C>@c8npE7+[r#^AU5=_3W'uJ%BdF^913#(R6KHi,Pe)C=\
ej.sF<d@24F>G>!:r1f>;uD"`AO:8))cI9$i1q(S3bnS^f'l=?KYp/*ufjK;ku)*jJh.lcsN
HlI#\^\*#JTJ&5REmA>;[e.B+J`kEMM\s-aRGMBD[*TcUGTYnsNeG&C(;#KpV4C>jq@&f]A\<
C>H#9-o$'@/_+Y$^1ibuq"eg,]AIEF77aq"b[=6SfA#IVm>?jIceqcPW<EX.*A;KXj^J:VUh)
u-jkfLX';'*t_kn^Su(iu:^a3QF?Tg[K"4_=4_HbCZl'qGeVn30:A5@O_u2c".(Qf^M0fQFo
`HH8S'qKaASc!!,CV/**sC!V?p.EO$IO&9S-Ll(236d$^,cKDcW?;Lt;(Np[^V\n:o7`9%aB
TRuAq7#u*b2K42)0oQ0V@$JA[A8!#N)FE96XK6N$[nmHp<2ISN&[^)-?\r\qhGtX9]A<JdB.$
?I:[8hE5<5.UoC@W'2-PKB#ht8Rqr3f_d'F!qlfGEAN-[\n\faaf$r5V\\+-DY&Z;m^)I_8:
A`OOW%o#aqX6nLdTi&hb-=2QuchnYY/=>8.L0h-XR3JIlC]Adp6p.s8M@0[3s.l%<q,c$hldU
[`]AQN/#W?(C@bD9%;>bDPU?b3MQqM_[A-+6skojB!Db47qA$T"EBTGVc=^Usl#18lI/NF/u(
8gS$;_@9DAa7l7#[0sabg-uZblfm6-=`oE">*;cI*QS/F'k'Th<f6TkkG[H7^1TUIppMd,^g
D>m$[fuV+=Huib-2A8G@KmI#8Ja5VlNma6,:f3]Ah+&[`)c%&nU]A/IZRI<N"_-KmHc/AuZ%N<
NbqR7M4]AGhX2'G'"D[c$b"%Pc4"4rmddL\a1e#WHM_lD)8&<WK0q$-0uVP/?5.:"[01*r@3o
;5cH\hX%$-*_"rZXM13PU+.tI`28Oa6$oS6@:F3qopUW<AAmEpQG8[*GtqlH/IpqhFsB_ck<
E?Q-$d1hGM$Sin1I2Kk-_EQXZY3ZfM-%K&F,J<iqlXhGG[O+E[5&]A0s=7<b5W0fg.qT,)N2-
ST02:>.GBc(+_s0D&>\jS*ku%UJuXs1I8^Z)(="9"*jdrM3(I;W8i#Up%;$ulom+:BAfPRPT
ODda*VjZT.M`smFqolK1GY/Z]AKsa4PR@CLnB+%4W4"a5krQM:S+s7C_,pO\")6;]Aa$CELE]AM
_eNlUiT3G?"Ti.46G0.?$l\kpkmfUHClaG;QO55PV).<P_?CRZ*>h%OI;G\B\Ij$/^VrD/!*
V80"AT=Z!fJKf%!3FnI(l_#7"22bP_Bh.p*7S%DO=C+#PiW*]A[acbj#rHqD`1Tla^cP-$GKS
dS*)Va85K6_fJ]AS[ERb#HRiOdNprms?N+UO0n#p7<5;jf>A+G[G">$0VTu=0.TTUAA,.@!Tp
W4k)fOrnd,7:STO*leE.Zf?Ypb'Wl4-V50%h"58?rV_X4@j\DFUK2"qTC16M]AGc[e8\&b21h
HhRm(jfcC7oQc9h4m83/OVlOin*0'G%J%//FJWehgYEFL\c)s1bU?Y>I=sb4rS]Ae\*/Hh.Yq
CfHIY10Y<R5&<k`\S)TH/lJ(B(j(EE/j^(tL:>))(@9!KmRkfAV:1JOOmq=f!a/FcW4:\,Wt
)33R/7:>F&q*31Mdba?%rUhgTZAQO5?&?R4a:8+Jeb\Y4`?qcG&@gh/b<n%I3n]A#1+M4Htr-
tK^b62I*ll+2YeD\00r,2!q[EGU<WG&5:ck@lQk'pr4#l/uJjgc$"\^g_Za'OO)7g:QAF9:L
Ych^Ia9!ZnAnVa]AR4E2>?g:mkO]A)YlUs35OgG+G!^_lXRL(&!35bTL46No-aK'0Z@/9f`YY:
<Dt[ENApUJ"jm_-1nj$!Z)_:^AH0"kH@&5_ll;7^7K6\S;c)9Z+bUTUs[C.S=s/;EX+,P5SI
(Zbu<g[ij*9AY$-).B]A\DZU>NZ?>uJsoCmV5\#^K:mU`FiflITWX-I0_JCi/Q,kl,7:<YPMA
Ll6a9$9muPP[eg*s)\$(R7:qVTEJj^1bA2l1jfoK3TrL[9;X*Z?]A76&]AX(pK\in!2,AGAXZZ
@X7jYVBJ49NG2kH1@+F`lE2$cXqU'9QeJ0FOKL7Po[&3uKupbg+1Rga2OgZ@^oZOe3%pZ4pb
dXGKjroHE"0r8_^,%WWn5jrWRHo(&HX1np5Da-tOhj+&nU+$_+6`Yf!iL9m=FKnQ^%<n#37r
^=g;G*@D!JJ?BB^UH]Anj:i6Bp?,:s$M%bMW\'C<ZM5j9VX8fr+d(sK_;h5bja=+dldD-o\e*
sk_R_m/&7[bM\NJuh)tjnD!Vg]Aj0Q9bVO^J54CQP=X>bNgQmP1-Oac8Ij$65-#C[f&j@:jD`
I(RZ1_Pc>tV"?dVPd7MK^75'N6O3ZVahSR5dH&dlj4b,#>sIg1h`B0<C_<eYOKe,9'E+:%Im
SrrC46u:BA''L18bI:9t8FujG::XHfk6lZ4_c.Sg#6#aU)utrhbXp6+;Xo?[.UM+CW2m%fs<
QoDR@m"kY*_/rRdbRm#.4GPG1K%5[6)]A!B-BJ1j.GgnUA?Z%Dd$$jkJJ8b>BtBn1&"-4U%Lh
';#NXA7'"aj/&j$XM7$@tlfT[S.^/JIZsUBiJ[HM7D+mK-7^"c]Amr`R)gH7."hj(:'J7sQ]A>
N4$%HJE'c.MB/"e:EImA6$>NBMpOoW[^'E*1GOt9%>fnuc+=_HrLL?Z`tQD4+X\e3;fan*Yh
%b]AfBf)B]A7,m84&QIf([<G\tPDC_j5mYF,Om-PooS>Q:-;?+I!1`&%SeSklP*=m,G#]A/ID)5
NW9a0K&$*65Q!C4Og,<tM2^d+^_8`_Kr68D\YDR\Y%Ed1g,u5s&ef(#K"Ln&L@liT-`D^r4\
@,)t+Zi-eS^H0#;Ink-&58$E3!!?b0T*C@uh5q0TB<jL0SW?>JFX@..'-r"pdE8b*'3T$UKM
4SY28'RUeHVg9s>D=U6!R?1gmMPZ>;Z%sbJuVjORa4%O&U(om4D7[\8ZhV-?">N*?(V5aZ?J
TpJC@gQm8-@)H;JR>:M[Nl0CO**&0''EilRbI66fWE"Z^KDElIglbJNQ"Zu20DV"KMP&FSr&
.)VtC#JC1pMGgVJJ<s[u^#B]AC>%Q:@m;)RkY-dP#h;mir7N!l8ns`o]AF2$]AG0FG"0R=7Zn[Q
R66+Ofg^'Q!?'E*\b;e`EO`0dh:UN)KSZLjP_+:jA6t!ktO_n6T\44=6"e&4Z)GI1n-]A-PpO
A(J<rP?qio;nZVP<)5,"6VooAoiP9ESg$V4Sa`V4NqITXpKB#=rP7'ClXr10,$S?IsB-o$0`
C'mreNEkD=V,Z'bMCU5mt""c*FR`@mqNDr5l)5;_Tri&euno8#Zf?sXpbhR.s':eIEGcO@%`
]A4[.\1C1;l>#%Mdbm-W>sb>c3nm&S!gFX1*e963I\lEBBfAoY]AI7YhgF4cpAS3)i%?CZUM7[
,$kd2T^C9WI6Y]ArFQ0>dZl%afDk^OWR[1;!N1g`dCD0!NODe:f7.3<aR;UWp&jO,@%2?0"6c
KK?_Z)V'*Yf[qZMpV)Ol:CMfC(L3/K`>!9"@H:8^)@u3qLf`%:<acLX\=Af<)iXb'!WLD7nm
unTq`\kiL=U9_6"N.i@Y;^3NF.6@@(cD?sWmF,@(&f!;71Q8OV8rfD]A\A'esSoJ*-MK(jiF%
FC-@<^<7>CofF*W!pB$-oUY%"3P'/M=/`,PbX0G@r35<,bRim/D:4(=;FVe2\%7[Eb;)4Du`
b+,N91J&kX'F9cH=&2A;6U?UN^sisc"l$U?G?;mn;Canj5d:uH!8&mj/>c#hIO=[oUeFA%Za
\8d:BA9`2F2!tK#rlB6E>5fEb(&^/fR9BNI28sC5dEdNO94MIO=kSF`Vn_OgAfl9XW_+_bXb
IA&,E">,FH(l>3jiQLbX%[e+6Y:IGCJYrb.oP/a>3Ppa)T;YAm2*l`=oOfL1Wi[RM`M&HN6F
X&X6?IZ4s&odEU[m@[Ra-1(IZd>Kb<HC<:BsaPUGNf/*ab)fq^">rqrSD$kJEm3eJ8J:kr:-
[o[Op%NO/VaB7USEZn>Rs!'^3#7=BkQ6%(UY#KU$5hla`U;?!RuCo=#gnRZM@A)&$b_-A+5?
l%5Q:IE2$[l'D8A@:CI\4aO!M>(l",!-V2g3%gr[Sk%6_.Vlj-6M<Jo55j$kJ<K1aKqqU4pn
J',po,BBm.2]AZXr'p3/?H:`B"BcDXRr%c:%/8X9@Gb78NfDI==2;;'U8?li=N?R*9ZD9U)R=
:._6>+cM3=oGM&/(t^]A,t9?'EHI_U?kXEJU)+3A!*[I%RPLWI_Wocn%*S>JU=t<7Mp29Je&c
ZTXT)mo)(JR.T&aHG^,#LD:k4umR7ZJ8bORA;TL<L<9$@DLa>XKrY:p`MZJ'VK[pt>QHS^SJ
FO@9fMPB7anoK_h4sPC8?D&rP32$[Kero]Ag6M]A*jJUp&:)'#qCP18dCX3NbQ3n+Rd0Zd:juP
hH^8;,p,a2=\*ui&*mC^isB9g9.[/ciL.-bac@<i^DD*#YrNMA^M&Db_7n)9'W^YCM--M&;#
EI)=iBU:<n$+Yj2GJu<s7D*j`!/b3oZ=ICR[PEBSdc+'Hk/;WSF$T8a]AmHY!)IA6!&S[&b=2
fV>nVg0,Vp./,qO>bEfUn0f(Rl&@&MobHU)%u<[##5dHU477K$U+`*ULA5)d\a0=K)b*1H/?
:r9<?H6:T.MO/D'k#KDOAZVc;d+u+pVEM/'S3m.=D:t$MsR@h.NJ7C'?O48B!\r%S`\)LYI@
eJB3qtt(0>+r`;,%%/M=[>8rpm"<`2CkTKK*MkYQddCV;8I-:BNEl+l\pXUS!ap^HiZDuThW
DmX.(j<>+F>YTP(hrVm37Oid2NW,_48ioVl_1%(D&UT8O_am]AJ/c^nbV_+hU"j%ZtE&K$;&F
*)hq6[JWi(+0XL^U@OO`DPo[!5+:Ih!L%(rcnG)7\190:aK3diOLn->rCSK(_XX_1:OD!oLp
KVLM$H"bq&nZ6$/s_`lj?)i]AS[Ueel/W'Wso`7pe=Z7hJ9-7c[Vj"kb#kHSZkCljmW_5;)Nf
@^N=I5MhQoING-<\<mJ=L&"&nV%3X6S!E1*;FE83Wit!ni[6pOAj"$kH,HW%W3n.R'&AH/^@
`qEu\-SW%[X/;tB@iXQVLI8BLAm6hd'EM34C-cUA7@<u71j"9UMS0>P-+ABiRaZ]A)jqdIXWO
+*(V['k*,8,(3d=Qb3-g*i-#B6P&<#1Qbe`Xh#pV>q"\l*oRa>AWdu`jj!2ggJ7pBg7pAl[Q
8tgcC`Pq*jnG<j!@l,n.'0X+m3HTr(MO$_f>&gBU]Ah*9rUrS2^'C_WkS*NB:&G;">;T,=,e[
J^'b(4UGiK5WC3;hVAEuILtOZ%)^Z;20(GGtAWQB*87bc]A>I_tnul&KX;n:B]A;Hd.)AWDXU>
-bH"*5;VLMAK]AT05!C:f*bI.cOH>KrVWW[`s;gqppr$V3@IrKg0IXHq.6+/T7f2p&&R@Mit*
9Df=$^5lAHQ$2%2V0e4fGKo*[LlY><V,8<cc)NS,jeCa<!f:Kb@kt0,AQ6hLT?L+LCa,R5"m
QsrhOerLui28&o;CV13%$M;b!:"Uf/fFJ:4eFZ)bi)eg-CUfm(SdKgt3,RVRF>1d+Z-?m(2"
"V[`-!>R#<(F.O%/3cifMdE_Q=M'+K")?mG?Hc4Z/]A-qpr"feJ#UYL6BN&qR^P2Np*0NQ9i.
bIeD0utp:J*%E`qkib5GN#Y-SaW:f1AbQUHAP&Z1B]A$;AsJu`EqQX/p0]A/YpXrL(Q?ujojN\
J#CCdMU$InP++P@\]A'C;@Vk?rrES6]ALY8cJNGg74Gf2u/jZRF%K*2`Uu>iF,*'p7.q:HdKc$
I.W2XR*Y\O65CAR,$jiKPl(V!M7+o,J.3,(#_6^PfgF)$4e\$>`1>/BoOniS.(@lr;t(.bm?
CdSAJ@3pY4?_J18O/,38;rW,'eSj!i#dVnL1/W>=p<MBW>j__kIp-^Q#U*sbIa-?1p8@#Ge/
$P*CAPc)TkU+),fFXo64(8+Bo'.m@3i1YS[6>*hC-9gB8IdiiXIr[qFpt>Z=#S39aR5"^@P:
[c/Mr"E'/201l8m`0cF)sGUHZI0t7kE#NZ-'PakMNI<Z-G-KBk#YK)F:q,&$=CX%nieGlP=O
p3?n]AD1,u"Ye@9PDUT:A)`L&94WF)e./&=pZ,IJ48fJUsQVXe,f0!9Wk#B%U*Ei*Pt%c:ol#
m*HU3&oDhUK#N0+3ErqLY6`Knk',*]APo>_8!Flk7=a2kE_%']AY`Q#kJ;h3AOud290+QecKSF
8l7A=kF'9i?a`Lo]A'\2K;T=N4ap:a/%?gKfQ4S>1LtCq*8T07`C_MS?GCN'pfWM_4emNgj:g
_$hFl+[m/GjeU(a"4lJ;Rm`m<@akS)95p*D*hhs+1qB>_6&B\.R4Y9$hS"dHQ=(5CH^b=g&p
pK'<rgYJZM.lLJR7r@g=B$5Tj4@M8+9YX1=1fN(l=M2[XV$@n_H-C(B!$j.NIQk=)9aSFD55
17qBAq!3dEnQ2CdfZ5US<=do&m5Ql>t^CY[k@BjcI(B!A;Q>kY0]A8?!9%7c[j(ml6#T;Z/%8
OHU)1AURb-W!]ANV#+-oBkNH%Y"*B;,"IDN@TH1<P_BO#L,f6rInuH.Uorm\@kLBLWuh)qKNY
,#Mq!Oi8+\j7jriXdf2W(&pr$GE"5VT@Zp,Zr1U0'h0cn)uUq%#rk:ZM_!nSK7<T1$U<nsrG
Y=c-11C-h>DjdE6A1$IZb&E[&AG9L?M\>ru>jU:6BUpk21l/$HMEeUWo(GVpG^$TccS&7A]AB
FRPGDL8RM9!d)p+o/Th%k#(Bi_gu6]Agsm_GfDZ?\[^03m@!+1d6sT&>.-6D=[7K_s%BH6thk
upgV75?H]AHG7M\RSV6gdha52$P%tRN]A>MM\[6WLnHbmgm1_e^O/JMoQa=5DU]A4otBE+)D=1[
jo_XirgHk$B9k^#bii;/`TB3r8P:\UubFV'&sb%^e3@<ErB00gQ_TAPLV^FG*3X]Ao+,=,477
/?BI=Ism8'gdU&W"b>rWC+TM\VWH?D)XaN?'qiD;!Jf@`)8f>Licdi"<*D71-)&N<Qj``a?K
3,$f'e/U;2"R\0D&:&aD6=c5D7K#np"L+U$p7kQuT)Z:pW/e8KT#ime]A?a[5,-nP;_5ck1`,
5RcEJ%q;q.h.*a'smMJ9mp8e&fD6e>i9EGdM?Qm]AosG?pC1U@jqIMK?,+'m/3?.E1`QIQq)b
*mA%=t2`UrChcjAl$+9rYN4Gr&)tLg"r1UcoIf.A&\)R:6SR$:)qSpuV'a4"C[4TcR:s$NP"
R]AGD@'IFCs"*Yci=:&r<m0:dc78_CB!2?,#D)N)N?3TlZ1Rq@39rI%0CD>tmKKl9ILa6--;o
6N9uoUZdf`NaLFV!3"bs$#N`t+Mj3iB\&1:]A?/6T/T]A>26WA^*D+*o.r(fUiJLpDi=jaUPQQ
3%I:qgCJ)nk3ED?Wn:DdTGs@%bkkp]App]AMp_nXfXm4HaC2+#T9q_Gk*igJp?(1ATZWkUQX1"
3>(k6BLD>Jo$=J-r&3Zqs<@iF"fr:fG^Z?8f3u.%-q`Dr<3LDbnq1.-p:IHVa;9KtQ==)BH1
VjV#QW9(bR^85C1kI-OH,1#\AAoBeE,\RBZbrL#a^XjE$M6gEB'hh$lGrWrHGoD+0.KZak9K
[nosE89'%Xb,UASEi=-44`9q_:_Q`-e&,P=g6)Q/FsirHubq*jXV(9TlNq78^Y\a-Zbo_.?D
cp?/,NsNbou1\<&4^)Z]ATAep'/Lch_T#%Se(UYYES0Qm`R=)_ZK]AbG$^4h.'\$i8*)TkM<\]A
&Q!IPE]A@qVZpE'Tl?OeGVDiX7qR=2T*_O`8g9!YYgg.ZW:es!m6Mrh(V<"8_VYd-Zfon@*^c
,>0gEm$Y;r<1**tL*8%&0&H;51$A)5)L9oH44/0,@RIGkd;r?mB`Z-g-A+ILg5'?Vo<6eA>b
S^"n1Wb#KtLIuDij.2HiQ^fjM4/[J#l5gdH@Q(S#JA51q>7k43(fO1RYFK+dK$JdS:[X/&[A
^-5)f&[(P]ACSe`+^sfm>bc2@*fnAam(Y@eA;TPXhf%a#54",Qs.js"Mn&I+PjJ82`Fn_NiIg
F'_]A]A$O-aPCPNMnk\R<+eYLi9?8Tdt-5LA#o"97P<eb+Lj%8F2[S^YNs*aTJDqqXK>gp8rZ2
@"MU"Tn]AbZ7pA`S7\mc;>2hNdnG*m$mp\^+C>BYbgns>)cWuSFZnCoU;)0sP?"D0J`e=]A4R]A
Gn+Tb9h$Au]AP',4*<TB^kHM"V'c*DgBdce`<LPXJjLD9O)pG1J%Zd9,'9LGP\GoIk_J`mQn-
16af)de$dH.q"D2@J0ZJ%n+Q!Ier&9*<qQF6_?siDF6fg7fA0_J`1=&@LE/77Z=`[+-cb%K;
_,k;#d/(m?2sX92csqj[#i?WbG;Af[`8Q@<-SSR.7Z9EIaW\e?d#k[B!kV%if_&o?oD&O=XQ
:A6rt[1Kh\r0q*!td>`\+iG&P5H?CC;2_AO`uf1#1Gh_rj%rIEMSIV&3M3phK%g*6OM^.f\*
GagD\-RrKhhmkG.8MVJkY[<KlAUu\J#V9[1dd_MN!]AW\:`*5&uaFh!a58n,<S1\!fln#Qm%=
I(,)#dqh7Q8qi+=dQu!E6+i0!*=3n4PF$dJ\6?<XJ[kN,BW\!11@2JLIAQe]A-;UA`J:%;htb
_a\Fh<FT2_iBekdS_`clUF[K\tf`%emruTg&[_OHH55nD![/tDE^:U2KQ`K^2Z]ACdM:V;B!G
Q#+O'47;nMYuDTrYF*?.!D6UBT=G7enN7XIFXrUGt^#b9Cf7I%j*l!P!`dmooU+T_q3.Q+h0
N<`]A(g4L4M441sP-!*^SG+,q0kc(+)[3CG&?57:8=i>`ca+[^B/i2qKEC2Jd1H4$j>/e:R!6
=XS^05u!?HMX%<Y4C$u3a&oVD@NM9";_+VuG&OmR5AU2`\!?p2!AqnR6'T0Ws,DUnAt4Jhc*
R;4/*,l_H;&N*<CZMHI[`IYL%=W_7d*J?FljeP/HSgjfF_"&@RBMH1H,0c?e.3(i?#MD"(Tp
kr%'WXg33M)STjBi4"MMaTSpN+`G!745LP'VB#iW+jqITNNf]Am6Js<A0]AA!sZO$m9bQZ223d
D)"Fi/=?m6iN9Y>9_Y5FrEdXNAoSc?QT:o)<9Ga?#^$<QX>A@FkHVi-OS?&2kQ.Y31R\V#<B
=>,nGsqjDP!>s#Y\Mn+[p<j*1E]AhsidWa7&dD^Z0P9No0C,BD`sm6fNTYPJ-C%&-[&thJ\`Z
H+YU(_/,%bs,E(`jL-:^2%9k.:>8`_Hf"a,q&_Q`r\j~
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
<BoundsAttr x="0" y="0" width="960" height="468"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="468"/>
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
<Size width="960" height="468"/>
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
<![CDATA[1257300,1905000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[0,4572000,4572000,9144000,9144000,5715000,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[ID]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="1">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="1">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="1">
<O>
<![CDATA[项目主名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="1">
<O>
<![CDATA[项目副名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="1">
<O>
<![CDATA[业主名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="2">
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
<C c="1" r="1" s="3">
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
<C c="2" r="1" s="0">
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
<C c="3" r="1" s="4">
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
<C c="4" r="1" s="4">
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
<C c="5" r="1" s="0">
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="1" size="88"/>
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
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<X%[P$@g$F-^F+V3]AR_/)00ic(#M!1E.;P202AA8P9X1;%[KkSEmMg'Xb6:`;t#ab)+P79a
)8sPgfc":uR]A8i83A[SF\ho\^']Ajq<,\=^%V[]A(2LVXF$IQg+Q9u>_j8QZ2m6DmC<N$o-SMW
+[2(=*biC\'hJ$Xfpod\u5RqF%*kr\KR2t&S6LRORm<+%TqoB^Pm8\<N^UNKWdCOJ@:EDa"U
j@OHKa2XZ+4m]A?46bF&^J8qD_Y,mO6O%mrYY+UY7e8:)>X.1+E)PB2;3LT]AO^/PS3(gCmZa#
&t1_H/'m)A+YV)c2moF_dZV3#u#o&BrI*O6\"KKKO8ouJ)E7=qiL-P1jI?LJIn`ZLT=<D4ps
JEk39i?R2\e?4cEGLiCa%i5dXL2/Pi?061c_fl8p;sqftCOD+;a)Q0]AeH><pig!sJ\Td$XMC
l`8?P.6PaHb^gL3&d0D.M6ugmhd7b4*PWaU^^Rf+bLY>Zr"O=mMs)6eouQ),)4(<mX#q[kl!
/p,Tq:7e+ilcs%%Dn@Aa0;2$Vh0<MA]A4h;cla%<qB2sC#J`tgCcR2)tlm8MCL;%be4J2Hi)]A
9MnT2.<V!P/nUYEG:H(.CB'HEU%\8W-gbA23S$Pc,Zds/I'E)dY^\Q(M[h@4f2HGcdiGEV`^
ciqF`_/?nTaP,f/BT:HiGqoL<BfVcrnBQcCD6n.V8?e@.Uj\ZpSLN-JRC;AdSG=r7Y.Tj58r
m(aZY8/"3`lCU]A`B1hJ:R9`$4)@9*&0&A3i\24/9Xan6I0hdKH<A*C]A[&&-lB/.9:\:u'h:?
G]A-ai:(%_sFuG3^"tfq=fD'<$B2&KRMJlTIbJeHFe1XV8)AqDOIs2GE?@_EhHB#gm<eB*@hI
U]A98SS(,bqRqjKoP+UMQ)=b<^tF($Lp#`WG$@2HP-fMQJ;<&a[*]A`lV?6UMd(d_C>FK".>gp
U6Nk^---aO37E@OK*`h3#*n+Lh8GnnR"CjD:9Jt5*_fnL%@`48`Sr+H-;,aKA#;VOZ0V!+[k
Kh9I_,0=A:PU*iZ/]A.K.cbh4';g9c+R.[dh`\cFRjX3=s*k05UiSN,oS^YWTI#&0e<#WWYRV
BPIphDaA-=g(r`gBQM1'[*cR6J4&TFotE,<EV([V/n,N=buJ.=H3q$>DBFQ#s&;^#nd&snJn
q6+UHtu8Qe;LH;:"7F$<1<!2nj8GeMPl8,?[8?G/XE"lj+9b[3]A5[r)ONj/U;hp+%fVT:7+o
cqt1m&'<n!T*'G_^Df'[U1BC'e,Q%2E#g9S?8^#Mp^u?r?`L!pJ0kaujC!XXp(M*'W$a!)E^
7[)I[!Y?;dXGr):,K5\CO[\9()&^q5(s`3ia[d4B^`u-s4WU&m-8a/&(e1)*mj[u.O\t>2GN
bUB;YUM)fsh?dANXoVu_Bgfk-NCe?0,82!]A0ti?L^nR:l]AMR-NcijM9*K_`^`#c]AN9.[U]Apu
Gdic!0DuIS3[j(_At.7qf(^<3X*BTd(p>6L=>7%X:Oa?JWcFIB\2/G!IY=J3di>.=pHc*LjA
TK[*L#+/FX`YAH?R((CGf&G1Fl]A7:p^+QeUNi%<5^Jl"<c1L[mmcACT:(.oC-RJO3BfFa3nd
9#s`2t[%=_S?iDZDUC^IFD2uZMp9XT5<EIMR8b8Z%p4oo+_oFRC="71=B*S[(rk#OF6P.YN4
ZN'`,4VOQXi*YaaFfJVDqqikXL_eq!p7DT/dt(le]AHX!$;[Wg4Qd%!eUsbuUJdFm6MDD0Fhg
(Y#<?3q:T7#\fX=o1V0#dM;'TA>T88Q4@`OR<oAQ7Z7'H@[U#k[iZkR,;DnZGd>e[%B2q^ue
-FDkC2dB_VJ.q3WQ]A-?sE>e.nI<7dG4U/GsPDR_4U*ptO$Wt$6a[mdFr7m\5mcA4gXZ=+JaL
u=#52&031tb6^4AhusS)6+k]AG?GJ#n^oq2VB^1L:&0P/ODj9H4N>_ockp<LWK.V*`H4D+4;t
`N&H1#f7a7K:G&r=bQ^A9.S&aQ[i*E>O"+sC@.Sj^QEYD?pG9Q,Ej$OOgkZ>cBIL\qYBX;f@
H9"'@lDIi5NpH=SStY!nOClX^EHKmlHM!IRY_5#WH=Q&SopOMhiqDn?Qtk6J.fIgC!ABgb=6
4"PP(#?EZ0pr(:5046TFEH`uQ_5BJ,,RV`RC==Su,J,R9@"JpAKPb0m[a7<[/Akn4:CD,Y*>
h&5'g4.;#Lo?!!Qa<-.?e=(Ra=.i,ZKp%s`FoRhDib>)\Xe>R3c?jj\C!L)uqRh)<.Qm4/0I
;EN"eHH$H,N"JcBgFCJ'q#JA`DFAe=Q*,o+JaYF?<fH($['G3uDV[EN?Ub`o0i/MZJ6F_Rk(
?&C!sj`tkV8G8%q+Fg"'emaBso.6-`/EX0`TMN%.W8S5)$;tu7'+;bS`Zap2`pa1)=,h!7O.
s%0m6<-,PrS29>pa9EMadKni-B]A.q<DJCr)p>NIe>a=XapD"+hHcgm)q%>LP62cS>1Du0%jR
'27+]A,_\Zf>0g5(sI&nA"Gr6-ZV;AX!5XtAc`q?]ARRFdO6;(!rjdYH]A1e'cNq4B5t4:W#kji
pHc(A3L<SX%h&F$"Ie6ISTX>1+.f+&57b?F.d^4a*k@Q.dWlrsjP"QP\l/pYc\CGY3[ob,!>
Q58,'GE7>)"4i^W&TZh'G<n9jRfa(&st7P3]AQ%%UNEpN,!c5Z@3OQ]AbNE#1OW04GJnEa0TuU
'`7a_B_'9LfE%nO-OpFV"!4kjS`W:ht_.+.)MN!3;4c-V<C,X1F;9#jAlBe0a:#$ZK3,3,1F
7O(o`$a7uWehVM?;q%tIUh.9CtP?7S]A&UPXb@D#@6h_5<AN6jh85EMX[_p8`.kTmHT#X^]AOJ
84AU=1JU\J=l*p/H")/]AQmEm_9^C"8\#8csOCk@P,KJrP]AKXlm@-EVBISaffum:CB1B<Vpp/
8!Q!H0_O)d?bqj"8`ATlH.:5$,uZj&FK:sbW\SiIN:rG?CZoTXAFSJMR%u$mlU1>/<W[[fl7
04qW9B)m8/"C\5]A`4eKO2aeN-Fle.ak\&g1YuM1-'kk6ZLio(VWk<[X9`*fV-_R:/1@t)aca
ZO#V=GQMGanpa\MK2Y"F32)S&,"TT0`.d;*j,/!rWTmt>p&8lL7$MPNfSMCl2Q<Sd2jWuS7`
IeA_h3%nS+l6!e+1)HkVi';=d:lWk2fn3_$C%LQf1ahW7*R2,F:f+W]A1R<_aQ>b[9Tg4clQ[
B%DdeJOFXjb;FhNlan4(=t@YHXo>lhY6lJsn"`$=@1b&q3Pj$`XPacnq#:eVtLL'JMOc2uid
2P:]An$Ig?Y-WSb-^M<kpE0H*7mg_5VPP2Q"qiocZ_U<M7b:/PEq2'G>3^$$gZQC)(2!^A/Pu
N$2T*QMrm.c4?e^H>IRO2dbBJB(XROPumfAcu4&QlIdcK'>.)!.]AKBtrIFg8Tt%"D6dI=IPJ
,R-r\DnqmmgGRoOTih`tQiN8I'PhS,#Ak9+7)=&jN-)ke:=/7g1b&8;4f+hKe*2j9GWM+[!N
1g)kmIV5q7XO,_MOVFYXh46E?/cM\(<,o)k'Kj5k^*G>U%G$gW/nGn\+eQC1egAF(/Hr>k8!
Z$qVou`^DXX#O-;AS>*+N>HTR:1Zuq=?TsDZF`NC(Y;h(;shMf>L=mU#iWTPguJA+gTQ"[-l
kf%\5J?L=M41EJNnMJ,:<d0OZL5RY$WW^h^p\U$<p&rC?ViDNE$\-N#Yrdjj_gm]Ak>E3/lgH
8rEC@J'.r]AJ5]AJj9b*$]AugU%"W#$ZeaOi@:1__]AK$@fEWFPuISB#dqrdpp:fCd'Srfm(-:WL
R)b`fr47."MZ:nU3JWnMF]AG%(p/%s@(7YA5#[`XH*=:Lm.[XNWhn&,PCdrP\C%I5*UV<i2U-
9GBuC^m.gQDu?`\'18ZS(>sh+BR.-5Y^I)Ds\;V%#+\L@Z+EZ8M7<!.%'(SqrpKr-R\>-b-C
@rPoXbkVH%-/=<=QHJ+4-=`GN:f>GelVLT2,bMLgpDf2HMfmrSHSm>[%H0qU\O]A5IbH(_\-i
.:`/nXiW6A@LrjGMl@#MORRcuHl0QtG)[7s#e[3'0q-e(MOu0#5,4]AUWMe7nq;Y)2P@:1G<,
.QsiU(6lquP:2:QP1.n92tR!+HYlB`oLCE[XT#9"sPUf_G1m1E70<&7U1=.f.Bei7;9[Yid)
_mI"a\@VGQ6T5Slf7<KaOY?h^"SQ1=R(%5JBc!stA[^s[=5Iih4qduV2%ZJbMLhufPYqtJi%
:U=D;DY1n5UA3nh^nedTA<IXBRtE>J!rl3C>+$*.h@A<h[lX^)J!pc7J_k]A<(ZcM8(G1X2S7
Tq2@ZP?N?Sf0d%[uGT&l>.Y&Y3`]Ak>5VhM8,p:-?N<E]ATfZ$n49,SJiIE'C+:VO7l7Q2'B9o
mQBM*[d)+BTfX>sTpOY$N`lD6=*Su*MZ?*AoY-mPo]A^oHB]A@Z(YRS85c:-t><SO$T<GU*Ogf
s!WP1A]AoR-l3,LH8DGl8:I`dgGKu1C0r3T'!h8.4K;?crXV/E7"o-FGRc38ZNUoC?-F%,al+
/G1Zp=qe4oH[k,_iL9@_+J$=+iB]A2r+E^5*`ea5Z.jg0B7gcIW"&j6S=[*Mus@=Ad*@5\ssg
'<GL$<="`GVi8`Run#t8h#sD_lm8h=%OVY\#XI$H]A'F*3!Y3MI=sHEk?`*G5%ng-nF!/SpP7
:#4(;G!9L%o3-Y;[:dC!;,<hc]AJr]A!'P]A#m=rH,K>L+5Vh,'r2s%jT<R.pEI[@ambD$<N8fg
nH&NJDfh']AmPEK[6]Ao$Ye(ei9Eu48)ca\2!rAs0<jn2B:?a#a<hN[HS\cU7'S"0+GMd+skEU
_hOfi_XWoNZ*%dn6I/-/cf%VSE/igT(A3':3B/F*$WmSg\54a`Kj&ni8tYhj)/_e_!5d"03[
c9A1crC71M30E(7H!D2"_=')k*WNe8[pm9r$?'PO>fSC^AG>Ce-K21P;>ugGL&WTlh<9ksD-
`\>.cGH)^KfSqo/Z:k*`spNiZU/u@nXN`gD&n%.9mW=_Bm9%>GN_$=@j6h26Vk-hgN2%_*GT
!V1k07@@$Vn@<#,]AUN/'s&`AB0%#N/sj']As_d4FO]A1lnX4XXIqP`%TdIsM^trN$06W;:>WT/
lULjB+^'mC%=s?PF'el\3VmiN_&M)mP'eRp2jn/64^K<58ZN@F!I8X")e5&KC$n3m:nq2=b@
Tp8AeTK+S8]ADX[6Vma"?)q,IA[o2l![)O9)U8&7(0`'Q0/B+jj5#;2=H2u7M/W9=?WtH0P9>
&\-pU2<7steN.YZG8seum8,Hlf4a4B0[P;Bt5)?g=g?NkeR`rHI0tfDX$"q>t6^IQ$XVQ*a5
/d"\<M@-7YEO5EIL"AkG(PAR,[/\sM)uh-0V*l`$pB<hi9iVh=`H]AE[I!,0*k/*1]AW4@Vrd_
]AUOTVj"5nN4JXOn*>m6`8m2"O3F`8\-n:F?ea/EntF09-]ABYb9R@UAOlYRD&SbO=*.S#QBm4
09qTp'J>89bR"4>K!efK27ra0,<fXl;A:b>-G(bN6[%+*4PD:7\0-[Gb2$$[psh[45q9FN"3
WQcPk&p0A=)#W&gHd=?X*!>.$m+Ts!3A1QW.H>=))]AlPsIG1gJ5QD8Oa&>+=e]A7\c->0,29V
SD:4DJDC=K%5S9@iB^^3?<G]Ac-0#*!S@utGkoK&a^^Mua;ZlgK.3(q#NFG8FtV#QI(cB>_;D
[ud7jcZ9IGX6\>FO5,ba^emHeEQni++8tBQrC>(]AROn0,ji%2K3KB66a`6.QcQBC#^bjWj,P
TE1lE%:lr:n8+We<0o5!T*P;GFn1#edBC%e.nmcn4X`_#f2Xh9M%+q#DNNb$ZQ:c%\FdSZ:Y
Xi3#u3^(X2g+#5fb9-t_!Eh_doc`bDJ8'@F_T_(=DKkU!?]A=<hK+V\P)RWRd(8=9<50I;c?F
'u_eP_Llr@l.dF,ee]A",lQ'<Pq,WjF&%3<BleZTD!=D3K^d8mSnku<H4O]AA+cc!R(4$?EkYu
um]ArgIgPOU`AGsP@,CV7(2*UE5c/>ZD(0_`+d30=nZ?&L&csb&Lo75D]AiuN4:)W;BXCg1lZj
6dHi]A6&leC;tVOhYTVl5*+$CQa6OLbXKLRqfJ\?SG>p=4dtg+dnXU[l$Y\%7jRobBM74u/g7
&k(N`?QgFTUIiS36"I5j:.Nhuplqi-'qe?dRdg(SZ)I6X9@i;qJ*<c.eujX[?7*Su-Yq`eU$
a_C%99n&dn"deb.p"(p:5cJJ>,d9NuaRj<P>Nn&le)BpMkjge_=jGgrkf9!1.9?W+H`P.hr_
klh\"+j1a>I1Cr*ajNO5mk(QaGH@JFu#*F>4]Ao(%;WEd.,^4[4p.J]Ad`9j&.A9K*RS":.DEE
R,2Vn<,.UYKIS$HS/K+/Gm@jT.O-59h!HD!ZR:j^mqIm[?Y^&V%[@:q0+&BTPe@&J=]A)a&fh
oW>*d)r"MWS4%7!PB:iaLKiuM/_*QFr1l<VDpb)r;q]AI_b3[IlI'&1i7>3^iTJAi@1(uG\sd
Vj]Ag>XA]AkAp:+c\"*C5?O<im<rC"mD:E%:,``rm%:F>!q+WOuM:]AC:**N&sX6;k)&iYQ<fG6
(M`/LRIX\lrtiqdA,e4YGVA-oX&c?C*8Bt#&TX`IqnLEN)]A5XUn)neb(_gTQ0)_^0bA]A7`.R
b@8FL<`^)r)F:s&Eu6,Q*%=BDRa15hc6d(K*N!?pnlN-WTVo*b"Nj`EdtuG@`]A2VTC,0mbNf
aTs__4GtfgAD#N2_o#,7n_4HuF1IEIIqp6?!a&BDW_Und6MJJGqcqHScn.DhRMW^O"dN!u7J
>bXMg:i1c$g:Kt9W@/Y7B]A&V,tiB:-Ye_r/@m8YK/9;#8-ta<M@FYSY/_[RLBuRASiA23K_-
%d9:V,^;YD3f)3*5NFdHP=\E>F6hT[u79&>nkRG$D.[=mLsNr(Oh':Yj%A3/@N!K*8F\]A![d
,mEc,q/rF0MNKs]A@tiL:l4ocu^D0a%!lqp%\SG:;Vl*Kc=rr@$bbf#@gSnfn%:iSL69X(t!Z
B43!8SMubsf(Z:uI').<(F_X6K3f$@L5=R5Qu((utsCX,eEPXH^9]A1X]Ag@%MnP++V]AIbccXh
JpLkFnMO8SuTgd9YjP,<ki75du_l\`P[.?.se.b<u\oLcfDsM'^m<RQ9of9`>,K$9t.Oc,t#
]AK:le$;=N<FDXkQrp(WT-7aki`u7QA@bc]Al)4/op)CJ@3J.(c@Q+$e)*;sm;`Ncq"BYcALMX
Ra;o9bQF-bUdWV@0gOG95_9LPF-'#H2.PO4`34^SCmYC^9tF3>W(+:L1:;r9rWGGHa@eZnP_
<)gs_:$'W2MZBbW96GC!,4K6Gl4_9-)$?qM0k.R5)JUMV/6<&Vlu<8i$NpfD.'c??&;*,*Qg
h9!4J-Wch"rOKj?005eGG+K'P!b^#H:n9VLG\6`Y9hq4HFr>`1isWs$\330+@oB\Rk+:2I%N
-O?ces@[@;3-@@f$0@S4SY:+:46*H\HigE<HN>`Dlq&pXVCuWj,Nc(F9LjnU/>%ao,fHB-XQ
\usHd]AUs_j-?=G/F6>B770B4qm'KB,?0OjAfb3?qfRX'F9"3D=;YP>J+",4BElQM6C;nK;BD
IJM=,+pMIjHslm3K+;nQlT`n5(#O]Aqu4angZt/b2qIRg'\)$Yo_pb\L-Kq8h*&?8D_ZH<G7X
!VZ^?2L\3'+3!U,/9gsKiHKqc05enkb%I0%dbU7=B'ZqpCDk^)*A.oF\9t)d'k,poBH-q!e\
<"JrY]A<4ZTuosDh$4+om$tri/\,F_chk/kh'fh]A2Es:+oDk#E3!jjnuO(rjar?4p'iklWL_>
K8@gFWF"GHug.AW:Vp,OW`@F-&nl'JPh2dD%,9c``Rqigkmnf;5B'rbeiSObK3?rC]AY0c>i%
)@@0^7JrSq_8*+b7T8T[1<HYc\2I?Q8900-i3mqflXBY?q)OMktNX:;fjEQS1.H<9h,sl%RX
fVS/k)6;qs64h`;__)]AC>D^lDWe]A)Ci:0gnNPg8?"QFDZu46R6H-=C[r+-Z<,Ro#X^^8[Q2U
a3*^'19%)Hm4Ac@P-':D!mm"PZQ.=[1Q/1-1VKuO>;=`Gf3MTs82n3MY@.Y(Z_)!O"6,q*>r
Qh\i+1Uj7QHrN_o6uD%)Etb-C's!Z0No-Om(aj662b&$fX_]A8@!0QKcnWt=br_;6DhR<68j3
&\7aAI1n/%&=QG'%O%]Ar4pqN*5M>\Sc6,9>mJ#r6TUUDPD+$$3nm1,jrqI'J0rjYd$mk]A<s1
p&89cKoinLBGe&[]A<*TG)^`(PQGs$#WBT?29k1JnV->Pe4ZY`73\(1\l,]AXLs)_+`!X$i?2J
2g!R`YQ<5[`Fab0Qm_%_>"EQ-h@-W*n@$akYp6GbaDeOpWn'cZQXd7'q*')!alj"`8!F8(Su
=5@Hq]A4ream>fbi'Arc/Nk)BCk!+4DW?!E"3R"_*\Pfd(i4=UIfFt(W?M^AM#OWm0l,D]AIg`
aE0Vs9$sS$%lH5oj/k06N7:idA!^Ri?oMa-]AZZ6^e%fXnm.:#l3jqKeaLEkLC:/?U;:C=t@P
;?QiO5pSQIQ4LbL_]A(O:E`Oc2(Y0GR0@dfNF.:NkP[3'p+EBtKeflqW]A.jP*\[uj!%cFtQk,
7/B59)Id',0NQFUIfctJ^rTuDiDU@)?[P+)1L<fmNfn7B6q+KpG[oB*QB.BUQRsTG7'qoFk0
PL@@O=7q4CR6=oRl\0uU\MC1Jo$Y:tP(F"H.,#,)3E&Mmk[#kJs'E;/lJouJlEBPRAJ]A^+qL
B(9+B&S@+pjYRLQ9P"OD,T`6Z_QMYq,(bYjpS&bL@S%MMC3\`sXC.<t.;P>Gh_nhk..@F%`l
mafZ^U%E$:64`\bOlOF;fN<ShJo"\`W1BXdUnJO\XIC54#_">,DTcIC%<*EUT#<mq5SRkU`f
bXMc'<[A?TE;9,-JL(@E4:l,[L,7Q'gFMX=7=(88%:t$O>04tiBK%,nsjXDD;P=-3(?UqVLP
G&-ke#ATp`OqB97nt)m1==@[)Y-uJ1-iDXbA3J#J/5M]A)jG(h/AGKHZWMsFG92@b_p5A/2En
+h^+M:80C=>e(Nu</c"&]A2hX1#(iQRR*&?2C8;O;^m02>*h6L72jl+%sOL@'iWc%+SGkRU5B
EDJ50!C1isMn$itK`p6%D&_FJ7MLH2kk=M<L#>+U2U!MVIT;b^4TR94!T.$.L;(6Y7(OKa%G
#(=!?sg6]A8Aj?>(EDO!`[6T,`m(J7aNhS^am$1m@lCaj#),;eucBT$GXUkU<r'M3UJcKh&b1
>VaR&r'K5_"1,O]AVkR]Ai\6h=:5(pm<4EHc_TO!UjN2YS0VrI(9&K2?V'e_6T8deHaU-!=gkG
N91%GE!\tQ0$Ll]Ab*fB#/0t+d$.oKe6H>B_m;+J\:!5B<]AW4M)9T]A,qoj7;k./UnU!*#I0J0
`c$G6;bN$>Ujf?K)U(%E'bbe"tq%I.;GR\fH&/a>>O!,)'8b0M-0>'%*3:l%5eX\]AOI6dgHm
lNuUt5p$9eIrPTo;.8KUTp'Wk%C+0j[hRZkA"EV[+5bfdnZHiWq3_r:7P%C\TE5SaS&$(TVS
F?so>I1cM]A'__V`I)G^WkNcC9Hua390ZOS@$7OoG@2_grh-QM&iK"S9<T3r:ZAjpQWJ\ghV^
[_,QM3Mu.#_qaS,po.ar9e(Nq<pp8DRI/)$d@jDe#M*c[4-BH>GPm:&-Fa\Y%>uEtY)itp>C
Btji&7@(qUjji7KBnuGjs3Zo.q+'6"\N;uk@hGG*1.4(]A=bdFgc8H6&5:k=QrbG)L8PpGNe=
,[N/gVs!G4jM.HT7a7HjJ-"9DeP-nW'^-<e^r+&9+Z:OY3!1$3k%-BIEFnip&1_nR%V_8^(@
NOYos)XQjn'f!8uBl_d)mF"ckBqhc\H2-cq4_2,+!!6TX;T&%pXA(TqFT0ITf]AdXqqJ/X\./
<>(_a[.=ikjHB'\7WZ$_q>RTL]AL-h"dHEQ+I>b(oFYY$OWfAG6^K*:LKR5GLn;sH]A)r!.dY,
bA+K1"GJrY.8)rg,M')P-''<Mtj^JZ^O_<2q%ahL:A\HCKLk3VQTK#-.gC&8!/c,/nLY,NT7
:0$HR5/cq.PlQ:$$n(^Uoct-fCRq_4tK37>-[)=dgYo(LK]AI/ZmtFRA!(:b[m#N;Za_2FQO9
/Y>S+('5OXa<W$8N.)bJ@=2%]A)ACT2U>:ethF[XEP;(.&tFNEg!EL#OVi"WFo9^kcSqWOFtN
cHTt.L<i;G,%l/(V2LfZCli7o#r&,@ObcGg8*"L9e8mRc,."WXjl%7Eg8X;dK+:3@E^R@+1_
f,^J2n)!$Q4)Y=""ZS/k,+fn7^n71V1X6&CAd6AsnK6-=f%.F'f6TRTOTHZnm[XOIXQG'k]AY
'60aT=mRa3?n-c:#<peTXoF)t5aZ^t9?Q@TgX2ks'B`r:+fh..m;[#bC!>Ri?0Ip\X@Ou)kc
?l1a._L7k6nqB'n[[=Me]AcEaPsocGG7ml6<IlWbKH)T1@@;Zc8'2_YG`EWJKWdNDTS*pKW@@
i9&-@@8X\C5$`$Pb,#BO5&Mk;m#O!?S?#r?Xnq3AZC0QW;G)c&QZf'$Ss1R<O?Zk$q+*$\_2
B:]AoDhX0>Z7JNTT?Bq!5"+*VgE(Qdq9guQ-N/(C,U(35LG)`/`jq`2a7'S)?hNC,0q&&B8?`
]AkoA,R!bVM?nd4M1R%d>:CKRM@JKYA4)$b>Bn6]AS/]A&&"EKU,*a`;eq<=l&S\d_N>;H"eg5*
.fb1),4K[BghW8D-*DPOoT#Dc2ZfWh1UR&U)R*ZW!-=WQlK&&!P1%)ZeDTTPdWs=\SVD`\4Y
Ag'O)rtB'+Z<7Mb:G6JbLTm[U.8H??1&RIT[^5YitbkS(&#j$K(358dPpp5;g9H5SA\c\B_>
_VfU2N5nr'FS88r:GquF,VSI8*-7"r<#O%%CU!*-)cCi84C9na>4e)+c)NTU]Ag^*@"6`@Ga@
eNJR^@:PDCpT8S`7<rS5ibl\i7WO;h6E6AH6nr)te2giDT)'f?63Y6&NB1POIS'6q"I0hgo>
XEoM&b-rW.o1fOY9`D-Dm'J#Eg/DFr:o]A@p\dK$$QSo?jlqSrQB0O;IK7sJ2KVIWVcRGr*2&
gV05P$GU/;707/?[FAccpbZE1h2eSBbSLY#:efi(VK$*A/m/tDF+"U#.`94['XX91^>38_m3
?MWe/.6pD;8g57'ipjR1h`-<Loa@.D_j00)XZ;c1njN^@rYNBN?D;n+O8`/(Xu173VE*G;rH
Hpl+Br$<X*,\d\>M7:ameXB>d(<(ES,A>KT\fcZ2AtM2gI4)u6ph60H27W:C=^54Wr4Ab[+@
dH]A<A>[C>KcXYQ,$N=-f@A$,;6M)p(4VM,)iC66A8!C(X!b59E[DK;+?/Bn_`[L7/`OBTl[,
J[.m!d-sfSVI;D[8GcAL7!PR1$3VVS\;3g3o5r`&HAdm`X`aB?Ig"lc+49aHB\?12O7E'*Up
e.Q=829EqD/ZdgV1:dV%"/jZ/!p$Z5E?;L3r1S]AW,TtVI29I^;<<oT(</a'_K7OeZB&;Bbea
%SUheKk:NF9L%!mTs<([c\D0;-R<iH1XU6?ZG5on^L]A?B_&-k@e1k;QaZc$QDI>]Ak@b?=('I
UD5@>p48&]Ap_#^:r9h639Gq&&Jaq"E\BZZq7Wgq"-\j7]AL*2nS*"#J'>-Te(/Y2u3pIpX&/]A
DoLd$eAaOq-+jFh?Of]A#[#<<E4s&/BFrAn"f_[<,)XgcFkC,UcX&2BhTHe*iEfp*7",mK?em
!37Ugq>dm^oMgm+T'Jm^o'2<bP&!fT(POG7&ohp]Au)>2ITB_2O6n\Mg.!!@l8m!6:k#(eKd(
GLgE":$K3OJM-s2#<,eWpe9(9VYT;2%38nQ0!6WEp+fb!B,D63]A\h7<V3LI2q$s5(D]Ab)4=j
&oMjCI2;QLUnN\9+Y@X\3pYl)87M@[C\OuVH)Ufr)ZpSF`,ebOSqAm</%"OI[:dLPoMp>rb!
3'W4l8N[,\#'Qt:<!PnddG^&CQpCq67)jii&mCT#-"^=.3R%d:+irG9BD)n8=!pI7i:UL:Jk
G*#M(%UAN!ADZUS^a_"m=\Ni"QNQ.#,t,k@!,VJg(\fKcp2M@^i"E59D=ZF?#N"YQk&uGB\*
_;%1.fYVi2GQDWa$fF3B1]A_X1V90<fgV3kY/2*X]AqnX='ii%.a7-NA'p_T`9CjY2aJ@"Ad<P
Re;i(:&>!!I^NF'n4nc1e=[mQdSKRcX?iDUg/LA/7WgO3/r;-[?ia.uo9bem*iu_:;QeP/fO
?OVHB==Cq"7%pp)hIAC<]A[I^4L<C53H1dCc/6dAPf"@:`I1E&NGoq[pHZQ%74n]A@Knc6Hra@
lSaBIQ%HsXA+MfksA@;0IrC,(Od3$is*F*2d2RLbCjB[(tnQD+";6Wj^0c"1eMBVsSnb=bG`
IhQ#r1-1[J1OQ[$kClCYc.F%m_na"q(W:)o,`(V+RFm1pkB^[GA<^O6Gq%KZJ7KJO)[ZCUB(
UL/LS&<a'&bZn2+7JQDMSL(9MJH0fQ'68gpk=NEM,MG_BX.3eQ4abj,raJ-]A=l+ABhk.>494
"h!n&kE_CmK-*=!d3J0l=jOu^Qq(@5A!h''Zi0s,E`cbC!U>%e.52WP(W_OTi9b>BDItr@4n
sX9*\I35C(gfOn0G/O#;qmL[@)#JFPf4]A]A[BdKHP#K'NQ\ak]AAsmP2V8B4sD2;QC8sR!#m>1
J]AqoX)>)O.02=VY&WAB+aS*MV.;ZO9(Q^"'FPDnF4sd-;oaJ0]AV"MMKBmf)l0Uc!YgpDjCu^
]AAI\;l<-#D-aPA_Is:mj@<"7Ok;VF]A-cQBkD6$ri@_XMgm-9;*(IO4sKpZuMqpd`&+!#gS\8
aiL+f<4a-;&-.3=SIVC<Z50s+!t=RmhY>3Iun1pW,lGpWDg,&H+Y1h=";7`,$14I.n5Jn'*Y
6i.n!?'<$C;D2[)Rkp;j9ZYT/]A4d7t-C16`NGJ,Yc\bB&'_6tg!Xo5[<gNqeYV[*+Ui?us9"
.>q)s)+P,>>LS_0?QE:f(Oef\UW(U)O\>F=aK&B4`-ddYqXSb.'KoSV0s#-Gos\i>8<3WW>H
O*2J1X4m.o>edlruU(+8^0(n!M=o&=r+/k5HLepNH%7Q5e1<3,^l-@LL!6It,VDBZ]A5S&!u^
mR,dYEN(,8h>;5J3G7nrX#gO?7(9W":K3c5h<IZn$CcOQda>-U'8P?2p`EHNrQhIM>`@t+^h
ad]AC.#FN'-?-aA&lgQG#E^+p:uL!mS2Kq-Ko'?457CiOKj(kjkmA[;8L*\'-,Quk>XDX,?$N
lcUKflJVam3RIuV:>952FqgEe?1451CSe4@J<B2q+571DQkH?fgeE%I"N>F71G*#_05/;W;b
[OG<fI(&)WV^h2iPFEBg4)9(4Z[PUU;^EN/F9<O[T&X#R/CUOmiX\ME6D%j>_i.s8qERV0u#
l[O6OCoN0q6:GFI)Il'PA9kNs'7&Fr<,%qXTVV%gqf)(E;tGGLXTS)1-er1#:%Z0iXgZ=td[
ebeWh#n/BIlPHFmEiUG`51p4nFc@cIa5a!kbj4CAZ$MghG!)5*%=D4K/)E2Xk,rQdbVLA"kX
S##JSNNa\J=O"pNFGV2PGJE,Q=/r\cttVRfpPFm_jR@,\*$CPi*pi?aW5ZB9W>B9aJ.h\nfp
,0Di'.+1\<E%Fg%=*jTOOeVLo%?K?,4PCeEV3%;@uQl:App<qLIV/@eT0:Vd?qt9ME%IV[CF
21uo8V4R<JS1Io@aQ3D@3ERfds1Gc3nO<@RV^j&"5\5cGP\@"hV@GhmiM83YGegKi3JOXq5$
KF^/M*e:]AGKchm[Dg0/qp^4*Ie8ijaL)J+q[tirA62\c:9r0RS.V]A^eSQ4!U5Z<irr;IF`f5
W`>sXrPmai)h6mdr/JJ]A2u^hSp`"_CDu>U0nMgGsM@ZM)Pih[>ZA4r83hj>sNR"P(G?8"i#1
]A:^s)4LO%3PDhCkI*hDIrY^HfpUF'A)^Q(B~
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
<BoundsAttr x="0" y="0" width="960" height="468"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="468"/>
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
<Size width="960" height="468"/>
<tabFitAttr index="1" tabNameIndex="1"/>
</Widget>
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
<![CDATA[1257300,1905000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[0,4572000,4572000,9144000,9144000,5715000,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[ID]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="0" s="1">
<O>
<![CDATA[项目编号]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="0" s="1">
<O>
<![CDATA[报备日期]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="0" s="1">
<O>
<![CDATA[项目主名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="0" s="1">
<O>
<![CDATA[项目副名]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="0" s="1">
<O>
<![CDATA[业主名称]]></O>
<PrivilegeControl/>
<Expand>
<cellSortAttr/>
</Expand>
</C>
<C c="0" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ID"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<CellInsertPolicy/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="1" r="1" s="3">
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
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<CellInsertPolicy/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="2" r="1" s="0">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="Billdate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<CellInsertPolicy/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="3" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ProjectName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<CellInsertPolicy/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="4" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ProjectSubname"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<CellInsertPolicy/>
<Expand dir="0">
<cellSortAttr/>
</Expand>
</C>
<C c="5" r="1" s="0">
<O t="DSColumn">
<Attributes dsName="ds1已发" columnName="ProprietorName"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
<cellSortAttr/>
</O>
<PrivilegeControl/>
<CellPageAttr/>
<CellOptionalAttrHolder>
<DesensitizationAttr class="com.fr.report.cell.cellattr.CellDesensitizationAttr">
<Desensitizations desensitizeScope="0"/>
</DesensitizationAttr>
</CellOptionalAttrHolder>
<CellInsertPolicy/>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="simhei" style="1" size="88"/>
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
</StyleList>
<DesensitizationList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
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
<BoundsAttr x="0" y="0" width="960" height="468"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="468"/>
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
<Size width="960" height="468"/>
<tabFitAttr index="2" tabNameIndex="2"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<carouselAttr isCarousel="false" carouselInterval="1.8"/>
</Center>
</InnerWidget>
<BoundsAttr x="0" y="36" width="960" height="504"/>
</Widget>
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
<BoundsAttr x="670" y="2" width="80" height="31"/>
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
<BoundsAttr x="540" y="2" width="80" height="31"/>
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
<BoundsAttr x="375" y="2" width="100" height="31"/>
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
<BoundsAttr x="275" y="2" width="100" height="31"/>
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
<BoundsAttr x="145" y="2" width="100" height="31"/>
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
<BoundsAttr x="45" y="2" width="100" height="31"/>
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
<BoundsAttr x="0" y="0" width="960" height="36"/>
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
<StrategyConfig dsName="ds1待办" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
<StrategyConfig dsName="ds1已办" enabled="false" useGlobal="true" shouldMonitor="true" shouldEvolve="false" scheduleBySchema="false" timeToLive="1500000" timeToIdle="86400000" updateInterval="1500000" terminalTime="" updateSchema="0 0 8 * * ? *" activeInitiation="false"/>
</StrategyConfigs>
</StrategyConfigsAttr>
<NewFormMarkAttr class="com.fr.form.fit.NewFormMarkAttr">
<NewFormMarkAttr type="1" tabPreload="true" fontScaleFrontAdjust="true" supportColRowAutoAdjust="true" supportExportTransparency="false" supportFrontEndDataCache="false"/>
</NewFormMarkAttr>
<TemplateCloudInfoAttrMark class="com.fr.plugin.cloud.analytics.attr.TemplateInfoAttrMark" pluginID="com.fr.plugin.cloud.analytics.v11" plugin-version="3.17.0.20230612">
<TemplateCloudInfoAttrMark createTime="1686213877575"/>
</TemplateCloudInfoAttrMark>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="9c356418-7090-4127-a175-146a6684b399"/>
</TemplateIdAttMark>
</Form>
