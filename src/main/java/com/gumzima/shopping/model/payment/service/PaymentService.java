package com.gumzima.shopping.model.payment.service;

import java.util.List;

import com.gumzima.shopping.model.domain.Cart;
import com.gumzima.shopping.model.domain.Member;
import com.gumzima.shopping.model.domain.Orders;

public interface PaymentService {
	//장바구니 관련 업무
	public List selectCartList();//회원 구분없이 모든 데이터 가져오기 
	public List selectCartList(int member_id);//특정 회원의 장바구니 내역
	public Cart selectCart(int cart_id);
	public void insert(Cart cart);
	public void update(List<Cart> cartList); //일괄 수정
	public void delete(Cart cart); //pk에 속한 데이터 삭제할예정
	public void delete(Member member); //회원에 속한 데이터 삭제할예정
	public int selectCartItems(int member_id);
	
	//결제 업무
	public List selectPaymethodList();
	public void registOrder(Orders orders);//트랜잭션 처리가 요구되는 메서드...
}
