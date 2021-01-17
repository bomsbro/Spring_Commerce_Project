package com.gumzima.shopping.controller.member;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.exception.MailSendException;
import com.gumzima.shopping.exception.MemberRegistException;
import com.gumzima.shopping.model.common.MessageData;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.member.repository.MemberDAO;
import com.gumzima.shopping.model.member.service.MemberService;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberDAO memberDAO;
	
	// 회원목록 수정하기
	@RequestMapping(value="/shop/member/edit",method=RequestMethod.POST)
	public ModelAndView update(HttpServletRequest request, Member member) {
		ModelAndView mav = new ModelAndView();
		memberService.update(member);		
		System.out.println("c"+member);
		mav.setViewName("redirect:/shop/member/detail?member_id="+member.getMember_id());
		return mav;
	}
	
	// 마이 페이지
	@RequestMapping(value="/shop/member/mypagehome",method = RequestMethod.GET)
	public String getMypage(HttpServletRequest request) {
		
		return "/shop/member/mypageHome";
	}
	
	// 회원 1명의 정보 보기
	@RequestMapping(value="/shop/member/myPageEdit",method = RequestMethod.GET)
	public ModelAndView InfoSignup(HttpServletRequest request, int member_id) {
		
		Member member = memberService.selectId(member_id);
		ModelAndView mav = new ModelAndView("shop/member/mypage");
		mav.addObject("member", member);
		System.out.println("member:"+member);		

		return mav;
	}
	
	// 마이페이지 회원정보 수정 클릭시(수정된다)
	@RequestMapping(value="/shop/member/myPage_Edit",method = RequestMethod.POST)
	public String mypageEdit(HttpServletRequest request, Member member) {		
		memberService.mypageEdit(member);	// 수정한 값 세션에 담자 //데이터베이스 영역
//		session.setAttribute("member", member);			//세션 영
		return "/shop/member/mypageHome";
	}
	

	// 마이페이지 회원탈퇴 폼 요청
	@RequestMapping(value="/shop/member/myPage_Del",method=RequestMethod.POST)
	public ModelAndView mypageDel(HttpServletRequest request,Member member) {		
		ModelAndView mav = new ModelAndView("shop/member/deleteForm");
		mav.addObject("member", member);
		
		return mav;
	}
	
	// 마이페이지 회원탈퇴 패스워드 체크
	@RequestMapping(value="/shop/member/delete_Form",method = RequestMethod.POST)	
	public String deletePass(HttpServletRequest request, Member member) {
		int result = memberService.deletePass(member);
		if(result==1) {
			memberService.mypageDel(member);//비밀번호가 맞으면 jsp다시 가지 말고 여기서 데이터를 삭제하고 jsp
		}
		request.getSession().invalidate();
		return "redirect:/shop";
	}
		
	//로그아웃 요청 처리 
	@RequestMapping(value="/shop/member/logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request) {
		request.getSession().invalidate(); //세션 무효화, 이시점부터 담겨진 데이터가 다 무효가 된다
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("로그아웃 되었습니다");
		messageData.setUrl("/");
		ModelAndView mav = new ModelAndView("shop/error/message");
		mav.addObject("messageData", messageData);
		return mav;
	}
		
	
}
