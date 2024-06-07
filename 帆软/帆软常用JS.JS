//常用JS
// 序号单元格斑马纹公式
(row() - 1) % 2 == 0
// 文本控件编辑后事件中的自动查询
_g().parameterCommit();
// 一键清除所有控件值
$.each(_g().getParameterContainer().getAllWidgets(), (i, item) => {
  if (item.getType() !== 'label' && item.getType() !== 'freebutton') {
    item.reset();
  }
})
// 合作状态公式
switch ($$$, "合作", "<span class='el-tag el-tag--dark'><span class='el-tag__content'>合作</span></span>", "未合作", "<span class='el-tag el-tag--dark el-tag--danger'><span class='el-tag__content'>未合作</span></span>")
// 上架状态公式
switch ($$$, "上架", "<span class='el-tag el-tag--light'><span class='el-tag__content'>上架</span></span>", "下架", "<span class='el-tag el-tag--danger el-tag-light'><span class='el-tagcontent'>下架</span></span>")
// 编辑按钮公式
"<span class='el-tag el-tag--dark'><span class='el-tag_content'>编辑</span></span>"
// 提交按钮点击提交回调函数
if (fr_submitinfo.success) {
  window.parent.FR.Msg.toast({
    message: "填报成功！",
    type: "success"
  });
  window.parent._g().parameterCommit();
  window.parent.FR.closeDialog(); //确定获取值后，关闭取消父窗口的对话框
  window.parent.FR.destroyDialog();
} else {
  window.parent.FR.Msg.toast('提交失败，错误信息为：' + fr_submitinfo.failinfo);
}
// 填报页面加载结束事件
if (bm) {
  _g().getWidgetByCell("B4").setEnable(false);
}
// 公式
len($产品编码) > 0
// 控件默认值当天
TODAY()
// 控件默认值7天前
today() - 7
// 时间自定义显示值格式化
FORMAT($$$, "hh:mm")
// 公式拼接多个字段
CONCATENATE(B2, "[", C2, "]")
// 长文本格式化公式
if (len($$$) > 10, left($$$, 10) + "…", $$$)
  // 下拉控件编辑结束事件
  // 将控件的值传递给参数控件。
  _g().getParameterContainer().getWidgetByName("客户类型").setValue(this.getValue());
// 提交参数查询
_g().parameterCommit();
// 填报预览页面记载结束事件
// 去除控件的边框
$(".fr-trigger-btn-up").css("border", "none");
// 去除input边框并将其宽度设置为0进行隐藏
$(".fr-trigger-text.fr-border-box").css({ "border": "none", "width": "0px" });