<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理后台 - 苏州市医院预约挂号系统</title>
<jsp:include page="include/admin_headtag.jsp" />
<style>
.stat-card { background: #fff; border-radius: 5px; padding: 20px; margin: 10px 0; text-align: center; box-shadow: 0 1px 4px rgba(0,0,0,0.1); }
.stat-card h2 { color: #eb6864; font-weight: bold; margin: 10px 0; }
.stat-card .icon { font-size: 36px; color: #999; }
</style>
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-dashboard"></i> 控制台首页</h3>
			<hr/>
			<div class="row">
				<div class="col-md-2 col-sm-6">
					<div class="stat-card">
						<div class="icon"><i class="fa fa-list-alt"></i></div>
						<h2>${totalOrders}</h2>
						<p>预约总数</p>
					</div>
				</div>
				<div class="col-md-2 col-sm-6">
					<div class="stat-card">
						<div class="icon"><i class="fa fa-clock-o"></i></div>
						<h2>${pendingOrders}</h2>
						<p>待审核</p>
					</div>
				</div>
				<div class="col-md-2 col-sm-6">
					<div class="stat-card">
						<div class="icon"><i class="fa fa-user-md"></i></div>
						<h2>${totalDoctors}</h2>
						<p>医生总数</p>
					</div>
				</div>
				<div class="col-md-2 col-sm-6">
					<div class="stat-card">
						<div class="icon"><i class="fa fa-building"></i></div>
						<h2>${totalOffices}</h2>
						<p>科室总数</p>
					</div>
				</div>
				<div class="col-md-2 col-sm-6">
					<div class="stat-card">
						<div class="icon"><i class="fa fa-calendar"></i></div>
						<h2>${todaySchedules}</h2>
						<p>排班记录</p>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:20px;">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading"><strong>快捷操作</strong></div>
						<div class="panel-body">
							<a href="${mybasePath}admin/officeAdd" class="btn btn-primary"><i class="fa fa-plus"></i> 新增科室</a>
							<a href="${mybasePath}admin/doctorAdd" class="btn btn-success"><i class="fa fa-plus"></i> 新增医生</a>
							<a href="${mybasePath}admin/scheduleAdd" class="btn btn-info"><i class="fa fa-plus"></i> 新增排班</a>
							<a href="${mybasePath}admin/scheduleBatch" class="btn btn-warning"><i class="fa fa-calendar-plus-o"></i> 批量排班</a>
							<a href="${mybasePath}admin/orderList/1" class="btn btn-danger"><i class="fa fa-tasks"></i> 审核预约</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
