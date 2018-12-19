<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>
    学生信息管理平台
</title><link href="/Style/StudentStyle.css" rel="stylesheet" type="text/css" />
	<link href="/Script/jBox/Skins/Blue/jbox.css" rel="stylesheet" type="text/css" />
	<link href="/Style/ks.css" rel="stylesheet" type="text/css" />
    <script src="/Script/jBox/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/Script/jBox/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <script src="/Script/jBox/i18n/jquery.jBox-zh-CN.js" type="text/javascript"></script>
    <script src="/Script/Common.js" type="text/javascript"></script>
    <script src="/Script/Data.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function () {
            setStudMsgHeadTabCheck();
            showUnreadSysMsgCount();
        });

        //我的信息头部选项卡
        function setStudMsgHeadTabCheck() {
            var currentUrl = window.location.href;
            currentUrl = currentUrl.toLowerCase();
            var asmhm = "";
            $("#ulStudMsgHeadTab li").each(function () {
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
                StudentLogin.loginOut(function (data) {
                    if (data == "true") {
                        window.location = "/Login.aspx";
                    }
                    else {
                        jBox.alert("退出失败！", "提示", new { buttons: { "确定": true} });
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
            }
            else {
                cateoryId = thisObj.val();
            }
            var studentId = $("#studentId").val();
            if (cateoryId.length <= 0) {
                jBox.tip("报考类别不能为空！");
                if (id == null) {
                    thisObj.val(oldCateoryId);
                }
            }
            else {
                studentInfo.changeStudentCateory(cateoryId, function (data) {
                    var result = $.parseJSON(data);
                    if ((String(result.ok) == "true")) {
                        window.location.href = "/Index.aspx";
                    }
                    else {
                        jBox.tip(result.message);
                    }
                });
            }
        }
    </script>
    
<script type="text/javascript" language="javascript">

    function confirmStatus(pid, ptype) {
        if (confirm("确定取消报名么？") == true) {
            financialInfor.modifyStudentPaymentStatus(pid, ptype, function (data) {
                var result = $.parseJSON(data);
                if ((String(result.ok) == "true")) {
                    jBox.alert(result.message, "提示");
                    setTimeout(function () {
                        window.location.reload();
                    }, 1500);
                }
                else {
                    $.jBox.error(result.message, '提示');
                }
            });
        }
    }

    function submitObjection(pid) {
        var mtitle = "缴费有异议";
        var html = "<div style='padding:10px;'><div style='width:65px; height:120px; float:left;'>异议内容：</div><div style='width:250px; height:120px; float:left;'><textarea id='objeCont' name='objeCont' style='width:250px; height:105px;'></textarea></div></div>";

        var submit = function (v, h, f) {
            if (f.objeCont == '' || f.objeCont.length > 80) {
                $.jBox.tip("请您输入异议内容，且不超过80个字！", 'error', { focusId: "objeCont" }); // 关闭设置 objeCont 为焦点
                return false;
            }

            StudentCompain.insertCompain('', mtitle, 2, f.objeCont, function (data) {
                var obj = $.parseJSON(data);
                var resultObj = false;
                if (obj.ok) {
                    financialInfor.modifyStudentPaymentStatus(pid, 3, function (data) {
                        var result = $.parseJSON(data);
                        if ((String(result.ok) == "true")) {
                            jBox.alert("成功提交异议！", "提示");
                            setTimeout(function () {
                                window.location.reload();
                            }, 1500);
                        }
                        else {
                            jBox.tip("提交异议失败！");
                            return false;
                        }
                    });
                }
                else {
                    jBox.tip("提交异议失败！");
                }
            });
        };

        $.jBox(html, { title: "提交异议", submit: submit });
    }
</script>
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
                     910513201419学员：邹智，欢迎您！ <a href="MyInfo.jsp">我的信息</a> <a href="systemMsge.jsp">
                        通知</a> <a href="ChangePasswd.jsp">密码修改</a> <a onclick="loginOut()"
                            href="javascript:">安全退出</a>
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
                            <a href="MyInfo.jsp">我的信息</a></div>
                        <div>
                            <a href="ClassInfo.jsp">报名信息 </a>
                        </div>
                        <div>
                            <a href="PayInfo.jsp">缴费信息</a></div>
                       
                    </div>
                    <div class="ta1">
                        <strong>教务中心</strong>
                        <div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="Application.jsp">我要报名</a></div>
                        <div>
                            <a href="checkscore">我的成绩</a></div>
                    </div>
                    <div class="ta1">
                        <strong>学习中心</strong><div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="StudentMaterial.jsp">资料下载</a></div>
                        <div>
                            <a href="index.jsp">111111</a></div>
                        <div>
                            <a href="index.jsp">111111</a></div>
                    </div>
                   
                    <div class="ta1">
                        <strong>通知中心</strong><div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="wdcw.jsp">信息通知</a></div>
                        <div>
                            <a href="index.jsp">111111</a></div>
                        <div>
                            <a href="index.jsp">111111</a></div>
                        <div>
                            <a href="index.jsp">111111</a></div>
                    </div>

                </div>
            </div>
            <div class="rightbox">

<h2 class="mbx">教务中心 &gt; 我的成绩</h2>
<div class="cztable">
    <div style="padding-bottom:20px;">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr align="center">
            <th>序号</th>
            <th>考试项目</th>
            <th>考试时间</th>
            <th>考试分数</th>
        </tr>
    <c:forEach items="${list}" var="list" varStatus="status">
   	  <tr>   	  	
   	  	 <th>${status.index + 1}<br></th>
   		 <th>${list.subject}<br></th>
   		 <th><fmt:formatDate value="${list.testtime}" var="date" pattern="yyyy-MM-dd"/>${date}<br></th>			 
		 <th>${list.score}</th>
		 
		</tr>	
	</c:forEach>	
   
    
    </table>
    </div>

</div>

            </div>
        </div>
        <div class="footer">
            <p>
                &copy;copyright 2018 超方系统 cfxt 版权所有 310</p>
        </div>
    </div>
</body>
</html>
