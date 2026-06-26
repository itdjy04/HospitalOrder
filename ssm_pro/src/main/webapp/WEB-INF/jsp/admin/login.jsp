<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	session.setAttribute("mybasePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理员登录 - 苏州市医院预约挂号系统</title>
<link rel="stylesheet" href="${mybasePath}assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${mybasePath}assets/font-awesome/css/font-awesome.min.css">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
html, body { height: 100%; }

body {
	font-family: "Microsoft YaHei", "微软雅黑", "Helvetica Neue", Arial, sans-serif;
	background: linear-gradient(135deg, #0d47a1 0%, #1565c0 25%, #1976d2 40%, #1e88e5 55%, #2196f3 70%, #42a5f5 85%, #64b5f6 100%);
	background-attachment: fixed;
	position: relative;
	overflow-x: hidden;
}

/* ---- 装饰性医疗十字背景 ---- */
body::before {
	content: '';
	position: fixed;
	top: 0; left: 0; right: 0; bottom: 0;
	background-image:
		radial-gradient(circle at 15% 20%, rgba(255,255,255,0.06) 0%, transparent 50%),
		radial-gradient(circle at 85% 75%, rgba(255,255,255,0.05) 0%, transparent 50%),
		radial-gradient(circle at 50% 50%, rgba(255,255,255,0.03) 0%, transparent 70%);
	pointer-events: none;
	z-index: 0;
}

/* ---- 十字装饰点阵 ---- */
.cross-pattern {
	position: fixed;
	top: 0; left: 0; right: 0; bottom: 0;
	background-image:
		linear-gradient(rgba(255,255,255,0.04) 1px, transparent 1px),
		linear-gradient(90deg, rgba(255,255,255,0.04) 1px, transparent 1px);
	background-size: 60px 60px;
	pointer-events: none;
	z-index: 0;
}

/* ---- 浮动医疗十字图标 ---- */
.floating-icons {
	position: fixed;
	top: 0; left: 0; right: 0; bottom: 0;
	pointer-events: none;
	z-index: 0;
}
.floating-icons .icon-item {
	position: absolute;
	color: rgba(255,255,255,0.08);
	font-size: 40px;
	animation: floatUp 12s infinite ease-in;
}
.floating-icons .icon-item:nth-child(1)  { left: 8%;  bottom: -60px; font-size: 50px; animation-delay: 0s; animation-duration: 14s; }
.floating-icons .icon-item:nth-child(2)  { left: 22%; bottom: -60px; font-size: 35px; animation-delay: 3s; animation-duration: 11s; }
.floating-icons .icon-item:nth-child(3)  { left: 38%; bottom: -60px; font-size: 55px; animation-delay: 6s; animation-duration: 15s; }
.floating-icons .icon-item:nth-child(4)  { left: 55%; bottom: -60px; font-size: 42px; animation-delay: 1.5s; animation-duration: 13s; }
.floating-icons .icon-item:nth-child(5)  { left: 70%; bottom: -60px; font-size: 48px; animation-delay: 4.5s; animation-duration: 10s; }
.floating-icons .icon-item:nth-child(6)  { left: 85%; bottom: -60px; font-size: 38px; animation-delay: 7.5s; animation-duration: 16s; }
.floating-icons .icon-item:nth-child(7)  { left: 15%; bottom: -60px; font-size: 32px; animation-delay: 9s; animation-duration: 12s; }
.floating-icons .icon-item:nth-child(8)  { left: 48%; bottom: -60px; font-size: 44px; animation-delay: 5.5s; animation-duration: 17s; }
.floating-icons .icon-item:nth-child(9)  { left: 92%; bottom: -60px; font-size: 52px; animation-delay: 2s; animation-duration: 13.5s; }
.floating-icons .icon-item:nth-child(10) { left: 65%; bottom: -60px; font-size: 36px; animation-delay: 8s; animation-duration: 14.5s; }

@keyframes floatUp {
	0%   { transform: translateY(0) rotate(0deg); opacity: 0; }
	5%   { opacity: 0.12; }
	50%  { opacity: 0.06; }
	95%  { opacity: 0.10; }
	100% { transform: translateY(-110vh) rotate(25deg); opacity: 0; }
}

/* ---- 顶部装饰光带 ---- */
.top-glow {
	position: fixed;
	top: 0; left: 0; right: 0;
	height: 3px;
	background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), rgba(255,255,255,0.8), rgba(255,255,255,0.5), transparent);
	z-index: 1;
	animation: shimmerLine 3s infinite;
}
@keyframes shimmerLine {
	0%   { opacity: 0.4; }
	50%  { opacity: 1; }
	100% { opacity: 0.4; }
}

