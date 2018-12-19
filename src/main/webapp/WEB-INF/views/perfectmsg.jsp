<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>

<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
<title>
	学生信息管理平台
</title><link href="/Style/StudentStyle.css" rel="stylesheet" type="text/css" />
		<link href="/Script/jBox/Skins/Blue/jbox.css" rel="stylesheet" type="text/css" />
		<link href="/Style/ks.css" rel="stylesheet" type="text/css" />
	    <script src="/Script/jBox/jquery-1.4.2.min.js" type="text/javascript"></script>
	    <script src="/Script/jBox/jquery.jBox-2.3.min.js" type="text/javascript"></script>
	    <script src="/Script/jBox/i18n/jquery.jBox-zh-CN.js" type="text/javascript"></script>
	    <script src="/Script/Common.js" type="text/javascript"></script>
	    <script src="/Script/Data.js" type="text/javascript"></script>
		<script type="text/javascript" src="/Script/info.js" ></script>
   
  
<script type="text/javascript">
$(function(){
    	var xm = false;sfz = false; mz = false;yx = false;
    	function userName(inputid, spanid) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请填写姓名");
	        } else {	          
	            	xm = true;
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userName('#username', "#ckerror");
	
	function userIdcard(inputid, spanid) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请填写身份证号码");
	        } else {	          
	            	sfz = true;
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userIdcard('#idcard', "#ckerror");
	
	function userNation(inputid, spanid) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请填写民族");
	        } else {	          
	            	mz = true;
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userNation('#nation', "#ckerror");
	
	function userEmail(inputid, spanid) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请填写邮箱");
	        } else {	          
	            	yx = true;
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userEmail('#email', "#ckerror");
	
	
	
		//获取一个上传文件的扩展名
		var fileinput = document.getElementById('file-input');
		var btnSubmit = document.getElementById('btnSubmit');
		
		btnSubmit.onclick = function(){
			//获取文件上传文件的文件名和扩展名
			if(fileinput.files[0] == undefined){
				alert('未上传文件！');
			}else{
				//获取上传文件的文件名
				//alert(fileinput.files[0].name);
				document.getElementById('filename').value = fileinput.files[0].name;
				//alert(111+document.getElementById('filename').value);
			}
			//获取上传文件的扩展名
			var filevalue = fileinput.value;
			var index = filevalue.lastIndexOf('.');
			//alert(filevalue.substring(index));
		}
	
    //ajax提交完善后的信息
     /* $("#btnSubmit").click(function() {
			if(xm&&sfz&&mz&&yx){
				$.ajax({
					url : "/perfectmsg",
					type : "POST", 					
					data :{
							'username' : $("#username").val(),
							'sex' : $("#sex").val(),
							'idcard' : $("#idcard").val(),
							'nation' : $("#nation").val(),
							'edu' : $("#edu").val(),
							'province' : $("#param_province").val(),
							'city' : $("#param_city").val(),
							'email' : $("#email").val(),
							'file-input' : $("#file-input").val()
					},
					success : function(data){
						if(data != null){	
						     window.location.href = '你的跳转的目标地址'
						}
					}
				});
			}
	    });*/
	    }); 
</script>
<style type="text/css">
    .txtinput1{width:180px;}
</style>
</head>
<body onload="init()">
    <div class="page" style="height: auto;width:100%;background: url(/Images/800.jpg);">
        <div class="box mtop" >
            <div class="rightbox">
                
<h2 class="mbx" style="font-size: 18px;color: #000000;">完善信息</h2>
<div class="cztable">
 <center>
   <div class="error-box"id="ckerror"style="width: 100px;height:20px;color:red;font-size:10px;">${errmsg}</div>
 </center>
 <form method="post" enctype="multipart/form-data" action="perfectmsg">
<table border="0" cellspacing="0" cellpadding="0" width="500px" style="margin:30px auto 0px auto;">
    <tr align="center">
        <th style="width:20%; text-align:left;">姓名：</th>
        <td style="width:70%; text-align:left;">
        <input id="username" name="username" value="" type="text" class="input_2 txtinput1"/>
        </td>       
    </tr>
    <tr align="center">
        <th style="width:20%;text-align:left;">性别：</th>
        <td style="width:70%; text-align:left;">
        	<select name="sex" id="sex">   
	        <option value="男">男</option>   
	        <option value="女">女</option>  
	        </select>
        </td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">身份证：</th>
        <td style="width:70%; text-align:left;"><input id="idcard" name="idcard" value="" type="text"  maxlength="18" class="input_2 txtinput1" /></td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">民族：</th>
        <td style="width:70%; text-align:left;"><input id="nation" name="nation" value="" type="text" class="input_2 txtinput1" /></td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">学历：</th>
        <td style="width:70%; text-align:left;">
        	<select name="edu" id="edu">   
	        <option value="高中">高中</option>   
	        <option value="大学专科">大学专科</option> 
	        <option value="大学本科">大学本科</option> 
	        <option value="研究生">研究生</option> 
        </td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">籍贯：</th>
        <td style="width:70%; text-align:left;">
		<select name="province" id="param_province" onchange="provincechange(this.selectedIndex)"><option>请选择省份</option></select>
  		<select name="city" id="param_city"><option>请选择城市</option></select>
        </td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">邮箱：</th>
        <td style="width:70%; text-align:left;"><input id="email" name="email" value="" type="text" class="input_2 txtinput1" /></td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">请上传一张照片：</th>
        <td style="width:70%; text-align:left;">
        	<input type="file" id="file-input" name="file-input" value="选择文件" />
        	<input type="hidden" id="filename" name="filename" value=""/>
        </td>
    </tr>
    
    <tr>
    <td colspan="2" style="text-align:center;"><input type="submit" id="btnSubmit" value="确认提交"  class="input2" /></td>
    </tr>
    
</table>
</form>
</div>

            </div>
        </div>
       
      
    </div>
      <div class="footer">
             <p>
                &copy;copyright 2018 超方系统 cfxt 版权所有 310</p>
        </div>
</body>
</html>
