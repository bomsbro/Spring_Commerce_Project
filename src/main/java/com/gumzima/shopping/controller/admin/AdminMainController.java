package com.gumzima.shopping.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminMainController {
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminMain(HttpServletRequest request) {
		return "admin/index";
	}
}
