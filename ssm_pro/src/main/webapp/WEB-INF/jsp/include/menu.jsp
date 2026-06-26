<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="wrapper">

	<!-- Sidebar -->
	<div id="sidebar-wrapper">
		<ul class="sidebar-nav">
			<li class="sidebar-brand"><a href="#"> </a></li>
			<br />
			<br />
			<br />
			<li><a class="list-group-item" href="/ssm_pro/index"><font  color="#fff">首页</font></a></li>
			<li><a class="list-group-item" href="/ssm_pro/hosIndex"><font  color="#fff">医院挂号</font></a></li>
			<li><a class="list-group-item" href="/ssm_pro/officeIndex/1"><font color="#fff">科室挂号</font></a></li>
			<li><a class="list-group-item" href="/ssm_pro/doctorIndex/1"><font color="#fff">医生挂号</font></a></li>


			<!-- <li><a class="list-group-item" href="/ssm_pro/orderIndex"><font color="#fff">快速预约</font></a></li> -->


			<li><a class="list-group-item" href="/ssm_pro/feedBack"><font color="#fff">意见反馈</font></a></li>
			<li><a class="list-group-item" href="/ssm_pro/noticeIndex/1"><font color="#fff">最新公告</font></a></li>
			<li><a class="list-group-item" href="/ssm_pro/contact"><font color="#fff">联系我们</font></a></li>
			<c:if test="${userInfo.isAdmin == 1}">
				<li><hr style="margin:5px 0;border-color:#555;"/></li>
				<li><a class="list-group-item" href="/ssm_pro/admin/index"><font color="#ffd700"><i class="fa fa-cog"></i> 后台管理</font></a></li>
			</c:if>
		</ul>
	</div>
	<!-- /#sidebar-wrapper -->


</div>
<!-- /#wrapper -->

<!-- jQuery 和 Bootstrap 已在 headtag.jsp 中加载，此处不再重复加载 -->
