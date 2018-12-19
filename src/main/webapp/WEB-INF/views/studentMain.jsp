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
</title><link href="Style/StudentStyle.css" rel="stylesheet" type="text/css" /><link href="Script/jBox/Skins/Blue/jbox.css" rel="stylesheet" type="text/css" /><link href="Style/ks.css" rel="stylesheet" type="text/css" />
<link href="/Style/my.css" rel="stylesheet" type="text/css" />
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
    
    <script src="Script/changeOption.js" type="text/javascript"></script>
    <script src="Script/rl.js" type="text/javascript"></script>
</head>
<body>



    <div class="banner">
        <div class="bgh">
            <div class="page">
                <div id="logo">
                    <a href="login">
                        <img src="Images/Student/logo.png" alt="" width="200" height="80" style="margin-top: -15px;"/>
                    </a>
                </div>
                <div class="topxx" style="padding-top: 20px;font-size: 12px;">
                     	学员：小明，欢迎您！ <a href="myinfo">我的信息</a> <a href="InfoNotice">
                        通知</a> <a href="chPwd">密码修改</a> <a 
                            href="login">安全退出</a>
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
                        	<a href="#">返回主页</a></div>
                        <div>
                    </div>
 				  </div>
                </div>
            </div>
<div class="rightbox">

    <div class="dhbg">
        <div class="dh1" style="margin: 0 27px 15px 0;">
            <div class="dhwz">
                <p>
                    你应交<span class="blue">10</span> 元，实缴 <span class="green">10</span>元</p>
                    <p>
                    欠费 <span class="red">20</span> 元</p>
                <p>
                <div class="btright">
                    <a href="PayInfo.jsp">
                        查看缴费信息</a></div>
            </div>
        </div>
        <div class="dh2">
            <div class="dhwz">
                <p>
                    你有 <span class="red">2</span> 门课程要考 <a href="EducationCenter/Application.aspx.html" class="red">查看报考计划</a></p>
                <p>
                    你已经通过 <span class="red">0 </span>门课程&nbsp;共有 <span class="red">2</span> 门 <a href="EducationCenter/Score.aspx.html" class="red">查看成绩</a>
                </p>
            </div>
        </div>
        
    </div>

    <div class="c-right-newslist">
            <ul class="c-right-newslist-ul">
                <li><span class="square"></span><a style="width:500px;" href="index.php?c=index&amp;a=news_detail&amp;id=3824&amp;web=chinese">关于格致楼原玻璃房乒乓室改为自修室的通知</a><span class="date2">2018-11-26</span></li><li><span class="square"></span><a style="width:500px;" href="index.php?c=index&amp;a=news_detail&amp;id=3738&amp;web=chinese">关于班车2号线始发站点调整的通知</a><span class="date2">2018-11-05</span></li><li><span class="square"></span><a style="width:500px;" href="index.php?c=index&amp;a=news_detail&amp;id=3725&amp;web=chinese">关于举办杭州电子科技大学信息工程学院第二届田径运动会的通知</a><span class="date2">2018-11-01</span></li><li><span class="square"></span><a style="width:500px;" href="index.php?c=index&amp;a=news_detail&amp;id=3715&amp;web=chinese">信息工程学院分工会关于“享秋日情韵、与健康同行”活动的通知</a><span class="date2">2018-10-29</span></li><li><span class="square"></span><a style="width:500px;" href="index.php?c=index&amp;a=news_detail&amp;id=3676&amp;web=chinese">关于班车2号线恢复文一校区（北门公交站）停靠点的通知</a><span class="date2">2018-10-15</span></li><li><span class="square"></span><a style="width:500px;" href="index.php?c=index&amp;a=news_detail&amp;id=3658&amp;web=chinese">关于举办杭州电子科技大学信息工程学院图书馆数字资源使用培训讲座的通知</a><span class="date2">2018-09-30</span></li><li><span class="square"></span><a style="width:500px;" href="index.php?c=index&amp;a=news_detail&amp;id=3657&amp;web=chinese">          
            </ul>
            
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
