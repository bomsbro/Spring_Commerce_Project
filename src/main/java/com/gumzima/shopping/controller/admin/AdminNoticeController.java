package com.gumzima.shopping.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
public class AdminNoticeController {
	@Autowired
	private NoticeService noticeService;

	// 공지사항 폼
	@RequestMapping(value = "/admin/notice/registform")
	public String noticeForm(HttpServletRequest request) {
		return "admin/notice/regist_form";
	}

	// 공지사항 목록
	@RequestMapping(value = "/admin/notice/list", method = RequestMethod.GET)
	public ModelAndView getNoticeList(HttpServletRequest request) {// int currentPage
		ModelAndView mav = new ModelAndView("admin/notice/list");
		List noticeList = noticeService.selectAll();
		mav.addObject("noticeList", noticeList);
		// int a = currentPage;
		// if(a>1) {
		// mav.addObject("currentPage", currentPage);
		// }
		return mav;
	}

	// 공지사항 등록 요청
	@RequestMapping(value = "/admin/notice/regist", method = RequestMethod.POST)
	public String regist(HttpServletRequest request, Notice notice) {
		noticeService.insert(notice);
		return "redirect:/admin/notice/list";
	}

	// 공지사항 상세보기
	@RequestMapping(value = "/admin/notice/detail", method = RequestMethod.GET)
	public ModelAndView select(HttpServletRequest request, int notice_id) {
		Notice notice = noticeService.select(notice_id);

		ModelAndView mav = new ModelAndView();
		mav.addObject("notice", notice);
		mav.setViewName("admin/notice/detail");
		return mav;
	}

	// 공지사항 글 수정하기
	@RequestMapping(value = "/admin/notice/edit", method = RequestMethod.POST)
	public String update(HttpServletRequest request, Notice notice) {

		noticeService.update(notice);
		return "redirect:/admin/notice/detail?notice_id=" + notice.getNotice_id();
	}

	// 공지사항 글 삭제하기
	@RequestMapping(value = "/admin/notice/delete", method = RequestMethod.POST)
	public String delete(HttpServletRequest request, int notice_id) {
		noticeService.delete(notice_id);
		return "redirect:/admin/notice/list";
	}

	// 검색하기
	@RequestMapping(value = "/admin/notice/listPage", method = RequestMethod.GET)
	public ModelAndView listPage(HttpServletRequest request, Notice notice) {
		noticeService.listPage(notice);

		ModelAndView mav = new ModelAndView("admin/notice/list");
		mav.addObject("listPage", notice);
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
