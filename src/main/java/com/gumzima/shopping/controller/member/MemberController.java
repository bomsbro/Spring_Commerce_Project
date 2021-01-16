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

import com.gumzima.shopping.common.MessageData;
import com.gumzima.shopping.exception.MailSendException;
import com.gumzima.shopping.exception.MemberRegistException;
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
			
	// 회원가입폼 요청
	@RequestMapping(value="/shop/member/signup",method=RequestMethod.GET)
	public String getRegistForm() {	      	      
		return "shop/member/signup";      
   }

	// 주소 팝업창 다음
	@RequestMapping(value="/shop/member/jusoPopup",method=RequestMethod.GET)
	public String getApi() {	      	      
	      return "shop/member/jusoPopup";
	}
	
	// 회원가입 요청 처리(가입버튼)
	@RequestMapping(value="/shop/member/regist", method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String regist(Member member,String m_id) {
		 
		logger.debug("넘겨받은 m_id "+m_id);
		
		logger.debug("아이디 "+member.getM_id());
		logger.debug("비번 "+member.getM_pass());
		logger.debug("이름 "+member.getM_name());
		logger.debug("이메일ID "+member.getM_email());
		logger.debug("이메일SERVER"+member.getM_email_server());
		logger.debug("연락처"+member.getM_phone());
		logger.debug("우편번호"+member.getM_addr1());
		logger.debug("주소 "+member.getM_addr2());
		
		int result = memberService.Id_Check(m_id);  
		StringBuffer sb=null;
		if(result==1) {// 중복!
			return "/shop/member/signup";
		}else if(result==0){
			memberService.regist(member);
			sb = new StringBuffer();
			sb.append("{");
			sb.append(" \"result\":1, ");
			sb.append(" \"msg\":\"회원가입을 축하드립니다.\"");		
			sb.append("}");					
		}
				
		return sb.toString();		// 쇼핑몰 메인..
	}
	
	// 회원 전체목록
	@RequestMapping(value="/shop/member/list",method=RequestMethod.GET)
	public ModelAndView getList() {
		ModelAndView mav = new ModelAndView("shop/member/list");
		
		List memberList = memberService.selectAll();
		mav.addObject("memberList", memberList);		
		return mav;
	}
	
	// 회원목록 상세보기
	@RequestMapping(value="/shop/member/detail",method=RequestMethod.GET)
	public ModelAndView select(int member_id) {
		Member member = memberService.select(member_id);
		ModelAndView mav = new ModelAndView("shop/member/detail");
		mav.addObject("member", member);
		return mav;
	}
	
	// 회원목록 수정하기
	@RequestMapping(value="/shop/member/edit",method=RequestMethod.POST)
	public ModelAndView update(Member member) {
		ModelAndView mav = new ModelAndView();
		memberService.update(member);		
		System.out.println("c"+member);
		mav.setViewName("redirect:/shop/member/detail?member_id="+member.getMember_id());
		return mav;
	}
	
	// 마이 페이지
	@RequestMapping(value="/shop/member/mypagehome",method = RequestMethod.GET)
	public String getMypage(HttpSession session) {
		
		return "/shop/member/mypageHome";
	}
	
	// 회원 1명의 정보 보기
	@RequestMapping(value="/shop/member/myPageEdit",method = RequestMethod.GET)
	public ModelAndView InfoSignup(int member_id) {
		
		Member member = memberService.selectId(member_id);
		ModelAndView mav = new ModelAndView("shop/member/mypage");
		mav.addObject("member", member);
		System.out.println("member:"+member);		

		return mav;
	}
	
	// 마이페이지 회원정보 수정 클릭시(수정된다)
	@RequestMapping(value="/shop/member/myPage_Edit",method = RequestMethod.POST)
	public String mypageEdit(HttpSession session,Member member) {		
		memberService.mypageEdit(member);	// 수정한 값 세션에 담자 //데이터베이스 영역
		session.setAttribute("member", member);			//세션 영
		return "/shop/member/mypageHome";
	}
	

	// 마이페이지 회원탈퇴 폼 요청
	@RequestMapping(value="/shop/member/myPage_Del",method=RequestMethod.POST)
	public ModelAndView mypageDel(HttpSession session,Member member) {		
		ModelAndView mav = new ModelAndView("shop/member/deleteForm");
		mav.addObject("member", member);
		
		return mav;
	}
	
	// 마이페이지 회원탈퇴 패스워드 체크
	@RequestMapping(value="/shop/member/delete_Form",method = RequestMethod.POST)	
	public String deletePass(Member member) {
		int result = memberService.deletePass(member);
		System.out.println("delete member"+member);
		if(result==1) {
			memberService.mypageDel(member);//비밀번호가 맞으면 jsp다시 가지 말고 여기서 데이터를 삭제하고 jsp
		}
		return "redirect:/shop";
	}
	
	// 마이페이지 회원탈퇴 진행
	//@RequestMapping(value="/shop/member/myPageDel",method=RequestMethod.POST)
	//public String mypageDel(HttpSession session,Member member) {		
		//memberService.mypageDel(member);		
		//return "redirect:/shop";
	//}

		
	//로그인 홈 요청 
	@RequestMapping(value="/shop/member/loginForm", method=RequestMethod.GET)
	public ModelAndView getLoginForm() {		
		
		ModelAndView mav = new ModelAndView("shop/member/signin");		
		return mav;
	}
	
	//로그인 요청 처리
	@RequestMapping(value="/shop/member/login", method=RequestMethod.POST)
	public String login(Member member, HttpServletRequest request) {
		//db에 존재여부 확인		

		Member obj=memberService.select(member);
		System.out.println("obj"+member);
		//존재 O : 세션에 회원정보 담아두기
		HttpSession session=request.getSession();		
		session.setAttribute("member", obj); //id, pw가 저장되어있음..
		
		logger.debug("로그인 요청 처리완료");
		return "redirect:/shop";	
	}
	
	// 아이디 찾기 폼
	@RequestMapping(value="/shop/find/findidform",method = RequestMethod.GET)
	public ModelAndView getFindIdForm() {
		ModelAndView mav = new ModelAndView("shop/find/findid_form");	
		return mav;
	}
	
	// 아이디 찾기 요청
	@RequestMapping(value="/shop/find/findid",method = RequestMethod.POST)
	public ModelAndView find_id(Member member){		
		ModelAndView mav = new ModelAndView("shop/member/signin");
		String id=memberService.find_id(member);		
		logger.debug("결과 아이디는 "+id); //retry 
		mav.addObject("m_id", id); 
		
		return mav;
	}
	
	// 비밀번호 찾기 폼
	@RequestMapping(value="/shop/find/findpassform",method = RequestMethod.GET)
	public ModelAndView getFindPassForm() {
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("이메일로 임시비밀번호를 발송해드렸습니다.");
		messageData.setUrl("/shop/member/loginForm");
		
		ModelAndView mav = new ModelAndView("shop/find/findpass_form");	
		mav.addObject("messageData", messageData);
		return mav;
	}
	
	// 비밀번호 찾기 요청
	@RequestMapping(value="/shop/find/findpass",method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String find_pass(Member member) {
		memberService.find_pass(member);
		return "임시비밀번호를 이메일로 발송하였습니다.";
	}

	//로그아웃 요청 처리 
	@RequestMapping(value="/shop/member/logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request) {
		request.getSession().invalidate(); //세션 무효화, 이시점부터 담겨진 데이터가 다 무효가 된다
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("로그아웃 되었습니다");
		messageData.setUrl("/shop");
		System.out.println("message"+messageData);
		ModelAndView mav = new ModelAndView("shop/error/message");
		mav.addObject("messageData", messageData);
		return mav;
	}
	
	
	// id 중복체크
	@RequestMapping(value="/shop/member/Id_Check",method=RequestMethod.GET)
	@ResponseBody
	public int Id_Check(String m_id) {	
		int result = memberService.Id_Check(m_id); 
		System.out.println("idcheckcontroller"+m_id);
		System.out.println("결과 "+result);
		return result;
	}

	
	// 예외 핸들러 2가지 처리
	@ExceptionHandler(MemberRegistException.class)
	@ResponseBody
	public String handleException(MemberRegistException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":0, ");
		sb.append(" \"msg\":\""+e.getMessage()+"\"");		
		sb.append("}");		
		return sb.toString();
	}
	
}
