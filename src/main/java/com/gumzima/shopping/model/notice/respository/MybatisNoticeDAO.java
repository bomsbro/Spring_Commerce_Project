package com.gumzima.shopping.model.notice.respository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.common.Search;
import com.gumzima.shopping.exception.NoticeException;
import com.gumzima.shopping.model.domain.Notice;

@Repository
public class MybatisNoticeDAO implements NoticeDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll() {
		List list = null;
		list = sqlSessionTemplate.selectList("Notice.selectAll");
		return list;
	}

	@Override
	public Notice select(int notice_id) {
		Notice notice = null;
		notice = sqlSessionTemplate.selectOne("Notice.select", notice_id);
		return notice;
	}
	
	
	public void listPage(Notice notice) {
		sqlSessionTemplate.selectList("Notice.listPage", notice);
	}
	
	@Override
	public void insert(Notice notice) throws NoticeException{
		int result = sqlSessionTemplate.insert("Notice.insert", notice);
		if(result==0) {
			throw new NoticeException("글 등록에 실패하였습니다.");
		}
	}

	@Override
	public void update(Notice notice) throws NoticeException{
		int result = sqlSessionTemplate.update("Notice.update", notice);
		if(result==0) {
			throw new NoticeException("글 수정이 실패하였습니다.");
		}
	}

	@Override
	public void delete(int notice_id) throws NoticeException{
		int result = sqlSessionTemplate.delete("Notice.delete", notice_id);
		if(result==0) {
			throw new NoticeException("글 삭제가 실패하였습니다.");
		}
	}

}
