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
<title>预约失败</title>
<jsp:include page="../include/headtag.jsp" />
<link rel="stylesheet" href="${mybasePath}assets/css/form-elements.css">
<link rel="stylesheet" href="${mybasePath}assets/css/style.css">
</head>
<body>
<jsp:include page="../include/head.jsp" />
<jsp:include page="../include/menu.jsp" />
<div id="page-wrapper" style="margin-top:50px;">
	<div id="page-inner">
		<div class="row">
			<div class="col-md-12">
				<h3 class="text-left">预约失败</h3>
			</div>
		</div>
		<hr/>
		<div class="col-md-12">
			<div class="alert alert-danger">
				<h4><i class="fa fa-exclamation-circle"></i> ${msg}</h4>
				<p>请返回医生详情页重新选择可用时段。</p>
			</div>
			<a href="javascript:history.back();" class="btn btn-primary">返回上页</a>
			<a href="${mybasePath}doctorIndex/1" class="btn btn-default">浏览其他医生</a>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
</body>
</html>
