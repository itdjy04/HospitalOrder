<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	session.setAttribute("mybasePath", basePath);
%>
<!-- CSS -->
<link rel="stylesheet" href="${mybasePath}assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${mybasePath}assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${mybasePath}assets/css/style.css">
<link rel="stylesheet" href="${mybasePath}assets/css/custom.css">
