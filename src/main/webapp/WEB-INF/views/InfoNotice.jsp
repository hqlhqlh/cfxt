<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	//1111111111111111111111111111111111111111111
	/*
	function checkmore(xid){
  		//var r=confirm("是否确认取消报名?!");
		//if(r==true){
				$.ajax({
					url : "/checkmore",
					type : "POST", 
					data :{
							'xid' : xid
					},
					success : function(data){
						if(data == 1){
							alert(data);
							window.location.href = 'InfoNoticeMore'
						}
					}
				});
		}
	*/
</script>

<script src="../Script/jquery-1.4.1.js" type="text/javascript"></script>
<link href="../Style/history.css" rel="stylesheet" type="text/css" />
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
				<div class="history">
					<div class="history-date">
						<ul id="hData">
						</ul>
					</div>
				</div>
				<div class="c-right-newslist">
				 <c:forEach items="${list}" var="list">
					<ul class="c-right-newslist-ul">
						<li>
						<span class="square"></span>
						 <a style="width:500px;"
							href="checkmore?xid=${list.xid}">${list.title}</a>
						<span class="date2"><fmt:formatDate value="${list.publishedtime}" var="date" pattern="yyyy-MM-dd"/>${date}</span>
						</li>
						
					</ul>
					</c:forEach>
					<div class="page-box clearFix">
						<!--分页-->
						<ul class="pagination pagination-lg" style="margin-left:40%;margin-top:3%;">
									<c:if test="${page!=1 }"><li><a href="said0?ipage=${page-1}"><i class="fa fa-angle-left">«</i></a></li></c:if>
									<c:if test="${page==1 }"><li class="disabled"><a onclick="fun1()"><i class="fa fa-angle-left">«</i></a></li></c:if>
									<c:forEach items="${a}" var="a" step="1" varStatus="i" >
										<li><a href="said0?ipage=${a}">${a}</a></li>
									</c:forEach>
									<c:if test="${page!=allpage}"><li><a href="said0?ipage=${page+1 }"><i class="fa fa-angle-right">»</i></a></li></c:if>
									<c:if test="${page==allpage}"><li class="disabled"><a onclick="fun2()"><i class="fa fa-angle-right">»</i></a></li></c:if>
					</ul>
					<h style="margin-top:5%;float:right;margin-right:5%;">共有${allpage }页,本页是第${page }页</h>
					</div>
					<!--分页/-->
				</div>
				<script type="text/javascript">
					function fun1(){
						alert("已经是第一页了！");
									}
					function fun2(){
						alert("已经是最后一页了！");
									}
				</script>

			</div>
		</div>
		<div class="footer">
			<p>&copy;copyright 2018 超方系统 cfxt 版权所有 310</p>
		</div>
	</div>
</body>
</html>
