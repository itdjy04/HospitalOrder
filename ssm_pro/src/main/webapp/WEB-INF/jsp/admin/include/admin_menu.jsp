<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-md-2" style="background:#2c3e50;min-height:calc(100vh - 52px);padding:0;margin-top:52px;">
	<ul class="nav nav-pills nav-stacked" style="padding-top:20px;">
		<li id="menu-index"><a href="${mybasePath}admin/index" style="color:#ecf0f1;border-radius:0;"><i class="fa fa-dashboard"></i> 控制台首页</a></li>
		<li id="menu-office"><a href="${mybasePath}admin/officeList/1" style="color:#ecf0f1;border-radius:0;"><i class="fa fa-building"></i> 科室管理</a></li>
		<li id="menu-doctor"><a href="${mybasePath}admin/doctorList/1" style="color:#ecf0f1;border-radius:0;"><i class="fa fa-user-md"></i> 医生管理</a></li>
		<li id="menu-schedule"><a href="${mybasePath}admin/scheduleList/1" style="color:#ecf0f1;border-radius:0;"><i class="fa fa-calendar"></i> 排班管理</a></li>
		<li id="menu-order"><a href="${mybasePath}admin/orderList/1" style="color:#ecf0f1;border-radius:0;"><i class="fa fa-list-alt"></i> 预约管理</a></li>
		<li id="menu-hos"><a href="${mybasePath}admin/hosList/1" style="color:#ecf0f1;border-radius:0;"><i class="fa fa-hospital-o"></i> 医院管理</a></li>
	</ul>
</div>
<script>
// 高亮当前菜单
$(function(){
	var path = window.location.pathname;
	if(path.indexOf('/admin/index')>=0) $('#menu-index').addClass('active');
	if(path.indexOf('/admin/office')>=0) $('#menu-office').addClass('active');
	if(path.indexOf('/admin/doctor')>=0) $('#menu-doctor').addClass('active');
	if(path.indexOf('/admin/schedule')>=0) $('#menu-schedule').addClass('active');
	if(path.indexOf('/admin/order')>=0) $('#menu-order').addClass('active');
	if(path.indexOf('/admin/hos')>=0) $('#menu-hos').addClass('active');
});
</script>
