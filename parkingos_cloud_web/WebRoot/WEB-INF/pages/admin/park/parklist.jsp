<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ��������</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//����</script>
<script src="js/tq.public.js?0817" type="text/javascript">//����</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//����</script>
<script src="js/tq.form.js?033434" type="text/javascript">//����</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ����</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<script src="js/tq.newtree.js?1014" type="text/javascript"></script>

</head>
<body>
<div id="parkingobj" style="width:100%;height:100%;margin:0px;"></div>
<script >

/*Ȩ��*/
var authlist = T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴,ע��,�༭,ɾ��,����ʾ��APP,����,��������,���UGC����
function getMarketers (){
	var markets = eval(T.A.sendData("getdata.do?action=markets"));
	return markets;
}
function getBizcircles(){
	var bizs = eval(T.A.sendData("parking.do?action=getbizs"));
	return bizs;
}
var role=${role};
var marketers=getMarketers();
var bizcircles = getBizcircles();
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var etc_states=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
var etc_add_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"},{"value_no":4,"value_name":"Pos������"}]

var isfixed = false;
if(role==7)
	isfixed=true;
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"40" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"pid",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='-1'&&parseInt(value)>0){
					var local = T.A.sendData("getdata.do?action=getparkname&id="+value);
					return local;
				}else
					return "��";
			}},
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"180" ,height:"",issort:false},
		{fieldcnname:"ͣ�����绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"������ҵ",fieldname:"mcompany",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"parking_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"},{"value_no":3,"value_name":"����/����"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��С�۸�λ",fieldname:"minprice_unit",fieldvalue:'',inputtype:"select", noList:[{"value_no":0.00,"value_name":"Ĭ��"},{"value_no":0.50,"value_name":"0.5"},{"value_no":1.00,"value_name":"1"}], twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"stop_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"ƽ������"},{"value_no":1,"value_name":"��������"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��ʷ������",fieldname:"total_money",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,hide:true},
		{fieldcnname:"��ǰ���",fieldname:"money",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,hide:true},
		{fieldcnname:"���г�רԱ�ĳ���",fieldname:"no_marketer",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"���г�רԱ"}], twidth:"60" ,height:"",issort:false,fhide:true},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"select",noList:marketers, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������Ȧ",fieldname:"biz_id",fieldvalue:'',inputtype:"select",noList:bizcircles, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�ͻ�����",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"parking.do?action=localdata",edit:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'&&parseInt(value)>0){
					var local = T.A.sendData("parking.do?action=getlocalbycode&code="+value);
					return local;
				}else
					return value;
			}},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�����"},{"value_no":2,"value_name":"δ���"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�Ƿ�У��",fieldname:"isfixed",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δУ��"},{"value_no":1,"value_name":"��У��"},{"value_no":2,"value_name":"����У��"},{"value_no":3,"value_name":"һ��δͨ��"},{"value_no":4,"value_name":"����δͨ��"},{"value_no":5,"value_name":"����δͨ��"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"NFC",fieldname:"nfc",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"etc",fieldvalue:'',inputtype:"select",noList:etc_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"Ԥ��",fieldname:"book",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"���ڵ���",fieldname:"navi",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"֧���¿�",fieldname:"monthlypay",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"ҹ��ͣ��",fieldname:"isnight",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"֧��"},{"value_no":1,"value_name":"��֧��"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"����֧��",fieldname:"epay",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"֧��"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false},
		{fieldcnname:"�շ�Ա�ڸ�״̬",fieldname:"is_hasparker",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"���ڸ�"},{"value_no":1,"value_name":"�ڸ�"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��ͼ��ʾ",fieldname:"isview",fieldvalue:'',defaultValue:'��ʾ||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����ʾ"},{"value_no":1,"value_name":"��ʾ"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"δ����������������",fieldname:"invalid_order",fieldvalue:'',inputtype:"text", twidth:"150" ,height:""},
		{fieldcnname:"���ִ�С��",fieldname:"car_type",fieldvalue:'',defaultValue:'������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�Ƿ�������ѽ��㶩��",fieldname:"passfree",fieldvalue:'',defaultValue:'����||0',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"������"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����Զ�֧��",fieldname:"isautopay",fieldvalue:'',defaultValue:'��֧��||0',inputtype:"select", noList:[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"֧��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"activity",fieldvalue:'',defaultValue:'ȫ��||-1',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"û�л"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"����ͨ��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����������",fieldname:"full_set",fieldvalue:'',defaultValue:'�ɽ�||0',inputtype:"select", noList:[{"value_no":0,"value_name":"�ɽ�"},{"value_no":1,"value_name":"��ֹ"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�볡����",fieldname:"leave_set",fieldvalue:'',defaultValue:'Ĭ������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"Ĭ������"},{"value_no":1,"value_name":"ʶ���̧��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����",fieldname:"activity_content",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"ÿ��ͣ��ȯ�����������",fieldname:"allowance",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false}
		];
