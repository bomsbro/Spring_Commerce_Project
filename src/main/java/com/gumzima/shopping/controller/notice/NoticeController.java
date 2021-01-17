package com.gumzima.shopping.controller.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.exception.NoticeException;
import com.gumzima.shopping.model.domain.Notice;
import com.gumzima.shopping.model.notice.service.NoticeService;

@Controller
public class NoticeController {	
	
	@Autowired
	private NoticeService noticeService;
	
	
	
	// 이용자 페이지 공지사항 목록
	@RequestMapping(value = "/shop/notice/list", method = RequestMethod.GET)
	public ModelAndView getShopNoticeList() {//int currentPage
		ModelAndView mav = new ModelAndView("shop/notice/notice_list");
		List noticeList = noticeService.selectAll();		
		mav.addObject("noticeList", noticeList);	
		return mav;
	}
	
	// 공지사항 상세보기
		@RequestMapping(value = "/shop/notice/detail", method = RequestMethod.GET)
		public ModelAndView select(int notice_id) {
			Notice notice = noticeService.select(notice_id);

			ModelAndView mav = new ModelAndView();
			mav.addObject("notice", notice);
			mav.setViewName("shop/notice/detail");
			return mav;
		}
	
	// 예외처리 등록
	@ExceptionHandler(NoticeException.class)
	@ResponseBody
	public String handleException(NoticeException e) {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"result\":0");
		sb.append("\"msg\":\"" + e.getMessage() + "\"");
		sb.append("}");
		return sb.toString();
	}
}
