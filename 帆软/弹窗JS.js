window.form = this.options.form; //当前的form赋值给全局变量
var $iframe = $("<iframe id='inp' name='inp' width='100%' height='100%' scrolling='no' frameborder='0'>"); // iframe参数的命名及宽高等
$iframe.attr("src", "http://localhost:8075/webroot/decision/view/report?viewlet=/doc/JS/参数界面JS实例/数据回填_弹窗.cpt&ref_t=design&op=view&ref_c=9e2cfd00-e8b1-4f7a-b870-bd0574f39811"); //数据回填_弹窗.cpt为点击查询时，对话框中显示的子报表
var o = {
title : "筛选所需数据并返回",
width : 600,//调整对话框宽度
height: 300//调整对话框高度
};
FR.showDialog(o.title, o.width, o.height, $iframe,o); //弹出对话框




window.form = this.options.form; //当前的form赋值给全局变量
var $iframe = $("<iframe id='inp' name='inp' width='100%' height='100%' scrolling='no' frameborder='0'>"); // iframe参数的命名及宽高等
$iframe.attr("src", "http://222.133.23.90:9085/webroot/decision/report?viewlet=/报表设计/品酒/品酒准备/方案选择_弹窗.cpt&ref_t=design&op=view&ref_c=d36e64ce-932b-4d16-8a3b-eb16022ea2e8"); //数据回填_弹窗.cpt为点击查询时，对话框中显示的子报表
var o = {
title : "筛选所需数据并返回",
width : 900,//调整对话框宽度
height: 900//调整对话框高度
};
FR.showDialog(o.title, o.width, o.height, $iframe,o); //弹出对话框

window.form = this.options.form; //当前的form赋值给全局变量
var $iframe = $("<iframe id='inp' name='inp' width='100%' height='100%' scrolling='no' frameborder='0'>"); // iframe参数的命名及宽高等
$iframe.attr("src", "http://localhost:8075/webroot/decision/view/report?viewlet=/doc/JS/参数界面JS实例/数据回填_弹窗.cpt&ref_t=design&op=view&ref_c=9e2cfd00-e8b1-4f7a-b870-bd0574f39811"); //数据回填_弹窗.cpt为点击查询时，对话框中显示的子报表
var o = {
title : "筛选所需数据并返回",
width : 600,//调整对话框宽度
height: 300//调整对话框高度
};
FR.showDialog(o.title, o.width, o.height, $iframe,o); //弹出对话框

window.form = this.options.form; //当前的form赋值给全局变量
var $iframe = $("<iframe id='inp' name='inp' width='100%' height='100%' scrolling='no' frameborder='0'>"); // iframe参数的命名及宽高等
$iframe.attr("src", "http://localhost:8075/webroot/decision/view/report?viewlet=doc/JS/参数界面JS实例/高级筛选_子.cpt&ref_t=design&op=view&ref_c=9e2cfd00-e8b1-4f7a-b870-bd0574f39811"); //childtest.cpt为点击查询时，对话框中显示的子报表
var o = {
title : "筛选所需数据并返回",
width : 600,//调整对话框宽度
height: 300//调整对话框高度
};
FR.showDialog(o.title, o.width, o.height, $iframe,o); //弹出对话框