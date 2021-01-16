package com.gumzima.shopping.model.payment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.exception.CartException;
import com.gumzima.shopping.model.domain.Cart;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.domain.OrderDetail;
import com.gumzima.shopping.model.domain.Orders;
import com.gumzima.shopping.model.orders.repository.CartDAO;
import com.gumzima.shopping.model.orders.repository.OrderDetailDAO;
import com.gumzima.shopping.model.orders.repository.OrdersDAO;
import com.gumzima.shopping.model.orders.repository.PaymethodDAO;

@Service
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	private CartDAO cartDAO;
	
	@Autowired
	private PaymethodDAO paymethodDAO;
	
	//주문관련 3가지 DAO 
	@Autowired
	private OrdersDAO ordersDAO;
	
	//@Autowired
	//private ReceiverDAO receiverDAO;
	
	@Autowired
	private OrderDetailDAO orderDetailDAO;
	
	
	@Override
	public List selectCartList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectCartList(int member_id) {
		return cartDAO.selectAll(member_id);
	}

	@Override
	public Cart selectCart(int cart_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Cart cart) throws CartException{
		cartDAO.duplicateCheck(cart);
		cartDAO.insert(cart);
	}

	

	@Override
	public void delete(Cart cart) {
		// TODO Auto-generated method stub
		
	}

	public void delete(Member member) throws CartException{
		cartDAO.delete(member);
	}
	
	@Override
	public List selectPaymethodList() {
		return paymethodDAO.selectAll();
	}
	

	@Override
	public void update(List<Cart> cartList)  throws CartException{
		for(Cart cart : cartList) {
			cartDAO.update(cart);
		}
		
	}
	
	//주문 등록 
	@Override
	public void registOrder(Orders orders){
		//주문요약 등록 
		int orders_id = ordersDAO.insert(orders);
		//주문 요약이 등록된 이후, orderSummary VO에는 mybatis의 selectkey에 의해 order_summary_id 가  채워져 있다..
		//따라서 취득한 주문번호를 받는사람, 상세에 넣어줘야 함.
	
		List<Cart> cartList = cartDAO.selectAll(orders.getMember_id());
		
		
		for(Cart cart : cartList) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrders_id(orders_id);
			orderDetail.setProduct_id(cart.getProduct_id());
			orderDetail.setProduct_name(cart.getProduct_name());
			orderDetail.setFilename(cart.getFilename()); 
			orderDetail.setProduct_price(cart.getPrice());
			orderDetail.setQuantity(cart.getQuantity());
			
			orderDetailDAO.insert(orderDetail);
		}
		
	}
	
}