var _addField = [
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ͣ�����绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ϵ��",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ϵ���ֻ�",fieldname:"cmobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"������ҵ",fieldname:"mcompany",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"parking_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"},{"value_no":3,"value_name":"����/����"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��С�۸�λ",fieldname:"minprice_unit",fieldvalue:'',inputtype:"select", noList:[{"value_no":0.00,"value_name":"Ĭ��"},{"value_no":0.50,"value_name":"0.5"},{"value_no":1.00,"value_name":"1"}], twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"stop_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"ƽ������"},{"value_no":1,"value_name":"��������"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,hide:true},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"select",noList:marketers, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������Ȧ",fieldname:"biz_id",fieldvalue:'',inputtype:"select",noList:bizcircles, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ͻ�����",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"parking.do?action=localdata",edit:true},
		{fieldcnname:"NFC",fieldname:"nfc",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"��������",fieldname:"etc",fieldvalue:'',defaultValue:'ͨ������||2',inputtype:"select",noList:etc_add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"Ԥ��",fieldname:"book",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"���ڵ���",fieldname:"navi",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"֧���¿�",fieldname:"monthlypay",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		//{fieldcnname:"�Ƿ�֧�ֱ��ػ�",fieldname:"isautopay",fieldvalue:'',defaultValue:'��֧��||0',inputtype:"select", noList:[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"֧��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ҹ��ͣ��",fieldname:"isnight",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":0,"value_name":"֧��"},{"value_no":1,"value_name":"��֧��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����֧��",fieldname:"epay",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"֧��"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",fhide:true,hide:true,shide:true},
		{fieldcnname:"",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",fhide:true,hide:true,shide:true}
	];
var rules =[
		{name:"company_name",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
		];
var _parkingT = new TQTable({
	tabletitle:"�����ͣ����",
	ischeck:false,
	tablename:"parking_tables",
	dataUrl:"parking.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#parkingobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
//�鿴,ע��,�༭,ɾ��,����ʾ��APP,����,��������,���UGC����
function getAuthButtons(){
	var bus = [];
	if(subauth[1])
	bus.push({dname:"ע��ͣ����",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"parking_add",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				Tform({
					formname: "parking_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"parking.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("parking_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"���ӳɹ���",2,"");
							TwinC("parking_add");
							_parkingT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}});
	if(subauth[0])
	bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkingT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
			if(o.fieldname=='strid'||o.fieldname=='nickname'||o.fieldname=='cmobile')
				o.shide=true;
		});
		Twin({Id:"parking_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "parking_search_f",
					formObj:tObj,
					formWinId:"parking_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("parking_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_parkingT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	bus.push({dname:"�����ͣ����",icon:"edit_add.png",onpress:function(Obj){
		//this.dname='<font color="red">�����ͣ����</font>';
		_parkingT.C({cpage:1,tabletitle:"�����ͣ����",
			extparam:"&action=quickquery&state=0"
		})
	
	}});
	bus.push({dname:"δ���ͣ����",icon:"edit_add.png",onpress:function(Obj){
		_parkingT.C({cpage:1,tabletitle:"δ���ͣ����",
			extparam:"&action=quickquery&state=2"
		})
	}});
	if(subauth[7])
	bus.push({dname:"�����UGCͣ����",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do?action=ugc&state=0";
	}});
	if(subauth[7])
	bus.push({dname:"δ���UGCͣ����",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do?action=ugc&state=2";
	}});
	bus.push({dname:"���÷Ǳ�������",onpress:function(Obj){
		Tconfirm({Title:"ȷ�����÷Ǳ���������",Content:"ȷ�����û�����",OKFn:function(){T.A.sendData("parking.do?action=initnobj","GET","",
			function deletebackfun(ret){
				T.loadTip(1,"������"+ret+"���Ǽ��ϳ���",2,"");
			}
		)}})
	}});
	/*bus.push({dname:"���복��",onpress:function(Obj){
		Tconfirm({Title:"ȷ�ϵ��복����",Content:"ȷ�ϵ��복��",OKFn:function(){T.A.sendData("parking.do?action=import","GET","",
			function callbackfun(ret){
				T.loadTip(2,ret,100,"");
			}
		)}})
	}});*/
	return bus;
}
//�鿴,ע��,�༭,ɾ��,����ʾ��APP,����,��������,���UGC����
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		var fixed = _parkingT.GD(id,"isfixed");
		T.each(_parkingT.tc.tableitems,function(o,j){
			if(o.fieldname=='city'){
				var code = _parkingT.GD(id)[j];
				var local = T.A.sendData("parking.do?action=getlocalbycode&code="+code);	
				o.fieldvalue = code+"||"+local;
			}else
				o.fieldvalue = _parkingT.GD(id)[j];
		});
		Twin({Id:"parking_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "parking_edit_f",
					formObj:tObj,
					recordid:"parking_id",
					suburl:"parking.do?action=modify&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_parkingT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("parking_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("parking_edit_"+id);
							_parkingT.M()
						}else if(ret=="-1"){
							T.loadTip(1,"��γ���ظ���",2,o);
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
		if(fixed=='1'&&role!=7){//�Ѷ�λ�������޸ľ�γ��
			T("#parking_edit_f_address").disabled=true;
			T("#parking_edit_f_address_showmap").disabled=true;
		}
	}});
if(subauth[3])
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("parking.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_parkingT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[4])
	bts.push({name:"����ʾ",
		rule:function(id){
				var state =_parkingT.GD(id,"isview");
				if(state==1){
					this.name="����ʾ";
				}else{
					this.name=" &nbsp;��  ʾ      ";
				}
				return true;
			},
		tit:"�����Ƿ����ֻ��ͻ��˵�ͼ����ʾ",
		fun:function(id){
			var state =_parkingT.GD(id,"isview");
			var type = "��ʾ���ֻ���ͼ";
			if(state==1){
				type = "����ʾ���ֻ���ͼ";
			}
			Tconfirm({
				Title:"��ʾ��Ϣ",
				Ttype:"alert",
				Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> ��",
				OKFn:function(){
				T.A.sendData("parking.do?action=isview&id="+id+"&isview="+state,"GET","",
					function(ret){
						if(ret=="1"){
							T.loadTip(1,"����"+type+"�ɹ���",2,"");
							_parkingT.C();
						}else{
							T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
						}
					},0,null)
				}
			});
		}});
	if(subauth[5])
	bts.push({name:"����",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"ͣ��������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"parksetting.do?id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	if(subauth[6])	
	bts.push({name:"��λ����",fun:function(id){
		var pname = _parkingT.GD(id,"company_name");
		Twin({
			Id:"client_detail_"+id,
			Title:"��λ����  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"parklalaanly.do?action=parkidle&pname="+encodeURI(encodeURI(pname))+"&comid="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	if(bts.length <= 0){return false;}
	return bts;
}
_parkingT.C();
</script>

</body>
</html>