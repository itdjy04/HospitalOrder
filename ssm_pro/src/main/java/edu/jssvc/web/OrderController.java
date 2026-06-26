package edu.jssvc.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.jssvc.dao.FavouriteDao;
import edu.jssvc.entity.CommonUser;
import edu.jssvc.entity.Favourite;
import edu.jssvc.entity.Hospital;
import edu.jssvc.entity.OrderRecords;
import edu.jssvc.service.CommonUserService;
import edu.jssvc.service.DoctorScheduleService;
import edu.jssvc.service.HospitalService;
import edu.jssvc.service.OrderRecordsService;
import edu.jssvc.entity.DoctorSchedule;

/**
 * 
 * @author itdjy
 *
 * @date 2026年6月23日
 */
@Controller
public class OrderController {

	@Autowired
	private CommonUserService commnUserService;
	@Autowired
	private OrderRecordsService orderRecordsService;
	@Autowired
	private FavouriteDao favouriteDao;
	@Autowired
	private HospitalService hospitalService;
	@Autowired
	private DoctorScheduleService doctorScheduleService;

	private static Logger log = LoggerFactory.getLogger(OrderController.class);

	/**
	 * 用户预约首页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/orderIndex", method = RequestMethod.GET)
	public String orderIndex() {

		return "order/orderInfo";
	}

	/**
	 * 用户预约
	 * 
	 * @return
	 */
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public String order(String orderInfoValue, String hospitalName, String officesName, String doctorName,
			String userIdenf, Model model, String doctorImg, Integer doctorId) {
		// 分解传入的时间以及时间段
		String orderInfoValueArry[] = orderInfoValue.split(",");
		String transact_date = orderInfoValueArry[0];
		String transact_time = orderInfoValueArry[1];
		CommonUser commonUser = commnUserService.findCommonUserByUserIdenf(userIdenf);

		// 检查排班是否可用
		if (doctorId != null) {
			List<DoctorSchedule> slots = doctorScheduleService.findAvailableSlots(doctorId, transact_date);
			boolean slotAvailable = false;
			int scheduleId = 0;
			for (DoctorSchedule slot : slots) {
				if (slot.getTimeSlot().equals(transact_time) && slot.getBookedCount() < slot.getMaxPatients()) {
					slotAvailable = true;
					scheduleId = slot.getId();
					break;
				}
			}
			if (!slotAvailable) {
				model.addAttribute("msg", "该时段已约满或不可预约，请重新选择！");
				return "order/orderError";
			}
			// 增加已预约数
			doctorScheduleService.incrementBookedCount(scheduleId);
		}

		OrderRecords orderRecords = new OrderRecords();
		// 设置orderRecords
		orderRecords.setUserID((int) commonUser.getUserId());
		orderRecords.setTransactTime(transact_time);
		orderRecords.setTransactDate(transact_date);
		orderRecords.setHospitalName(hospitalName);
		orderRecords.setOfficesName(officesName);
		orderRecords.setDoctorName(doctorName);
		// 设置预约识别码 0代表只选择时间段，未提交订单
		orderRecords.setOrderVer(0);
		log.info("插入订单，待提交！");
		// 插入订单
		orderRecordsService.insertOrderRecords(orderRecords);
		// 设置最后插入的id(不会发生并发性问题，是根据线程查询的)
		int id = orderRecordsService.findLastId();
		System.out.println(id);
		orderRecords.setId(id);
		model.addAttribute("orderRecords", orderRecords);
		model.addAttribute("commonUser", commonUser);
		model.addAttribute("doctorImg", doctorImg);
		return "order/orderInfo";
	}

	/**
	 * 提交订单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/orderUserCenter", method = RequestMethod.POST)
	public String OrderUserCenter(Model model, int userID, int id, String diseaseInfo, HttpSession session) {
		// 得到用户的收藏记录
		List<Favourite> favourites = favouriteDao.findFavHos(userID);
		List<Hospital> hospitals = null;
		if (favourites.size() != 0) {
			hospitals = hospitalService.findFavHos(favourites);
		}
		model.addAttribute("hospitals", hospitals);
		// 得到用户的信息
		CommonUser commonUser = (CommonUser) session.getAttribute("userInfo");
		model.addAttribute("commonUser", commonUser);
		orderRecordsService.updateOrderSta1(id);
		orderRecordsService.updateOrderdiseaseInfo(diseaseInfo, id);
		// 通过userId查询所有订单，为个人中心提供
		List<OrderRecords> orderRecords = orderRecordsService.findOrderRecordsByUserID(userID);
		log.info("插入订单，已提交订单！");
		model.addAttribute("orderRecords", orderRecords);
		return "userCenter/userCenter";

	}

	/**
	 * 取消订单
	 */
	@RequestMapping(value = "/cancelOrder/{id}", method = RequestMethod.POST)
	public String cancelOrder(Model model, @PathVariable(value = "id") int id, HttpSession session) {
		// 通过id更改订单状态
		orderRecordsService.cancelOrder(id);
		CommonUser commonUser = (CommonUser) session.getAttribute("userInfo");
		if (commonUser != null) {
			// 得到用户的收藏记录
			List<Favourite> favourites = favouriteDao.findFavHos(commonUser.getUserId());
			List<Hospital> hospitals = null;
			if (favourites.size() != 0) {
				hospitals = hospitalService.findFavHos(favourites);
			}
			model.addAttribute("hospitals", hospitals);
			// 得到用户的个人订单
			List<OrderRecords> orderRecords = orderRecordsService.findOrderRecordsByUserID(commonUser.getUserId());
			model.addAttribute("orderRecords", orderRecords);
			model.addAttribute("commonUser", commonUser);
			return "userCenter/userCenter";
		}
		return "userCenter/userCenter";
	}

}
