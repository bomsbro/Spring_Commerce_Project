package com.gumzima.shopping.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.model.customer.service.CustomerService;
import com.gumzima.shopping.model.domain.Customer;
@Controller
public class AdminCustomerController {
	@Autowired
	private CustomerService customerService;

	// 전체목록
	@RequestMapping(value = "/shop/customer/customer_list", method = RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/customer/regist");

		List customerList = customerService.selectAll();
		mav.addObject("customerList", customerList);
		return mav;
	}

	// 1건 문의 상세보기
	@RequestMapping(value = "/shop/customer/customerdetail", method = RequestMethod.GET)
	public ModelAndView select(HttpServletRequest request, int customer_id) {
		Customer customer = customerService.select(customer_id);
		ModelAndView mav = new ModelAndView("admin/customer/detail");
		mav.addObject("customer", customer);
		return mav;
	}

	// 1건 문의 답변보내기
	@ResponseBody
	@RequestMapping(value = "/shop/customer/customerupdate", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	public String replyMail(HttpServletRequest request, Customer customer) {
		customerService.replyMail(customer);
		return "회원님 이메일로 답변을 전송하였습니다.";
	}
}