/* ---- 主容器 ---- */
.login-wrapper {
	position: relative;
	z-index: 2;
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
	padding: 20px;
}

/* ---- 左侧品牌区 ---- */
.brand-panel {
	flex: 0 0 420px;
	padding: 40px 50px;
	color: #fff;
	text-align: left;
}
.brand-panel .brand-icon {
	width: 70px; height: 70px;
	background: rgba(255,255,255,0.18);
	border-radius: 18px;
	display: flex; align-items: center; justify-content: center;
	font-size: 36px;
	margin-bottom: 24px;
	backdrop-filter: blur(4px);
	border: 1px solid rgba(255,255,255,0.25);
}
.brand-panel h1 {
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 12px;
	letter-spacing: 2px;
	text-shadow: 0 2px 10px rgba(0,0,0,0.2);
}
.brand-panel h1 span { font-weight: 300; }
.brand-panel .subtitle {
	font-size: 15px;
	opacity: 0.85;
	line-height: 1.8;
	margin-bottom: 30px;
}
.brand-panel .feature-list {
	list-style: none;
	padding: 0;
}
.brand-panel .feature-list li {
	padding: 8px 0;
	font-size: 14px;
	opacity: 0.80;
}
.brand-panel .feature-list li i {
	margin-right: 10px;
	width: 20px;
	text-align: center;
	color: rgba(255,255,255,0.9);
}

