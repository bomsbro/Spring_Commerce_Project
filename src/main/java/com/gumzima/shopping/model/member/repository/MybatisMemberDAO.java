package com.gumzima.shopping.model.member.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.exception.MemberNotFoundException;
import com.gumzima.shopping.exception.MemberRegistException;
import com.gumzima.shopping.exception.NoticeException;
import com.gumzima.shopping.exception.parseException;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.domain.Notice;

@Repository
public class MybatisMemberDAO implements MemberDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll() {
		return sqlSessionTemplate.selectList("Member.selectAll");
	}

	// 회원 상세보기
	public Member select(int member_id) {
		return sqlSessionTemplate.selectOne("Member.selectOne", member_id);
	}
	
	// 회원 아이디 1명 상세보기
	public Member selectId(int member_id) {
		Member member = sqlSessionTemplate.selectOne("Member.selectId", member_id);
		return member;
	}
	// 회원 수정하기
	public void update(Member member) {
		sqlSessionTemplate.update("Member.update", member); 	
	}
	
	// 마이페이지 회원 수정하기
	public void mypageEdit(Member member) throws NoticeException{
		int result = sqlSessionTemplate.update("Member.updateMypage", member);
		if(result==0) {
			throw new NoticeException("수정이 실패하였습니다.");
		}
	}

	// 마이페이지 회원탈퇴
	public void mypageDel(Member member) {
		sqlSessionTemplate.delete("Member.delete", member);		
	}	
	
	// 마이페이지 회원탈퇴 패스워드 체크
	public int deletePass(Member member) {
		int result = sqlSessionTemplate.delete("Member.deletePass",member);
		return result;
	}
	
	// 로그인 검증
	public Member select(Member member) throws MemberNotFoundException{
		Member obj = sqlSessionTemplate.selectOne("Member.select", member);
		System.out.println("objDAO"+obj);
		if(obj==null) {//올바르지 않은 정보로 회원을 조회하려고 하는 것임..
			throw new MemberNotFoundException("로그인 정보가 올바르지 않습니다.");	// 문제가 있다면? 서비스로 전가..
		}
		return obj;	
	}
	
	// 아이디 중복체크
	public int Id_Check(String idcheck) {		
		System.out.println("idcheck"+idcheck);	// null
		return sqlSessionTemplate.selectOne("Member.idCheck", idcheck);
	}
	
	// 로그인 - 아이디 찾기
	public String find_id(Member member) {		
		System.out.println("m_name"+member.getM_name());
		System.out.println("m_name"+member.getM_email());
		return sqlSessionTemplate.selectOne("Member.find_id",member);
	}
	
	// 로그인 - 비밀번호 찾기(임시비밀번호사용)
	public int find_pass(Member member) {
		return sqlSessionTemplate.update("Member.find_pass", member);
	}
	
	// 로그인 - 비밀번호 찾기 - 비교작업
	public Member find_equ(Member member) {		
		return sqlSessionTemplate.selectOne("Member.find_equ", member);
	}
	
	public void insert(Member member) throws MemberRegistException{
		int result = sqlSessionTemplate.insert("Member.insert", member); 
		if(result==0) {
			throw new MemberRegistException("회원가입에 실패하였습니다.");
		}
	}
}
