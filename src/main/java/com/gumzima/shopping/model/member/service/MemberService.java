package com.gumzima.shopping.model.member.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.domain.Notice;


public interface MemberService {
	public List selectAll();	// 모든 회원가져오기
	public Member selectId(int member_id); 
	public Member select(Member member);
	public Member select(int member_id);	// 회원1명 가져오기
	public void regist(Member member);	//회원등록->DAO와 구분.. / 기타 필요사항 처리..
	public void update(Member member);	//회원정보 수정
	public void mypageEdit(Member member);	//회원정보 수정(사용자)
	
	public void mypageDel(Member member);	//회원탈퇴
	public int deletePass(Member member);	// 패스워드 체크
	// 중복체크	
	public int Id_Check(String idcheck);
	// 아이디 찾기
	public String find_id(Member member);
	// 비밀번호 찾기
	public int find_pass(Member member);	
}
