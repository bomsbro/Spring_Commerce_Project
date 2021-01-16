package com.gumzima.shopping.model.member.repository;

import java.util.List;
import java.util.Map;

import com.gumzima.shopping.model.domain.Member;


public interface MemberDAO {
	public List selectAll();	// 모든 회원가져오기
	
	public void insert(Member member);	//회원등록
	public Member select(Member member);	// 로그인검증
	public Member selectId(int member_id);	// 회원1명정보가져오기
	public void update(Member member);	//회원정보 수정(관리자)
	public Member select(int member_id);	// 회원상세보기
	public void mypageEdit(Member member);	//회원정보 수정(사용자)
	
	public void mypageDel(Member member);	//회원탈퇴
	public int deletePass(Member member);
	// 중복체크	
	public int Id_Check(String idcheck);	
	// 아이디 찾기
	public String find_id(Member member);
	// 비밀번호 찾기
	public int find_pass(Member member);
	public Member find_equ(Member member);	
}
