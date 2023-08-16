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
<WidgetAttr invisible="true" aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
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
<![CDATA[1257300,952500,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
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
<C c="1" r="1" s="3">
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
<C c="2" r="1" s="4">
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
<C c="5" r="1" s="4">
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
<FRFont name="simhei" style="0" size="96"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
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
<![CDATA[mCIRBdV8J?CbsPmW]A;YGY2r?H>NROj@uFBbB(!3(P#<n\mYYDak/KBGQ>:'2M+WY_MEn")j+
<[,+sJHR$6m"\$3EG^n+X$CH-^d9Hd?u`#nGSMS.Ff^4:g'Bgt04Z*aX#2hS%t-%L!#ih&"A
/]AqV1h1J%MMh"IfH:4(<lIhWTuFYB8-oL^Rod^Q^am[`Y476Q#\9[Wld6'1Ldh.+cRZZNO6*
R:h0qX&+#j"Ed27X?k7g2sZF/flg3^Fu144?Sp(%.\r8,h>*U^%c=9mnsW?KPj^fNi*6gA^;
-g*B_-qMZ'cH]A81JH>p$KJ`n_JXH#CBEI6C7uLBOl3mmYmV'%)KBcgY`72[R+a`3q/Fn?.+m
W.dn^k8JE"*;>O*..GESfK5KRiqlBP-)\2"T`4R's2Yq`BlF^B*:g/*<IhqWEmpLP"'&fmTM
KbNB]Agt0Rg";j@.W(:^J%.7\]AjiX$GU;Zq<Y`)V1o=n!-Mi$@.W&[Hg[T:rqV%\Ah7Lb5K"?
b'4d=n`)-=j=Q6-JN[Khpe'V?S#!P,-@)if]AL:i8[N4$:*amebGod*]A:N:>(MhnP[I$K2@';
B:EC%",a%P*.P+'XGQ;%AZNf(m5^%QpP%`a#q/2*^uIb<?@np,ki`08:[]A"#i[T5>#;cr_g]A
*0"I=WQ7iIXip)EVCGoLFLZP1?g:6@'1/g&[CE7EQLA[WR5"F#lrUr>_^fF+XV&_JlX>St>M
rB?_pjeWU224-1Q%1L(R@KRQ*;H,Z4OkgcsK9PFjS>9>eXFbf_$CN`G2Fb98)-)F_@n,;5ie
kZa+sJ3UaA26/g=P"dFY,2hXD8,>]A2M^F7R0Q2!_e;9VbmZ:#;Rt`P4WHpL0'*:'%Q3!]AA1O
?hC6<ai-?[;.A'6`31VU*gK!0^3GWbO&=,;":4)U\6)c?J=XlnWR/f-83UJ'0/op%qhk6s6`
6e2I^UiuN7stI(4218ql?s20Ksn>`)tb$fe:4!r>$iER'3B_L\`*hk@_='7TFVm,_1=XPM>8
rQ16nS?0)N]A@/KL^7-]A3OMC>=E9NR>cBriAK`HsP,lmI+Mj88aKf'79/]AO=9p($,j$ImEmiI
iuh]Aj/[LXhHn_*22q-L#CKCtRQ)qCH'dBSJ8s+d!o0ohO/&Aqt\gu6<mV,2<A,%Fp(pPRnAQ
$_MUb#_J:97%Uo@@WKoa1\WJO66j1#ff04+e>5l0slu?hTJ.lD!i:7,\ihV5o`WTR*-DAi,J
\F'0:LP@l#309,!2g!J`rs0PiH2]A3JY'aR;A=O)Ht+2pgCeBZFUknSSD.%SXbkHXHR&mjRC.
L>op]AQBQn:JI<AG[#AHTL6ZcX&"gKO35\6M&5n_@=pPbf)"@pOr+^a$tBU%r#aKOF,\tsUgY
u3GF/N)W>utq#fG<"H,l]ALZTe;#P>bsro?`lrWDc[1/)QNckrQ1#=Jj/-77h.jWFs6Xe-\?,
$?'S9kOt\9"]AV'V*sO3]A/?iKV;OOS5;OQ`!]ADI_;]Al?^Rhh'b88f%KI."c5cPp:PO:<-DLGI
8>06->.&ONhn$df9j*[8g6h"fGV'AA<)1'ZQ?m9"UQl+kFBE9?h=M%#Y)M\O!b&jGeg03S:'
k,Q)D:8S]AYD2R&B>S!$IW-VC*[G]AS.,Z!lO7QO\L-m:`eTq)=;`9UqD^)C>!U-bOrUf2D=rV
8rnR..nTLLOB,W4bSo:7'425Bs)1@=2kk=:GsNmDg7pL##!hmEscZT3XN'S?^5HA^(oaGL_*
I?aCJsW^A.3lI_f"t>[>32+D@GJETs!ib_1i1[\N@HIW6`IKQkKdG,A-LR.2e1.6ZW1'0j3p
Z>O0B165t(B5kshjflRFDlZ+h`o9]A$^JAO]A1n;*B>u<aqB^lUT&JkPefhE53W9T)bK6aX_h+
GKINP9m)+Qq5W9ks,4l:A\5ddYdhhV7"OA/Sa0/@)lPXt^njSU[2:[8scDVMa7bkOUu*Z.!@
+P$e.AN#->5K'O@R#0lsUdrTI%2f?_\Oe;oGT[\Of8.7cg*7^E[^R_7cb[P,=e0tDG;+.Aa0
kbl<DjjP<`QNhh@CW&GV`7J^S5$i5:0[E6/2i>HJ2uf*SB'sZJ1p3PM!q0S;"RD!'!-/*i]AN
L0^YqOe=kK?L7JF)/WX$j.RaBrdA"J>Sp&Rq&1aKU<;u/K_l'+`#6Jr>opLTfSFo3^Dn3*NT
3]AGr%G]AGHOjX^f/R%07BpR'N/D[!L'eQ.A>LBI,1N0=-:nA&,_^k4D&BnZdaf5gEdPC;3=mX
!UI5H;qsC$XJTMNBH2Qe=07Nsj<`-\8Vr2j`f&<X[8M/P]A0?hJWK*`E&H""TQq_GVE1Bl0`,
/+J>D^`fUn<&*9V5_([0kfiV%1.O?aViR"#od_op-lr^lpjPt,N=6$uRrC!n&ce:mGAM60dT
06@-D&1*_4-mc5o*deQ)Sabu!T,t=H"D*RVXZf4'T!hFSeE3$]A(S]Ah:2:2`7N+BEG`UXu>5>
e?QJDk\_-AeD+\;X0^jHcE#A>;NRlLZX50I!AAoc2&Td\#-af7?7X`cA`b_=VCg)-I+?Tq"t
4YnVQrg4BJqc&Qi*.h#]AjJ")s^BRGJhi8^KS--0+ge7'P$o,jF/M@@sE1DT2\:CM[3XFslbV
mn&r#P2)OLTUDm;UoUc^dl"D0+s]A-@,8!_EF/#]A8W%Ob,,^fibBF9Z8dtZ[I@0Td7=gB9IO#
/fZi;a?-5.,K"#aN,:lJS]AJ=?=I'ab72Q>o*KIQZ+@4-UHNYtJ9%co3a:Ir@9j;CP['ZHZu(
_gQ$9^)Nb[t>`UNGsu+8DX"!Fk'?P.8bK*f5&5Qr:T-%GSq&MB?`1A!$?<CH5CnTQi=1je:V
\ZD<k`cn[r;c9FRaN3Y8PKVMB):)f_(g<U`?G^iRj0M)W.)jbjqX9OR6$Jm\Tc:46aQEsB`J
j]A!.8;Q6A,>Q:Ltm2]A)5=PEAo0+`,dJi<[h/+k;q\9'fV*WaC-YYDtG-BO/U6sZ-EKYg#RoF
/;9C4rm'+'cbh^>9>,OY.,E!L=mYKhcB$WNE3/FhbeNI/G7+?Sec.T\=>>`ja<j8(T27_RBk
m"`[/^dOG+`f`Y+Aot<EhqHNOaT'MUq.tYQ>R%gJanSS"l^Wa?+qbt1OqMDWOGT/F^Cndgr\
k08sOgD4hbT)_.kJLI(VV!lQKJl)9la5*\<Vf2X"b.-!Vu>%kC1dM(]AV`C4Y`;KFf=P-*KrN
MhHJO'`Yf+SZ%3BluVInT5KiP."HH[p5'dk_\j2-oBW9)ekR!FN'q%%=3lKLnp?F#aAOIu+B
%&Zd;a<u)*h3O]A?h+Jq(=W73Kr14jJEaMJ^djLaW@?C*]AlO//mq6ZKkjSe.O7NesB6G2:5ag
/3+&2g0MURUQ8V&.qM3A$Zd>1rC\Wsg-:,">5OUr>q?pY$d).Em"sOJu0dF3n3;&^kLL5bS#
8am;mA)IF2&amqoWIj3akhd6@[m#2HRf+N#niRFR;M1\Vceirk^;p)QU4WgMKMkD(6`_4mNh
HrE8/:Y7*m[@ph&U(n%#UcE\LtWe>8+'Wrf;Nj=-6r$:o4eM*q_1Pq68_.!@,rt'JM7RB-Wn
/&d4K,4..&H*>r)c`jeP="Ub4??dIu<@WtGO-1#G>6ToJNIJ`4<'QfE;?&.#o:Z`PY?(EN4r
D7C3@^[0bA]A5!oSk0lC5)2t-\"TV9iM3t6Tb`ni0^c(?JlX<kGW7\@;!PjFM%[TWR?u2N;j]A
1(@s4.!pa5Se^n*Qj_\Dc:(N*iEJYC3OMJ0Hnc*-DMn>4&._&.c0ZOH>0#lVt_j46OroFnp;
e]A&+0[Chb^R!m\2Q4:0L7H!dBsmd]AaEm7k,@Ds%n+1[XeCk1hm0AG6(T7T&H+*Y.AAb&e=X`
"aU`FR-c.@HK`/-#KN$>8jsYa.7cH/=sDFg>["?dgcliFuWcJ2Xkg/\WQjGqjT',41F@()8<
[+fb"uBVXA'al__::X)rcZI<qr+]An8*Ueh4D$\j"n'lu>nG@;-`>HFopTrkZ?e,a@JhIKu#0
bp>dK5STR^Mpn<pTYc-<,;+$0bHf;nTl(s/hN=$+ZsiBtF$Z_qlj=m"@A)m3(^1u[Pp(MI)4
mgO7LTq\2O'nTKmU!6C`Y6(@\]A`(p9KLk",K#!"E(]A$#eIgMJhTI,`^<-#39H<dpi,K.$<):
ICR'unA99=2cOt^9Il2*4%7t*k*s\4Pm>'isp,81B22/*FP-[ZGO@SJ8It;M3Sf#^0[J7N5]A
L^fT4P&4CU"BYhYD#tX]A'D$in<23neA*`(]AhhFORULTjC#,me4hg[8WlpgjTYGN&)5P^F[`N
YspSX70XiCag%oc=K$BW#Z69bMiMCJVH#d;:YFa7CR@1K*]A(AGo*GM;mHr#C&k9CY)DhY$HA
lqOK4-3]A@a6iVLjc1b8dCDf/G9(sMO%S/Y-h;eeF//BAb\4>lfB_TLK]ACn[_35)bj89ol$OP
V>_DKp>V(OQ)b@Al>U-Cb&Jd]AgIep/V7FMhL,\E^$Re7.@T&L9IP>"<'eBT.66=n4F?9T]A;2
iK*de%COgi1Y@_a->s9oOe0JhQT$AZk9rlj\GIg\*&A[E?(pafqEojM/IVb1CT]AWC=V]A"anS
LXW`iHp)NiN-)a\$u*2q;*=ZI*5Atl*8-D2FE*O2tq7eAdeIoTZ+cVAa'$XU%`;[MmbW`2ij
A3d]ARugLL3i:-]A4((]A%.=\g"5%^E2)(:&EIFGs$e0RZc\dh]AViA.<?mcXo@rg=S[8Lkkg6Q4
[Kt.kOj5?2N,S@8-^]Ai_:3]AV:=!rrhjT9tiZ\]AODdjc2@1C),gs(CRZK@[Yrp/2DOZ@\s4FJ
6[Nl^=DVYcX0FkM)2MbNeFEdo,uO<^EFtTlbNsg,SJR<Oa1h!M#R?V$&^*`n,_#g6"U+'pVf
jQSI#5+D`8d6u-)L(lU7XNBNs0'=$\oVTV/!lAS&*)c!_/NM*Nu`66j1qh(QU3?NlHAZ1olp
ijOOaF62RXm[Ofi#&8t88p@</E,-Ua9@,K2#DTi+4M$9:r,ha_++?(A<5uujl_b?3FlliGY/
Mq8BZ?`2=>?^*<!41;oainAQkM/Xj^#BAlZ%3BBknR8WJ&XSdD2LeGn,sqo!,KrU3\cjhXs9
pGQ?_h?/9ic[Tmg6Fq[;Zq.MpY,qQ)CC0c$NTtqNc7Fme6FiMnRK'/B+Ma\3l+>sVqi6-IU!
77#5^\B)R]AnZWTU\1Z4ah1i'J#^k?QKiCn'N\i9E(gh461Gdo'Vr+g8(e[L/1E[T8fnX`CfL
qr;DJ!UAFoJ]Ae4.g_nt!&#nh'pS4TZ?e?,mCR<_3([-,mIop1@t+(`UKj\Du,loUlMTnNAHH
1d_&QiD4;Uio.&@?>X0PtF@Jc=smhA'n.s&3SgbD=A[eh0+37Pd\<f"1X[Vbcb8kY!Ip,(h7
2j)iICj??_;:8E;-%'X_SDNW'I<Y92Z]AZeO)+"tV@C)i&PPom?Er?@rt!BM8]Ami!`Dm/.?Rg
V9\`:Mo^j1>nG`p1B"DGKY'Z+,_\Q"$q]A-3">^oZ;K\mMG-.kGZXY&5^=L.?9Kg(ES%M@XG8
>0'.PF$iS>Nr/,V*>iB;"d:h4tM\aja:WXaB9hH3Q-MU\#Q7V^#MR]Ag/.1C]AJd(:i?6B;"Ln
kSRqF**r:)sI<8BIo<T^3#KQHnHc-HB%Ge8.4!u$AW.S438OE`t`V'AGR%$@gie>GrU@tfuI
d^lN8`j/c>"`_P5+bir(N1;rBc0mrk2'*IM#n(!0iK%[)!Xm[rU>Y&p"eC&lSXQ&4s1)S36_
>q]A"3@`#NPT+9\HjnLc,!og7bs799(&X`Us`cG5G3V3Shj@bc3O!X3:s4l^@*9e\;4SD>Jqc
l/;^b4Wrh;(Mhdo`BcFX-ApjW\)[YUTk84%cMiZ8T6PIGEBhU(K8`H<hljn2!a#:SQ0^2,&P
Z0QG8=sOGdK.Wk?F:_QBqLk^=l:.2&W:^8DlLjIktS*UKS4*[Et#3p*-!sYurU3oH[9<;0/;
X\\6?i+h[sSJ62?gWN\R;Y/9eXN);taeIs]A-oUrjuR#Mr_;/M\!.'dnO3NSt<b8$1dc*BDDk
!+cQq2HnPEi@kF."!2,rPuD17-7qD+r7F'D$</<(m?[^AI#ND3@Qr<rKGf?c?r[FU%rH#Q6R
l.3rA)fB907JA-5Uj2>Po.X_M5bc2]A'&Xf,_S$0j\rg(2?HSHqkB&>V0^NbQL/DO8s<[?>CR
Z<h)_r:2UtTC/rEZF'6<So:a'B6BMs+R"okM>$Z(nbia3]A3r+s<s/h):Gp/#c.C<eVbLt&h@
$hugoV<Vb5TD&_8J,_V_Y-G(=8(^>j5J,R-@\`f`>@U?OGV*YIJHHgebTFpH/ATJ;^\C_"a8
OA?is_([EN9/GKj*H0JJ<`pgS5J;i2jWT"VlS/kG64a^/l$0-ihdJH#C-@f6&i\EY4p%:5iF
A#;BEZ#iI;2EIX1o+/1f4gSTR/Q/KHBiAhc<pJ;F8-sI@=rItn<s9G1?#dFXSG9+n%?3?Ut\
;YSLhN7Ub**-:FmTOJeqUrL=mDT*E$iObo+`*;XhF%@**(7jl%B.GRAr[c^nW4P<.&`iD="t
qFQT?SG$:Q^!eND^VM/]AX*6g3G4gq!DkFIAcgucQSuP<V&GqDoT""u"iic=,->O'=Pqp3Yh^
eh<]AXX90b)JW\B]Ao>g8>-t!C!YP@:#//gcAMk0*shp]A'>30%lE""\qnsp(8___SqhHbj$]Acg
7\LUI9Pa[OQ7YpE&j54/=s*PqkeYW70K?=HkJ7bK`J-G;m^]A/3[?-5Po>u$VF4Kr5&iViWn=
46^(!Flq\qtp.)N;CD/VuO4EcO>R%^<nS%>b>YU&/t9jHqpD]A@sn04IjZg)\a\#4YiAAL865
^+$&T?SVOMF<c)3M1^lk=@@&e.(s1\*^#4(GFl9d(GJ-r<>K5\*+_f7)A+WX[Q=.9dROj+X?
@E?:7;<(]AbTjA4:#pHFs`\;qe:\G+2M(6MULqn'Hr'a!I#j\Ki#Fm^7lfp1P]AiCN+\X5FM?K
2G-4pAcMFZa("'otdJ+g^6&7eTWNnC1)qF%Y_=$T-n-fPa7Tos2CHek4A$q?f=;XrP@(#P\j
J87Wg.a'0r$dWc'?l1!UAQWb7Y$I''cTY;%1HigrlAe`6b?lj[!?Dc2a_k-HU`P5S54It^U6
G&Q*/gBP5^g8;7%bbVaM6DhbGhQI-R/m^lhm`BD_(,pG!#qD\`,fH9#6%?#]AGUfQq/lG/?<"
g(LjY-D1p`l)83B.dg!Jg?&e;6^n%F2CgFb]AR.#?-W98knA:iX]A75i)&72>4iCWL;t^^lFfb
!F>osEp%6.Ju@Z;)i:r?(nh("#bRL>X]A8W*SmVWQOk<8l>]A(<1Nk3P%Xt@o&A^R'16rIHD&)
fJb>MkQ@?4m3U"4kKn2d=?E*T6N^KX,J?6r<!OZrDqCrmWiTR;g3505A6V6?<Ra7Zo9L?mm^
54ClC.8*5_]A-Ydpb%M)/*HZE(?Cb,^G&!0i"EEd-@cgfXg2Uj#QL3`V6O1fWA7XNkd-UB30q
W*"nH"V-D[0b\kX1Er$r2sln?KZ^X5g$s9ic'>(piKKYS#t<$dgH3qZD^2aO;SJTYc6EQi4"
aEbV>OV9e*GnU,"`<DgG;,)UoQ[;,6V>V\pA0bt+[7hQFJ%Ms1YT%jO[jgIR$Z8P1D\f9:dq
QEQ>HG--4KX^KEj=.;+HRq"N/,0+MZ'lu*qI-u;nWsJVp^=.Nf50&BeAaHV\^!%;G'>,2LIL
QhPj<*B\*mQD*I=%Zk97ta"i6.`2DEZB!lki_.+Ue__5QTEj<[^H/j=<R:i:o3'*mh)7e_gY
*D[6hNV;[/9]A"-s[?rI;"CXigB*]AF9`jBf&/[a]A8,7"t$V0=?`"iK-+=eIUl[#5b2faJ^Rr#
EErcW-:\ebtO<-0E/J9Kl[^jGh'o:WP]AmW&#$`h]A^;^.aL?$OYguLXbc`,]A5t^2"?Aqd8%"\
c?ZJhTtnOnC8;0)<n;<"Z6Ki]Aq.TIt^d:&fC$aJuGL8=s`>5V?eZa#PS:3>62&77ij"#CGtB
3e2,rO'$U'e?3JJG2<qJ/?u,#F4VZ2;;p\K;K-'2&tmO>TbjK"W0M<>M+>"YTf8'XnXp-IS/
._,h9*Q?2df.I3("i8\V40hiCQ6a=acu$)Y?,tB>B05\G<(Qi2h3!=DKYg?3?[[Dg/6-Z!Gd
"DJbB)9R=HR21;VaT"I7bCEK9E.SH5?=`JD8Ts7NK4BtRcGW-#\riK9,)t@m%Kludkgq\kMq
=MX:KZ?T.Y1tr!6@SQBd.o'<'S\fS-Pr3+C\Q1XMb8KZ-u/@T[HlO&UBJh3M9NW[YgJR^m*D
@AYDj<pnH/_aH[ss)Uglg^Pn"9g70d%X"nQkg^^RQuoEqR!d!/s<NI0I_;Kjq%,c2`0pg1Y)
BOd3:EQuFX;-uG:<X\A/&a$.HT-GOh)"4bIa5mQj5<A-l]Abq_FGuPnSK"rs8C)RcC&j^G\*H
l6M*/W!t5k9rV3G\1tP_9I7c)$FG9C+[ciU`S\'4&/EUlsTefG-L;E$2tCiJpdupCGEYC;</
T@>VIlK+]A"c:sqUjMC?U6-masj1`KMk[geQXBZ83We@mqll&<-*HBVa^`>#dP^^%4nfjsNkI
+Mkdak0Nadnp;`jbI-fnC4PaJ5_qDG]AdQ5^^t!^#opYi?N;8T9/GL_Y3+l8*R0g>r\fjm:8/
R)8Q]A=Od_uR:b\+\L7+G)P9),0OS>R-;TPL*V*UMnWLhh/n(<Z^n4JfU[^eWGh6dh'>TsI'N
(b4)7>-lho%P7Vh[>ZJrG0$Yt^F`*/X%)n2!*3fe'Bn(J$qL"^dJrP0Z/eFNU;[EL#"^EgE#
h-Oj/6lIMl+3T6Yo8`_I=H??S4RI1Juu]AC;p#?k*2NLqWu#l6r-8UTp,?#OtWN@bX`./)!8f
3ne@t'`A\PeGRD6;IN97d`#b]A9#lu\J`P%mS?4Y-<TTgl\J@DfC3#]AIXHm^>J^1Ak5>_<&f[
X-^r(G\Y_3k<HrZ'1*FP5(\S)7Yhq9FNN,]Arn@b7^+YaQ-5C^#2)5-/ij-g$tP/VOGf3\R:n
GKSe`,@(42LbSprd*3ab-T1'98q*P5CT^+o]A%LGi\Of?5_?266h%;R!_-p%?l(R1<QCi6u25
=3H5$bC\@U"#mB_pBH$u9p/XLUBoeC%S.:Raed'K(19\3DCd!"%FUhD$Ao*qI3&(0.>/+D4T
D8<J^h/VH?CP5BYk^[Gt^-\*9d4Ck<WofimtSI[`PrP@48'a7&Xo14rEGkUMt!ng-KOk9g.?
ep"s2CoJL?Ld=#CXgO;.M-c><4EgO!9DOZ)?klF4<qpbq?YTQZsDbr#N0T``f[dh'(g6]AE,q
nhW+Su#/l4<olhDm\1(%Tl]A1<[UTS,cRk#@DUEIYt51WH74g\`c@7ERSckIpD!_!rZp[TJ9T
O#3nik)XH5k2gL=Fhf(G6K6g%Eg%Mn0Q`HE#kR.p8R9#]A28o]A=o(AK(L?WJki'_MA#@`f:f?
!f#[,(]AolmGTaXW4C)!r-*er<9cQlhnkgPD,$F12*ses]AOmmR+j^dVaDdSJ.*H^gb^K.WLV_
/Tb`LOkBqE+=JiTO('O^JXe9aTB$[0stDCGSeF[X2E[H;"F2mPF%(ma0>nIsuN[i;=E*A>G.
7Nc4S52&#"qnJ,k*F9[KN9Pc07>%Ne"D2,Rbn0sds/J4pD_\R<A@48jk!1(@?SZ,!+bM3O\4
Z*7rfN-UKc,ou2U4M=?W+XZM%bS#eOeC(Dr"gkI0]A'#=6i@EdmMBi)a@NHEn<FpKN',:dh:C
/l'j[n/4t5+7Y&)^o@qF;fR*pCFA#J>?=bOMsK@AE2T.,E?eh=T/QHCfc2684Ih_e3=F>E.M
r4*:,M`qgQ87M.C./?1j_,*.Mku%nf?E;O'X%r(nC;iRF9f:51+-=_;J_,Hd9Dh[/YB.6UT5
iC]A$e'3]A`h?)XnRZ24gGK0+]A0K$V%;doSa^1QBPEdGiBN:`AFJ1E7@Y/cM$"m;iTP2WD]A"pF
=2jkH#-9!8JJq*k_]AZY"[4eH:\HdkJgUnQfL3iM"Z?\i7*NA,j='NssO"N1tXFQ,J*@an@;S
\s6MQuAVYfBJ)8#g_X*bV=CN0s.>pW0#'`8MmlZC606lOLY;(.**clWeiSDR^3>ZW&iFCUb`
l)(gf46@]AK9Kl@&<?N9($Vf94]A`[duTb8C")::;4t"pVkm;)5pM\;tX?3@W\Z[l+*5q[4P6p
2=Y\(_&NuEp2h"e[!nkAmYU&?3*7d_FHGbk1WD?KcXTG.)*H>Y@2V:ci!a,'r%r;aj?qjd"j
ko/(=OEK`bt!2o$ECO+jAOHA/iY1Y%Bq)pI814mAe*+SZ3Y'HI*8-$LMK/QnnpgC*BYber*6
!+=Z*\JRX9=8f[Ma8Y$\N(G(,_(`1c_p[RG&bF1QR..i%DCcikg7`m9%K8P9d'YUlrQK9^)7
A"D9`Mi`Nm>Yk_BnJbB5d=&0Z%#K+m@GRQT!Sfd(Ut"QL8L&N4RS9Y/B[!mZI#oHlX<RCG9O
.9&VM2-/r![L"/XDBVP6>3#]APW7WVNrX['YY&h1^]Ao)5;!nQ$mu1/Lg?RU<$%VjL&j9+L.26
B%6g[KDcKd>;F[00js"Yp&$\HNEs^cKEV.=c7]A'2(X/W%&!R]Af\7S1n4@%i?-M53-DS$_96g
$2*E]A'ONku!AD66qCh_A>qQXl/lk0RQ8;>HlX\dfX3"T>=Zja+(kMDR%[1EktjrPPQrdGE4>
*iBT%=nYF9T:kOonO>@<1jq@?dp_nXg9XA>@QONZ]A[J[$sH/bY</LEM9broA*Aa&(`<b0_>6
T-IAh4%.n_[OJU3.h8.fT\*_&(T-:m_$'IpK>Gb[pT@-F#u3!I4[T6ZRL0pY2*r*O(^Vr:ja
lVhd/-PN6-#U3Y4?H8,c"YA$!i&T1=mG$/n+t/g:,/:@MH/PX$9u*9lA=F&PF81_JatXq-R?
#]AI#<"(=#AfLi?SBAWq[lr\U;c514^5HTM;DC=Yi<G;&DX4"+([#/8,L\UQFojed0*h*!rJW
I</]A"(uG*1l'l!8OGo"sZnSYOW_;_Gg7>D)h3%NNk'Z1WpDZ'"PU,V9eOkcga#0,F]AF:p/'<
/O9ag.]AuFI@_=.GlEJErC<.`'k56gu9+F+8t9`&H#j9:E7pFK[#m(V2nF+i0sf5_U7^kBT3d
.AM;*EIbBf"fW9D/AcjJ?pQEJY&<sk=24e,DI*sT9W/=XTC=N-9\GD0jOTS_CHG?Yqck@Z9]A
<?Bf#&"W@Zs&?rNYZr\WKgig[p)e+5@U`pah6&FI-9:5NXlr,KabC)-!?gX:=#k!SA/de@p_
WB-TWVgh?0HTtYJgq']Ale6)508QSF/@a=ru'LR^L@,'FZSE]Angg,Z"Q(M!JI3>$I*hDN:OY8
6t3an1)&!S#OGk+Teh-L7\YMZ:=,?mn!Q8W#KC=?_"E`MTCnj/-F!6LXI0F;spA>geKX1SI`
dF212]AKRQ%UC>IYTCQBKo96[h]AAdho,hqcXVWHd7%SUmlpoW:L1O="mjat_h$1ZS6u9YIWsD
W^Zik>(fcPqZ:S'1[]AQ$/8sUZl#\6TMgJFG,7?A,F9D;N`>7I>\hQC+R^]A0D2-H`!^'KAdM4
9?iT=t7jN(r-Q+biS2:KF@6Y-pD61aiuPD%jhg"KC3\t*b$O;RG>-DR3_X&_;+o%culhSaWG
3,2Ko%')&ki1p7k*NrbYUmT&H5(E-[7uj=?Q?8_J;_DUEdI$Zo`(3OQq<D07>0psN7l*J^GB
3G:hr=ucgS6t;P$;47GStd,5g_`E4CROZEESPp!%(r\h1.gYcpb6->(a&c\QP4.;m7e7k*"k
"pH+T!:]A43dPRK6T*!BZNdJF^$qKpVJSJ(m.YC2fs#VOtp5*9?uhO=1Fh#ldXp677TM2n%L$
:gp*#TdU4h0<qs*M*P@^GRhH2/2/#b0Admr,;KFI?ngNjI3H'5:P-An7$N.AL-QG%l-ng`r1
.7TRT^A[L7nFIj0RF5Q/jKibE(`VH*'CUMG!6hd:!1_4S+6T:s?)JdDA>!-q%XUu#f[aPrFo
H,2YnLTNUE)=!nLTM9p&L,-&lS1kjAEM<#I`*NCNIBlYlqSgR<DT>1r19)=pgf^d]ABDaZ7F(
""f+f<$>5kF\0)"/W92OL]ARa1;=\(lr\7qVp.%/9biNKP.7%jIqn0N3i9+CFYj1ojM%AM<+N
?_=o,Pnil1cs32=L+JBq,lg?!0N)nZfM\(ZIJ"OQX<+!m?"2'i@)cElZIn:NbgDsSE%!j)BZ
$&3DQ^+F8&Tg0#@re*?HJgJYPt3nI6/]A@:C<"!B_T:?67kjqfWT_)_LC67#n8@cDqR;YGpsj
#[>%@_/;!e(]A3c)O.k0Ha<`UMjN>m^qJ<&>5;;cHS<Iat*5Mh8h7\j,ZhrkKWN"+T5>r..*%
#QDL\p]AH$(&,^uCnGfum?++>Am_URgh0tiFr,ptggY%>1J)0ob~
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
<![CDATA[1257300,952500,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
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
<C c="2" r="1" s="4">
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
<C c="3" r="1" s="5">
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
<C c="4" r="1" s="5">
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
<C c="5" r="1" s="4">
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
<FRFont name="simhei" style="0" size="96"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
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
<![CDATA[m<FCbPA0nHY,eWr&R"?eoM\^M#_\XH'\8O!d\J;tO\S:M,_9&`V8W=/:h^80%7Q)+SlgLc8.
ZpJ!b<I/Oq8gg&4f?4idTeRba^oUba^J!Aod"(BARpsa`Ut:I9lUEd*pf>I]Apat)&X=fo=pp
2-mQ&3,lLpHZ<Oogd<GNG1,8jqo4Lj+8hFXNms/O/P6Uq(2VZ(\*mVKBlSk6\T"giQIsSl]Af
jDFWN^!78c@b]A:6')&[dsgN.^.63c[Em\Y5Po6TKC\>,#7n7Kaa*E'q8;g%<^S1mB]A^[#Fj+
8F$.LD74m+ne#cC^j&Ttt\>$IM6[C]A!qbI-rRA7XO,(tGd*48&PO$!4NDm%[o!h-[8uS,`&.
ipb.kVcEl_$)'H^'*]A%IT.i7aDn/7i&fR7`B[p,?Z6`I6G2]Ai_njsB77DSUYU7L>R<>up'QY
P_qmF6'XLbM?_=FI-P04EQbI3Ss+3&Dgf9<,SB7NB5ZT!`<WG:/"MXQABKR#9pO+H4HE:#7X
\+sb(;INu:k4p-q_K-i!TeqE@8V([.MC2JM'ElLJ?Bu<@r05]AZu1("=(>]A;*l&Ef20aYZ6eI
,-!RO_PBZhS?CpZhb:e&=l\\V43aTb!FN<Y4=rL&mU;,,We#[4kj>FOkY%&l::PuJAUP+<5S
?1CEak*`??E;CSAkj"Ti4hO2K-9C-NNmng5&mWc&X*\Be9PQd+L^ULjSf3k&):ZZ4J)a"g5P
/h+.d)V#Obn:Zef=_'A>lGAjPbO"I$[esEe^]AnViL4t-Z_O7U"d37r7kZ5[QMhOl>@m3#;/9
&;91h,j1?g,^;HC0e7j[3pVO)I9pk?%H^']Aa4)=;R/KLr4>N-7GP[iA,Dq+=g\Q#=!k9!7G4
g_r08q(d>Ugn^bjP[79WQDj=%`^G3=LY#.PjZZe#s@jW+,G)(d[R[8!u_KA1aNpc#3IT^E+4
NM;Z,#'0#%Nn5d3-<j%T.ftcUm'AWpCGM+08-4*IU*=WMq&gudIK`9`([Eq*tdb_,'=(-2m_
S:j6W*=;l_H#/c67\Q1">_LZQ'8MK-9sI]AAqofb'9hn]A]A+eSVdN^!\ud8&T+IJ=_LObAo;,H
S0dtdl>fQc.uHik]AbKLUY%l"Z5ZrOjoc91-f?-/<pTS&q7LX&U%a4>fmbf==o0>0V7Z4i<@X
>7;BjhsI*[.6td7q37/ihPe)u<12r9:RO-FT3'93DmW5YBH/Khi2d#YST:c-+YT(eRH@2CEr
hrq!k29:D)n`gqU9KnV\VBq@ko$Va>c'M`Sri2U/Yq$*";b!G]A"=RX1<DWaplL(S(/6\d^nN
Yg=r.Hp=NhOQ#SCF,\/nb:/XY>:Wa)\X2B0-!q@RUS`CV2p$>iQD@"R(`;:%1*>(_\aF!,>t
`jnjf?'qc)KX`k*TVr(>*T^f'".Y17r66*+FS,WrhX@>8^lg33(qX:HEHFsh(gA3'tdHhtAm
1BbdF2s>sW2=MCCnk5;L.]A`_6bjr&)P2U4h"@qra^FR3Z#?gNa&JrA;.j6^#df8,<l[b?<Hu
N$rrU#B=+jmH?363AP6k%TL6R4'lLC#eppIp&u\S%=t!#LYGDa?d]A!?=<+o=[,73(\:k51<A
04/hE2kq$PjrsTXf!o4jh2;YM4s'3,l@usjge<tZ)`5&NO="F>PgT-jq9Bij=M_S&qE`r@h/
rj&b2<q<e:4&OJFCGPhXh:m91W,=(6a_>OZ1EUn?L)0?ma^'&)E^Ldbg:Fd02^ZJ;b<L$QB4
7fq71oNM7&J>?ZKZI)C$2LE\of;lpMr)VHpJVP`V)$<j6\$@p!0'kfP167.8(#GcJ@^_kI[+
]A7AWuf[R\;/o9uT]As_KgomFZ\9IO9^%s"n63leVg0o$LHXD[pq>F([.8$<t2O)DkZAfdSC&$
V<Yb6]AUVdDIMU*1FQLE*V%()N;$qWYR,[<XCTcgd*]Au'fm0co)).Db##Y*<YYaqb@"E8n9Y=
RA:rlFS4ubg-s,Tt!Gm%hQ(ueIo\dSRV%?+Og!jeZgf"F8=+/P<A,LV$.RA,F>RF3+:CtOuo
gQAk(uP9&kN/VY/j+L%8h49!rZg26l9!W2Db!nTj=KpdY?G['EZ$XW@kO:0?J,nJ*7peR'Q/
<>[;+4%3UW[R$OH?Jl71b7^dJmFA6[ZT<4Q>jQ`4lCEK@UnI>26qIJ&CbM0;Xgb!G?WhShu,
7X3adde$I[O;ZgK9YAoo9m!:<GdUWQI[>lKcC7\IHU,e:ZrN["F_u`4@Z<!`WSh:A@EaBhVh
NKfPe++8HBFLJ\)bp>oXi`'::'atjJsYuYbtP75,>4r>FN8mHXM5IS"R:raJb.lZ\L`;2lfY
V1-+U&]AFe::S4)p[`@ZNK\LG8u=X^c,dsBk8(DPi_M)7h)fNE^7d9L*ka:i+gp8jsihV?)"2
lpEBdVnc"]A3sio!G.0&Gs^?SY6unT=]Aeu+qW45OfaO]Aa>_3\YZ$oR="$/=KTZr[18TK+f)#D
5;pJ,[laP6C2rCX('"XVd^66@%o3SmK`0A*%'_E.1;+pc7no[-4W;dA@=(9J2A:;dgr^c8L_
+'Qj/b7Scp-YTmbZ4+TOaFRJ.g6t)k';d&dlpTDd`PlSPU&t\)VnrgMm_4T+E4UrrUN]AlGE7
U,(>AN**MIb&H<%!_Q_d!4nrm![:]AjS>2UsN)EFGK@3&$O21rK[X"!BD>L\pU1gno!n$^mp@
@;^^%>?>:ol;0]AMO-^hk?!Sc!Xnaqb[)TV-eXfY4#JkMt+e(oR]A051=g)Cf&2M<8XS/^J4CS
l9V$fr4q.$=TG?eDDD:2`j^eqCJ]A76RsrF4u_IcKet)cNBdJtF0aujDWf4f_79hu8/lFZ'qa
QgIpi[5UN$E"L[MK#jD-*CYBL.OmK&"K#Tii2>k$8t6_oZ:MD+a,m@(p8_0k^@o_-(8$H3cY
@+KZ1)DVVu195Op^T6U,Tldg9KZ->t^Ii`UGkhGj`j1<7c..dUF>/]Ah>/Y`(<r_"A8/]A]Ap.S
rJ"j?D67.]A8\-<I0/u#Uk:k`%Af7BjPMc>)\b7N3$nhmp=""OD+mBiMXjlX,k=\;p#G[Oc&j
;]AkJ.JKO`cON&#&e3_,+SWBt)X^mV<.Vo"Mp0f:2d,pX]A32@PJ&lml[7h=MYM*\K_5YE'4'A
Sd_FPn_^Fdr5/Bq8^'`+h99R@89)@KNEs9W]APJ;5g),=hnoqp@G$rTOFOHpmB;\#UFNN@4Du
:eZ\G3k9'DJBY7J1E&dC(BHhtP/-GIbfq"WqKd0sR"_6ePan)q7I6VfWhI>,LD=e?I&FT.%f
nF#"A6f@8.-=U2(qe74ImQ6O_1paqim"VZA>[CclZ'4K]Adm?PGn)EO9M_Xne)m9m*:7KUc,;
rHFc>>TAG-^9S33qQ+$%<7(/+gV\&L_;d5;H4FB!Oq4pTNa2fHY:0]AM)J9/oPb/(*?]Ac>A4;
h(gkq)0#%oF%`f[$#aM)Vof1UE-H$J`U$j*%+?nJ*g/,U-4R?ern1/0:I1*\,CFC1`9:Aqh(
Dl3L!!/EC*gkcjCHS<1j7i?#i'.)78uaDJ7`\Ku*ReLg$pJ@?m\Ag_Bqss<J^=qInSWr[8+Z
G+7TGCo#,Z5JQtp8u48,3]AIS#*=nLjJQ);i*o!H7=0oLYu1;q;c6RfPV%`Xj>4nqDR_s.N,R
gR!onN;s.#]A9$NQG!kZ/O$c4['Bcuk5jAh\7OcF7ks>2G1]ArXHAhWfR;nb43(sB`dFB)KB/@
m6'<eEROIcdn"51TX-#RlmCPoB5X=OPV`5K/At=TOLo5t<\k'^/O:4a$2a8U<:#cM>TX93>"
F/>K+,4lsSf471P(>,-'\NI)_6LOr-]ArDMTr2_2>=<ojuU*lo__H:#V6!8/ZbMl0>RIfk1T:
W1KPe+-,grc1.Go)*=jeW6o1#CJ_O9)j(4r&Y(d)p!/Dg/0lApgFZU^eQ\P*$SP^'-Z''<+)
W#cK%f9&5`q@eb-2D2o$ApUkT]A$AhJa]A2*p(E9.<"(%GUXhchWb*\@MPL=]AV/f#8J:45$):R
kl(F1$'U1=E]Atj2[&?IqZ<-?mgVO0seq<f#.U(2RhD+u!46pSPZCd4dhJ#3MIW'3YGFrc_>c
]AtbD25r6a*@MMj+[\;@UkLL\i7H:?%\A&<etgY7aQEap*26WR!H4=o072\Ss\sTG=C_MB@9]A
op]AlE8@$SL8X8H6bF<1:>Y+I4t9UPl(Sf&=_W:d\5J-[:.\5b71kH0d#/'@+jnC==_8oFr'm
>beHJ##n4;R&ZL$W2\Qd1u)_f\0,V"5Qt'1&_@1r#.[H?_d'u(3^C!H7h0)A1?,Fjt@3?NV)
_D^>DB5H#c#_NP]A:P;u-\*B`L%MdjP46O?G*X5S_X(m(NYL\dVi)1Xk[)p+.\'U#)O=l%C!L
'G?U$pWRp\.+tQ'i@NN$Eg9Lm(H-4a.`j^:oX6BqNlf,bf[5V`L7S#Q6S0Kqe+IK/:h.,201
?+rhZ?^`,3hWq,!bEf&#h_X[eW,-*^)Kd0A&$p./*f\kZtH!S]AD3\pb;<N*+IXTAHs,:EU[Z
)a,7<kT2CNg9O<P.>n;;\W^D&U00QdZrD`+o27Od8>U:1bbeA9,D52i82G`#r1r/NCqS(gR\
?7Lf06$GPY"\tE)W8gf0pG<hG*eUDCE=\eH<6]AGnZ)m'4sdbA;ub3!]AkmP1.:\:LGe(;a#hM
,3]A!Tl&qch%b>pnHXmQGm+AC_;q;XU3*,VO0iHs@TdqCH-Fm2I-Z9B^(r$1tD;`qds[Cjfdq
jAdP:jn8X0H#PdRZ@Af,r]A)@eBm[\dba,tKO.*\5C=I3k#LWI`h$9er.j5*t<<W:/QJ+8T\j
lHcGhQ&FY5H[<=HkG[+6kWV\j%6EP50HS?7S%@T5,*l?s#IXI.`B/dN`Tk2E&u4_Hk3Dr[FR
us5</edCkD`L#4A\%5O(raQn(?qIK78j@^4!W#T`SPJ&>kcF0oF^,M<krhediWN(mcV>77Ve
,5Wq:$p)O-6;cU0<;M3:TZUgr'O<84nR/94cgk,p92IH)FURpon_G+o`emef)WQ8J*Ulq[e!
=+6k4>r'04OqY'm*W/r^lA!',)fo@Sua1jT"eOVH"37$TJ)K;r)lPO-t<CjIU[aJ^\<@=laR
-agP2/)c4s-4tl`N=n^HG_O$rK@E2.+^t4.^f0Mr#ru@+EXMrI91D\,K5DKm1$sHX./3,pjM
-U-;:E,i,Iqu$:+uA'(u+![dmn(uY8N'P4q(%u8'HC_-Llj*pSW7KPVq`l!7.GO]A8.D-:*S*
)AqifIkTDrOBLi<*EQqr7BV.qpa<tU;Gng]AFc-G4[lL1#6ZBs&5`WWj!GH."<e]A6puBY<jq)
nfR0>>grC#3C$A]A82P+E=s.oP_SD-e^F4-V<mhl/nNd#1?rHN>.g6EO"B.;<i"ORY/<,`S4g
Be.3gfJM4oK-"@!M?/UiST?VCC*__]Aa.dg`EL/EcMpb4tIKn,3*L5/gorVOL9e[fKgXaVOKf
"--sq"7H?'.%]AO%[=b)"jb9OdOe/EgVKak,%u7&j7qOYI#=C>7\nKBNl#1%*m]Ak,(k\k+BF2
uF(QTOk^OF?Q*mfW:MO!)+l2Za0="H4op3i1SqXW9L.g:oj.@jH*uUo2l,9(,.M$n`1lH;`I
5IP=.fLmGuu1n/6g1[NuU>`2nNp'd<K!YqjmA2JJ^Xq\m'Y0nTkBBG^A$!R>)o*"`F:uPb/1
Y-XDjNahVrt:I&D43"L3>eGamQ?hTAaA<WORQ<$1L%k]A'pG=e-Q'SCb<qib"ob$N&E*1J`Hc
*YG,#k9k1OEHjR2;^i!=GmCUd))pHjRVZH/-L=j6OS)*+Pg3Nmf'_62H@oZ?3r,(c>MOY2EB
T<#6r*Y_V0QrON\M",J#KRbQ90S>sUN71B/=@WT8WUorsb5Zmbl3-`djU64*<Q]ACG=2ofYqU
49D7Eo3-X,f^A:K3%$a[OsRr&Z>ZY1P(j<B.J!_9Z8i)*2s`>bG`;Ql7O=@]A4Pn.*q\m>,(6
tP\C*\N6VVZa/mT;7-Y8j,f%cX+[u:QcQ>0&Ta/I%PDXc`oRqig'g4SGc1!$N5S\4G$\`^PA
+Q0c@H^*WqHVu!h*r*CjEhO;?r.X?CkT%N)4r;^8!%XVNp3)7fcKr7O35$oc@[sS'?)=*+oM
F[-Q[rb;]AK3lXs\Q%X$q<YAZT6=PON[u&YTEL^]A2?()*Fd;6M\nG"6DUW9s[c'p>gebgrDkR
A`s&f_m6C1#V08e=k&56KZ&*\:J0INa\M(fVXJQpYIN*=Ll:YlR1>X8B%fXNC%.lcPn6+c6<
n9#.`u9R*lsmt876rg4QS+1XaY^6r%mV_HO,C=r;OnfF(G`C'LrnO_jP%AIWram*E<RHcUuI
=aF+:uHj2&Y]A>15[<Q#$#@iegm94<.nQLMpgMU801gZ)lGrZ-m/j!8_\DA<_#52Fn]Ap]A9l$"
6s3o['p0_`M)?Pq1-.WEE$hkgG$eJ)&$2GiKuUY3$`"5Lm9%:UjfF4lob6FFNt9!nD3s"'m2
Jir./nR2"^_d5QtKsf\IoQ905siH4jpi+q7H,LkYUn.QHT$$Z8082S42h1Tl6'8VK,/rUa3s
)<Heech8[_G3sOQ=t%k\m\+*bT*?H?]As4Hes6D24l3%tB)7>L"4tPES`-8gm?"Y@bH=HU`EP
K7$I(sq=U&OY"XO@-ZEpmM4Y>lT/U09W!890-\ZfX>'kdU66<Xhh#>Zt=sbK7i$jte4_Z(?A
$I^'&WYnNL\m"41ee*qQ&E,FU'b;UA<N(qOqqt9Gn\F-#iRLN'#T7"-T2]A90T]AIkqXF,45.g
6mD8ANF9ND,mRN\3Wfh6hs?q(R.#;?S$3^0pd.n,RO$1oa$dhT\lV(f$]A%_,`oK!L@TR67M$
's:"p_@S4CC'0nU%3KN5Q_SGn0TIH2Yj9_FIKT@V;Fm]ATe`o),GkFgkS1kJR9f/hV]AE-\o#R
8YE32&e(UA&;MMMAXfJrnL:_VAn[h?Gb]A#I!=S!hP9c$^=X/NbXlMrklK0YF%l2ZdkZc%'Pp
I7Np>D-(g=O(nKC>E03a9D!2$gu%IVOUAZd<[+1-@M*b6ONe2@..rDWq.l[R*"c%74Ud,-Hl
26sPF=]A+*/F-(+OA7t1Lq$+nGbM(.=?W.'j'NX/rg!4FV0BC1J2,IW:Ya!]A@39K\:$1TaS.)
c+dKF^ZW_"Nb&a2R*e+%7@7>`piPunYhPSWDHiM6pE\KL"Wk]A;=oSjRK(Ual6.nlghEi#2N[
EVIpUdr<:PCG<g$l%d.Wn7h-^r0m@PamlHa@M9V/%W-O1e^;1jtI?/F53YN.ml>W%[-k)[/8
:4$.j2V-%A$1C9\SJDB!9h'Gqg3pt7"Nf=32jcP]Ara]A7rSHe(nV9D),8QL._=TT!JaSuDG`,
rKtPo=eY=WWbof[mf='MiXYn57h8J`K"@]A3]A0q6!joMGd$D5gV,DaHt5A!+<WR"c8Z6&d>?a
)`60J[PX);e<+3)aH&sat`U6bYU[,)j32c0$s87UL:=<TZ:H0bh!,SOC/(*M$ebhu'*dm:Z+
4"rN8p:b'%DB`S7:j`=)l>@5N^g<p9,sCO_Y[c?*6SDoM[.qSjK*8fgGCT"$]A'qGSOTQ[V*E
M%1f"3pc3)(f1f%%[NAD(XFPcM"Ll-8E:$@^/8*CYSW+rp\3g/r<kD9+^N6!GdX(?mb@QP5X
4;&5CRcMI57F)tm,mmb'M!H5f]ATA)eI:[)@UX?2UZJAiB2'\1c(b$6nJMJjpB;59^B`RT3T>
H<]A!5-;=J:Y<ZZl[/7flcqCUJsn]Aj:eoubD`TbS@KVP%[Z"XP6,;Q">XB&Ef@/[Z@?QGLOA.
e-Q<PY4Yn$IfNNoaM/]A8l<oVjl"l%"_$1Y4VmDdNrZuhh1gF8DASkjY*gjq`?6g$lt%T9rLW
d]Ab>;8iJ1WF^@%D+*s(bsLsST;UXMSNK"-Rk[F&?C\FG3:/gaJKrMe"GZ)CMAL"Wnc[`Ac1k
!CfTfaEV28Q)1Zf1sm=goNqeo"HgD<?p\Z)/":7W$6MK\)6PM[JhSSF!">'oea,2b90NAPJ=
=4eGK7(_uYgkkmLM]AAnt?P!2p^5H.XU(]A3i'lO[q@8W"Sm@*:A7F'M=FC!D1,,&K>@u@d@nS
&f#`,'Rk9NI+2LmF+Dos;8XL9/Gag6TR0N/3b;h?iQ9KA7tEOLoeni%JEo:Et?1_jt[hg"Mh
H&_f47K$2gbG3V%<8n1Zd+@P;&-#RUN>;%"p2-ab/=><6k*O<5l\.NUS`*\IjiuajDUhE@L?
#th":5)keS5p(jSJCS,'[MiW'W%YT=H-T:_q$WCFNmR-h^nCH(,^$Or8mmq(CL:pSf&RBbLg
HIA-t-/:"3"iJ1GAJ)*EbS/^SW3M9^a0FSu".MK9YE4n*['JZ5o6<8u(3'Be1"!PS`'4lQ4K
7.#5k1.P(uZST1?-mPCAs5HGOO+lB$c*=Rc_Dbq->Pc9/L2Tk5LPhc?Tb8`1j*gGNgK6H.C8
FDQUHTarm<p"W7"c%/IltKNo.Zh%3GG2>gFZ$83nZ1>M^?K3PmYfmk%6[\+m3joK2D%L<X$.
)[c:9t(;[Y>"iAP24\cjT\!c=J!h/(sd`^Jk&D.\Z;ToCV_7Ij(aHss1:3T:Ad3U5E:(eps>
><3*/iui&g;n0(pq*E>JA@sh91bJpVN0f#ZP)5;*^V'H8IE*A*m\V@QFsXB)"Ga**4nM7k1;
bd/J<1n@"?%KnZjF"n2A5R>(eiPc;Rb4fiRX9dJSi96&)U4ftGCfm.Hbb$jl(@VhV:^=HXoa
e.WhDM57k2<kYsJeCna>+ZaGhA;gmABlP?ueOrQg0c#&.R!JeXTB8*XC`[1k*?Po8$^l4uBB
pH$`rHJ>O(AEu_OF=\;H<3JXmp1JY3nl"fb^nbe/^JBBZX/0ON,`?ec7?C/r(68D[\L0*2PX
e9\@F]Ai:7K+9T*6!H##[HVf.U#'^_2n;^Y5%SC-[<F`LQ%!'ZH>1&f9^.oF-&o5DS,l9rk[[
oec'O[-p-Y61jHJuVc9Yoc"B8qjTdN?ikk/bQYcH@-Mj`FZ\RNVdKqdD?Q;WVR2)QC;Wf5Nu
i9Oa?HYp8ZPM?_+@=o'@5gfb"Jge6:EWjMo18Koc(AE:;BFQ]A>R-/2p"Qp!6@Mj[#p?]AXB;p
HRQ`a>H__mF*LW"\!(@8qI1ZN-Z-F<,_9LXYUDWHAl7E2.PWO=LfuDc]A$EAd9seE<U^rY_$3
16b>08L7YR0<irIUd@QiM6pV)WRPRPOs;(!?*0GT#K6VmjZSC,:[[T:7Df>V44O/l(A5A,3c
a[@.3RpX!^jK2)_;<X819ZL7I9nX>^4MIYa+0PNpIa,0(@(br7k%&]A&-oSj7H(hJhi'ZY>f`
'h]A7Il,<3(8+3(C/?r"3to51d]A8Q2P_3=bDTeDqS@4JJ%[[-AOs\?BOh*jWP\9-FG1[nAT]AV
3\YtGP*_&q,q%6b$)MjFg39^2a!BP8+bVb@YYB,0<R**rW2YApk,an>=!nkCCbKt<$QlT/eA
_Fm7!S+Xq7eYpJ_jrfLdE`qR`IE2h+\mTbp]AumpAc9sO$"BpDT#HQiDTil&lKR-6.YWSdXQq
IbjpDrnt;3miS-sDGU7;B`+RmXeJko:k9`84(PG+W0]AGUscAhCQt@Dm0`O4<>t8$Q\6Ngi>R
FVO0LEX>U:lBE@HZ;n^^@-Z36bmDc#C]AO,V*\jX1^XW%@QeAIAFUEZXER@CITQqjHf^);A3;
%[(jgh6J4_H*Yg\?cC.^tN`_m]A,aBlputIH-)[r'?oseIL3:.NpVf!q9'6+<Ukhq1=:?`)ok
s7/W?aXQ-b!Q?uFpiZ6?>a%uB1j<N(p]A6Ua3.Zl\&V53bh[[Di;Q)8#mIN_s%nZ=CQ1I<u<F
HDM08+'T46l0=d@C4"+>2K4#I%<+)C$Z!!k,</G.d3r^rlY0SnPR;YDrO&a=l:G0^1i>uX2D
gGVjL!I-[kn:rhf)J+p'2D'+_,n+E2q;eTcm"Vq"1_+;+kkl:VjT(hQ\j+3\i^WAt7WKJUZp
>OPPXI-^hnrYq_F3;iu.%oHIq80OS#6=$)b\P\Fi#Q$g,Mh!t&+9ss\r+\$_T:#BgbaDtBn;
H6B&N&)KnPM!fBkk=@3[;+HK/ka(6<M5-cf":X6L_s`UAXk0ONVM!VA8>Zr!5!oEm8#"`X%a
Y0]AC#'58a#1cGFeENGs"7?L04B2%GWql16Cp3h!nJ/r3Pn(^p(B)Gn&8XhG1\3f5,E1YJo,D
'+Qf+*Re'.YGq%[D5HV9GG]A,\*2M9)R%.BTQN-a0&CpVXlPtC6m+=Qc@P(NbD@!Y'8+g5(1U
3Kt^bf0L$>_6QDiONLYu[dTEu&]A4\-6R`rl0I[__ACV.)Fe5FsN.'1Z&33/Z+`q<t:"-<S3s
\S@7DhTYfOR*eI<O!bT*LO<?,&G\80i5.uKA'`)bOk_1T=X+E\q^DGn9@1gC51S.j$e$eMO?
3<'4A5OrMf2>l^Hnm7JY^]AjP`D4!um1V;sPaj'\+kQlP&t[i,=KFcF0+.Ntaa-d=Y_)</B.\
0h$9i$[D;(^'Q<CWO</j_4#"5d>3d<VR>7L3hSu?bdK4@Hi9ZU;m6`ZcOkR_Qm8P8\FR;"u'
q#h=NcVBk(F!(kh1=#0u1i_Z*FfCN%g4=#.("kPVhE5'0UHH6+gV)Kk'@/gbb"Wj?^aSj8j=
l<_nQ1?;;^h_i+0oAOA*#'_p<ra:&T:)eIF5\Ka+/R=Kr''a;$Zo%83aS`frUP+&G,_0LS82
cSC@_i;\$HD%oFehYL?4W*$b$\"<XWo%$o17*6%/?=sY#;S$/IQNuQLR2:BGjhcpiXkE5k(D
hd<NZ87+bDUts:@'\.E?u9iW%#2*-gWc_h8Y7Rq(-_Xcgfiec>'Cr[)YHM^Mt7'pEME(Z$eH
YFqdB26+"'[JZ#SS3Yr2A0q8i$,=m.>U@Q%;,bcj?6Z)i+W=SsXaf,*e3I<"HkEIReF(>i2_
;kcL3<Us)Sf?R'I:b1!0Fr:+FBWAY\GoSH`*-K9WdqTEqpmu%$V)B&UO!b"q-<r:+T)f`TK"
RR9g(kf.;[issIhfq)Q5c-=O^#0Z9S3QQ`S;Fq;%5`MfZI<f(F^u5ElMG(=G=/0#GI?aUZ(q
\8N5Q[!8)4"J@t5c?1kMG%UB4;XInk%d`'-_ntQh()F9d]AT6Y9!PW2u:q;Ec_md0Y<@tme*q
iMNJ#K$$/7jI<A\)(Yh.=!T=C@JonIF:=t1Aq(KF-.,f#AO0H<<V#g<'4@SfVM)(Y4]AEIMEE
[8?=X6mSD.S@2m:Orl%GLeJ678r<En]AiOL<&cA:cH]A`:^9nHq@lG`J*&$GMA[LA00tobTMr3
S\@]Aq;c'0Y*kQHu7n#.)@lo/cgO_fR:/&>kch/""1n^h?;Z&'db_J3m7/>tgQ-'p1/(]AUKG#
Sm5(YTPqbRsc)PMgQqTjN`D@3n`dQm)1!@KtgQ5"8W0@;ZngEG<!:#;gJLj,CN0F5Nd:D[G+
XR5ipJFpuZY!aPIe>UAaf+[g'5rgp>00MjLq=fkfjC""RmZtaK\YYAo?fTO.]AI\_!sX=Iu=U
Jadq/a,gN@>dnh+.`D$K_a^hm=*j(mq#b4f5Fp+T&I$jFlXh%/"goZ6uP.b+XT;cFIE.&rqu
tb*K7/Q-iSApOCQ-XPcd!P?5MtPnf$0@a9j_O_S(VNSbUMj+'Q/6NC`.d+?S>a9kTbmec92i
@0b3&CsrET75$TD+$t0.2:^,kbbs^*^=`\Lm]AgZE:VNrZ=umu;d1^5nN"4h$Tqm$oI@i()&,
GoeRTgdWY'MnkG'b[*Q^16*rN)<%[Fag\D0dsTBZ8_CHY1Q&/FIBhWE]AL8lS^]Au(=/da@qSs
lDNTV>A*ta8S!X%N_lnA^hgJaH;tuqkZu6B:Kd(:?_GdJ0[h?3RdDf@[[&R2I[PL^Qh9Y(tQ
ZbLQKB%K&[_M72'Yb1U9Dj817C=77nn[\(=flTOS$Qn"nf=2AF%G(=UgPeMKlfP':UaAb`"(
)lGOW/k<&UZJ3%[nhQ>%Ke,NBb*IU5Z:k#QS@ibfX%a1$NU&,^uCn-As.+8>qfi",a:5O\pW
^`W=RJ)L@9pf8ScYHe#C_p_?WAYbsikM4BAT"/n)IfT~
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
<WidgetAttr invisible="true" aspectRatioLocked="false" aspectRatioBackup="-1.0" description="">
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
<![CDATA[1257300,952500,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
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
<![CDATA[mC7F@deibkhK6&$1WqQ:XHR?Y*lg[F*)Dl!:75&GE@@a/)&sPiC/3E$Ss@H$9MJ@uW>mlX7Z
'/+-(tME:5F_AV9eW-?0c_']A'K?@s1,u*&"^2^]AO0"Aqq6>2?J+"9M&qjE[Vt%ed2RS(hqkj
2TS;=!J)mg6fa-[bn(Xb$]AO?9F.B\Va([b!?pB&t1X@E$sk\[6@(739a>^Z)=5N[\ZT)T;Hp
%WPp^&*$)_?KIIF7\kK0*1(q^Dg9,YC)U@(;0Ie9#baiTK\5r[V?4_&4bp!I1.<bRD]AO?(`W
.rScDK;9W7L1g/ja"IQVe"hnEm?=.J3]ADI6<Wihr5uC,q1L4#=OA`8Ap/H&TKXq`Z*_(7VA%
CE53R3%u?,VW&V\M@cN8Zd/PNXh:87R*F(kQp6M."(sg*c[3<%*\o8q0Y\*b1:FiuCjh:[X%
*p@QraUl^,dW]AYq"^1l,Idq\\Kl:iC*N6qn?;S[]A.&Ii"rMC`8[`ds7.!o^g7?]ARg&!"rrGD
??FdXNRI!CN!U?1:<2r6\Bc&]AI71WrdbK#%6`qBDA5/j:9='N8mc@tj#2R&A=9&*7tNC6b?m
RMNM+*l_uH+r"p0"d7qO!RhE[S[SCHdFs*_+bRj,6+Ddd+5NVF5"$_[7MeW7)k4qn/%J--M^
.6(E+G'gPsJ""ZKc:a]Ag(\hB'R'#IKZrB*!5/`!S0H4QscT-1]AV7P*'0b$OQFH=EqRbO,OG,
RY3.q8E-@@cBZ#ZE9]APtH4Gnn\8(Z;WAQ&u,;Icl#dP<)0p*c=C.[-K#J'p2guN1An+/f)BC
nNn/aPHAa+65l+D#+hUYZ`M(5'Jh&suH9ODOQ#mdB$?9_Oh*Uq=b.NNg^?8;A#k0P88H;$4I
Me?37DdWkRH^3t(c/k(,25dF1$gGCJV+IJ6FdDG&M'D>hG]AP91:UO0>\>M*oJ*L#'m-IdebX
S%ij-dT173"GH+X4:,_`-%JTGS@B_]Ah?]AXG@+gfM@R%R[-W8>LJpssU8,5'Kk@S0^hOkE^N]A
'>9?GJ6kN\JG^,gI@=[k&F0:G%g'Vo'WaQZcF5ag9]A]A&a8MP)0[HT=KpdD`Ce/Pt0(j@9"Z6
Cnp1#/)bbnWWgE?"kQtu5^>n)-2k#nK`9d9,[HEP><>j\Xia>="jZq\gS'\uNOHXkU,.!W!I
=@Y,K"l:/jt'3KVcgg[j)Es1D#mc87$U(cc]AWaG\.gdG]AL'JmEeO/lV\%t,T,\!gdB_*nh8Q
'E20<o>OEhMkr,=eE+e#=W*,)9VBeK&Bt+6SbSN>>DI`GKDM!KI&+^9%*9X00:63IPB1Q!^7
P`i62PpOs!oi+iKV7*)?l=<<Pm-]AC-hkU(L-e.;e;d<*V77+F,b?mSol"O-4UhM5dp7_&ei!
oZ@O/_'cK(;3&3>%N*s::cgjj$rYB(!d`_H&D2Tm-"M%f?G1J@$)\;;$qgFHstes6aYi#Ygj
!(=H``C;tW!&GTP!6iYuQY"\?Qm56IH-rn50,rQtLEsLAj6#Mck@sWX+LbRMkeG$o]A&eV%lp
'm+*:Hcso.3T/V/.b\9fUE<Kq5E3,d@LL`4'g28RcfU9,:(_!94eUHtgoJ-e9Isd'.Eg@BQ"
aRZ^;*6[)a;8`(m/JY`X#O<?1OTdqc>=(*HKm[]A'<LK>Z&RD.&NFJUmj52;1lbBJ-/Vg".<2
_=^*]AYXGEY/N0p>*:35KuO^]A*.B7G.G"KjkjV1#3+ECu2hT.5[_UTM2!t5^T!SlFS9U//W1$
S[Ka/-'epK2#VoS\dZ6kc\&H;fiK>oY7>SDU_JE3Beo+aDJ!_7\0@<P8QC.>fsP-G>Lo_-eU
Lh=G`?[N.\s,67_d8-b6N2JD*GHM'DSX1A0rX`t[h8"h@*BmU1'riL!j>[7P24)#"`mS7QkD
.UL+mGLp+;a^()HB=<+MRU>VsS6/'rGQWrIE?bDOWU49ZQZY]AQnS1]A_2Yqf^g>ms/<Y,`(6U
8*M_4HYe&<s9>AKRB9#HskuORH:T#]A^#j`oMf5M9oLmiZ-R=$/H1SjbD%?oL+#F^.+Q[#D6(
0aU?%uu>+:qW5dY'BP".4V_jE,c%<:/s>-4DBDk$s#o(36H%HZraud)Y2@G7]AqQJ<F5gLPI/
Rp2$k"1D`Cb<oF'I=#a<Sl?TJUL%Gb-D)j__PH+WBdLihEqqM<UjqD4bh`n"*;<(Hq"=rLBW
MNP0XTEdM<m)P+-`$@rMA7uoUH<t>*2l'2EAA"CA0U#uqg(_*$LLgbaTJ\NN4`'-br"_JnQ_
ViB/*6^P(:k60EKlOk==jX<.sg7h*$tI-"W1.`<%D;cF/gqpLdN_BUF0'e`#C;1gGK\"^0=Z
rQ5[&WQ0FerN*&cg17eHL7X\E)o&T!!3n@e!-5]AcEVrV'N`DibX!`B,[q%oI+;mo8A\_ZF;#
.Xk*q:s_Q\Nu+R)8h3(/e$%@LT!p)L5/5&_I;64J;fn_)Y#t;H_/=KXeh'j:$]ATP.5]AEV5E&
0;YgR!>;>>Y)$Z*d+B**Iq4,>RH3W;/[fD>O\K/Zn<:A6LDiQd^te/>B\Zc2kVTs]A4=jIJm2
"pXq]A1:kA?XY6%&+m5_4Y)9T5WYO2K_.YL79'K:&Sr;nr(po,q0e4j.E![+2@.B<X,q8aQk2
P(WOtn+:ZZZZ&0>?91D_g(!B(k;YfrUud%Vj.!l,=rV1e#>\G'("RSk-.BOdK>jZSWDDZFUg
sU/CT/%A<IANn=%*'dA:PFWCuqLp$-MF'd6bAd)qe*92=5e]AQ@>=?"eL+tUSpPPSlmm8Wp"8
12SI&Jga!(S5;VZ,g=Q$pPa!JlNb\+e_K:8B$/Am8H#p)]A0!d]Ag=i<S+<=RpI0Vk?p`oAP$M
0Gr)8r6hg5hh7N4T9m&BrCOL-khDh6[R27;pT$Kf,N$-q<f3[[E=U4NTXKe4^+342M7,_pAP
q4RXlc7UcM=rHsS1$S-fH>'[[lij?@\WjWjc(;'T_ht$[j-Z-X&>oF0lb^s*OfFt6eo<J>B1
g#[IliqP\)$LiX'8$hfH+\to]AE7)TMu5KV$uQhr_3'+7f)sYnPY[,nQS%O$rt'N^]A0\P#+^O
P'C:SkJ(O!K4"2KO2>QR;9(.M(OZ@&Wljn8GmeRl9kF^Id%m68eesP6?`U<$G_6nhH\a*I,q
m5V,XH>(GqTMQZ\lLU6pDs9jOG:)C7"?U.pVPU2q2./$nCS#G!*5AQr#G_:+lN:i':oS&We7
9<PSAFJ,#E^K\lO^3!"I%:H6ZEO]ArQc0mXr2qb.GrhY93n,h?"<eAFG7c$G1)cJ"'.q>Igof
U4E[lkf?q?cgf".4[J9Z$brCY-%Dn,[WNnHhb'5cP?R;=[%EtO%duR@NmAg^hc]AC$^,204q&
J+cB(G=fXXKAu19r_AX3Q\nI";okVOiK6LXpl6%N;^9`-kPh\^1:7Q]A%WJAu1Y=,K,=U.onc
J]AT-Pc4T9;sFT;a3&$i[EEXQdQBET!I-;:9`k*=M.EQt9DAPKMI__3@>_G%jR-!Vk@,IAE&Z
:EOTc2+gjCV=6[Xj93i5E`2KS\ApF'=Z_&$.PeT_foW2gb,\I[#EpQnY%IoI`/s%X]A?LX1DH
cslm9`oi9J8uL9?4ZB!M$I[Y<^\qZtGglK.!"70Zg=-Qqg*jOWh6*IXe!dmr4=l]AgP$#g*'V
57c+'OnIG"[1oc'Kf!`dA0-54>;Z-RVZ4q.Q2MC"Tl6=G9#pfpN2b$;YHmKEb&^R$>i--#Cd
*?9RC7J5;Z4kg+#iQG6,oB%W@#hT9!9bN3m"gH-/1Z$QW2&``Ust3WL=2F8IS4_$%+WnrcTG
(2WPO8&s6b5ALVZsj?pqs-7Aok;GQjSfCUB&:4mhKM(GdG2cf*VCfYgHp!-5NRPT3dO.iUfF
5b^:<hfaLZ)dqMSCctkLi7p"RE[a*2ji1Q\J/S'oo"`&k3l;@G=\L\o56P\eH2(=G?a=<F2#
Oj8Z-+Docp9fjo,(bkGYC$HaY]A'$aF[e.VQGip!W%D>%!K+"JEZ*nM[,#<#$btfpmlO'eMp,
rG.@lK@]AK2iBU0A:'O,_^*.5(:>eZq;'5;pH:,$[/j1'L6gSW<AMBJ2h)'gr]A,ulAPUlAi)F
Cq^*@apKW!AMicVb'e)Y*>g!bOu(,2IPlD0B>(M)N%^.2tEBWhh\P&Xnb_@&>_,S<V<0JD-E
^o:d:fk;?@g$.=)s3;R^@9)XZk/cWUJ29.J/@V5cE%@ZMB5#LYAhrR!o,(/0%4&jHQk@`"'T
P4TJ;d=d:p20AG:=6DDcYM@QICs3pOrFUQ0;m$Rnq,jcL[u;<5kCem^='BpV:'<:Wc7'%G.S
Sos+rC_^/D/oEs3.G8h/CZm[^nJEa'E1MtDS":uk=rY@!8DD1.`<Y8%C.<;?e*"(it$F$"LJ
oE9`YS]Ak=965Zgm'lC.+IIcuInZ#1SL.Y6kn36b(=>;b[OIm;"]AYf,oC;FquF8s1FU7U,GTG
U6+UMh#AjX-:=A/t;L+@NQOdj'bp4&u!XkugF3-En9J]Ai/*2;Jhu=7/lOU+n#+a;Zk3o5KiK
Q*k@]AQqZQ#,,W5LkZBX82<H\khpIh%>nP\n]A+o-4nL'D)jdB`[Z..m1SS$jeEBYD1E-\L]Ab/
hng@-!eOj<b\%e&+"ER,o7.XWZ6HtrN]A@1S'W#r\^@82Zm(r)`tN''=BiEDqmKCOjbXVkm4c
t22"TeH$Pc1[3N&;nWnJQc$/HtUG?+L+!s"^L+ic[P@e=-4q4BCD%f5>e-O4r\78?2k$%$/;
\A*$ELT=<0+_UZ%Q]A>)hoOEU@l%:@,j7ZlcoA(bIo""%<lRH=s`Ada10KVNGEJg\[m<@'W&X
'N\,;Tp%YD"L)HPHZd%K'Ea]A9c"SJquqLgbt>9)%H/gHg;"`DI9&)Nh1<]A"''C)=LFIMKLK<
Y&=9.'cm'!#:)?Ad,o'jd?RRs)m([>sV/Dkj9RJSlYOB:D@7+Bo:WYRO^gjXL&XdPm[78d.I
WT1Z?4=WNaIB\k%M#[b-REQ(/.Q8^IX^%bERfu>I1uRO.JoO46Wn2npG!,NIY/"4/&o:-$_#
Uq+V*B*1&I]A7,@lG=9;i"uduXDEiUT&Yc.D@6J2j\m5P3_BX["W"ikt1&6!=.3.3MMNFK]A)^
>LLF2m_S;N6.,e;?I?g_V@DIA&iR-AM4akXH<\[jQC`g%D#mGd]A[Ls=#kPjh^?]Au*gu[6[#A
HI(X74jOfe7pB^%>'OFp73lDTnDg#PYufhWH[b#Cl?c6O)G^Tgtd,aT_:<OfL$nM1=GdcYP2
0pmaQto3mW^?)V:<H`gc#S9VKCY=Y^#cV%BMhYZgi9pi</02@q>WV'qhO:98!adJcJ%l/2cR
]Aj^&@neOj3GBM<7'VuKr&tTHO"Vc9V#O78n[-Z.GDI0QF45=!`-S%-?6&Wt!p:>*=#Nn!YK3
FeYZn;>9?5K+M%OtZrClMJ[i4MsGV(;6j%eS94itJ3MU\L8+0Qq-<Cf1%nCDR#/"H%drG(@9
/0<bf>-NnPk`Q[pZr0^e_k7%Y\lj*TWb'%4cKd)C'[Ti@HbD?T'i2t7V,dhM"YZTpKihd!-e
h]A0\?XkUC7mYH8OkB1j3,TNJf@3Z+9!6fESSB]A9+:ep@'*=H\jBSdfC\`/mn&<6S3hBJ,uiW
AID2aU3?r%9'D1Re]A'52$]A?pWK&RQ]AZV"\U)1*"+WmmZI`]A@Nd4XmtTgN\,!sHY.V-\WsfS`
.$AOhb19*FZKmTWXo##5'5>/e4cB51%^V3HuAQ!;J5l#SC!WWQ&dL<MRJ>fK9gp^2SSTt:&E
t0/e;ts!q'\-5>pa,fRt<74M*-leF;[Ak#Z9JLp#j8B]ATu8F&8B!bTUk1BJioUjCob#WGb$f
OYtQX*k3t\oX&R)GML&SS84o8FHkc[%`dGokg6i@*B%N7>.^8+E/3E4"iPmO<)ZFk",:9Ip+
VaEgKV9;0&0_0b@;<Iife=c>ZD,>7BHdQRZ]ALFZ1[Pc=S9(oq5CSE+74Q`e`c71.h`C.FJ*L
47XCngb,`TIf#TsbGt>KYkW+UQFuH#VDDa$3MKB#)`4#"=UnWN;DJd]AVp%6RSV?h,6']AuIj'
_+$"(I_*qacYRihAHVHANG*9SfHu<C=gP*8nM3K+JJq;q?b'*J)#@IJ&$amFBUH+e)=XHY>d
#AGPDLuk*Ca$T`3q3G8kdfdZ[_ZITBf&:tn%d^+=@prRJfVQWCU.hdQ?n2rq2F+d/#-388#M
/j-FG-BRlCq$,tl#YG,qbqoG*(oArjfrO9;o!HlaTgRH?1GR\Uha;)qMja<A)NViiJ8Y2-b=
"Lqfr>s"1_6$3\U('nN0$;-SLE'^2;UK1XoVdUCW0WEmYZqNh6^r1ZmR56(?[I=i*;J)T*oH
u4cq)oCbSKjnQrt,bFR*KDA*.GBFa/8fhb-5$cCqrJf?CB.5/e3o9aL/2,j91;hm@14Me^S4
:,+:"VoT.+(CYZj1sfeGa(6F9KWUW<Nt5oK3k<Sjg9%k(i;RPBMFl?a`*e5Ot!8Dbp6mRie*
`to7\>s<r6f=`j)eRpWM(7*j)qI7s$La8s=Qj3TcKuZ=SgQ*^a3d(SH]A8InX3Cknnd\rAeo.
V23)pUIIO4DLN=\334-.Qi?ADY#euu"%?D5'$4LdmgT:A>!i+=&hm=s_@5B'IeJ52A$]AQ(V\
rHD>F$pRCIG8$q3`g"`(t&PXp1YW2t8ZCdG_a7T(8SJ7KOHkPV.Dbb=FEs5+&*.55k,P7:p2
X]AU)Hd`\$HTS%!pWStFoLn*tp$SKZlZA@X73Hn&+[g&Ka)k3;MH9.U=8;>EH0q:&J2B<'BA>
setk<b;nlmFaAuDhfC?]A"HFWa(T&u7d[g32Abj7h)1kDAUaX*g=9o+6))<hV?HAoCD=4.Zt(
7lY7^R+#A5"`'b>?pr>Wn9=Z&ahd:OV,9H]AUu'mp3]A2tGoH_cXWdgNPjuoQE@kDI_.4DYQ!e
?jT?@E,U_f=P=5bd%%Tbe*`3LA*`N82l'5iWNf/EA",(tm-bY/Edjj)\uF:&\]A;'8_0%Vr1!
J8LF7ZD.*ojO\)'%h^VGF0&h9kqEQgCg,#P&HnTl,?KgQ_uR>mNVOAp"8);'+m>*PK[(*o2V
VKQOdocTfEPb^%4[Y\*mWV0E+;^kR\(1I`R@@RX%\]AXd\I7V8LSF&KV9DKf;#C?]A\G(-Xh:d
+?Ou`jS,@)g6-Q[pfjeZ1<Q*RL"EJ;u(BUK`QK%+&YDmq4p@^1LM0Am<3<W%XQ%!dBQIqH8q
4#bEga;@s]A)LPD*"dP(1I`5H.'0/A1=oZ/eu&Y>ZV@f5u-H58;roL/6HtYhBaQ-P#$/Kj&=4
ob#-ES@fNu-6)<G_LO*Zh>U)0,28DTH%]AAIbK_t-0"8Z1:4W'uUUn19:isef*@h)sab4<u;:
!\WL)dRI?TV\Ge8Xce/N_0e@KZY^27>V:Kif:bcR:4!i/U$"-MBh<ZVk0Mpk4e>r-dI2pm:3
$<OnMuidj0&Z8K?q4$*;%m%"W5\9f5UZGu%_BVa1K;@+Tm'q/J@Eir^#@dJ/kO=^j6elg&Zh
W.J`'!L]A"5]Au16CQp?#jj'I`6i&EoX5EoRBEu"kEmY[2S\c8ll\!h2_hmHJ*%E^EgEX@S@n,
,J:?"n#84*U%M"T=6K`D^ML#[O%J0)7:P;\s*5J5p,BA>oqq@[<4Q#@qfeL!sdnea+^10BVQ
3-lY+id\U5::)=WY,DmX@tn-'qoKh8hM<\BgBQr:lTaSaJ+sfug%Z_pWuuQ*$SM=9_jZ4_6\
;(m@k+eud9A.kpP=.A?EY:n,&ukD,HCf:[g?\1\8bsKD74ND3b#2\RnQOid$l_KJ*^Os9UV1
NR1,W]AQg[AdA*k$D(#%\j-;!*%@LL#m5]AAqYZO$tKM,f)G^6*khpccQ$!XU:I\r1BbjC"Q:_
7c5Zj*W?r36]Aq%)7_qYV,:SOF^jh4:+u=!B3@VrG_X=.@M2l+Q0NQe+[[=Gin:nB@$r-T(H?
]A!f(':JMHGOpcU7DG_Z#,GbaTNlW0@b;n?`X8K4COSHL6H"]AL-!5N70^OUEPH/5'.tVcf20j
N'nAM[nGi?DaA7c>46q9lq[;9q,]A<$_cuO-20B*R><BK>.t2Cd!-#?`-t[fa0Y**9[qbNiNq
e(`;YelS/KRg*92-H%):cnQR#,tI1K'4H.s_lt4VQqJ7JHZf[mgcG#HY'c3[@7V?tQ@l#K/1
Ub\t5mnhX_RL>(Ru;7hk3I*($&L%X:@+od9H;FtSA9=$Zj_5kP9#f,%:O;.$/fT:1#bV4A7:
+5/k3L&@n$(-Rs^CM6RPA*LfUANEe,LO#5*k.'W0S*bq@=,f;"Uq/b$#YsThh*b9CMZN^Mj?
np`]A6]A'g`4Y^C<Ef%n"[2Z(rlc*@:,MN6G#noLaj'&!$6o=c7ZpX1c&#Fc8@M(cCH*PK[hD7
W-O>",!L7@gdB.+K0:0qNRXc`j_ZK!LgnQF_rr\M7#N6:N*4IZ>_[<Ak/SMh'!K*^(=c['':
CVfWf:U-H4M7B&R0tu;3YaS)cis2E)r/0e*]AV0[AJ3%i#?I#_50lp^/uaAdL?\iI[4hE0ih1
HZ.IYu+<R)de8lH5KsJU$?QHU@>Dh*(UX(Q`/gXKI5KuB3Z6.\;&O4\l!bs/BFhf>J^!B(93
^>Wiq8gHg^u[>o`m3[c+:?MLGQm$?'VF&*U3:BrHWm<pdVkX)R2=%oIg0PZRqn\>>aQ%?)5l
mKmg6#\*P'5,N_O1&*1c+%KcTpORq1jn:a`!WmJE24jGANUj[u7W+"h.bQ@CcQES$B_rg/Hj
qLSOQQb,CFJ(`S?eK9]A^l&C-+N`h0']A3@=O^!cOP^?_,^bA4c%,;0Pk&5P7/7dOuN&EgK)ms
=<8]A$W)USTGbsTo\V#RG2\cs%mGmK5RlV9gpZtBSm#_:H]Ad,/XSKSeB54\)QEeL!9m(U/$Bj
K[O&BS>Wj'g(Fpbnemm,(,FLJ?_NdbXBU?e!>D46g1GuCW,X:(#"I`4Bc;,J:i6()gd[Il23
V11DaPH%+m+g%`H>TPMTksS,A"OK/Km8;jE[!kTH0dnf*IBnR82HD<,N^^qN6+4.foaqM'cY
s(Ws>JZ0BiRR,Ou"<FYR8Z)Ki)f<S\4rpASIp$><[UXL#t'j-4d2#=S&34X(nDd!N/mA8`1r
[(=:2,2gfnbXs93b')=;%j+rZ=U#c?g^q8m$JZNhjuoH"!uM?,+XAY794@Z1.P8ZOngJO0]A3
!FZ(>;+[_E;SLN"Q)/+6ONbFmF8]AYO[Po`%NKem@4[hrs7qaD,2bbY3J`"mZ8Qi)?d%^A9'U
d9?c>[j)DEU%BgFDJf,mE!Il49)No,SM!9L**@kLH`C%0-=;1bCaVQSg=:O=".(;1JH8:\Xe
S]A-s.b,</IUDtGV_+"BFf"UPo#/f"fN]Af6j?r#^8e:!8)f9[284P3Rl&,5?EfrL<"P*b"5TD
S=Gn"I?(puKF@XK'lZMh8IILc0aH=q;M*&YQ6q]A1*%M,t+_3=d/AfpoEd1l7h8`SOj+l\9$a
D&Nrkoa,.'maoMQn!F6^.o=f(&^m(tUT"fo"-eXPJmSIjG/&hg&ITM;D5g+2j8:3M@`bJ8b'
"i$>=%uM_3I+eJb1`/,H1qXdIso$;'@ttd(hSaGNYR*$Vni9KQl&8\B,&rWjun<$VPe8@4l$
h&Z.n3:&#flahY#rQk+7-$,BWG.i?glY3J&QNUS_@T#7YKj*D!TluAJaU&:F\"p8Fp<a&!'(
@rSpl4B5;74-3S)tLmBM`-Ue_:pEc*=j*olT2I`_%lH9eI3O$c>*60Qm%ub_0C$.;f4320NQ
Jc>H?I,s7f))R,Xq]AM&2J_]AO9ZOP8-8V\_HAocnZlrZ=/YRnQ$kf@P@%Hkm<"XMlO#T===1]A
()oT-C(8C"Pn*_Y:2Jd,(F[7*/*4Bn"!d?Zc3c'08LkR>c@n<W:>@lNFXSWqd5*Bt3s7Hd[?
lS@&]ACdCIc;OrMWrN9b)B:D%o&#a1/>=.&JV2'f5%/uT#\fX74`mm!qkh1]A\S:&dj>O;:&n&
ic:Kk=LaX*o3B]A<igV=12Zh+/*[TCt<p3ujL+u1]A[r(fJ,<XM=N#U)o`[MQO[euh@t5PY)(h
,YTWMSM;#e%O1jm5;"4'^Zcuc0*:7aO^C$XC0#E+=c2eM0R8RPRL;kLM.M'C85KWmW%7S*k0
D#`D&OkSNXuW)/0G]A9UWR8ENT+.9rXHn<O.egU*bXdT5WPd$NSOJ8p@9RC9JT:f=I4MHMcY[
8IoOt]A1WchZ#ZQmK,jN`a$`aS8u#'>jrn:h3P]AbQ?+f3&)B->k3/tLj"`uiA!@D''W26,XS3
ht@pQFSSEIj7?$%Hj<A6.;&eY;2gD>"ju/i+MfO"IO-#TBZ9r'KM[s$*VLMd)1"7=KYWq9go
C&;UqeL<.g$+@H_[%Oi_V,"_rhn;`9N-R(RE#!U5lNMRF43o@#Q=a9_oPD#l2=rF!E+Fhm;o
#ph;%+>Tg&Eal.iNS8>ZI)P^AM-6:;,eUX+eYX<Z-JPpN6M1qhGJ&1Ykj9IZ!fo;:%&9>rNG
&K"+_tLaXd[RNKk+,e!kdsE!@OHfcAEnlO/+06er9r$8XS'+Yls[@EJe'HQ"4NjdIL9DBjd*
^L=9VqO!>gE;#L3=@'Q''0+Q>+_oXhp&Q;>&u+pmOKg]AY+#-q53W:-DMZR8a@;H_KERR^e3G
F("W<kJB]AU&VM4L/L9R4qI*5,Jg',Y@Zu:TE2n#G&-4<#V?=+Tcpdg^b^pO<#i?_kh3cA+C:
mRif68hlgI'`.W=mP4&b&60[#NjF]AIGjE:<C_?R-<3OIFF_@2>VEtBd,ooagQ'"m3?c^jZg\
#V%T&,-R+Pod:>Uo8PlNgaPoMfipu^OZ5ZI`)<bO89J0#E)u!Yqk(?[Cb%/*K(c`Fl%J(Nu;
`nTMH\2aKo;<'R`d8OPqpfMBl"T=nu1trk&QR/F:TaS\6EC@)uX#(E/,XbRQ5]A$JR]A<>gW$'
/s.oE@cg$\V(el29;fL-#i`V@8ZGF'CEbt9:PEpEQ13VZY+EEq#%r-D1Y@Q4!Nb4!,sjc&($
uniU2/Bqc`^+NP`5a\EAQXO5'k<2G(<!P=WCmYRC8S15?2<sNZtoKX30(02^^QA5620U:@:,
D0@1%X)a'cslF=[p]A8KAi3*(Cq-@5k^K:U_'"-CkuroH-8>$mE3*oe#g8sJ&Hm/H>X0R<E0n
su\<[IQ%(=iI)kj47_B+nkDP^GBMu7!:qia3cTnIsr5;Z)(@.[&7f>2\%7ZO9$(8fOuBI`aS
1m\n&97*W,f>=@W1oYqD%k`u&C>+7dDo@m4rOdM?JtrVMYb!URuA`l"]A(G6TDdLj5mR%^9[c
C%l"_)u[=K$he?(cfNp3FelSUqlTTM4u/;qJ<ruJ7\\CJ'r?DODl1!Jl#fci8);M_'jcq2-P
]AW]Aa7G?#0'apK^Q!(a90Pu[f8W@a6NbBue]AOGdc@Q2,hnN9VdqR:&:h-^#1)g(4:3X%uk$=D
"?"Mo/MK%YHbRQp@-MjZ4\/Gbkr$2Uj[*fmp6Db6,k3ijRV-o'q]AB;[CV?"ph&R#tqF`*OFl
QWZ!1J'ao52f]A4DB5cnq/7@3Gc!9sm]AYbQgP^bX;]AR5@L)rgZ79mSBY7nnm=[pc=i&`LIJ`V
V!9;b>",`gB_O#G0KN<aW2VKFNG'eOF\UBH"SAY]AYV)3Y@f2,^/C&u3Iq?9q_bCs;h"DjbK5
7rio83k7^L\cqrP.*c'b.-Jqg*G>*_IN%>n@4@fi+?_o1DkoO/T()PlH,6^mM-75?>N*[1km
*NMEm+KnnaKDPE4_p=]A8o`25@LYno=M.)g`Et<r#AgK.cbORFP=RN*H1o_*jN_6jF-oIeUb,
=JM.aPSdM;cs6hQ^3iMMR\O-l,$@cn'cn*ggl?fT-s4p%)3"u_3+`%b\jD0;bO#r8%<pt%Vn
f*F2[0Q2"-$C`Hn"'6"U#BHB?UXb'\2LAo3!LE<0e".7M\el@oT=<O,7@io#%isNUDsF:2,[
3\Fi%Vi?Dn9pm^?Kk\";2m/?K_Zf-TGFH9qhncMu\>$GiRT:fE._S`#M[Vp^]Ai)XK]AFJ'/@S
']AQm_^t)\+&KID^ebii`_OKC8,eMX?1Is%5.L5Usds!p\<ItAn:9r@0msD;8lc\aCMo$OZMs
%EQH3/lpcfEqXp1aK/a1tH!@.Z/LL_'_bQ3t$a8421&YAD&2$E]AH5C_-b7E'.H2J0$Z.XGVk
"A1*i_"IB="QIrrjheR&PJ]A%BY"m+G[&q!RQ$.U-*fXL>'"&n`<qf5;X_8"o8n1XPQr!WK-s
+5a:^YiJg0DH@]A$iU>0K)]A20q$Q0%<2n39n#c$l]AP^j(R_qhf4oHH~
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
<TemplateIdAttMark TemplateId="ffa00fec-2165-480a-b731-983d785ada96"/>
</TemplateIdAttMark>
</Form>
