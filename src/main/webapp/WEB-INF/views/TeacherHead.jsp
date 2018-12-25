<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="banner">
	<div class="bgh">
		<div class="page">
			<div id="logo">
				<a href="index.jsp"> <img src="Images/Student/logo.png" alt=""
					width="200" height="80" style="margin-top: -15px;" />
				</a>
			</div>
			<div class="topxx" style="padding-top: 20px;font-size: 12px;">
				教师：<%=(String) request.getSession().getAttribute("userName")%>，欢迎您！
				<a href="teacherInfo">我的信息</a> <a href="#"> 通知</a> <a href="#">密码修改</a>
				<a href="login">安全退出</a>
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
					<div class="leftbgbt"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="teacherInfo">我的信息</a>
					</div>
					<div>
						<a href="sInvigilatorInfo">监考信息 </a>
					</div>
				</div>
				<div class="ta1">
					<strong>成绩管理</strong>
					<div class="leftbgbt2"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="subjectshow">成绩录入</a>
					</div>
					<div>
						<a href="sGradeRevision">成绩修改</a>
					</div>
					<div>
						<a href="exportExcelpg">成绩导出</a>
					</div>
				</div>
				<div class="ta1">
					<strong>通知中心</strong>
					<div class="leftbgbt2"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="#">信息通知</a>
					</div>
					<div>
						<a href="teacherMain">返回主页</a>
					</div>
					<div></div>
				</div>
			</div>
		</div>