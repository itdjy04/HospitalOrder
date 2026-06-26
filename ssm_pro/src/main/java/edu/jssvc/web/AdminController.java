package edu.jssvc.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.jssvc.entity.CommonCondition;
import edu.jssvc.entity.CommonUser;
import edu.jssvc.entity.Doctor;
import edu.jssvc.entity.DoctorSchedule;
import edu.jssvc.entity.Hospital;
import edu.jssvc.entity.Office;
import edu.jssvc.entity.OrderRecords;
import edu.jssvc.service.CommonUserService;
import edu.jssvc.service.DoctorScheduleService;
import edu.jssvc.service.DoctorService;
import edu.jssvc.service.HospitalService;
import edu.jssvc.service.OfficeService;
import edu.jssvc.service.OrderRecordsService;
import edu.jssvc.utils.PageUtils;

@Controller
public class AdminController {

	@Autowired
	private CommonUserService commonUserService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private DoctorService doctorService;
	@Autowired
	private HospitalService hospitalService;
	@Autowired
	private OrderRecordsService orderRecordsService;
	@Autowired
	private DoctorScheduleService doctorScheduleService;
	@Autowired
	private PageUtils pageUtils;

	// ==================== 登录相关 ====================

	@RequestMapping(value = "/admin/login", method = RequestMethod.GET)
	public String loginPage() {
		return "admin/login";
	}

	@RequestMapping(value = "/admin/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model) {
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");

		int result = commonUserService.loginAdmin(userEmail, userPassword, request);
		if (result == 3) {
			CommonUser user = commonUserService.findCommonUserByEmail(userEmail);
			request.getSession().setAttribute("userInfo", user);
			return "redirect:/admin/index";
		} else if (result == 0) {
			model.addAttribute("msg", "用户不存在");
		} else if (result == 1) {
			model.addAttribute("msg", "密码不正确");
		} else if (result == 2) {
			model.addAttribute("msg", "无管理员权限");
		}
		return "admin/login";
	}

	@RequestMapping(value = "/admin/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin/login";
	}

	// ==================== 管理后台首页 ====================

	@RequestMapping(value = "/admin/index", method = RequestMethod.GET)
	public String index(Model model) {
		// 统计数据
		int totalOrders = orderRecordsService.countAllOrders(null, null, null, null, null, 1);
		int pendingOrders = orderRecordsService.countAllOrders(null, null, null, 0, 0, 1);
		int totalDoctors = doctorService.findDoctorNum(new Doctor());
		int totalOffices = officeService.findOrderOfficeNum(new Office());
		int todaySchedules = doctorScheduleService.countAll();

		model.addAttribute("totalOrders", totalOrders);
		model.addAttribute("pendingOrders", pendingOrders);
		model.addAttribute("totalDoctors", totalDoctors);
		model.addAttribute("totalOffices", totalOffices);
		model.addAttribute("todaySchedules", todaySchedules);

		return "admin/index";
	}

	// ==================== 科室管理 ====================

	@RequestMapping(value = "/admin/officeList/{page}", method = RequestMethod.GET)
	public String officeList(Model model, @PathVariable("page") int page,
			@RequestParam(value = "hospitalName", required = false) String hospitalName,
			@RequestParam(value = "officesName", required = false) String officesName) {
		Office searchOffice = new Office();
		searchOffice.setHospitalName(hospitalName);
		searchOffice.setOfficesName(officesName);

		pageUtils.setCurrentPage(page);
		pageUtils.setTotalRecord(officeService.findOrderOfficeNum(searchOffice));
		int start;
		if (pageUtils.getCurrentPage() == 0) {
			start = 0;
		} else {
			start = pageUtils.getPageRecord() * (pageUtils.getCurrentPage() - 1);
		}
		List<Office> officeList = officeService.findOfficeByConditon(searchOffice, start, 20);

		model.addAttribute("officeList", officeList);
		model.addAttribute("pages", pageUtils);
		model.addAttribute("hospitalName", hospitalName);
		model.addAttribute("officesName", officesName);
		return "admin/officeList";
	}

	@RequestMapping(value = "/admin/officeAdd", method = RequestMethod.GET)
	public String officeAddPage(Model model) {
		List<Hospital> hospitalList = hospitalService.findOpenHos();
		model.addAttribute("hospitalList", hospitalList);
		return "admin/officeForm";
	}

