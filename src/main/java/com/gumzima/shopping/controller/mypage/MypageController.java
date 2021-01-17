package com.gumzima.shopping.controller.mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.controller.admin.AdminOrdersController;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.domain.OrderStatus;
import com.gumzima.shopping.model.domain.Orders;
import com.gumzima.shopping.model.orders.service.OrderStatusService;
import com.gumzima.shopping.model.orders.service.OrdersService;

@Controller
public class MypageController {
	private static final Logger logger= LoggerFactory.getLogger(AdminOrdersController.class);
	@Autowired
	private OrdersService ordersService;
	
	@Autowired OrderStatusService orderStatusService;

	@GetMapping("/shop/mypage/orderhistory")
	public ModelAndView getOrderHistory(HttpServletRequest requset) {
		//포스트매핑으로 바꾼다.
		//여기서 멤버얻어와야된다.
		HttpSession session=requset.getSession();
		Member member = (Member) session.getAttribute("member");
		List<Orders> ordersList = ordersService.selectById(member.getMember_id());
		
		ModelAndView mav = new ModelAndView("shop/mypage/order_history");
		mav.addObject("OrdersList", ordersList);
		
		return mav;
	}
	
	@GetMapping("/shop/mypage/orderhistory/detail")
	public ModelAndView getOrderHistoryDetail(HttpServletRequest requset, int orders_id) {
		ModelAndView mav = new ModelAndView("shop/mypage/order_history_detail");
		Orders orders = ordersService.getDescription(orders_id);
		List<OrderStatus> orderStatusList = orderStatusService.selectAll();
		mav.addObject("Orders", orders);
		mav.addObject("OrderStatusList", orderStatusList);
		return mav;
	}
	
}


