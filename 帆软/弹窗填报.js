//模板路径
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
    height: 720,        //高度
    closable:false,    //是否显示关闭按钮，默认true
    left:100,
    //confirm:true,     //是否添加确认取消按钮,默认false
    //draggable:true   //是否可拖动，默认true
};
//弹出窗体
FR.showDialog(o.title, o.width, o.height, $iframe, o);
//$('.fr-core-window-header ').css("background","red");
//标题背景色



var url= "${servletURL}?reportlet=/CRM/项目报备/项目报备表_填报.cpt&op=write&__cutpage__=v";
FR.doHyperlinkByGet(url,'REPORT','_dialog');
