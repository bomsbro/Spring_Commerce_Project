package com.gumzima.shopping.controller.admin;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.model.domain.OrderStatus;
import com.gumzima.shopping.model.domain.Orders;
import com.gumzima.shopping.model.orders.service.OrderStatusService;
import com.gumzima.shopping.model.orders.service.OrdersService;

@Controller
public class AdminOrdersController{
	private static final Logger logger= LoggerFactory.getLogger(AdminOrdersController.class);
	@Autowired
	private OrdersService ordersService;
	
	@Autowired
	private OrderStatusService orderStatusService;
	
	@RequestMapping(value="/admin/orders/list", method=RequestMethod.GET )
	public ModelAndView getOrdersList(HttpServletRequest requset) {
		ModelAndView mav = new ModelAndView("admin/orders/orders_list");
		List<Orders> ordersList = ordersService.selectAll();
		List<OrderStatus> orderStatusList = orderStatusService.selectAll();
		
		mav.addObject("OrdersList", ordersList);
		mav.addObject("OrderStatusList", orderStatusList);
		return mav;
	}
	
	@RequestMapping(value="/admin/orders/detail", method=RequestMethod.GET )
		public ModelAndView getOrderDetail(HttpServletRequest requset, int orders_id) {
		ModelAndView mav = new ModelAndView("admin/orders/orders_detail");
		Orders orders = ordersService.getDescription(orders_id);
		List<OrderStatus> orderStatusList = orderStatusService.selectAll();
		mav.addObject("Orders", orders);
		mav.addObject("OrderStatusList", orderStatusList);
		return mav;
	}
	
	
	@RequestMapping(value="/admin/orders/list/update", method=RequestMethod.POST, produces ="text/html;charset=utf8")
	@ResponseBody
	public String updateListStatus(HttpServletRequest requset,
		@RequestParam(value = "chkArr[]", required=false) List<Integer> chkArr
		, @RequestParam(value="selArr[]", required=false) List<Integer> selArr) {
		
		ordersService.updateStatus(chkArr, selArr); //상품등록 서비스에게 요청
		
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"result\":1,");
		sb.append("\"msg\":\"상태 일괄 수정 성공\"");
		sb.append("}");
		
		return sb.toString();
	}
	
	@RequestMapping(value="/admin/orders/detail/update", method=RequestMethod.POST, produces="text/html;charset=utf-8")
	@ResponseBody
	public String updateDetailStatus(HttpServletRequest requset, Orders orders) {
		ordersService.update(orders);
		
		StringBuffer sb= new StringBuffer();
		sb.append("{");
		sb.append("\"result\":1,");
		sb.append("\"msg\":\"업데이트성공\"");
		sb.append("}");
		return sb.toString();
	}
	
	@RequestMapping(value="/admin/orders/list/delete", method=RequestMethod.POST, produces ="text/html;charset=utf8")
	@ResponseBody
	public String deleteOrders(HttpServletRequest requset,
		@RequestParam(value = "chkArr[]", required=false) List<Integer> chkArr
		) {
		
		ordersService.deleteOrders(chkArr); //상품등록 서비스에게 요청
		
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"result\":1,");
		sb.append("\"msg\":\"주문 일괄 삭제 성공\"");
		sb.append("}");
		
		return sb.toString();
	}
}
