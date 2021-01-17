package com.gumzima.shopping.controller.payment;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.exception.CartException;
import com.gumzima.shopping.exception.LoginRequiredException;
import com.gumzima.shopping.model.common.MessageData;
import com.gumzima.shopping.model.domain.Cart;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.domain.Orders;
import com.gumzima.shopping.model.payment.service.PaymentService;


@Controller
public class PaymentController {
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	@Autowired
	private PaymentService paymentService;
	
	//@Autowired
	//private TopCategoryService topCategoryService;
	
	//장바구니 목록 요청 
		@RequestMapping(value="/shop/cart/list", method=RequestMethod.GET)
		public ModelAndView getCartList(HttpServletRequest request) {
			HttpSession session = request.getSession();
			Member member = (Member)session.getAttribute("member");

			List<Cart> cartList = paymentService.selectCartList(member.getMember_id());
			
			ModelAndView mav = new ModelAndView("shop/cart/cart_list");

			mav.addObject("cartList", cartList);
			
			return mav;
		}
		
		//장바구니에 상품 담기 요청 
		@RequestMapping(value="/shop/cart/regist", method=RequestMethod.POST)
		@ResponseBody
		public MessageData registCart(Cart cart, HttpServletRequest request) {
			HttpSession session=request.getSession();
			Member member = (Member)session.getAttribute("member");
			
			cart.setMember_id(member.getMember_id());
			paymentService.insert(cart);
			int cartItems=paymentService.selectCartItems(member.getMember_id());
			session.setAttribute("cartItems", cartItems);
			//MessageConverter 에 의해 VO는 JSON형태로 응답되어질 수 있다!!
			MessageData messageData = new MessageData();
			messageData.setResultCode(1);
			messageData.setMsg("장바구니에 상품이 담겼습니다");
			messageData.setUrl("/shop/cart/list");
			
			return messageData;
		}
		
		//장바구니 비우기 
		@RequestMapping(value="/shop/cart/del", method=RequestMethod.GET)
		@ResponseBody
		public MessageData delCart(HttpServletRequest requset){
			//장바구니를 삭제하기 위해서는, 로그인한 회원만 가능..
			HttpSession session=requset.getSession();
			Member member = (Member)session.getAttribute("member");
			
			paymentService.delete(member);
			
			//MessageConverter 에 의해 VO는 JSON형태로 응답되어질 수 있다!!
			MessageData messageData = new MessageData();
			messageData.setResultCode(1);
			messageData.setMsg("장바구니를 비웠습니다.");
			messageData.setUrl("/shop/cart/list");
			
			return messageData;
		}
		
		@RequestMapping(value="/shop/cart/edit", method=RequestMethod.POST)
		public ModelAndView editCart(HttpServletRequest requset,@RequestParam("cart_id") int[] cartArray, @RequestParam("quantity") int[] qArray) {
			//넘겨받은 파라미터 출력하기!!  cart_id,  quantity 
			HttpSession session=requset.getSession();
			Member member = (Member)session.getAttribute("member");
			int member_id = member.getMember_id();
			List cartList = new ArrayList();
			for(int i=0;i<cartArray.length;i++) {
				Cart cart  = new Cart();
				cart.setMember_id(member_id);
				cart.setCart_id(cartArray[i]);
				cart.setQuantity(qArray[i]);
				cartList.add(cart);
			}
			paymentService.update(cartList);
			
			//수정되었다는 메시지를 보고싶다면.. message.jsp로 응답하자
			MessageData messageData = new MessageData();
			messageData.setResultCode(1);
			messageData.setMsg("장바구니가 수정되었습니다");
			messageData.setUrl("/shop/cart/list");
			ModelAndView mav = new ModelAndView();
			mav.addObject("messageData", messageData);
			mav.setViewName("shop/error/message");
			
			return mav;
		}
		
		//체크아웃 페이지 요청 
		@GetMapping("/shop/payment/form")
		public String payForm(HttpServletRequest requset, Model model) {
			HttpSession session=requset.getSession();
			Member member = (Member)session.getAttribute("member");
			
			//결제수단 가져오기 
			List paymethodList = paymentService.selectPaymethodList();
			model.addAttribute("paymethodList", paymethodList);
			
			//장바구니 정보도 가져오기 
			List cartList = paymentService.selectCartList(member.getMember_id());
			model.addAttribute("cartList", cartList);
			
			return "shop/payment/checkout";
		}
	
		//결제요청 처리
		@PostMapping("/shop/payment/regist")
		public String pay(HttpServletRequest requset, Orders orders) {
			HttpSession session=requset.getSession();
			Member member = (Member)session.getAttribute("member");
		
			orders.setMember_id(member.getMember_id()); //나중에 수정해야함***
			
			paymentService.registOrder(orders);
			
			paymentService.delete(member);
			return "redirect:/";
		}
		
		@ExceptionHandler(CartException.class)
		@ResponseBody
		public MessageData handleException(CartException e) {
			MessageData messageData= new MessageData();
			messageData.setResultCode(0);
			messageData.setMsg(e.getMessage()); 
			messageData.setUrl("/shop/cart/list");
			return messageData;
		}
		
}
