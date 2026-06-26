<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>排班管理 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-calendar"></i> 排班管理
				<a href="${mybasePath}admin/scheduleAdd" class="btn btn-primary btn-sm pull-right" style="margin-left:5px;"><i class="fa fa-plus"></i> 新增排班</a>
				<a href="${mybasePath}admin/scheduleBatch" class="btn btn-warning btn-sm pull-right"><i class="fa fa-calendar-plus-o"></i> 批量排班</a>
			</h3>
			<hr/>
			<form class="form-inline" action="${mybasePath}admin/scheduleList/1" method="get" style="margin-bottom:15px;">
				<input type="text" name="doctorName" class="form-control" placeholder="医生姓名" value="${doctorName}">
				<input type="text" name="hospitalName" class="form-control" placeholder="医院名称" value="${hospitalName}">
				<input type="date" name="scheduleDate" class="form-control" value="${scheduleDate}">
				<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> 搜索</button>
			</form>
			<table class="table table-striped table-hover">
				<thead>
					<tr><th>ID</th><th>医院</th><th>科室</th><th>日期</th><th>时段</th><th>号源</th><th>已约</th><th>状态</th><th>操作</th></tr>
				</thead>
				<tbody>
					<c:forEach var="s" items="${scheduleList}">
						<tr>
							<td>${s.id}</td>
							<td>${s.hospitalName}</td>
							<td>${s.officesName}</td>
							<td>${s.scheduleDate}</td>
							<td>${s.timeSlot}</td>
							<td>${s.maxPatients}</td>
							<td>${s.bookedCount}</td>
							<td>
								<c:if test="${s.status == 1}"><span class="label label-success">可预约</span></c:if>
								<c:if test="${s.status == 0}"><span class="label label-danger">已停诊</span></c:if>
							</td>
							<td>
								<button onclick="toggleSchedule(${s.id})" class="btn btn-xs ${s.status == 1 ? 'btn-warning' : 'btn-success'}">
									${s.status == 1 ? '停诊' : '恢复'}
								</button>
								<button onclick="delSchedule(${s.id})" class="btn btn-xs btn-danger">删除</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="text-align:center;">
				<ul class="pagination">
					<c:if test="${pages.currentPage > 1}">
						<li><a href="${mybasePath}admin/scheduleList/${pages.prePage}?doctorName=${doctorName}&hospitalName=${hospitalName}&scheduleDate=${scheduleDate}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pages.pageNumStart}" end="${pages.pageNumEnd}" var="p">
						<li <c:if test="${p == pages.currentPage}">class="active"</c:if>>
							<a href="${mybasePath}admin/scheduleList/${p}?doctorName=${doctorName}&hospitalName=${hospitalName}&scheduleDate=${scheduleDate}">${p}</a>
						</li>
					</c:forEach>
					<c:if test="${pages.currentPage < pages.totalPage}">
						<li><a href="${mybasePath}admin/scheduleList/${pages.nextPage}?doctorName=${doctorName}&hospitalName=${hospitalName}&scheduleDate=${scheduleDate}">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
<script>
function delSchedule(id){
	if(confirm('确定要删除该排班吗？')) {
		$.post('${mybasePath}admin/scheduleDelete/'+id, function(res){
			if(res.success){ alert('删除成功'); location.reload(); }
			else { alert('删除失败'); }
		}, 'json');
	}
}
function toggleSchedule(id){
	$.post('${mybasePath}admin/scheduleToggle/'+id, function(res){
		if(res.success){ location.reload(); }
		else { alert('操作失败'); }
	}, 'json');
}
</script>
</body>
</html>
