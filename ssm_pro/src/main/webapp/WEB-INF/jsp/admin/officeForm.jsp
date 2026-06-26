<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${office != null ? '编辑' : '新增'}科室 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-building"></i> ${office != null ? '编辑科室' : '新增科室'}</h3>
			<hr/>
			<form class="form-horizontal" action="${mybasePath}admin/${office != null ? 'officeUpdate' : 'officeSave'}" method="post"
				style="max-width:800px;">
				<c:if test="${office != null}">
					<input type="hidden" name="id" value="${office.id}">
				</c:if>
				<div class="form-group">
					<label class="col-md-2 control-label">科室名称</label>
					<div class="col-md-6"><input type="text" name="officesName" class="form-control" value="${office.officesName}" required></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">所属医院</label>
					<div class="col-md-6">
						<select name="hospitalName" class="form-control" required>
							<option value="">请选择医院</option>
							<c:forEach var="hos" items="${hospitalList}">
								<option value="${hos.hospitalName}" <c:if test="${office.hospitalName == hos.hospitalName}">selected</c:if>>${hos.hospitalName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">科室设备</label>
					<div class="col-md-10"><textarea name="officesEquipment" class="form-control" rows="3">${office.officesEquipment}</textarea></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">科室简介</label>
					<div class="col-md-10"><textarea name="officesAbout" class="form-control" rows="5">${office.officesAbout}</textarea></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">科室荣誉</label>
					<div class="col-md-10"><textarea name="officesHonor" class="form-control" rows="3">${office.officesHonor}</textarea></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">诊疗范围</label>
					<div class="col-md-10"><textarea name="officesDiagnosisScope" class="form-control" rows="3">${office.officesDiagnosisScope}</textarea></div>
				</div>
				<div class="form-group">
					<div class="col-md-offset-2 col-md-10">
						<button type="submit" class="btn btn-primary">保存</button>
						<a href="${mybasePath}admin/officeList/1" class="btn btn-default">返回</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
