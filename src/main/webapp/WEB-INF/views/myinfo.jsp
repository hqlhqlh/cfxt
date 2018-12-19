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
    
    <script type="text/javascript">
        function submitMail() {
            var mtitle = "联系方式有修改";
            var html = "<div style='padding:10px;'><div style='width:65px; height:120px; float:left;'>修改的地方：</div><div style='width:250px; height:120px; float:left;'><textarea id='objeCont' name='objeCont' style='width:250px; height:105px;'></textarea></div></div>";

            var submit = function (v, h, f) {
                if (f.objeCont == '' || f.objeCont.length > 80) {
                    $.jBox.tip("请您输入有修改的地方，且不超过80个字！", 'error', { focusId: "objeCont" }); // 关闭设置 objeCont 为焦点
                    return false;
                }

                StudentCompain.insertCompain('', mtitle, 5, f.objeCont, function (data) {
                    var obj = $.parseJSON(data);
                    var resultObj = false;
                    if (obj.ok) {
                        $.jBox.tip("成功提交联系方式的修改邮件！");
                    }
                });
            };

            $.jBox(html, { title: "联系方式修改的邮件", submit: submit });
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
<h2 class="mbx">我的信息 &gt; 个人资料 &nbsp;&nbsp;&nbsp;</h2>       
<div class="morebt">
    

</div>
<div class="cztable">
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" width="80">姓名：</td>
            <td>${user.username}&nbsp;</td>
            <td align="right" width="90">身份证号码：</td>
            <td>${user.idcard}&nbsp;</td>
            
            <td rowspan="9"><div align="center">
            	<img id="pic_face"  height="160" width="120" src="/photo/${user.photo}" style="padding:2px 2px 5px; border:1px #ddd solid;"></div>
            &nbsp;</td>
        </tr>
        <tr>
            <td align="right">性别：</td>
            <td>${user.sex}&nbsp;</td>
            <td align="right">民族：</td>
            <td>${user.nation}&nbsp;</td>
        </tr>
        <tr>
            <td align="right">籍贯：</td>
            <td>${user.nativeplace}&nbsp;</td>
            <td align="right">学历：</td>
            <td>${user.edu}&nbsp;</td>
        </tr>
        <tr>
            <td align="right">个人邮箱：</td>
            <td>${user.edu}&nbsp;</td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td colspan="4" align="left">联系方式（如联系方式有变动请及时修改，以便能及时联系到你。谢谢！）</td>
            
        </tr>
        <tr>
            <td align="right">手机号码：</td>
            <td>${user.phone}</td>
            <td align="right"></td>
            <td></td>
           
        </tr>
        
        <tr align="center">
            <td colspan="5" height="40">
                <div align="center">
                    
                    <input type="button" id="button2" value="联系方式有修改" onclick="submitMail()" class="input2" />
                </div>
            </td>
        </tr>
    </table>
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
