<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预约详情 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-list-alt"></i> 预约详情
				<a href="${mybasePath}admin/orderList/1" class="btn btn-default btn-sm pull-right"><i class="fa fa-arrow-left"></i> 返回列表</a>
			</h3>
			<hr/>
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading"><strong>预约信息</strong></div>
						<div class="panel-body">
							<table class="table table-bordered">
								<tr><td width="120"><strong>预约ID</strong></td><td>${order.id}</td></tr>
								<tr><td><strong>医院</strong></td><td>${order.hospitalName}</td></tr>
								<tr><td><strong>科室</strong></td><td>${order.officesName}</td></tr>
								<tr><td><strong>医生</strong></td><td>${order.doctorName}</td></tr>
								<tr><td><strong>就诊日期</strong></td><td>${order.transactDate}</td></tr>
								<tr><td><strong>就诊时段</strong></td><td>${order.transactTime}</td></tr>
								<tr><td><strong>病情描述</strong></td><td>${order.diseaseInfo}</td></tr>
							</table>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading"><strong>状态信息</strong></div>
						<div class="panel-body">
							<table class="table table-bordered">
								<tr><td width="120"><strong>审核状态</strong></td>
									<td>
										<c:if test="${order.isSuccess == 1}"><span class="label label-success">已通过</span></c:if>
										<c:if test="${order.isSuccess == 0}"><span class="label label-warning">待审核</span></c:if>
									</td>
								</tr>
								<tr><td><strong>取消状态</strong></td>
									<td>
										<c:if test="${order.isCancel == 0}"><span class="label label-info">正常</span></c:if>
										<c:if test="${order.isCancel == 1}"><span class="label label-default">已取消</span></c:if>
										<c:if test="${order.isCancel == 2}"><span class="label label-danger">已拒绝</span></c:if>
									</td>
								</tr>
								<tr><td><strong>通知状态</strong></td>
									<td>
										<c:if test="${order.isSend == 0}"><span class="label label-default">未发送</span></c:if>
										<c:if test="${order.isSend == 1}"><span class="label label-success">已发送</span></c:if>
										<c:if test="${order.isSend == 2}"><span class="label label-danger">发送失败</span></c:if>
									</td>
								</tr>
								<tr><td><strong>创建时间</strong></td><td>${order.createTime}</td></tr>
							</table>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading"><strong>审核操作</strong></div>
						<div class="panel-body">
							<c:if test="${order.isSuccess == 0 && order.isCancel == 0}">
								<button onclick="approveOrder(${order.id})" class="btn btn-success"><i class="fa fa-check"></i> 审核通过</button>
								<button onclick="rejectOrder(${order.id})" class="btn btn-danger"><i class="fa fa-times"></i> 审核拒绝</button>
							</c:if>
							<c:if test="${order.isSuccess == 1}">
								<span class="text-success">该预约已审核通过</span>
							</c:if>
							<c:if test="${order.isCancel != 0}">
								<span class="text-muted">该预约已取消/拒绝</span>
							</c:if>
						</div>
					</div>
				</div>
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
