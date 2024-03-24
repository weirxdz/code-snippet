//返回起始日期的毫秒数
var startdate = Date.parse(_g().parameterEl.getWidgetByName("startdate").getValue());
//返回截止日期的毫秒数
var enddate = Date.parse(_g().parameterEl.getWidgetByName("enddate").getValue());
//返回两个日期之间的天数
var days=(enddate - startdate)/(1*24*60*60*1000);

//定义字符串
var str = new String();
//返回拼接sql代码
for(var i=0;i<=days;i++)
{
	var temp_num = 15;
	temp_num = temp_num + i;
	var temp = "select * from ";
	temp = temp + 'test_04' + temp_num.toString() + ' ';
	str = str + temp;
	if(i<days)
	{
		str = str + 'union ' ;
		}
	}
_g().parameterEl.getWidgetByName("sql").setValue(str)