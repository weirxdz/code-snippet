//在控件的
//取单元格的值
var currentUser = _g().getCellValue(0, 1, 17);
var creater = _g().getCellValue(0, 2, 4);
if (currentUser == creater) {
	this.setEnable(true);
}
else if(currentUser == 9){
	this.setEnable(true);
}
else {
	this.setEnable(false);
}

//fr10,支持移动端
/*获取当前单元格的值，根据当前判断某一个单元格的控件是否可用*/
var ch = this.getValue();
if(ch == "酒罐"){
	_g().getWidgetByCell("D36").setEnable(false);
	}else {
	_g().getWidgetByCell("D36").setEnable(true);
	}

//获取当前文本控件值
//如果当前值的长度超过8位，截取最右8位
//用于扫码填写酒坛号的处理，文本控件上设置编辑后事件
//相关单元格的单元格属性→其他→插入行策略 选择“原值”
var str = this.getValue();
if(str.length > 8){
	this.setValue(str.slice(-8),true);
	}