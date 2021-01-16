package com.gumzima.shopping.model.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.common.Search;
import com.gumzima.shopping.exception.NoticeException;
import com.gumzima.shopping.model.domain.Notice;
import com.gumzima.shopping.model.notice.respository.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDAO noticeDAO;
	
	public List selectAll() {
		return noticeDAO.selectAll();
	}

	@Override
	public Notice select(int notice_id) {
		Notice notice = noticeDAO.select(notice_id);		
		return notice;
	}

	public void listPage(Notice notice) {
		noticeDAO.listPage(notice);
	}
	
	@Override
	public void insert(Notice notice) throws NoticeException{
		noticeDAO.insert(notice);
		
	}

	@Override
	public void update(Notice notice) throws NoticeException{
		noticeDAO.update(notice);
		
	}

	@Override
	public void delete(int notice_id) throws NoticeException{
		noticeDAO.delete(notice_id);
		
	}

}