	@RequestMapping(value = "/admin/officeSave", method = RequestMethod.POST)
	public String officeSave(Office office) {
		officeService.insertOffice(office);
		return "redirect:/admin/officeList/1";
	}

	@RequestMapping(value = "/admin/officeEdit/{id}", method = RequestMethod.GET)
	public String officeEditPage(Model model, @PathVariable("id") int id) {
		Office office = officeService.findOfficeById(id);
		List<Hospital> hospitalList = hospitalService.findOpenHos();
		model.addAttribute("office", office);
		model.addAttribute("hospitalList", hospitalList);
		return "admin/officeForm";
	}

	@RequestMapping(value = "/admin/officeUpdate", method = RequestMethod.POST)
	public String officeUpdate(Office office) {
		officeService.updateOffice(office);
		return "redirect:/admin/officeList/1";
	}

	@RequestMapping(value = "/admin/officeDelete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> officeDelete(@PathVariable("id") int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			officeService.deleteOffice(id);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "删除失败，请先删除该科室下的医生");
		}
		return result;
	}

	// ==================== 医生管理 ====================

	@RequestMapping(value = "/admin/doctorList/{page}", method = RequestMethod.GET)
	public String doctorList(Model model, @PathVariable("page") int page,
			@RequestParam(value = "hospitalName", required = false) String hospitalName,
			@RequestParam(value = "officesName", required = false) String officesName,
			@RequestParam(value = "doctorName", required = false) String doctorName) {
		Doctor searchDoctor = new Doctor();
		searchDoctor.setHospitalName(hospitalName);
		searchDoctor.setOfficesName(officesName);
		searchDoctor.setDoctorName(doctorName);

		pageUtils.setCurrentPage(page);
		pageUtils.setTotalRecord(doctorService.findDoctorNum(searchDoctor));
		int start;
		if (pageUtils.getCurrentPage() == 0) {
			start = 0;
		} else {
			start = pageUtils.getPageRecord() * (pageUtils.getCurrentPage() - 1);
		}
		List<Doctor> doctorList = doctorService.findDoctorByCondition(searchDoctor, start, 20);

		model.addAttribute("doctorList", doctorList);
		model.addAttribute("pages", pageUtils);
		model.addAttribute("hospitalName", hospitalName);
		model.addAttribute("officesName", officesName);
		model.addAttribute("doctorName", doctorName);
		return "admin/doctorList";
	}

	@RequestMapping(value = "/admin/doctorAdd", method = RequestMethod.GET)
	public String doctorAddPage(Model model) {
		List<Hospital> hospitalList = hospitalService.findOpenHos();
		model.addAttribute("hospitalList", hospitalList);
		return "admin/doctorForm";
	}

	@RequestMapping(value = "/admin/doctorSave", method = RequestMethod.POST)
	public String doctorSave(Doctor doctor) {
		doctorService.insertDoctor(doctor);
		return "redirect:/admin/doctorList/1";
	}

	@RequestMapping(value = "/admin/doctorEdit/{id}", method = RequestMethod.GET)
	public String doctorEditPage(Model model, @PathVariable("id") int id) {
		Doctor doctor = doctorService.findDoctorById(id);
		List<Hospital> hospitalList = hospitalService.findOpenHos();
		model.addAttribute("doctor", doctor);
		model.addAttribute("hospitalList", hospitalList);
		return "admin/doctorForm";
	}

	@RequestMapping(value = "/admin/doctorUpdate", method = RequestMethod.POST)
	public String doctorUpdate(Doctor doctor) {
		doctorService.updateDoctor(doctor);
		return "redirect:/admin/doctorList/1";
	}

	@RequestMapping(value = "/admin/doctorDelete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doctorDelete(@PathVariable("id") int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			doctorService.deleteDoctor(id);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "删除失败");
		}
		return result;
	}

	// ==================== 排班管理 ====================

	@RequestMapping(value = "/admin/scheduleList/{page}", method = RequestMethod.GET)
	public String scheduleList(Model model, @PathVariable("page") int page,
			@RequestParam(value = "doctorName", required = false) String doctorName,
			@RequestParam(value = "hospitalName", required = false) String hospitalName,
			@RequestParam(value = "scheduleDate", required = false) String scheduleDate) {
		pageUtils.setCurrentPage(page);
		pageUtils.setTotalRecord(doctorScheduleService.countByCondition(doctorName, hospitalName, scheduleDate));
		int start;
		if (pageUtils.getCurrentPage() == 0) {
			start = 0;
		} else {
			start = pageUtils.getPageRecord() * (pageUtils.getCurrentPage() - 1);
		}
		List<DoctorSchedule> scheduleList = doctorScheduleService.findByCondition(doctorName, hospitalName, scheduleDate, start, 20);

		model.addAttribute("scheduleList", scheduleList);
		model.addAttribute("pages", pageUtils);
		model.addAttribute("doctorName", doctorName);
		model.addAttribute("hospitalName", hospitalName);
		model.addAttribute("scheduleDate", scheduleDate);
		return "admin/scheduleList";
	}

	@RequestMapping(value = "/admin/scheduleAdd", method = RequestMethod.GET)
	public String scheduleAddPage(Model model) {
		return "admin/scheduleForm";
	}

	@RequestMapping(value = "/admin/scheduleSave", method = RequestMethod.POST)
	public String scheduleSave(DoctorSchedule schedule) {
		// 根据doctorId填充hospitalName和officesName
		Doctor doctor = doctorService.findDoctorById(schedule.getDoctorId());
		if (doctor != null) {
			schedule.setHospitalName(doctor.getHospitalName());
			schedule.setOfficesName(doctor.getOfficesName());
		}
		doctorScheduleService.insert(schedule);
		return "redirect:/admin/scheduleList/1";
	}

	@RequestMapping(value = "/admin/scheduleBatch", method = RequestMethod.GET)
	public String scheduleBatchPage(Model model) {
		return "admin/scheduleBatch";
	}

	@RequestMapping(value = "/admin/scheduleBatchSave", method = RequestMethod.POST)
	public String scheduleBatchSave(HttpServletRequest request) {
		String[] doctorIds = request.getParameterValues("doctorId");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String[] timeSlots = request.getParameterValues("timeSlot");
		String maxPatientsStr = request.getParameter("maxPatients");

		int maxPatients = 20;
		if (maxPatientsStr != null && !maxPatientsStr.isEmpty()) {
			maxPatients = Integer.parseInt(maxPatientsStr);
		}

		if (doctorIds != null && startDate != null && endDate != null && timeSlots != null) {
			for (String doctorIdStr : doctorIds) {
				int doctorId = Integer.parseInt(doctorIdStr);
				Doctor doctor = doctorService.findDoctorById(doctorId);
				if (doctor == null) continue;

				// 生成日期范围内每天的排班
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
				try {
					java.util.Date start = sdf.parse(startDate);
					java.util.Date end = sdf.parse(endDate);
					java.util.Calendar cal = java.util.Calendar.getInstance();
					cal.setTime(start);

					while (!cal.getTime().after(end)) {
						String dateStr = sdf.format(cal.getTime());
						for (String slot : timeSlots) {
							if (slot != null && !slot.isEmpty()) {
								DoctorSchedule schedule = new DoctorSchedule();
								schedule.setDoctorId(doctorId);
								schedule.setHospitalName(doctor.getHospitalName());
								schedule.setOfficesName(doctor.getOfficesName());
								schedule.setScheduleDate(dateStr);
								schedule.setTimeSlot(slot);
								schedule.setMaxPatients(maxPatients);
								try {
									doctorScheduleService.insert(schedule);
								} catch (Exception e) {
									// 跳过重复的排班记录
								}
							}
						}
						cal.add(java.util.Calendar.DATE, 1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return "redirect:/admin/scheduleList/1";
	}

	@RequestMapping(value = "/admin/scheduleDelete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> scheduleDelete(@PathVariable("id") int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			doctorScheduleService.delete(id);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}

	@RequestMapping(value = "/admin/scheduleToggle/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> scheduleToggle(@PathVariable("id") int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			DoctorSchedule schedule = doctorScheduleService.findById(id);
			int newStatus = schedule.getStatus() == 1 ? 0 : 1;
			doctorScheduleService.toggleStatus(id, newStatus);
			result.put("success", true);
			result.put("status", newStatus);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}

		// AJAX: 获取所有医生列表（用于排班选择）
		@RequestMapping(value = "/admin/doctorListJson", method = RequestMethod.GET)
		@ResponseBody
		public List<Doctor> doctorListJson() {
			return doctorService.findDoctorByCondition(new Doctor(), 0, 1000);
		}

		// AJAX: 根据医生ID获取可用排班日期
	@RequestMapping(value = "/getScheduleByDoctor", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getScheduleByDoctor(@RequestParam("doctorId") int doctorId) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<String> dates = doctorScheduleService.findAvailableDates(doctorId);
		List<DoctorSchedule> allSlots = doctorScheduleService.findByDoctorId(doctorId);
		result.put("dates", dates);
		result.put("slots", allSlots);
		return result;
	}

	// ==================== 预约管理 ====================

	@RequestMapping(value = "/admin/orderList/{page}", method = RequestMethod.GET)
	public String orderList(Model model, @PathVariable("page") int page,
			@RequestParam(value = "hospitalName", required = false) String hospitalName,
			@RequestParam(value = "officesName", required = false) String officesName,
			@RequestParam(value = "doctorName", required = false) String doctorName,
			@RequestParam(value = "isSuccess", required = false) Integer isSuccess,
			@RequestParam(value = "isCancel", required = false) Integer isCancel) {
		Integer orderVer = 1; // 只查已提交的订单

		pageUtils.setCurrentPage(page);
		pageUtils.setTotalRecord(orderRecordsService.countAllOrders(hospitalName, officesName, doctorName,
				isSuccess, isCancel, orderVer));
		int start;
		if (pageUtils.getCurrentPage() == 0) {
			start = 0;
		} else {
			start = pageUtils.getPageRecord() * (pageUtils.getCurrentPage() - 1);
		}
		List<OrderRecords> orderList = orderRecordsService.findAllOrders(hospitalName, officesName, doctorName,
				isSuccess, isCancel, orderVer, start, 20);

		model.addAttribute("orderList", orderList);
		model.addAttribute("pages", pageUtils);
		model.addAttribute("hospitalName", hospitalName);
		model.addAttribute("officesName", officesName);
		model.addAttribute("doctorName", doctorName);
		model.addAttribute("isSuccess", isSuccess);
		model.addAttribute("isCancel", isCancel);
		return "admin/orderList";
	}

	@RequestMapping(value = "/admin/orderDetail/{id}", method = RequestMethod.GET)
	public String orderDetail(Model model, @PathVariable("id") int id) {
		OrderRecords order = orderRecordsService.findOrderById(id);
		model.addAttribute("order", order);
		return "admin/orderDetail";
	}

	@RequestMapping(value = "/admin/orderApprove/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderApprove(@PathVariable("id") int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			orderRecordsService.approveOrder(id);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}

	@RequestMapping(value = "/admin/orderReject/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderReject(@PathVariable("id") int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			orderRecordsService.rejectOrder(id);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}

	// ==================== 医院管理 ====================

	@RequestMapping(value = "/admin/hosList/{page}", method = RequestMethod.GET)
	public String hosList(Model model, @PathVariable("page") int page) {
		pageUtils.setCurrentPage(page);
		// 查询所有医院而不是仅开放预约的
		Hospital searchHos = new Hospital();
		searchHos.setHospitalName(null);
		pageUtils.setTotalRecord(hospitalService.findAllHosNum("", "", "", searchHos));
		int start;
		if (pageUtils.getCurrentPage() == 0) {
			start = 0;
		} else {
			start = pageUtils.getPageRecord() * (pageUtils.getCurrentPage() - 1);
		}
		List<Hospital> hosList = hospitalService.findAllHosByConditon("", "", "", searchHos, start, 20);

		model.addAttribute("hosList", hosList);
		model.addAttribute("pages", pageUtils);
		return "admin/hosList";
	}

	@RequestMapping(value = "/admin/hosToggle/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> hosToggle(@PathVariable("id") int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Hospital hos = hospitalService.findHosById(id);
			int newStatus = hos.getIsOpen() == 1 ? 0 : 1;
			hospitalService.toggleOpen(id, newStatus);
			result.put("success", true);
			result.put("isOpen", newStatus);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}
}
