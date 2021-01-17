package com.gumzima.shopping.model.notice.service;

import java.util.List;

import com.gumzima.shopping.model.common.Pager;
import com.gumzima.shopping.model.common.Search;
import com.gumzima.shopping.model.domain.Notice;


public interface NoticeService {
	public List selectAll();
	public Notice select(int notice_id);
	public void listPage(Notice notice);
	public void insert(Notice notice);	
	public void update(Notice notice);	
	public void delete(int notice_id);	
}
