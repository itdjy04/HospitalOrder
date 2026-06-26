<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>科室管理 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-building"></i> 科室管理
				<a href="${mybasePath}admin/officeAdd" class="btn btn-primary btn-sm pull-right"><i class="fa fa-plus"></i> 新增科室</a>
			</h3>
			<hr/>
			<form class="form-inline" action="${mybasePath}admin/officeList/1" method="get" style="margin-bottom:15px;">
				<input type="text" name="hospitalName" class="form-control" placeholder="医院名称" value="${hospitalName}">
				<input type="text" name="officesName" class="form-control" placeholder="科室名称" value="${officesName}">
				<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> 搜索</button>
			</form>
			<table class="table table-striped table-hover">
				<thead>
					<tr><th>ID</th><th>科室名称</th><th>所属医院</th><th>医生数量</th><th>操作</th></tr>
				</thead>
				<tbody>
					<c:forEach var="office" items="${officeList}">
						<tr>
							<td>${office.id}</td>
							<td>${office.officesName}</td>
							<td>${office.hospitalName}</td>
							<td>${office.doctorNum}</td>
							<td>
								<a href="${mybasePath}admin/officeEdit/${office.id}" class="btn btn-xs btn-info">编辑</a>
								<button onclick="delOffice(${office.id})" class="btn btn-xs btn-danger">删除</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 分页 -->
			<div style="text-align:center;">
				<ul class="pagination">
					<c:if test="${pages.currentPage > 1}">
						<li><a href="${mybasePath}admin/officeList/${pages.prePage}?hospitalName=${hospitalName}&officesName=${officesName}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pages.pageNumStart}" end="${pages.pageNumEnd}" var="p">
						<li <c:if test="${p == pages.currentPage}">class="active"</c:if>>
							<a href="${mybasePath}admin/officeList/${p}?hospitalName=${hospitalName}&officesName=${officesName}">${p}</a>
						</li>
					</c:forEach>
					<c:if test="${pages.currentPage < pages.totalPage}">
						<li><a href="${mybasePath}admin/officeList/${pages.nextPage}?hospitalName=${hospitalName}&officesName=${officesName}">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
<script>
function delOffice(id){
	if(confirm('确定要删除该科室吗？')) {
		$.post('${mybasePath}admin/officeDelete/'+id, function(res){
			if(res.success){ alert('删除成功'); location.reload(); }
			else { alert(res.msg || '删除失败'); }
		}, 'json');
	}
}
</script>
</body>
</html>
