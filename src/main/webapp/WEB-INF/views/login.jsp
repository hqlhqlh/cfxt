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
<script type="text/javascript" src="/js/yzm.js"></script>
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
  <div id="o-box-up" style="height: 450px;"></div>
  <div id="o-box-down"  style="table-layout:fixed;">
  		<% if(request.getAttribute("errmsg") != null){%>
  			<div class="error-box" id="ckuser">用户名或密码错误</div>
  		<%}%>
   		 <form action="Login" method="post">
	   <div class="fm-item">
		   <label for="logonId" class="form-label">超方系统登录：</label>
		   <input type="text" placeholder="请输入手机号" maxlength="11" id="phone" name="phone" class="i-text">    
	       <div class="ui-form-explain"></div>
	       <div class="error-box" id="ckphone"></div>
	  </div>
	  
	  <div class="fm-item">
		   <label for="logonId" class="form-label">登录密码：</label>
		   <input type="password" name="password" placeholder="请输入密码" maxlength="16" id="pwd" class="i-text" datatype="*8-12">    
	       <div class="ui-form-explain"></div>
	       <div class="error-box" id="ckpwd"></div>
	  </div>
	  <div class="fm-item">
		   <label for="logonId" class="form-label">
		   	<input type="radio" name="status" value="0" checked/>学生
		   	<input type="radio" name="status" value="1"/>老师
		   	<input type="radio" name="status" value="2"/>管理员
		   </label>
		   
	  </div>
	
	
  <div class="fm-item pos-r">
	   <label for="logonId" class="form-label">验证码:</label>
	   <input type="text"  maxlength="100" id="code_input" class="i-text yzm" placeholder="请输入验证码！" style="display: inline;float:left">    
       <div class="ui-form-explain" style="display: inline;float:left">
       	<div id="v_container" style="width: auto;height: auto;display: inline;float:right;margin-left: 10px;"></div>
       </div>
		<div class="error-box" id="ckyzm" style=" margin-top: 60px;"></div>
</div>
  <div class="fm-item">
	   <label for="logonId" class="form-label"></label>
	   <input type="submit" value="登录" tabindex="4"  class="btn-login">
       <div class="ui-form-explain"></div>
  </div>
  <div class="fm-item" style="margin-top: 5px;">
  	<p style="font-size: 12px;display:inline;">还没有账号？<a href="reg">立即注册</a></p>
  	<p style="font-size: 12px;float:none;display:inline;"><a href="forgetpwd" style="color: #f98803;">找回密码</a></p>
  </div>
  

  </div>
 </form>
</div>

	<div class="bd">
		<ul>
			<li style="background:url(themes/800.jpg) #CCE1F3 center 0;"></li>
		</ul>
	</div>

	<div class="hd"><ul></ul></div>
</div>
<script type="text/javascript">jQuery(".banner").slide({ titCell:".hd ul", mainCell:".bd ul", effect:"fold",  autoPlay:true, autoPage:true, trigger:"click" });</script>

 <script>
 
 $(function(){
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
	            }
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	userPwd('#pwd', "#ckpwd");
	
	var verifyCode = new GVerify("v_container");
   	function useryzm(inputid, spanid){
	    $(inputid).blur(function() {
	        if ($.trim($(inputid).val()).length == 0) {
	            $(spanid).html("请输入验证码");
	        } else {
	            if(!verifyCode.validate(document.getElementById("code_input").value)){
	                $("#ckyzm").html("验证码错误");
	            }
	        }
	        $(inputid).focus(function() {
	            $(spanid).html("");
	        });
	    });
	};
	useryzm('#code_input','#ckyzm');
 });
</script>

<div class="banner-shadow"></div>

<div class="footer">
   <p> &copy;copyright 2018 超方系统 cfxt 版权所有 310</p></p>
</div>
<div style="display:none"><script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540' language='JavaScript' charset='gb2312'></script></div>
</body>
</html>
