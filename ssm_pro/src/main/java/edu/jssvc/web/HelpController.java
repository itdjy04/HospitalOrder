package edu.jssvc.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.jssvc.dao.FeedBackDao;
import edu.jssvc.entity.FeedBack;
import edu.jssvc.entity.HelpQA;
import edu.jssvc.service.HelpQAService;
/**
 * 
 * @author itdjy
 *
 * @date 2026年6月23日
 */
@Controller
public class HelpController {
	@Autowired
	private HelpQAService helpQAService;
	@Autowired
	private FeedBackDao feedBackDao;
	private static Logger log = LoggerFactory.getLogger(HelpController.class);
	/**
	 * 用户帮助首页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/help", method = RequestMethod.GET)
	public String helpIndex(Model model) {
		List<HelpQA> commonQA = helpQAService.findQAByType("常见问题");
		List<HelpQA> signQA = helpQAService.findQAByType("如何注册");
		List<HelpQA> accountQA = helpQAService.findQAByType("帐号管理");
		model.addAttribute("commonQA", commonQA);
		model.addAttribute("signQA", signQA);
		model.addAttribute("accountQA", accountQA);
		return "help/helpIndex";
	}
	/**
	 * 意见反馈首页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/feedBack", method = RequestMethod.GET)
	public String feedBack(){
		return "feedBack/feedBack";
		
	}
	
	//意见反馈
	@RequestMapping(value = "/feedBackInfo", method = RequestMethod.POST)
	public String feedBack(FeedBack feedBack){
		feedBackDao.inserFeedBack(feedBack);
		log.info("有用户反馈意见"+feedBack.getUserId()+"***"+feedBack.getContent());
		return "feedBack/thanksFeedBack";
		
	}
	
	

}
