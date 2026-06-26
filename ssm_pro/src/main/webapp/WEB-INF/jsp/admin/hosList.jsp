<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医院管理 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-hospital-o"></i> 医院管理</h3>
			<hr/>
			<table class="table table-striped table-hover">
				<thead>
					<tr><th>ID</th><th>医院名称</th><th>等级</th><th>区域</th><th>类型</th><th>科室数</th><th>预约状态</th><th>操作</th></tr>
				</thead>
				<tbody>
					<c:forEach var="hos" items="${hosList}">
						<tr>
							<td>${hos.id}</td>
							<td>${hos.hospitalName}</td>
							<td>${hos.hospitalGrade}</td>
							<td>${hos.hospitalArea}</td>
							<td>${hos.hospitalNature}</td>
							<td>${hos.hospitalOfficesNum}</td>
							<td>
								<c:if test="${hos.isOpen == 1}"><span class="label label-success">开放预约</span></c:if>
								<c:if test="${hos.isOpen == 0}"><span class="label label-default">关闭预约</span></c:if>
							</td>
							<td>
								<button onclick="toggleHos(${hos.id})" class="btn btn-xs ${hos.isOpen == 1 ? 'btn-warning' : 'btn-success'}">
									${hos.isOpen == 1 ? '关闭预约' : '开放预约'}
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="text-align:center;">
				<ul class="pagination">
					<c:if test="${pages.currentPage > 1}">
						<li><a href="${mybasePath}admin/hosList/${pages.prePage}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pages.pageNumStart}" end="${pages.pageNumEnd}" var="p">
						<li <c:if test="${p == pages.currentPage}">class="active"</c:if>>
							<a href="${mybasePath}admin/hosList/${p}">${p}</a>
						</li>
					</c:forEach>
					<c:if test="${pages.currentPage < pages.totalPage}">
						<li><a href="${mybasePath}admin/hosList/${pages.nextPage}">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
<script>
function toggleHos(id){
	if(confirm('确定要切换该医院的预约状态吗？')){
		$.post('${mybasePath}admin/hosToggle/'+id, function(res){
			if(res.success){ location.reload(); }
			else { alert('操作失败'); }
		}, 'json');
	}
}
</script>
</body>
</html>
