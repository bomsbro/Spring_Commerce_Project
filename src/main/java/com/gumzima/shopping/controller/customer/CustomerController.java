package com.gumzima.shopping.controller.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.model.customer.service.CustomerService;
import com.gumzima.shopping.model.domain.Customer;


@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
		
	// 1:1 문의 폼
	@RequestMapping(value="/shop/customer/list",method = RequestMethod.GET)
	public String getCustomer() {		
		return "/shop/customer/customer_list";
	}
	
	// 1:1 문의 글 등록 / 이메일 발송하기
	@RequestMapping(value="/shop/customer/emailSubmit",method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String send(Customer customer) {
		customerService.insert(customer);
		return "문의내용을 관리자에 발송하였습니다. 빠른 답변을 드리도록 하겠습니다.";
	} 
}
