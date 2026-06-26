<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预约管理 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-list-alt"></i> 预约管理</h3>
			<hr/>
			<form class="form-inline" action="${mybasePath}admin/orderList/1" method="get" style="margin-bottom:15px;">
				<input type="text" name="hospitalName" class="form-control" placeholder="医院名称" value="${hospitalName}">
				<input type="text" name="officesName" class="form-control" placeholder="科室名称" value="${officesName}">
				<input type="text" name="doctorName" class="form-control" placeholder="医生姓名" value="${doctorName}">
				<select name="isSuccess" class="form-control">
					<option value="">审核状态</option>
					<option value="0" <c:if test="${isSuccess == 0}">selected</c:if>>待审核</option>
					<option value="1" <c:if test="${isSuccess == 1}">selected</c:if>>已通过</option>
				</select>
				<select name="isCancel" class="form-control">
					<option value="">取消状态</option>
					<option value="0" <c:if test="${isCancel == 0}">selected</c:if>>正常</option>
					<option value="1" <c:if test="${isCancel == 1}">selected</c:if>>已取消</option>
				</select>
				<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> 搜索</button>
			</form>
			<table class="table table-striped table-hover">
				<thead>
					<tr><th>ID</th><th>医院</th><th>科室</th><th>医生</th><th>日期</th><th>时段</th><th>审核</th><th>状态</th><th>操作</th></tr>
				</thead>
				<tbody>
					<c:forEach var="o" items="${orderList}">
						<tr>
							<td>${o.id}</td>
							<td>${o.hospitalName}</td>
							<td>${o.officesName}</td>
							<td>${o.doctorName}</td>
							<td>${o.transactDate}</td>
							<td>${o.transactTime}</td>
							<td>
								<c:if test="${o.isSuccess == 1}"><span class="label label-success">已通过</span></c:if>
								<c:if test="${o.isSuccess == 0}"><span class="label label-warning">待审核</span></c:if>
							</td>
							<td>
								<c:if test="${o.isCancel == 0}"><span class="label label-info">正常</span></c:if>
								<c:if test="${o.isCancel == 1}"><span class="label label-default">已取消</span></c:if>
								<c:if test="${o.isCancel == 2}"><span class="label label-danger">已拒绝</span></c:if>
							</td>
							<td>
								<a href="${mybasePath}admin/orderDetail/${o.id}" class="btn btn-xs btn-info">详情</a>
								<c:if test="${o.isSuccess == 0 && o.isCancel == 0}">
									<button onclick="approveOrder(${o.id})" class="btn btn-xs btn-success">通过</button>
									<button onclick="rejectOrder(${o.id})" class="btn btn-xs btn-danger">拒绝</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="text-align:center;">
				<ul class="pagination">
					<c:if test="${pages.currentPage > 1}">
						<li><a href="${mybasePath}admin/orderList/${pages.prePage}?hospitalName=${hospitalName}&officesName=${officesName}&doctorName=${doctorName}&isSuccess=${isSuccess}&isCancel=${isCancel}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pages.pageNumStart}" end="${pages.pageNumEnd}" var="p">
						<li <c:if test="${p == pages.currentPage}">class="active"</c:if>>
							<a href="${mybasePath}admin/orderList/${p}?hospitalName=${hospitalName}&officesName=${officesName}&doctorName=${doctorName}&isSuccess=${isSuccess}&isCancel=${isCancel}">${p}</a>
						</li>
					</c:forEach>
					<c:if test="${pages.currentPage < pages.totalPage}">
						<li><a href="${mybasePath}admin/orderList/${pages.nextPage}?hospitalName=${hospitalName}&officesName=${officesName}&doctorName=${doctorName}&isSuccess=${isSuccess}&isCancel=${isCancel}">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
<script>
function approveOrder(id){
	if(confirm('确定审核通过该预约吗？')){
		$.post('${mybasePath}admin/orderApprove/'+id, function(res){
			if(res.success){ alert('审核通过'); location.reload(); }
			else { alert('操作失败'); }
		}, 'json');
	}
}
function rejectOrder(id){
	if(confirm('确定拒绝该预约吗？')){
		$.post('${mybasePath}admin/orderReject/'+id, function(res){
			if(res.success){ alert('已拒绝'); location.reload(); }
			else { alert('操作失败'); }
		}, 'json');
	}
}
</script>
</body>
</html>
