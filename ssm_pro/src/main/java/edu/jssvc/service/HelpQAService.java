package edu.jssvc.service;

import java.util.List;

import edu.jssvc.entity.HelpQA;

public interface HelpQAService {
	//根据类型查找问题
		public List<HelpQA> findQAByType(String questionType);

}
