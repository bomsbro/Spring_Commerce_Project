package com.gumzima.shopping.model.member.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.common.MailSender;
import com.gumzima.shopping.common.SecureManager;
import com.gumzima.shopping.exception.MailSendException;
import com.gumzima.shopping.exception.MemberNotFoundException;
import com.gumzima.shopping.exception.MemberRegistException;
import com.gumzima.shopping.exception.NoticeException;
import com.gumzima.shopping.exception.parseException;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.domain.Notice;
import com.gumzima.shopping.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;	
	// 메일발송 객체
	@Autowired
	private MailSender mailSender;
	@Autowired
	private SecureManager secureManager;
		
	public List selectAll() {
		return memberDAO.selectAll();
	}
	
	public Member select(int member_id) {
		return memberDAO.select(member_id);
	}
	
	// 1명의 회원정도 가져요기
	public Member selectId(int member_id) {
		System.out.println("service : "+member_id);	// null
		Member member = null;
		member = memberDAO.selectId(member_id);
		return member;
	}
	
	// 마이페이지 회원수정
	public void mypageEdit(Member member) throws NoticeException{
		memberDAO.mypageEdit(member);	
	}
	
	// 마이페이지 회원탈퇴
	public void mypageDel(Member member) {
		memberDAO.mypageDel(member);	
	
	}
	
	// 마이페이지 회원탈퇴 패스워드 체크
	public int deletePass(Member member) {
		String hash = secureManager.getSecureData(member.getM_pass());
		member.setM_pass(hash); 		// vo에 다시 해시값 대입!!
		int result = memberDAO.deletePass(member);
		
		return result;
	}
	
	public Member select(Member member) throws MemberNotFoundException{
		// 유저가 전송한 파라미터 비번을 해시값으로 변환하여 아래의 메서드 호출 - 암호화
		String hash = secureManager.getSecureData(member.getM_pass());
		member.setM_pass(hash); 		// vo에 다시 해시값 대입!!
		Member obj = memberDAO.select(member);	// 조작한 값을 다시 넣음
		return obj;
	}
	
	public void regist(Member member) throws MemberRegistException, MailSendException{
		// DB에 넣기 + 이메일보내기 + 문자발송..
		
		// 암호화 처리 
		String secureData = secureManager.getSecureData(member.getM_pass());
		member.setM_pass(secureData); 		// 변환시켜 다시 vo에 대입!
		
		memberDAO.insert(member);
		String name = member.getM_name();
		String addr = member.getM_addr2();
		String email = member.getM_email()+"@"+member.getM_email_server();
		mailSender.send(email,name+ "님 [패션샵] 가입을 축하드립니다.", addr+"에 거주하세요? 많은 이용바랍니다.");
	}

	// 로그인 - 아이디 중복체크
	public int Id_Check(String idcheck) {
		return memberDAO.Id_Check(idcheck);
	}

	// 로그인 - 아이디 찾기	
	public String find_id(Member member){		
		String id = memberDAO.find_id(member);
		return id;
	}

	// -- 비밀번호 찾기
	public int find_pass(Member member) {	
		int result = 0;
		if(memberDAO.Id_Check(member.getM_id())==0) {
			JOptionPane.showMessageDialog(null, "존재하지 않는 아이디 입니다.");
		}else {
			if(memberDAO.find_equ(member)!=null) {// 이름, 이메일..
				//성공 -> 임시비밀번호 발송
				String password = "";
				for(int i=0;i<12;i++) {
					password +=(char)((Math.random()*26)+97);
				}
				String secureData = secureManager.getSecureData(password);
				member.setM_pass(secureData);
				// 비밀번호 변경
				memberDAO.find_pass(member);				
				// 메일발송		
				String name = member.getM_name();				
				String email = member.getM_email()+"@"+member.getM_email_server();
				System.out.println("email:"+email);
				mailSender.send(email,name+ "님 임시 비밀번호를 발송하였습니다.", "비밀번호가 임시비밀번호로 변경되었습니다."+"<br>"+"임시 비밀번호는: "+password);// 보내는사람이메일,제목,내용
	
				result= 1;
			}else {
				//에러
				result= 0;
			}
		}
		return result;
		
	}
	
	@Override
	public void update(Member member) {
		memberDAO.update(member);
		System.out.println("s"+member);
	}
}
