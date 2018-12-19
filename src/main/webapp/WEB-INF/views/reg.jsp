<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统登录</title>
<link href="/css/login.css" rel="stylesheet" rev="stylesheet" type="text/css" media="all" />
<link href="/css/demo.css" rel="stylesheet" rev="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="/js/jquery1.42.min.js"></script>

<script>
$(function(){
	var p = false;var y = false;var m =false;var m2 =false;var yzm="a";
	function isPhoneNo(phone) {
	    var pattern = /^1[34578]\d{9}$/;
	    return pattern.test(phone);
	}
	function userTel(inputid, spanid) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请输入手机号码");
	        } else {
	            if (isPhoneNo($.trim($(inputid).val())) == false) {
	                $(spanid).html("手机号码格式不正确");
	            }else{
	            	p = true;
	            }
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userTel('#phone', "#ckphone");
	
	function userPwd(inputid, spanid) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请输入密码");
	        } else {
	        	var t =  $.trim($(inputid).val());
	            if( t.length < 8 ){
	                $(spanid).html("密码过短最少八位");
	            }else{
	            	m = true;
	            }
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userPwd('#password', "#ckpwd");
	
	function userPwd2(inputid, spanid,inputid2) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请重复输入密码");
	        } else {
	            if( $.trim($(inputid).val()) != $.trim($(inputid2).val())){
	                $(spanid).html("两次密码不同");
	            }else{
	            	m2 = true;
	            }
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userPwd2('#password2', "#ckpwd2","#password");
	
	function userYZM(inputid, spanid) {
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请输入验证码");
	        } else {
	            if( $.trim($(inputid).val()) != yzm){
	                $(spanid).html("验证码有误");
	            }else{
	            	y = true;
	            }
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userYZM('#yzm',"#ckyzm");
	
	$("#VFC").click(function() {
		if(p){
			$.ajax({
				url : "/RegPhone",
				type : "POST", 
				data :{
						'phone' : $("#phone").val()
				},
				success : function(data){
					if(data != null){
						if(data==1){
							 $("#ckphone").html("该用户已注册");
						}else{	
							alert("已发送");
							yzm = data;
						}
					}
				}
			});
		}	
	  });
	    
	    $("#zc").click(function() {
			if(p&&y&&m&&m2){
				$.ajax({
					url : "/RegUser",
					type : "POST", 
					data :{
							'phone' : $("#phone").val(),
							'password' : $("#password").val()
					},
					success : function(data){
						if(data == 1 ){	
						     window.location.href = 'perfectmsg'
						}else{
							alert("修改失败");
						}
					}
				});
			}
	    });
	
	}); 

</script>
<script type="">
var countdown=60; 
		function sendemail(){
		    var obj = $("#VFC");
		    settime(obj);
		    
		    }
		function settime(obj) { //发送验证码倒计时
		    if (countdown == 0) { 
		        obj.attr('disabled',false); 
		        //obj.removeattr("disabled"); 
		        obj.val("点击发送");
		        countdown = 60; 
		        return;
		    } else { 
		        obj.attr('disabled',true);
		        obj.val("重新发送(" + countdown + ")");
		        countdown--; 
		    } 
		setTimeout(function() { 
		    settime(obj) }
		    ,1000) 
		}
</script>
<style>
	.i-text {
    height: 28px!important;
    }
    label.form-label {
    line-height: 0px!important;
    }
    .yzm-img {
    top: 10px!important;
    }
</style>

</head>

<body>
<div class="header">
  <h1 class="headerLogo"><a title="考试管理管理系统" target="_blank" href=" "><img alt="logo" src="images/logo.png" style="width: 261px;height: 107px;""></a></h1>
	<div class="headerNav">
		<a target="_blank" href=" ">超方官网</a>
		<a target="_blank" href=" ">关于超方</a>
		<a target="_blank" href=" ">开发团队</a>
		<a target="_blank" href=" ">意见反馈</a>
		<a target="_blank" href=" ">帮助</a>	
	</div>
</div>

<div class="banner">

<div class="login-aside">
  <div id="o-box-up"></div>
  <div id="o-box-down"  style="table-layout:fixed;">
   
   
  
   <div class="fm-item">
	   <label for="logonId" class="form-label">超方系统注册：</label>
	   <input type="text" value="" id="phone" placeholder="输入注册的手机号" maxlength="11" id="username" class="i-text" style="display:inline;width: 150px;" >    
      <input type="submit" value="点击发送" id="VFC" tabindex="4" class="btn-login" onclick="sendemail()" style="display:inline;width: 85px;height: 29px;"> 
		<div class="error-box" id="ckphone"></div>
       <div class="ui-form-explain"></div>
  </div>
    <div class="fm-item pos-r">
	   <label for="logonId" class="form-label">输入验证码：</label>
	   <input type="text" placeholder="输入验证码" maxlength="10" id="yzm" class="i-text yzm" style="width: 240px;">    
       <div class="error-box" id="ckyzm"></div>
       <div class="ui-form-explain"></div>
  </div>
  
  <div class="fm-item">
	   <label for="logonId" class="form-label">设置密码：</label>
	   <input type="password"  id="password" maxlength="16"  class="i-text" datatype="*8-12" >
		<div class="error-box" id="ckpwd"></div>
<!--	   <div class="passwordStrength"><b>密码强度：</b><span>弱</span> <span>中</span><span class="last">强</span>   -->

       <label for="logonId" class="form-label">重复密码：</label>
	   <input type="password" id="password2" maxlength="16"  class="i-text" datatype="*">    
       <div class="error-box" id="ckpwd2"></div>
       <div class="ui-form-explain"></div>
  </div>
  
  

  
  <div class="fm-item">
	   <label for="logonId" class="form-label"></label>
	   <input type="submit" value="注册" id="zc" tabindex="4"  class="btn-login"> 
       <div class="ui-form-explain"></div>
  </div>
  <div class="fm-item" style="margin-top: 5px;">
  	<p style="font-size: 12px;display:inline;">已有账号？<a href="login">立即登录</a></p>
  	<p style="font-size: 12px;float:none;display:inline;"><a href="forgetpwd" style="color: #f98803;">找回密码</a></p>
  </div>
  
 
  </div>

</div>

	<div class="bd">
		<ul>
			<li style="background:url(themes/800.jpg) #CCE1F3 center 0;"></li>
		</ul>
	</div>

	<div class="hd"><ul></ul></div>
</div>

<div class="banner-shadow"></div>

<div class="footer">
   <p> &copy;copyright 2018 超方系统 cfxt 版权所有 310</p></p>
</div>
	
</div>
</body>
</html>

