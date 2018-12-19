<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>
    学生信息管理平台
</title><link href="/Style/StudentStyle.css" rel="stylesheet" type="text/css" /><link href="Script/jBox/Skins/Blue/jbox.css" rel="stylesheet" type="text/css" /><link href="Style/ks.css" rel="stylesheet" type="text/css" />
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
    function downloadD(address) {
		var form = $("<form>");   //定义一个form表单
	    form.attr('style', 'display:none');   //在form表单中添加查询参数
	    form.attr('target', '');
	    form.attr('method', 'get');
	    form.attr('action', "downloadD");
	    var input1 = $('<input>');
	    input1.attr('type', 'hidden');
	    input1.attr('name', 'address');
	    input1.attr('value', address);
	    $('body').append(form);  //将表单放置在web中 
	    form.append(input1);   //将查询参数控件提交到表单上
	    form.submit();
    }
</script>   
    <script src="/Script/Common.js" type="text/javascript"></script>
  
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
                            <a href="myinfo">我的信息</a></div>
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
                
    <h2 class="mbx">
        学习中心 &gt; <a href="Download">资料下载</a></h2>
    <div class="feilei">
        <a href="#"><strong>资料中心</strong></a></div>
    <input type="hidden" id="cValue" value="" />
    <input type="hidden" id="tValue" value="" />
    <div class="fllist">
        <ul>
            <li><strong>科目：</strong><a href="downloadData" id="cAll" >全部</a>
               <c:forEach items="${sublist}" var="list" varStatus="status">
               	 <a href="downloadsub?sub=${list.subject}">${list.subject}</a>
               </c:forEach>
            </li>
            
        </ul>
        <div class="cztable"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="text-align:center;">
                <tr>
                    <th style="padding-left: 10px;width:20%" >  序号        </th>
                    <th style="width: 20%; text-align: center;">  资料名称</th>
                    <th style="width: 20%; text-align: center;"> 资料类型</th>
                    <th style="width: 20%; text-align: center;">   操作</th>
                </tr>
                <c:forEach items="${flgbslist}" var="list" varStatus="status">
	                <tr>
	                    <td>${status.index + 1} </td>
	                    <td>${list.subject}</td>
	                    <td>${list.type}</td>
	                    <td>
	                        <a href="javascript:;" onclick="downloadD('${list.address}')"><img src="/images/down.gif" alt="点击下载" /></a>
	                    </td>
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
