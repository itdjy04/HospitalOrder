<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医生管理 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-user-md"></i> 医生管理
				<a href="${mybasePath}admin/doctorAdd" class="btn btn-primary btn-sm pull-right"><i class="fa fa-plus"></i> 新增医生</a>
			</h3>
			<hr/>
			<form class="form-inline" action="${mybasePath}admin/doctorList/1" method="get" style="margin-bottom:15px;">
				<input type="text" name="hospitalName" class="form-control" placeholder="医院名称" value="${hospitalName}">
				<input type="text" name="officesName" class="form-control" placeholder="科室名称" value="${officesName}">
				<input type="text" name="doctorName" class="form-control" placeholder="医生姓名" value="${doctorName}">
				<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> 搜索</button>
			</form>
			<table class="table table-striped table-hover">
				<thead>
					<tr><th>ID</th><th>姓名</th><th>性别</th><th>所属医院</th><th>科室</th><th>职称</th><th>操作</th></tr>
				</thead>
				<tbody>
					<c:forEach var="doc" items="${doctorList}">
						<tr>
							<td>${doc.id}</td>
							<td>${doc.doctorName}</td>
							<td>${doc.doctorSex}</td>
							<td>${doc.hospitalName}</td>
							<td>${doc.officesName}</td>
							<td>${doc.doctorTitle}</td>
							<td>
								<a href="${mybasePath}admin/doctorEdit/${doc.id}" class="btn btn-xs btn-info">编辑</a>
								<button onclick="delDoctor(${doc.id})" class="btn btn-xs btn-danger">删除</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="text-align:center;">
				<ul class="pagination">
					<c:if test="${pages.currentPage > 1}">
						<li><a href="${mybasePath}admin/doctorList/${pages.prePage}?hospitalName=${hospitalName}&officesName=${officesName}&doctorName=${doctorName}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pages.pageNumStart}" end="${pages.pageNumEnd}" var="p">
						<li <c:if test="${p == pages.currentPage}">class="active"</c:if>>
							<a href="${mybasePath}admin/doctorList/${p}?hospitalName=${hospitalName}&officesName=${officesName}&doctorName=${doctorName}">${p}</a>
						</li>
					</c:forEach>
					<c:if test="${pages.currentPage < pages.totalPage}">
						<li><a href="${mybasePath}admin/doctorList/${pages.nextPage}?hospitalName=${hospitalName}&officesName=${officesName}&doctorName=${doctorName}">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
<script>
function delDoctor(id){
	if(confirm('确定要删除该医生吗？')) {
		$.post('${mybasePath}admin/doctorDelete/'+id, function(res){
			if(res.success){ alert('删除成功'); location.reload(); }
			else { alert(res.msg || '删除失败'); }
		}, 'json');
	}
}
</script>
</body>
</html>
