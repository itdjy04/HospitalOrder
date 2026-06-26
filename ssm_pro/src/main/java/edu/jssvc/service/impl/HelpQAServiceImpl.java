package edu.jssvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.jssvc.dao.HelpQADao;
import edu.jssvc.entity.HelpQA;
import edu.jssvc.service.HelpQAService;
@Service
public class HelpQAServiceImpl implements HelpQAService {
	@Autowired
	private HelpQADao helpQADao;
	@Override
	public List<HelpQA> findQAByType(String questionType) {
		// TODO Auto-generated method stub
		return helpQADao.findQAByType(questionType);
	}

}