/* ---- 右侧登录卡片 ---- */
.login-card {
	flex: 0 0 400px;
	background: #fff;
	border-radius: 12px;
	padding: 40px 36px;
	box-shadow: 0 20px 60px rgba(0,0,0,0.25), 0 4px 16px rgba(0,0,0,0.15);
	position: relative;
	overflow: hidden;
}
.login-card::before {
	content: '';
	position: absolute;
	top: 0; left: 0; right: 0;
	height: 4px;
	background: linear-gradient(90deg, #0d47a1, #1976d2, #42a5f5, #1976d2, #0d47a1);
}
.login-card .card-header-icon {
	text-align: center;
	margin-bottom: 6px;
}
.login-card .card-header-icon .circle {
	display: inline-flex;
	align-items: center; justify-content: center;
	width: 64px; height: 64px;
	border-radius: 50%;
	background: linear-gradient(135deg, #e3f2fd, #bbdefb);
	color: #1565c0;
	font-size: 28px;
}
.login-card h3 {
	text-align: center;
	color: #1565c0;
	font-weight: 700;
	margin-bottom: 6px;
	font-size: 20px;
	letter-spacing: 1px;
}
.login-card .card-sub {
	text-align: center;
	color: #999;
	font-size: 13px;
	margin-bottom: 24px;
}

/* ---- 输入框美化 ---- */
.login-card .form-group { margin-bottom: 18px; position: relative; }
.login-card .form-group label {
	font-weight: 600;
	color: #444;
	font-size: 13px;
	margin-bottom: 6px;
	display: block;
}
.login-card .input-icon-wrap {
	position: relative;
}
.login-card .input-icon-wrap .input-icon {
	position: absolute;
	left: 14px; top: 50%;
	transform: translateY(-50%);
	color: #90caf9;
	font-size: 16px;
	z-index: 2;
	transition: color 0.3s;
}
.login-card .input-icon-wrap input {
	height: 44px;
	padding: 8px 14px 8px 40px;
	border-radius: 8px;
	border: 2px solid #e0e0e0;
	font-size: 14px;
	transition: all 0.3s;
	width: 100%;
	outline: none;
}
.login-card .input-icon-wrap input:focus {
	border-color: #1976d2;
	box-shadow: 0 0 0 3px rgba(25,118,210,0.10);
}
.login-card .input-icon-wrap input:focus + .input-icon,
.login-card .input-icon-wrap input:focus ~ .input-icon { color: #1976d2; }

/* ---- 登录按钮 ---- */
.login-card .btn-login {
	height: 46px;
	border: none;
	border-radius: 8px;
	width: 100%;
	font-size: 16px;
	font-weight: 600;
	letter-spacing: 3px;
	color: #fff;
	background: linear-gradient(135deg, #1565c0, #1976d2, #1e88e5);
	box-shadow: 0 4px 14px rgba(21,101,192,0.35);
	transition: all 0.3s;
	cursor: pointer;
	margin-top: 6px;
}
.login-card .btn-login:hover {
	transform: translateY(-1px);
	box-shadow: 0 6px 20px rgba(21,101,192,0.45);
	background: linear-gradient(135deg, #0d47a1, #1565c0, #1976d2);
}
.login-card .btn-login:active {
	transform: translateY(0);
	box-shadow: 0 2px 8px rgba(21,101,192,0.30);
}

/* ---- 底部链接 ---- */
.login-card .card-footer-links {
	text-align: center;
	margin-top: 22px;
	padding-top: 16px;
	border-top: 1px solid #f0f0f0;
}
.login-card .card-footer-links a {
	color: #1976d2;
	font-size: 13px;
	text-decoration: none;
	transition: color 0.2s;
}
.login-card .card-footer-links a:hover {
	color: #0d47a1;
	text-decoration: underline;
}
.login-card .card-footer-links .divider {
	color: #ddd;
	margin: 0 10px;
}

/* ---- 错误提示 ---- */
.login-card .alert {
	border-radius: 8px;
	padding: 10px 14px;
	font-size: 13px;
	margin-bottom: 18px;
	border: none;
}
.login-card .alert-danger {
	background: #fff0f0;
	color: #c62828;
	border-left: 3px solid #ef5350;
}

/* ---- 响应式 ---- */
@media (max-width: 900px) {
	.login-wrapper {
		flex-direction: column;
	}
	.brand-panel {
		flex: 0 0 auto;
		text-align: center;
		padding: 30px 20px;
	}
	.brand-panel .brand-icon { margin: 0 auto 16px; }
	.brand-panel .feature-list { display: none; }
	.login-card {
		flex: 0 0 auto;
		width: 100%;
		max-width: 400px;
	}
}
</style>
</head>
<body>

<!-- 装饰层 -->
<div class="cross-pattern"></div>
<div class="top-glow"></div>
<div class="floating-icons">
	<span class="icon-item"><i class="fa fa-plus"></i></span>
	<span class="icon-item"><i class="fa fa-heartbeat"></i></span>
	<span class="icon-item"><i class="fa fa-plus"></i></span>
	<span class="icon-item"><i class="fa fa-medkit"></i></span>
	<span class="icon-item"><i class="fa fa-plus"></i></span>
	<span class="icon-item"><i class="fa fa-heartbeat"></i></span>
	<span class="icon-item"><i class="fa fa-plus"></i></span>
	<span class="icon-item"><i class="fa fa-user-md"></i></span>
	<span class="icon-item"><i class="fa fa-plus"></i></span>
	<span class="icon-item"><i class="fa fa-heartbeat"></i></span>
</div>

<!-- 主容器 -->
<div class="login-wrapper">
	<!-- 左侧品牌区 -->
	<div class="brand-panel">
		<div class="brand-icon"><i class="fa fa-hospital-o"></i></div>
		<h1>苏州<span>医院预约</span></h1>
		<p class="subtitle">苏州市医院预约挂号管理系统<br>为市民提供便捷的在线医疗服务</p>
		<ul class="feature-list">
			<li><i class="fa fa-check-circle"></i> 多医院、多科室在线预约</li>
			<li><i class="fa fa-check-circle"></i> 专家医生排班实时查询</li>
			<li><i class="fa fa-check-circle"></i> 预约审核高效管理</li>
			<li><i class="fa fa-check-circle"></i> 数据统计一目了然</li>
		</ul>
	</div>

	<!-- 右侧登录卡片 -->
	<div class="login-card">
		<div class="card-header-icon">
			<div class="circle"><i class="fa fa-user-md"></i></div>
		</div>
		<h3>管理员登录</h3>
		<p class="card-sub">Admin Panel Sign In</p>

		<c:if test="${msg != null}">
			<div class="alert alert-danger">
				<i class="fa fa-exclamation-circle"></i> ${msg}
			</div>
		</c:if>

		<form action="${mybasePath}admin/login" method="post">
			<div class="form-group">
				<label>管理员邮箱</label>
				<div class="input-icon-wrap">
					<i class="fa fa-envelope input-icon"></i>
					<input type="email" name="userEmail" placeholder="请输入管理员邮箱地址" required autofocus>
				</div>
			</div>
			<div class="form-group">
				<label>登录密码</label>
				<div class="input-icon-wrap">
					<i class="fa fa-lock input-icon"></i>
					<input type="password" name="userPassword" placeholder="请输入登录密码" required>
				</div>
			</div>
			<button type="submit" class="btn-login">
				<i class="fa fa-sign-in"></i> 登 录 后 台
			</button>
		</form>

		<div class="card-footer-links">
			<a href="${mybasePath}index"><i class="fa fa-home"></i> 返回前台首页</a>
			<span class="divider">|</span>
			<a href="${mybasePath}findPassword"><i class="fa fa-question-circle"></i> 忘记密码</a>
		</div>
	</div>
</div>

<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
