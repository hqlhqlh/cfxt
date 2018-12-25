<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="banner">
	<div class="bgh">
		<div class="page">
			<div id="logo">
				<a href="login"> <img src="Images/Student/logo.png" alt=""
					width="200" height="80" style="margin-top: -15px;" />
				</a>
			</div>
			<div class="topxx" style="padding-top: 20px;font-size: 12px;">
				学员：<%=(String) request.getSession().getAttribute("userName")%>，欢迎您！
				<a href="myinfo">我的信息</a> <a href="InfoNotice"> 通知</a> <a
					href="chPwd">密码修改</a> <a href="login">安全退出</a>
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
						<a href="myinfo">我的信息</a>
					</div>
					<div>
						<a href="signList">报名信息 </a>
					</div>
					<div>
						<a href="PayInfo">缴费信息</a>
					</div>

				</div>
				<div class="ta1">
					<strong>教务中心</strong>
					<div class="leftbgbt2"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="signUp">我要报名</a>
					</div>
					<div>
						<a href="cancelSignUp">取消报名</a>
					</div>
					<div>
						<a href="checkscore">我的成绩</a>
					</div>
				</div>
				<div class="ta1">
					<strong>学习中心</strong>
					<div class="leftbgbt2"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="downloadData">资料下载</a>
					</div>
					<div>
						<a href="#">学习中心</a>
					</div>
					<div>
						<a href="#">学习历程</a>
					</div>
				</div>

				<div class="ta1">
					<strong>通知中心</strong>
					<div class="leftbgbt2"></div>
				</div>
				<div class="cdlist">
					<div>
						<a href="xxtz">信息通知</a>
					</div>
					<div>
						<a href="#">温馨提示</a>
					</div>
					<div>
						<a href="studentMain">返回主页</a>
					</div>
					<div></div>
				</div>
			</div>
		</div>