package com.gumzima.shopping.model.notice.respository;

import java.util.List;
import java.util.Map;

import com.gumzima.shopping.common.Search;
import com.gumzima.shopping.model.domain.Notice;


public interface NoticeDAO {
	public List selectAll();
	public Notice select(int notice_id);
	public void listPage(Notice notice);
	public void insert(Notice notice);	
	public void update(Notice notice);	
	public void delete(int notice_id);	
}
