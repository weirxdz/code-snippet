var value = this.getValue();

var ro = FR.cellStr2ColumnRow(this.options.location).row;

var widget = _g().getWidgetByCell(FR.columnRow2CellStr({
	col: 3,
	row: ro
}));
widget.reset();


window.parent._g().parameterCommit();
window.parent.FR.closeDialog();

//window.parent.location.reload();
//刷新父窗口

var flag = this.getValue();
//获取当前值
var boxes = _g().getWidgetsByName("box1");
//获取当前页的复选按钮控件数组
if (typeof(boxes[0]) != "undefined") {
	for (i = 0; i < boxes.length; i++) {
		var cr=FR.cellStr2ColumnRow(boxes[i].options.location);
		//获取行列号对象
		_g().setCellValue(0,cr.col,cr.row,flag);
		//如果控件大于1个，则遍历赋值
	}
} else {
	var cr=FR.cellStr2ColumnRow(boxes.options.location);
	//获取行列号对象
	_g().setCellValue(0,cr.col,cr.row,flag);
	//如果控件只有1个，则直接赋值
}


this.setValue(true);
//获取当前行号	
var ro = FR.cellStr2ColumnRow(this.options.location).row;
//获取当前列号
var cl = FR.cellStr2ColumnRow(this.options.location).col;
cl = cl - 1;
var widget =_g().getCellValue(0,cl,ro);
//alert(widget);
if (widget = "undefined") {
	this.setVisible(false) ;
}

this.setValue(true);
//获取当前行号	
var ro = FR.cellStr2ColumnRow(this.options.location).row;
//获取当前列号
var cl = FR.cellStr2ColumnRow(this.options.location).col;
cl = cl - 1;
var widget =_g().getCellValue(0,cl,ro);
//alert(widget);
if (length(widget) < 1) {
	this.setVisible(false) ;
}

//获取当前控件值
var value = this.getValue().length;
//获取当前行号
var ro = FR.cellStr2ColumnRow(this.options.location).row;
//获取当前列号
var cl = FR.cellStr2ColumnRow(this.options.location).col;
//获取当前行的单价控件
var widget = _g().getWidgetByCell(FR.columnRow2CellStr({
	col: cl,
	row: ro
}));
//如果中止为是则禁用当前行的单价控件
value == "是" ? widget.setEnable(false) : widget.setEnable(true);


var value = this.getValue();
var len=value.length;
//alert(value+'@'+len);
if(len==0){
	//获取当前行号
	var ro = FR.cellStr2ColumnRow(this.options.location).row;
	//获取当前列号
	var cl = FR.cellStr2ColumnRow(this.options.location).col;
	//获取当前行的单价控件
	var widget = _g().getWidgetByCell(FR.columnRow2CellStr({
		col: cl,
		row: ro
	}));
	widget.setEnable(false)
	}
	
var value = this.getValue();
var len=value.length;
//alert(value+'@'+len);
if(len==0){
	//获取当前行号
	var ro = FR.cellStr2ColumnRow(this.options.location).row -1;
	//获取当前列号
	var cl = FR.cellStr2ColumnRow(this.options.location).col ;
	alert(ro +'@'+cl);
	//获取当前行的单价控件
	var widget = _g().getWidgetByCell(FR.columnRow2CellStr({
		col: cl,
		row: ro
	}));
	widget.setVisible()
	}
	
	
var location = this.options.location;  //获取当前控件的位置
var cr = FR.cellStr2ColumnRow(location);
var col = cr.col;  //列号
var ro = cr.row;  //行号

var zybck = contentPane.getWidgetByCell(FR.columnRow2CellStr({col: col-1, row: ro}));
//根据单元格获取控件
alert(zybck.getValue());//获取对应的值
