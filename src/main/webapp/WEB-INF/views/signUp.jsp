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
    <script src="Script/jBox/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="Script/jBox/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <script src="Script/jBox/i18n/jquery.jBox-zh-CN.js" type="text/javascript"></script>
    <script src="Script/Common.js" type="text/javascript"></script>
    <script src="Script/Data.js" type="text/javascript"></script>
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
        //报名
         $(document).ready(function(){
            $("#subject").change(function(){
                var index = $(this).get(0).selectedIndex;
                $('.school').hide().removeClass("selectsc").eq(index).show().addClass("selectsc");
            });
        });
        function submit(){
        	var subject = $("#subject").val(); 
        	var testplace = $(".selectsc").val(); 
        	if(subject==null&&testplace==null){
        		$("#ckSign").html("");
        		return;
        	}
        	$.ajax({
				url : "/Sign",
				type : "POST", 
				data :{
						'subject' : subject,
						'testplace' : testplace
				},
				success : function(data){
					if(data != null){
						if(data==1){
							 $("#ckSign").html("报名失败！已过考试时间，详情关注考试信息<a href='ksxx'>考试信息</a>");
						}else if(data==2){
							 $("#ckSign").html("报名失败，重复报名！");
						}else if(data==3){
							$("#ckSign").html("报名成功！");
						}else{
							$("#ckSign").html("");
						}
						
							
					}
				}
			});
        
        };
    </script>
<style type="text/css">
    .txtinput1{width:180px;}
    .school{
        display: none;;
     }
     .school_first {
        display: block;
     }
    
</style>
</head>
<body onload="init()">

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
                            <a href="Score.jsp">我的成绩</a></div>
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
<h2 class="mbx">教务中心 &gt; 点击报名 &nbsp;&nbsp;&nbsp;</h2>

<div class="cztable">
	<div class="error-box" id="ckSign" style="color: red;margin: 5px 10px 10px;"></div>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" width="80">姓名：</td>
            <td>${user.username}&nbsp;</td>
            <td align="right" width="90">身份证号码：</td>
            <td>${user.idcard}&nbsp;</td>
            
            <td rowspan="9"><div align="center"><img id="pic_face"  height="160" width="120" src="../Images/Student/photo.jpg"/ style="padding:2px 2px 5px; border:1px #ddd solid;"></div>&nbsp;</td>
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
            <td colspan="4" align="left">联系方式（如联系方式有变动请及时修改，以便能及时联系到你。谢谢！）</td>
            
        </tr>
        <tr>
            <td align="right">个人邮箱：</td>
            <td>${user.edu}&nbsp;</td>
            <td align="right">手机号码：</td>
            <td>${user.phone}</td>
        </tr>
        <tr>
            <td align="right">学校选择：</td>
            <td>
	            <select class="school school_first">
				    <option>----请选择学校----</option>
				</select>
				<c:forEach  items="${listTestPlace}" var="TestPlace">
		                <select name="school"  class="school"> 
		                <c:forEach  items="${TestPlace}" var="testPlace">    
		                    <option value="${testPlace}">${testPlace}</option>
		                     </c:forEach>
		                </select> 
                </c:forEach>
                
            </td>
            <td align="right">科目选择：</td>
            <td>
                <select name="subject" id="subject">
                	<option>----请选择科目----</option>
                	<c:forEach  items="${SubjectsList}" var="sub">   
	                    <option value=${sub.sid}>${sub.subject}</option>
	                </c:forEach>
	            </select>
            </td>
        </tr>
        
        <tr align="center">
            <td colspan="5" height="40">
           
                <div align="center">
                    
                    <input type="button" id="button2" value="点击报名" onclick="submit()" class="input2" />
                </div>
            </td>
        </tr>
    </table>
</div>

        <div class="footer">
            <p>
                &copy;copyright 2018 超方系统 cfxt 版权所有 310</p>
        </div>
    </div>
</body>
</html>
