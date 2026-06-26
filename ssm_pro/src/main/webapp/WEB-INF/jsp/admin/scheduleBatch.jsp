<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>批量排班 - 后台管理</title>
<jsp:include page="include/admin_headtag.jsp" />
<style>
.doctor-row { margin-bottom:8px; position:relative; }
.doctor-row .search-input { display:inline-block; width:280px; }
.doctor-row .dropdown-box {
	position:absolute; top:34px; left:0; z-index:999;
	max-height:220px; overflow-y:auto; width:280px;
	background:#fff; border:1px solid #ccc; border-top:none;
	display:none;
}
.doctor-row .dropdown-box .item {
	padding:6px 10px; cursor:pointer; border-bottom:1px solid #eee; font-size:13px;
}
.doctor-row .dropdown-box .item:hover { background:#f5f5f5; }
.doctor-row .dropdown-box .item.selected { background:#d9edf7; }
.doctor-row .dropdown-box .item .name { font-weight:bold; }
.doctor-row .dropdown-box .item .info { color:#888; }
.doctor-row .dropdown-box .no-data { padding:10px; text-align:center; color:#999; }
.doctor-row .selected-tag {
	display:none; margin-left:5px; padding:4px 10px; background:#d9edf7; border-radius:3px;
	font-size:13px; vertical-align:middle;
}
.doctor-row .selected-tag .remove-row { color:#a94442; cursor:pointer; margin-left:6px; }
</style>
</head>
<body>
<jsp:include page="include/admin_head.jsp" />
<div class="container-fluid" style="padding:0;">
	<div class="row" style="margin:0;">
		<jsp:include page="include/admin_menu.jsp" />
		<div class="col-md-10" style="padding:20px;margin-top:52px;">
			<h3><i class="fa fa-calendar-plus-o"></i> 批量排班</h3>
			<hr/>
			<form class="form-horizontal" action="${mybasePath}admin/scheduleBatchSave" method="post" style="max-width:850px;" id="batchForm">
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 选择医生</label>
					<div class="col-md-9">
						<div id="doctorRows">
							<div class="doctor-row" data-index="0">
								<input type="text" class="form-control search-input" placeholder="输入医生姓名搜索..." autocomplete="off" onfocus="showDropdown(this)" oninput="filterDoctors(this)">
								<div class="dropdown-box"></div>
								<span class="selected-tag"><i class="fa fa-user-md"></i> <span class="tag-text"></span><span class="remove-row" onclick="removeDoctorRow(this)"><i class="fa fa-times"></i></span></span>
								<input type="hidden" name="doctorId" value="">
							</div>
						</div>
						<button type="button" class="btn btn-xs btn-info" onclick="addDoctorRow()" style="margin-top:4px;"><i class="fa fa-plus"></i> 添加医生</button>
						<small class="text-muted">可添加多个医生，每个医生会在所选日期范围内生成排班</small>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 开始日期</label>
					<div class="col-md-4"><input type="date" name="startDate" id="startDate" class="form-control" required></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 结束日期</label>
					<div class="col-md-4"><input type="date" name="endDate" id="endDate" class="form-control" required></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 时段选择</label>
					<div class="col-md-6">
						<label class="checkbox-inline"><input type="checkbox" name="timeSlot" value="8:00-11:00" checked> 8:00-11:00 (上午)</label>
						<label class="checkbox-inline"><input type="checkbox" name="timeSlot" value="13:00-15:00" checked> 13:00-15:00 (下午)</label>
						<label class="checkbox-inline"><input type="checkbox" name="timeSlot" value="15:00-18:00"> 15:00-18:00 (下午)</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label"><font color="#eb6864">*</font> 号源数</label>
					<div class="col-md-3"><input type="number" name="maxPatients" class="form-control" value="20" required></div>
				</div>
				<div class="form-group">
					<div class="col-md-offset-2 col-md-10">
						<button type="submit" class="btn btn-warning"><i class="fa fa-calendar-plus-o"></i> 批量生成排班</button>
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
var rowIndex = 1;
// 加载所有医生
$.get('${mybasePath}admin/doctorListJson', function(data){
	allDoctors = data;
});

// 渲染某行的下拉
function renderRowDropdown($row, doctors){
	var $dd = $row.find('.dropdown-box');
	$dd.empty();
	if(!doctors || doctors.length === 0){
		$dd.append('<div class="no-data">无匹配医生</div>');
	} else {
		$.each(doctors, function(i, d){
			var html = '<div class="item" data-id="'+d.id+'" data-name="'+d.doctorName+'" data-hospital="'+d.hospitalName+'" data-office="'+d.officesName+'" data-title="'+(d.doctorTitle||'')+'" onclick="selectRowDoctor($(this).closest(\'.doctor-row\'), this)">'
				+ '<span class="name">'+d.doctorName+'</span>'
				+ '<span class="info"> | '+d.officesName+' | '+d.hospitalName+' | '+(d.doctorTitle||'无职称')+'</span>'
				+ '</div>';
			$dd.append(html);
		});
	}
}

// 显示下拉
function showDropdown(input){
	var $row = $(input).closest('.doctor-row');
	// 如果已经选过医生，不再显示下拉
	if($row.find('input[name="doctorId"]').val()) return;
	renderRowDropdown($row, allDoctors);
	$row.find('.dropdown-box').show();
}

// 搜索过滤
function filterDoctors(input){
	var keyword = $(input).val().toLowerCase();
	var $row = $(input).closest('.doctor-row');
	if(!keyword){
		renderRowDropdown($row, allDoctors);
	} else {
		var filtered = $.grep(allDoctors, function(d){
			return (d.doctorName||'').toLowerCase().indexOf(keyword) >= 0
				|| (d.officesName||'').toLowerCase().indexOf(keyword) >= 0
				|| (d.hospitalName||'').toLowerCase().indexOf(keyword) >= 0;
		});
		renderRowDropdown($row, filtered);
	}
	$row.find('.dropdown-box').show();
}

// 选择医生
function selectRowDoctor($row, el){
	var $el = $(el);
	$row.find('input[name="doctorId"]').val($el.data('id'));
	$row.find('.tag-text').text($el.data('name') + ' | ' + $el.data('office') + ' | ' + $el.data('hospital'));
	$row.find('.selected-tag').show();
	$row.find('.search-input').hide();
	$row.find('.dropdown-box').hide().empty();
}

// 移除该行
function removeDoctorRow(btn){
	$(btn).closest('.doctor-row').remove();
}

// 添加新行
function addDoctorRow(){
	var idx = rowIndex++;
	var html = '<div class="doctor-row" data-index="'+idx+'">'
		+ '<input type="text" class="form-control search-input" placeholder="输入医生姓名搜索..." autocomplete="off" onfocus="showDropdown(this)" oninput="filterDoctors(this)">'
		+ '<div class="dropdown-box"></div>'
		+ '<span class="selected-tag"><i class="fa fa-user-md"></i> <span class="tag-text"></span><span class="remove-row" onclick="removeDoctorRow(this)"><i class="fa fa-times"></i></span></span>'
		+ '<input type="hidden" name="doctorId" value="">'
		+ '</div>';
	$('#doctorRows').append(html);
}

// 点击外部关闭下拉
$(document).on('click', function(e){
	if(!$(e.target).closest('.doctor-row').length){
		$('.dropdown-box').hide();
	}
});

// 默认日期
$(function(){
	var tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate() + 1);
	var yyyy = tomorrow.getFullYear();
	var mm = ('0'+(tomorrow.getMonth()+1)).slice(-2);
	var dd = ('0'+tomorrow.getDate()).slice(-2);
	$('#startDate').val(yyyy+'-'+mm+'-'+dd);
	var end = new Date();
	end.setDate(end.getDate() + 7);
	var ey = end.getFullYear();
	var em = ('0'+(end.getMonth()+1)).slice(-2);
	var ed = ('0'+end.getDate()).slice(-2);
	$('#endDate').val(ey+'-'+em+'-'+ed);
});
</script>
</body>
</html>
