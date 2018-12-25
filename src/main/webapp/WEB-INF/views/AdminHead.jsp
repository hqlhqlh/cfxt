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
				管理员：<%=(String) request.getSession().getAttribute("userName")%>，欢迎您！
				<a href="AdminiInfo">我的信息</a> <a href="#"> 通知</a> <a href="#">密码修改</a>
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
						<a href="AdminiInfo">我的信息</a>
					</div>
					<div>
						<a href="#">修改密码</a>
					</div>
				</div>
				<div class="ta1">
					<strong>权限管理</strong>
					<div class="leftbgbt2"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="AddUser">添加用户</a>
					</div>
					<div>
						<a href="#">删除用户</a>
					</div>
				</div>
				<div class="ta1">
					<strong>考生管理</strong>
					<div class="leftbgbt"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="AdminManagementUser">信息管理</a>
					</div>
					<div>
						<a href="#">报名管理</a>
					</div>
					<div>
						<a href="#">成绩信息管理</a>
					</div>
					<div>
						<a href="Passcheck">合格人数统计</a>
					</div>

				</div>
				<div class="ta1">
					<strong>考试管理</strong>
					<div class="leftbgbt"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="AddSubject">考试信息管理</a>
					</div>
					<div>
						<a href="#">考点管理</a>
					</div>
					<div>
						<a href="Arrangement">考场安排</a>
					</div>
					<div>
						<a href="Admincheck">报名人数统计</a>
					</div>
					<div>
						<a href="#">编写公告</a>
					</div>
				</div>
			</div>
		</div>