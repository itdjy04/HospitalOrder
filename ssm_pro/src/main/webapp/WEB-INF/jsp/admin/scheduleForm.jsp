<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增排班 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
<style>
.doctor-selector { position:relative; }
.doctor-selector .dropdown-box {
	position:absolute; top:100%; left:0; right:0; z-index:999;
	max-height:300px; overflow-y:auto;
	background:#fff; border:1px solid #ccc; border-top:none;
	display:none;
}
.doctor-selector .dropdown-box .item {
	padding:8px 12px; cursor:pointer; border-bottom:1px solid #eee;
}
.doctor-selector .dropdown-box .item:hover { background:#f5f5f5; }
.doctor-selector .dropdown-box .item.selected { background:#d9edf7; }
.doctor-selector .dropdown-box .item .name { font-weight:bold; color:#333; }
.doctor-selector .dropdown-box .item .info { font-size:12px; color:#888; }
.doctor-selector .dropdown-box .no-data { padding:12px; text-align:center; color:#999; }
.selected-doctor { margin-top:6px; padding:8px 12px; background:#d9edf7; border-radius:4px; display:none; }
.selected-doctor .remove-btn { cursor:pointer; color:#a94442; margin-left:10px; }
</style>
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-calendar"></i> 新增排班</h3>
			<hr/>
			<form class="form-horizontal" action="${mybasePath}admin/scheduleSave" method="post" style="max-width:800px;" id="scheduleForm">
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 选择医生</label>
					<div class="col-md-6">
						<div class="doctor-selector">
							<input type="text" id="doctorSearch" class="form-control" placeholder="输入医生姓名、科室或医院名称搜索..." autocomplete="off">
							<div class="dropdown-box" id="doctorDropdown"></div>
						</div>
						<div class="selected-doctor" id="selectedDoctor">
							<i class="fa fa-user-md"></i> <span id="selectedDoctorText"></span>
							<span class="remove-btn" onclick="clearDoctor()"><i class="fa fa-times"></i> 清除</span>
						</div>
						<input type="hidden" name="doctorId" id="doctorId" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 出诊日期</label>
					<div class="col-md-4"><input type="date" name="scheduleDate" id="scheduleDate" class="form-control" required></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 时段</label>
					<div class="col-md-4">
						<select name="timeSlot" class="form-control" required>
							<option value="">请选择时段</option>
							<option value="8:00-11:00">8:00-11:00 (上午)</option>
							<option value="13:00-15:00">13:00-15:00 (下午)</option>
							<option value="15:00-18:00">15:00-18:00 (下午)</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 最大号源数</label>
					<div class="col-md-4"><input type="number" name="maxPatients" class="form-control" value="20" required></div>
				</div>
				<div class="form-group">
					<div class="col-md-offset-2 col-md-10">
						<button type="submit" class="btn btn-primary" id="submitBtn" disabled>保存</button>
						<a href="${mybasePath}admin/scheduleList/1" class="btn btn-default">返回</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="${mybasePath}assets/bootstrap/js/jquery.min.js"></script>
<script src="${mybasePath}assets/bootstrap/js/bootstrap.min.js"></script>
<script>
var allDoctors = [];
// 加载医生列表
$.get('${mybasePath}admin/doctorListJson', function(data){
	allDoctors = data;
	renderDropdown(allDoctors);
});

// 渲染下拉列表
function renderDropdown(doctors){
	var $dd = $('#doctorDropdown');
	$dd.empty();
	if(doctors.length === 0){
		$dd.append('<div class="no-data">暂无医生数据，请先在"医生管理"中添加医生</div>');
	} else {
		$.each(doctors, function(i, d){
			var html = '<div class="item" data-id="'+d.id+'" data-name="'+d.doctorName+'" data-hospital="'+d.hospitalName+'" data-office="'+d.officesName+'" data-title="'+(d.doctorTitle||'')+'" onclick="selectDoctor(this)">'
				+ '<span class="name">'+d.doctorName+'</span>'
				+ '<span class="info"> | '+d.officesName+' | '+d.hospitalName+' | '+(d.doctorTitle||'无职称')+'</span>'
				+ '</div>';
			$dd.append(html);
		});
	}
}

// 搜索过滤
$('#doctorSearch').on('input', function(){
	var keyword = $(this).val().toLowerCase();
	var $dd = $('#doctorDropdown');
	if(!keyword){
		renderDropdown(allDoctors);
		$dd.show();
		return;
	}
	var filtered = $.grep(allDoctors, function(d){
		return (d.doctorName||'').toLowerCase().indexOf(keyword) >= 0
			|| (d.officesName||'').toLowerCase().indexOf(keyword) >= 0
			|| (d.hospitalName||'').toLowerCase().indexOf(keyword) >= 0
			|| (d.doctorTitle||'').toLowerCase().indexOf(keyword) >= 0;
	});
	renderDropdown(filtered);
	$dd.show();
});

// 点击输入框显示下拉
$('#doctorSearch').on('focus', function(){
	$('#doctorDropdown').show();
});

// 点击外部隐藏下拉
$(document).on('click', function(e){
	if(!$(e.target).closest('.doctor-selector').length){
		$('#doctorDropdown').hide();
	}
});

// 选择医生
function selectDoctor(el){
	var $el = $(el);
	$('#doctorId').val($el.data('id'));
	$('#selectedDoctorText').text($el.data('name') + ' | ' + $el.data('office') + ' | ' + $el.data('hospital') + ' | ' + $el.data('title'));
	$('#selectedDoctor').show();
	$('#doctorSearch').val('');
	$('#doctorDropdown').hide().find('.item').removeClass('selected');
	$el.addClass('selected');
	$('#submitBtn').prop('disabled', false);
}

// 清除选择
function clearDoctor(){
	$('#doctorId').val('');
	$('#selectedDoctor').hide();
	$('#doctorSearch').val('');
	$('#submitBtn').prop('disabled', true);
	$('#doctorDropdown').find('.item').removeClass('selected');
}

// 默认日期设为明天
$(function(){
	var tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate() + 1);
	var yyyy = tomorrow.getFullYear();
	var mm = ('0'+(tomorrow.getMonth()+1)).slice(-2);
	var dd = ('0'+tomorrow.getDate()).slice(-2);
	$('#scheduleDate').val(yyyy+'-'+mm+'-'+dd);
});
</script>
</body>
</html>
