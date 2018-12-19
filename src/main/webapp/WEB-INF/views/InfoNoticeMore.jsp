<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学生信息管理平台</title>
<link href="Style/StudentStyle.css" rel="stylesheet" type="text/css" />
<link href="Script/jBox/Skins/Blue/jbox.css" rel="stylesheet"
	type="text/css" />
<link href="Style/ks.css" rel="stylesheet" type="text/css" />
<link href="Style/my.css" rel="stylesheet" type="text/css" />
<script src="Script/jBox/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="Script/jBox/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="Script/jBox/i18n/jquery.jBox-zh-CN.js"
	type="text/javascript"></script>

<script src="Script/Common.js" type="text/javascript"></script>
<script src="Script/Data.js" type="text/javascript"></script>
<script type="text/javascript">
	$().ready(function() {
		setStudMsgHeadTabCheck();
		showUnreadSysMsgCount();
	});

	//我的信息头部选项卡
	function setStudMsgHeadTabCheck() {
		var currentUrl = window.location.href;
		currentUrl = currentUrl.toLowerCase();
		var asmhm = "";
		$("#ulStudMsgHeadTab li").each(function() {
			asmhm = $(this).find('a').attr("href").toLowerCase();
			if (currentUrl.indexOf(asmhm) > 0) {
				$(this).find('a').attr("class", "tab1");
				return;
			}
		});
	}

	//显示未读系统信息
	function showUnreadSysMsgCount() {
		var unreadSysMsgCount = "0";
		if (Number(unreadSysMsgCount) > 0) {
			$("#unreadSysMsgCount").html("(" + unreadSysMsgCount + ")");
		}
	}

	//退出
	function loginOut() {
		if (confirm("确定退出吗？")) {
			StudentLogin.loginOut(function(data) {
				if (data == "true") {
					window.location = "/Login.aspx";
				} else {
					jBox.alert("退出失败！", "提示", new {
						buttons : {
							"确定" : true
						}
					});
				}
			});
		}
	}
	//更改报考类别
	function changeCateory(thisObj, id) {
		var oldCateoryId = $("#cateoryId").val();
		var cateoryId = "";
		if (id != null) {
			cateoryId = id;
		} else {
			cateoryId = thisObj.val();
		}
		var studentId = $("#studentId").val();
		if (cateoryId.length <= 0) {
			jBox.tip("报考类别不能为空！");
			if (id == null) {
				thisObj.val(oldCateoryId);
			}
		} else {
			studentInfo.changeStudentCateory(cateoryId, function(data) {
				var result = $.parseJSON(data);
				if ( (String(result.ok) == "true") ) {
					window.location.href = "/Index.aspx";
				} else {
					jBox.tip(result.message);
				}
			});
		}
	}
</script>

<script src="/Script/jquery-1.4.1.js" type="text/javascript"></script>
<link href="/Style/history.css" rel="stylesheet" type="text/css" />
</head>
<body>

 <div class="banner">
        <div class="bgh">
            <div class="page">
                <div id="logo">
                    <a href="index.jsp">
                        <img src="Images/Student/logo.png" alt="" width="200" height="80" style="margin-top: -15px;"/>
                    </a>
                </div>
                <div class="topxx" style="padding-top: 20px;font-size: 12px;">
                     	学员：小明，欢迎您！ <a href="myinfo">我的信息</a> <a href="InfoNotice">
                        通知</a> <a href="chPwd">密码修改</a> <a href="login">安全退出</a>
                </div>
                
            </div>
        </div>
    </div>
    <div class="page">
        <div class="box mtop" style="margin-top: 50px;">
                        <div class="leftbox">
                <div class="l_nav2">
                    <div class="ta1">
                        <strong>个人中心</strong>
                        <div class="leftbgbt">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="myinfo">我的信息</a></div>
                        <div>
                            <a href="signList">报名信息 </a>
                        </div>
                        <div>
                            <a href="PayInfo">缴费信息</a></div>
                       
                    </div>
                    <div class="ta1">
                        <strong>教务中心</strong>
                        <div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="signUp">我要报名</a></div>
                        <div>
                        	<a href="cancelSignUp">取消报名</a></div>
                        <div>
                            <a href="signList">我的报名信息</a></div>
                        <div>
                            <a href="checkscore">我的成绩</a></div>
                    </div>
                    <div class="ta1">
                        <strong>学习中心</strong><div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="downloadData">资料下载</a></div>
                        <div>
                            <a href="#">学习中心</a></div>
                        <div>
                            <a href="#">学习历程</a></div>
                    </div>
                   
                    <div class="ta1">
                        <strong>通知中心</strong><div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="xxtz">信息通知</a></div>
                        <div>
                            <a href="#">温馨提示</a></div>
                        <div>
                         	<a href="studentMain">回到主页</a></div>
                        <div>
                    </div>

                </div>
            </div>
            </div>
			<div class="rightbox">

				<h2 class="mbx">通知中心 &gt; 信息通知</h2>

				<div class="c-right-newslist c-right-newsdetails">

					<div class="list-right-news">

						<div class="neirong">
							<!--内容页-->
							<p style=";text-indent: 14px">
								<span style="font-family:Calibri">&nbsp;</span>
							</p>
							<p style=";text-align: center">
								<span style=";font-family: 华文中宋;font-size: 29px">${list.title}</span>
							</p>
							<br>
							<p style=";text-indent: 14px">
								&nbsp; <span style=";font-family: 仿宋;font-size: 21px">
									&nbsp;&nbsp;&nbsp;&nbsp;${list.content}</span>
							</p>
							
							<p>
								<span style="font-family:Calibri">&nbsp;</span>
							</p>
							<p>
								<span style="font-family:Calibri">&nbsp;</span>
							</p>
							<p>
								<span style="font-family:Calibri">&nbsp;</span>
							</p>
							<p>
								<span style="font-family:Calibri">&nbsp;</span>
							</p>
							<p
								style=";text-align: right;line-height: 150%;text-indent: 187px">
								<span style=";line-height: 150%;font-family: 仿宋;font-size: 21px"><fmt:formatDate value="${list.publishedtime}" var="date" pattern="yyyy-MM-dd"/>${date}</span>
							</p>
							<p>
								<span style=";font-family: 仿宋;font-size: 21px">&nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; 发布人:</span><span
									style=";font-family: 仿宋;font-size: 21px">${list.publisher}</span>
							</p>
							<p style=";text-indent: 14px">
								<span style=";font-family: 仿宋;font-size: 21px"></span><br>
							</p>
							<p>
								<br>
							</p>
						</div>
						<!--内容页/-->

						<div class="close-box">
							<!--关闭-->
							<a href="javascript:window.print()">打印</a> <a
								href="javascript:vold(0);"
								onclick="javascript :history.back(-1);">返回</a> <a
								href="javascript:window.close()">关闭</a>
						</div>
						<!--关闭/-->

						<div class="clear"></div>

					</div>
				</div>

				<div class="footer">
					<p>&copy;copyright 2018 超方系统 cfxt 版权所有 310</p>
				</div>
			</div>
</body>
</html>
