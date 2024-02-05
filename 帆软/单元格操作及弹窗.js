var v1 = _g().getCellValue(0, 1, 3);
//获取B4的值
var v2 = _g().getCellValue(0, 4, 2);
//获取E3的值
var v3 = _g().getCellValue("E4", null);
//获取E4的值
alert("雇员：" + v2 + "\n性别：" + v1 + "\n电话：" + v3);

$(".fr-sheetbutton-container").click(function()
	//给切换sheet的按钮绑定点击事件
	{
		var a = _g().selectedIndex;
		//获取当前sheet的编号（从0开始）
		if (a == 1) {
			//如果是第2个sheet
			$(".parameter-container-collapseimg-up").click();
			//点击参数面板收缩按钮,即隐藏参数面板
			$('.parameter-container-collapseimg-up').hide();
			//隐藏收缩按钮   
		} else {
			$('.parameter-container-collapseimg-down').show();
			//展示收缩按钮
			$('.parameter-container-collapseimg-down').click();
			//点击参数面板收缩按钮,即展示参数面板
		}
	});
	
	
	
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
    height: 600,        //高度
    closable:false,    //是否显示关闭按钮，默认true
    left:100,
    //confirm:true,     //是否添加确认取消按钮,默认false
    //draggable:true   //是否可拖动，默认true
};
//弹出窗体
FR.showDialog(o.title, o.width, o.height, $iframe, o);
//$('.fr-core-window-header ').css("background","red");
//标题背景色
