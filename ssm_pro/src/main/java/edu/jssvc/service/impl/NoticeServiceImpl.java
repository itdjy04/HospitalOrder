package edu.jssvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.jssvc.dao.NoticeDao;
import edu.jssvc.entity.Notice;
import edu.jssvc.service.NoticeService;
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	@Override
	public List<Notice> findNoticeByType(int start,int size) {
		// TODO Auto-generated method stub
		return noticeDao.findNoticeByType(start,size);
	}
	@Override
	public int findNoticeByTypeNum() {
		// TODO Auto-generated method stub
		return noticeDao.findNoticeByTypeNum();
	}
	@Override
	public Notice findNoticeById(int id) {
		// TODO Auto-generated method stub
		return noticeDao.findNoticeById(id);
	}

}
