var v1 = _g().getCellValue(0, 1, 3);
//��ȡB4��ֵ
var v2 = _g().getCellValue(0, 4, 2);
//��ȡE3��ֵ
var v3 = _g().getCellValue("E4", null);
//��ȡE4��ֵ
alert("��Ա��" + v2 + "\n�Ա�" + v1 + "\n�绰��" + v3);

$(".fr-sheetbutton-container").click(function()
	//���л�sheet�İ�ť�󶨵���¼�
	{
		var a = _g().selectedIndex;
		//��ȡ��ǰsheet�ı�ţ���0��ʼ��
		if (a == 1) {
			//����ǵ�2��sheet
			$(".parameter-container-collapseimg-up").click();
			//����������������ť,�����ز������
			$('.parameter-container-collapseimg-up').hide();
			//����������ť   
		} else {
			$('.parameter-container-collapseimg-down').show();
			//չʾ������ť
			$('.parameter-container-collapseimg-down').click();
			//����������������ť,��չʾ�������
		}
	});
	
	
	
	//ģ��·��
var url = "${servletURL}?reportlet=/CRM/��Ŀ����/��Ŀ������_�.cpt&op=write";
//����
var $iframe = $("<iframe id='inp' name='inp' width='100%' height='100%' scrolling='no' frameborder='0'>");
//�������src��������Ϊģ��·��
$iframe.attr("src", url);
//���������
var o = {
    title: "",    //����
    destroyOnClose:true,   // �Ƿ��ڹرնԻ����ʱ�򽫶Ի����dom���Ƴ�
    width: 960,         //���
    height: 600,        //�߶�
    closable:false,    //�Ƿ���ʾ�رհ�ť��Ĭ��true
    left:100,
    //confirm:true,     //�Ƿ����ȷ��ȡ����ť,Ĭ��false
    //draggable:true   //�Ƿ���϶���Ĭ��true
};
//��������
FR.showDialog(o.title, o.width, o.height, $iframe, o);
//$('.fr-core-window-header ').css("background","red");
//���ⱳ��ɫ
