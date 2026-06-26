package edu.jssvc.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.jssvc.entity.Notice;
import edu.jssvc.service.NoticeService;
import edu.jssvc.utils.PageUtils;

/**
 * 
 * @author itdjy
 *
 * @date 2026年6月23日
 */
@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	@Autowired
	private PageUtils pageUtils;

	/**
	 * 公告首页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/noticeIndex/{page}")
	public String noticeIndex(Model model, @PathVariable("page") int page) {
		// 设置页面
		pageUtils.setCurrentPage(page);
		pageUtils.setTotalRecord(noticeService.findNoticeByTypeNum());
		int start;
		if (pageUtils.getCurrentPage() == 0) {
			start = 0;
		} else {
			start = pageUtils.getPageRecord() * (pageUtils.getCurrentPage() - 1);
		}
		// 查询所有通知
		List<Notice> notice = noticeService.findNoticeByType(start, pageUtils.getPageRecord());
		System.out.println("*******************************************");
		model.addAttribute("notice", notice);
		model.addAttribute("pages", pageUtils);
		return "notice/noticeIndex";
	}

	/**
	 * 通知详情
	 * 
	 * @return
	 */
	@RequestMapping(value = "/noticeInfo/{id}", method = RequestMethod.GET)
	public String hosInfoShow(Model model, @PathVariable(value = "id") int id) {
		Notice notice = noticeService.findNoticeById(id);
		model.addAttribute("notice", notice);
		return "notice/noticeInfo";
	}

}
