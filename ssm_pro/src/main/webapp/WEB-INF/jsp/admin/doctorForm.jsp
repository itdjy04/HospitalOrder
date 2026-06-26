<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${doctor != null ? '编辑' : '新增'}医生 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-user-md"></i> ${doctor != null ? '编辑医生' : '新增医生'}</h3>
			<hr/>
			<form class="form-horizontal" action="${mybasePath}admin/${doctor != null ? 'doctorUpdate' : 'doctorSave'}" method="post" style="max-width:800px;">
				<c:if test="${doctor != null}">
					<input type="hidden" name="id" value="${doctor.id}">
				</c:if>
				<div class="form-group">
					<label class="col-md-2 control-label">医生姓名</label>
					<div class="col-md-6"><input type="text" name="doctorName" class="form-control" value="${doctor.doctorName}" required></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">性别</label>
					<div class="col-md-6">
						<select name="doctorSex" class="form-control">
							<option value="男" <c:if test="${doctor.doctorSex == '男'}">selected</c:if>>男</option>
							<option value="女" <c:if test="${doctor.doctorSex == '女'}">selected</c:if>>女</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">所属医院</label>
					<div class="col-md-6">
						<select name="hospitalName" class="form-control" required>
							<option value="">请选择医院</option>
							<c:forEach var="hos" items="${hospitalList}">
								<option value="${hos.hospitalName}" <c:if test="${doctor.hospitalName == hos.hospitalName}">selected</c:if>>${hos.hospitalName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">科室名称</label>
					<div class="col-md-6"><input type="text" name="officesName" class="form-control" value="${doctor.officesName}" required></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">医生职称</label>
					<div class="col-md-6"><input type="text" name="doctorTitle" class="form-control" value="${doctor.doctorTitle}" placeholder="如：主任医师"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">教学职称</label>
					<div class="col-md-6"><input type="text" name="teachTitle" class="form-control" value="${doctor.teachTitle}" placeholder="如：教授"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">行政职位</label>
					<div class="col-md-6"><input type="text" name="doctorAdministrative" class="form-control" value="${doctor.doctorAdministrative}" placeholder="如：科室主任"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">学位</label>
					<div class="col-md-6"><input type="text" name="doctorDegree" class="form-control" value="${doctor.doctorDegree}" placeholder="如：博士"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">头像URL</label>
					<div class="col-md-6"><input type="text" name="doctorImg" class="form-control" value="${doctor.doctorImg}"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">医生特长</label>
					<div class="col-md-10"><textarea name="doctorForte" class="form-control" rows="3">${doctor.doctorForte}</textarea></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">医生简介</label>
					<div class="col-md-10"><textarea name="doctorAbout" class="form-control" rows="5">${doctor.doctorAbout}</textarea></div>
				</div>
				<div class="form-group">
					<div class="col-md-offset-2 col-md-10">
						<button type="submit" class="btn btn-primary">保存</button>
						<a href="${mybasePath}admin/doctorList/1" class="btn btn-default">返回</a>
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
