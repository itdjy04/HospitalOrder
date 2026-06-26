<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#eb6864;border-color:#eb6864;">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="${mybasePath}admin/index"><font color="#fff"><i class="fa fa-cog"></i> 后台管理系统</font></a>
		</div>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="${mybasePath}admin/index" style="color:#fff;"><i class="fa fa-dashboard"></i> 控制台</a></li>
			<li><a href="${mybasePath}index" style="color:#fff;"><i class="fa fa-home"></i> 前台</a></li>
			<li><a href="${mybasePath}admin/logout" style="color:#fff;"><i class="fa fa-sign-out"></i> 退出</a></li>
		</ul>
	</div>
</nav>
