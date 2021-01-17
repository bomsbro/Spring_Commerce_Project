package com.gumzima.shopping.controller.main;

import java.net.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.controller.member.MemberController;
import com.gumzima.shopping.exception.MemberNotFoundException;
import com.gumzima.shopping.exception.MemberRegistException;
import com.gumzima.shopping.model.common.MessageData;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.member.repository.MemberDAO;
import com.gumzima.shopping.model.member.service.MemberService;
import com.gumzima.shopping.model.payment.service.PaymentService;
import com.gumzima.shopping.model.payment.service.PaymentServiceImpl;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private PaymentService paymentService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String shopMain(HttpSession session) {
		return "shop/index";
	}
	
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
	
	// id 중복체크
	@RequestMapping(value="/shop/member/Id_Check",method=RequestMethod.GET)
	@ResponseBody
	public int Id_Check(String m_id) {	
		int result = memberService.Id_Check(m_id); 
		return result;
	}
	
	// 회원가입 요청 처리(가입버튼)
	@RequestMapping(value="/shop/member/regist", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String regist(Member member,String m_id) {
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
	
	//로그인 홈 요청 
	@RequestMapping(value="/shop/member/loginForm", method=RequestMethod.GET)
	public ModelAndView getLoginForm() {		
		
		ModelAndView mav = new ModelAndView("shop/member/signin");		
		return mav;
	}
	
	//로그인 요청 처리
	@RequestMapping(value="/shop/member/login", method=RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String login(HttpServletRequest request, Member member) {
		//db에 존재여부 확인		
		Member obj=memberService.select(member);
		
		//존재 O : 세션에 회원정보 담아두기
		HttpSession session=request.getSession();
		session.setAttribute("member", obj); //id, pw가 저장되어있음..
		int cartItems=paymentService.selectCartItems(obj.getMember_id());
		session.setAttribute("cartItems", cartItems);
		return "1";
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
		if(memberService.find_id(member)==null) {
			id="0";
		}
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
		int result=memberService.find_pass(member);
		String msg=null;
		if(result==0) {
			msg="일치하는 정보가 없습니다.";
		}else {
			msg="임시비밀번호를 이메일로 발송하였습니다.";
		}
		return msg;
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
		
	
	@ExceptionHandler(MemberNotFoundException.class)
	@ResponseBody
	public String handleException(MemberNotFoundException e) {
		return "0";
	}
}
