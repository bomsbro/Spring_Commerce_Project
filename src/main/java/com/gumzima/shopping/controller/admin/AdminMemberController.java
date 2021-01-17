package com.gumzima.shopping.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.controller.member.MemberController;
import com.gumzima.shopping.model.common.MessageData;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.member.repository.MemberDAO;
import com.gumzima.shopping.model.member.service.MemberService;
@Controller
public class AdminMemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberDAO memberDAO;

	// 회원 전체목록
	@RequestMapping(value = "/shop/member/list", method = RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("shop/member/list");

		List memberList = memberService.selectAll();
		mav.addObject("memberList", memberList);
		return mav;
	}

	// 회원목록 상세보기
	@RequestMapping(value = "/shop/member/detail", method = RequestMethod.GET)
	public ModelAndView select(HttpServletRequest request, int member_id) {
		Member member = memberService.select(member_id);
		ModelAndView mav = new ModelAndView("shop/member/detail");
		mav.addObject("member", member);
		return mav;
	}
	
	//로그아웃 요청 처리 
		@RequestMapping(value="/admin/member/logout", method=RequestMethod.GET)
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
